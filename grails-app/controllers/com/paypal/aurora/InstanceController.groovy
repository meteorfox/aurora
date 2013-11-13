package com.paypal.aurora

import com.paypal.aurora.exception.RestClientRequestException
import com.paypal.aurora.model.AvailabilityZone
import com.paypal.aurora.model.Flavor
import com.paypal.aurora.model.Image
import com.paypal.aurora.model.Instance
import com.paypal.aurora.util.ConstraintsProcessor
import grails.converters.JSON
import grails.converters.XML
import org.apache.commons.lang.WordUtils

class InstanceController {

    def static allowedMethods = [list: 'GET', save: 'POST', terminate: 'POST', show: ['GET', 'POST'], update: 'POST', reboot: ['GET', 'POST'], makeSnapshot: ['GET', 'POST'], log: ['GET', 'POST'], pause: ['GET', 'POST'], unpause: ['GET', 'POST'], suspend: ['GET', 'POST'], resume: ['GET', 'POST'], getFQDN: ['GET', 'POST'], _instanceRow: ['GET', 'POST']]

    public final static enum InstanceSources {
        IMAGE, SNAPSHOT

        String getDisplayName() {
            return WordUtils.capitalizeFully(super.toString())
        }
    }

    public final static enum VolumeOptions {
        NOT_BOOT('Do not boot from volume'),
        BOOT_FROM_VOLUME('Boot from volume'),
        BOOT_FROM_SNAPSHOT('Boot from volume snapshot (creates a new volume)')

        private final String displayName;

        VolumeOptions(String displayName) {
            this.displayName = displayName
        }

        String getDisplayName() {
            return displayName
        }
    }

    def instanceService
    def flavorService
    def imageService
    def volumeService
    def securityGroupService
    def keypairService
    def sessionStorageService
    def quantumService
    def networkService
    def snapshotService
    def openStackRESTService
    def quantumDNSService

    def index = { redirect(action: 'list', params: params) }

    def list = {
        try {
            def model = getModelForList(false)
            withFormat {
                html { render(view: 'list', model: model) }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        } catch (RestClientRequestException e) {
            def error = ExceptionUtils.getExceptionMessage(e)
            def model = [errors: error]
            withFormat {
                html { render(view: 'list', model: [cmd: error]) }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        }
    }

    def toggleTenants = {
        ControllerUtils.toggleTenants(sessionStorageService)
        withFormat {
            xml { new XML([]).render(response) }
            json { new JSON([]).render(response) }
        }
    }

    private def getModelForList(def fillFloatingIPs = true) {
        List<Instance> instances = instanceService.listAll(fillFloatingIPs, sessionStorageService.allTenants)
        [instances: instances, isUseExternalFLIP: networkService.useExternalFLIP,
                showAdminCredentials: instanceService.showAdminLoginCredentials,
                showUserCredentials: instanceService.showUserLoginCredentials,
                userLoginHint: sessionStorageService.dataCenter.user_login_hint,
                adminLoginHint: sessionStorageService.dataCenter.admin_login_hint,
                useExternalFLIP: networkService.isUseExternalFLIP()
        ]
    }

    def _instances = {
        def model = modelForList
        withFormat {
            html { render(view: '_instances', model: model) }
            xml { new XML(model).render(response) }
            json { new JSON(model).render(response) }
        }
    }
    def _instanceRow = {
        try {
            def instance = instanceService.getById(params.id, false)
            withFormat {
                html { render(view: '_instanceRow', model: [instance: instance, isUseExternalFLIP: networkService.useExternalFLIP]) }
                xml { new XML(instance: instance).render(response) }
                json { new JSON(instance: instance).render(response) }
            }
        } catch (RestClientRequestException e) {
            def errors = ExceptionUtils.getExceptionMessage(e)
            def errorCode = ExceptionUtils.getExceptionCode(e)
            response.status = errorCode
            withFormat {
                html { render(view: '_instanceRow', model: [errors: errors, errorCode: errorCode]) }
                xml { new XML([errors: errors, errorCode: errorCode]).render(response) }
                json { new JSON([errors: errors, errorCode: errorCode]).render(response) }
            }

        }
    }

    def _instanceFloatingIps = {
        def instance = instanceService.getById(params.id)
        withFormat {
            html { render(view: '_instanceFloatingIps', model: [instance: instance]) }
            xml { new XML(instance: instance).render(response) }
            json { new JSON(instance: instance).render(response) }
        }
    }

    def show = {
        try {
            def instance = instanceService.getById(params.id, false, true)
            def services = []
            /*
            try {
                services = lbaasService.enabled ? lbaasService.getServicesByInstance(instance) : []
            } catch (RestClientRequestException e) {
                services = []
            }*/
            Flavor flavor = flavorService.getById(instance.flavorId)
            Image image = imageService.getImageById(instance.imageId)
            withFormat {
                html {
                    render(view: 'show', model: ['parent': "/instance", 'instance': instance, 'flavor': flavor,
                            'image': image, 'services': services, showAdminCredentials: instanceService.showAdminLoginCredentials,
                            showUserCredentials: instanceService.showUserLoginCredentials,
                            userLoginHint: sessionStorageService.dataCenter.user_login_hint,
                            adminLoginHint: sessionStorageService.dataCenter.admin_login_hint,
                            showAssociateButton: !networkService.isUseExternalFLIP() || instance.floatingIps.isEmpty()])
                }
                xml { new XML([instance: instance]).render(response) }
                json { new JSON([instance: instance]).render(response) }
            }
        } catch (RestClientRequestException e) {
            response.status = ExceptionUtils.getExceptionCode(e)
            def errors = ExceptionUtils.getExceptionMessage(e)
            withFormat {
                html { flash.message = errors; redirect(action: 'list') }
                xml { new XML([errors: errors]).render(response) }
                json { new JSON([errors: errors]).render(response) }
            }
        }
    }

    def create = {
        if (!params.count) {
            params.count = 1
        }
        if (!params._securityGroups) {
            params.securityGroups = ["default"]
        }
        if (params.securityGroups instanceof String) {
            params.securityGroups = [params.securityGroups]
        }
        if (params.networks instanceof String) {
            params.networks = [params.networks]
        }
        params.instanceSourcesArray = InstanceSources.values()
        params.volumeOptionsArray = VolumeOptions.values()
        params.flavors = flavorService.listAll()
        params.images = imageService.getAllImages()
        ifServiceEnabled([name: OpenStackRESTService.NOVA_VOLUME]) {
            params.volumes = volumeService.getAllVolumes()
        }
        params.snapshots = imageService.getAllInstanceSnapshots()
        params.volumeSnapshots = snapshotService.getAllSnapshots()
        params.securityGroupsArray = securityGroupService.getAllSecurityGroups()
        params.keypairs = keypairService.getAllNames()

        if (instanceService.isSendAZOnCreate()) {
            params.datacenter = sessionStorageService.dataCenterName
            params.needDatacenter = true
        }
        
        /*
        def zones = [new AvailabilityZone("—")]
        zones.addAll(instanceService.getAvailableAvailabilityZones())
        params.zones = zones
        */
        // If OpenStack have Quantum then it is Grizzly and user must select networks
        params.quantumEnabled = quantumService.enabled
        if (quantumService.enabled) {
            params.networksArray = []//quantumService.getNetworkList()
        }
        [parent: "/instance", constraints: ConstraintsProcessor.getConstraints(InstanceCreateCommand.class)]
    }

    def edit = {
        params.name = instanceService.getById(params.id, false).name
        [parent: "/instance/show/$params.id", constraints: ConstraintsProcessor.getConstraints(InputNameCommand.class)]
    }

    def update = { InputNameCommand cmd ->
        if (cmd.hasErrors()) {
            withFormat {
                html { chain(action: 'edit', model: [cmd: cmd], params: params) }
                xml { new XML(cmd.errors).render(response) }
                json { new JSON([errors: cmd.errors]).render(response) }
            }
        } else {
            try {
                def resp = instanceService.update(params)
                withFormat {
                    html { redirect(action: 'show', params: [id: params.id]) }
                    xml { new XML([resp: resp]).render(response) }
                    json { new JSON([resp: resp]).render(response) }
                }
            } catch (RestClientRequestException e) {
                response.status = ExceptionUtils.getExceptionCode(e)
                def error = ExceptionUtils.getExceptionMessage(e)
                def model = [errors: error]
                withFormat {
                    html { flash.message = error; redirect(action: 'list') }
                    xml { new XML(model).render(response) }
                    json { new JSON(model).render(response) }
                }
            }
        }
    }

    def snapshot = {
        Instance instance = instanceService.getById(params.id, false)
        [parent: "/instance/show/${params.instanceId ?: params.id}?name=${instance.name}",
                constraints: ConstraintsProcessor.getConstraints(InputNameCommand.class)]
    }

    def makeSnapshot = { InputNameCommand cmd ->
        if (cmd.hasErrors()) {
            withFormat {
                html { chain(action: 'snapshot', model: [cmd: cmd], params: params) }
                xml { new XML(cmd.errors).render(response) }
                json { new JSON([errors: cmd.errors]).render(response) }
            }
        } else {
            def resp = instanceService.createSnapshot(params.id, params.name)
            withFormat {
                html { redirect(controller: 'image', action: 'list') }
                xml { new XML([resp: resp]).render(response) }
                json { new JSON([resp: resp]).render(response) }
            }
        }
    }

    def save = { InstanceCreateCommand cmd ->
        if (cmd.hasErrors()) {
            withFormat {
                html { chain(action: 'create', model: [cmd: cmd], params: params) }
                xml { new XML([errors: cmd.errors]).render(response) }
                json { new JSON([errors: cmd.errors]).render(response) }
            }

        } else {
            try {
                def resp = instanceService.create(params)
                withFormat {
                    html { redirect(action: 'list') }
                    xml { new XML([resp: resp]).render(response) }
                    json { new JSON([resp: resp]).render(response) }
                }
            } catch (RestClientRequestException e) {
                response.status = ExceptionUtils.getExceptionCode(e)
                def error = ExceptionUtils.getExceptionMessage(e)
                def model = [errors: error]
                withFormat {
                    html { flash.message = error; redirect(action: 'list') }
                    xml { new XML(model).render(response) }
                    json { new JSON(model).render(response) }
                }
            }
        }
    }

    def pause = {
        try {
            instanceService.pause(params.instanceId)
            def resp = true
            def model = [resp: resp]
            withFormat {
                html { redirect(action: 'show', params: [id: params.instanceId]) }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        } catch (RestClientRequestException e) {
            response.status = ExceptionUtils.getExceptionCode(e)
            def error = ExceptionUtils.getExceptionMessage(e)
            def model = [errors: error]
            withFormat {
                html { flash.message = error; redirect(action: 'show', params: [id: params.instanceId]) }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        }

    }

    def unpause = {
        try {
            def resp = instanceService.unpause(params.instanceId)
            withFormat {
                html { redirect(action: 'show', params: [id: params.instanceId]) }
                xml { new XML([resp: resp]).render(response) }
                json { new JSON([resp: resp]).render(response) }
            }
        } catch (RestClientRequestException e) {
            response.status = ExceptionUtils.getExceptionCode(e)
            def error = ExceptionUtils.getExceptionMessage(e)
            withFormat {
                html { flash.message = error; redirect(action: 'show', params: [id: params.instanceId]) }
                xml { new XML([errors: error]).render(response) }
                json { new JSON([errors: error]).render(response) }
            }
        }
    }

    def suspend = {
        try {
            instanceService.suspend(params.instanceId)
            def resp = true
            withFormat {
                html { redirect(action: 'show', params: [id: params.instanceId]) }
                xml { new XML([resp: true]).render(response) }
                json { new JSON([resp: true]).render(response) }
            }
        } catch (RestClientRequestException e) {
            response.status = ExceptionUtils.getExceptionCode(e)
            def error = ExceptionUtils.getExceptionMessage(e)
            withFormat {
                html { flash.message = error; redirect(action: 'show', params: [id: params.instanceId]) }
                xml { new XML([resp: false, errors: error]).render(response) }
                json { new JSON([resp: false, errors: error]).render(response) }
            }
        }

    }

    def resume = {
        try {
            instanceService.resume(params.instanceId)
            def resp = true
            def model = [resp: resp]
            withFormat {
                html { redirect(action: 'show', params: [id: params.instanceId]) }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        } catch (RestClientRequestException e) {
            response.status = ExceptionUtils.getExceptionCode(e)
            def error = ExceptionUtils.getExceptionMessage(e)
            def model = [errors: error]
            withFormat {
                html { flash.message = error; redirect(action: 'show', params: [id: params.instanceId]) }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        }
    }

    def terminate = {
        List<String> instanceIds = Requests.ensureList(params.selectedInstances ?: params.instanceId)
        def model = instanceService.deleteInstancesById(instanceIds)
        String flashMessage = ResponseUtils.defineMessageByList("Could not terminate instances with id: ",
                model.notRemovedItems)
        response.status = ResponseUtils.defineResponseStatus(model, flashMessage)
        withFormat {
            html { flash.message = flashMessage; redirect(action: 'list') }
            xml { new XML(model).render(response) }
            json { new JSON(model).render(response) }
        }
    }

    def reboot = {
        try {
            def resp = instanceService.reboot(params.instanceId)
            def model = [resp: resp]
            withFormat {
                html { redirect(action: 'show', params: [id: params.instanceId]) }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        } catch (RestClientRequestException e) {
            response.status = ExceptionUtils.getExceptionCode(e)
            def error = ExceptionUtils.getExceptionMessage(e)
            response.status = ExceptionUtils.getExceptionCode(e)
            def model = [errors: error]
            withFormat {
                html { flash.message = error; redirect(action: 'show', params: [id: params.instanceId]) }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        }
    }

    def log = {
        Instance instance = instanceService.getById(params.instanceId ?: params.id, false)
        if (params.showAll) {
            params.length = null
        } else {
            try {
                params.length = Integer.valueOf(params.length)
            } catch (NumberFormatException e) {
                params.length = 35
            }
        }
        def log = [instanceId: params.instanceId, length: params.length,
                log: instanceService.getLog(params.instanceId, params.length)]
        withFormat {
            html { render(view: 'log', model: [parent: "/instance/show/${params.instanceId ?: params.id}?name=${instance.name}", 'log': log]) }
            xml { new XML(log).render(response) }
            json { new JSON(log).render(response) }
        }
    }

    def vnc = {
        def vncUrl = instanceService.getVncUrl(params.instanceId ?: params.id)
        Instance instance = instanceService.getById(params.instanceId ?: params.id, false)
        [parent: "/instance/show/${params.instanceId ?: params.id}?name=${instance.name}", 'vncUrl': vncUrl]
    }

    def getFQDN = {
        def address = openStackRESTService.isServiceEnabled(OpenStackRESTService.DNS) ? quantumDNSService.getFqdnByIp(params.ip) : params.ip
        withFormat {
            xml { new XML([address: address]).render(response) }
            json { new JSON([address: address]).render(response) }
        }
    }

}

class InstanceCreateCommand {

    def instanceService
    def quantumService

    String name
    String count
    String instanceSources
    String snapshot
    String image
    List securityGroups
    List networks

    static constraints = {
        name(nullable: false, blank: false, matches: /\w[\w\-]*/, validator: { name, command ->
            if (command.instanceService.exists(name)) {
                return "instanceCreateCommand.name.validator"
            }
        })
        count(nullable: false, blank: false, validator: { count, obj ->
            return ValidatorUtils.checkInteger(count)
        })
        snapshot(nullable: true, blank: false, validator: { snapshot, obj ->
            if (obj.instanceSources.equals(InstanceController.InstanceSources.SNAPSHOT.toString()) &&
                    !snapshot) {
                return "instanceCreateCommand.snapshot.validator"
            }
        })
        image(nullable: true, blank: false, validator: { image, obj ->
            if (obj.instanceSources.equals(InstanceController.InstanceSources.IMAGE.toString()) &&
                    !image) {
                return "instanceCreateCommand.image.validator"
            }
        })
        securityGroups(nullable: false, minSize: 1)
        /*
        networks(validator: { networks, obj ->
            if(obj.quantumService.enabled) {
                if(networks == null || networks.empty) {
                    return "instanceCreateCommand.networks.validator"
                }
            }
        })
        */
    }
}

class InputNameCommand {

    String name

    static constraints = {
        name(nullable: false, blank: false, matches: /\w[\w\-]*/)

    }
}
