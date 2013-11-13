package com.paypal.aurora

import com.paypal.aurora.exception.RestClientRequestException
import com.paypal.aurora.model.*
import com.paypal.aurora.util.ConstraintsProcessor
import grails.converters.JSON
import grails.converters.XML

import javax.servlet.http.HttpServletResponse

class LbaasController {

    final static allowedMethods = [saveVip: ['GET', 'POST'], listPolicies: 'GET', listPools: ['GET', 'POST'], showPool: 'GET', listMethods: 'GET', listMonitors: 'GET', savePool: ['GET', 'POST'], updatePool: ['GET', 'POST'], delete: 'POST', saveService: 'POST', enableService: 'POST', disableService: 'POST', deleteService: ['GET', 'POST'], listJobs: ['GET', 'POST'], showJob: ['GET', 'POST'], listVips: ['GET', 'POST'], showVip: ['GET', 'POST'], createVip: ['GET', 'POST'], deleteVip: ['GET', 'POST'], savePolicy: ['GET', 'POST'], updatePolicy: ['GET', 'POST'], deletePolicy: ['POST'], addPool: 'GET', editPool: 'GET', addServices: ['POST', 'GET'], getInstancesByPoolName: 'GET']

    def lbaasService
    def instanceService
    def tenantService
    def sessionStorageService

    def index = { redirect(action: 'listPools', params: params) }

    def listPools = {
        try {
            List<Pool> listPools = lbaasService.allPools
            withFormat {
                html { ['pools': listPools] }
                xml { new XML([pools: listPools]).render(response) }
                json { new JSON([pools: listPools]).render(response) }
            }
        } catch (RestClientRequestException e) {
            def error = ExceptionUtils.getExceptionMessage(e)
            response.status = ExceptionUtils.getExceptionCode(e)
            withFormat {
                html { ['pools': [], flash: [message: error]] }
                xml { new XML([errors: error]).render(response) }
                json { new JSON([errors: error]).render(response) }
            }
        }
    }

    def listMethods = {
        try {
            List<String> listMethods = lbaasService.getMethods();
            withFormat {
                xml { new XML([Methods: listMethods]).render(response) }
                json { new JSON([Methods: listMethods]).render(response) }
            }
        } catch (RestClientRequestException e) {
            def error = ExceptionUtils.getExceptionMessage(e)
            response.status = ExceptionUtils.getExceptionCode(e)
            withFormat {
                xml { new XML([errors: error]).render(response) }
                json { new JSON([errors: error]).render(response) }
            }
        }
    }

    def listMonitors = {
        try {
            List<String> listMonitors = lbaasService.getMonitors()
            withFormat {
                xml { new XML([Monitors: listMonitors]).render(response) }
                json { new JSON([Monitors: listMonitors]).render(response) }
            }
        } catch (RestClientRequestException e) {
            def error = ExceptionUtils.getExceptionMessage(e)
            response.status = ExceptionUtils.getExceptionCode(e)
            withFormat {
                xml { new XML([errors: error]).render(response) }
                json { new JSON([errors: error]).render(response) }
            }
        }
    }

    def showPool = {
        try {
            Pool pool = lbaasService.getPool(params.id)
            List<LBService> services = lbaasService.getServices(params.id)
            def model = [pool: pool, services: services]
            withFormat {
                html { [parent: "/lbaas/listPools", pool: pool, services: services] }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        } catch (RestClientRequestException e) {
            def error = ExceptionUtils.getExceptionMessage(e)
            response.status = ExceptionUtils.getExceptionCode(e)
            withFormat {
                html { flash.message = error; redirect(action: 'listPools') }
                xml { new XML([errors: error]).render(response) }
                json { new JSON([errors: error]).render(response) }
            }
        }
    }

    def listJobs = {
        try {
            List<Job> listJobs = lbaasService.getJobs()?.reverse()
            withFormat {
                html { model: ['jobs': listJobs] }
                xml { new XML([listJobs: listJobs]).render(response) }
                json { new JSON([listJobs: listJobs]).render(response) }
            }
        } catch (RestClientRequestException e) {
            def error = ExceptionUtils.getExceptionMessage(e)
            response.status = ExceptionUtils.getExceptionCode(e)
            withFormat {
                html { model: ['jobs': [], flash: [message: error]] }
                xml { new XML([errors: error]).render(response) }
                json { new JSON([errors: error]).render(response) }
            }
        }
    }

    def _jobs = {
        try {
            List<Job> listJobs = lbaasService.getJobs()?.reverse()
            withFormat {
                html { model: ['jobs': listJobs] }
                xml { new XML([listJobs: listJobs]).render(response) }
                json { new JSON([listJobs: listJobs]).render(response) }
            }
        } catch (RestClientRequestException e) {
            def error = ExceptionUtils.getExceptionMessage(e)
            response.status = ExceptionUtils.getExceptionCode(e)
            withFormat {
                html { model: ['jobs': [], flash: [message: error]] }
                xml { new XML([errors: error]).render(response) }
                json { new JSON([errors: error]).render(response) }
            }
        }
    }

    def showJob = {
        Job job = lbaasService.getJobById(params.id)
        withFormat {
            html { [parent: '/lbaas/listJobs', job: job] }
            xml { new XML([job: job]).render(response) }
            json { new JSON([job: job]).render(response) }
        }
    }

    def listVips = {
        try {
            List<Vip> listVips = lbaasService.getVips()
            withFormat {
                html { [vips: listVips] }
                xml { new XML([vips: listVips]).render(response) }
                json { new JSON([vips: listVips]).render(response) }
            }
        } catch (RestClientRequestException e) {
            def error = ExceptionUtils.getExceptionMessage(e)
            response.status = ExceptionUtils.getExceptionCode(e)
            withFormat {
                html { [vips: [], flash: [message: error]] }
                xml { new XML([errors: error]).render(response) }
                json { new JSON([errors: error]).render(response) }
            }
        }
    }

    def createVip = {
        params.allowedProtocols = allowedProtocols
        [parent: "/lbaas/listVips", constraints: ConstraintsProcessor.getConstraints(VipValidationCommand.class),
                params: params]
    }

    def saveVip = { VipValidationCommand cmd ->
        if (cmd.hasErrors()) {
            withFormat {
                html { chain(action: 'createVip', model: [cmd: cmd], params: params) }
                xml { new XML([errors: cmd.errors]).render(response) }
                json { new JSON([errors: cmd.errors]).render(response) }
            }
        } else {
            try {
                def resp = lbaasService.createVip(params)
                def model = [resp: resp]
                withFormat {
                    html { redirect(action: 'listJobs') }
                    xml { new XML(model).render(response) }
                    json { new JSON(model).render(response) }
                }
            } catch (RestClientRequestException e) {
                def errors = ExceptionUtils.getExceptionMessage(e)
                response.status = ExceptionUtils.getExceptionCode(e)
                withFormat {
                    html { flash.message = errors; chain(action: 'createVip', params: params) }
                    xml { new XML([errors: errors]).render(response) }
                    json { new JSON([errors: errors]).render(response) }
                }
            }

        }
    }

    def showVip = {
        try {
            def vip = lbaasService.getVip(params.id)
            def model = [vip: vip]
            withFormat {
                html { [parent: "/lbaas/listVips", vip: vip] }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        } catch (RestClientRequestException e) {
            response.status = ExceptionUtils.getExceptionCode(e)
            def errors = ExceptionUtils.getExceptionMessage(e)
            withFormat {
                html { flash.message = errors; redirect(action: 'listVips') }
                xml { new XML([errors: errors]).render(response) }
                json { new JSON([errors: errors]).render(response) }
            }
        }
    }

    def deleteVip = {
        List<String> vipNames = Requests.ensureList(params.selectedVips ?: params.id)
        def model = lbaasService.deleteVips(vipNames)
        def flashMessage = ResponseUtils.defineMessageByList("Could not delete vips with name: ",
                model.notRemovedItems)
        response.status = ResponseUtils.defineResponseStatus(model, flashMessage)
        withFormat {
            html {
                flash.message = flashMessage;
                redirect(action: 'listJobs')
            }
            xml { new XML(model).render(response) }
            json { new JSON(model).render(response) }
        }
    }

    def addServices = {
        def pool = lbaasService.getPool(params.id)
        List<Instance> instances = instanceService.getAllActiveInstances(true)
        Set<String> interfaces = new HashSet<String>()
        instances.each {
            it.networks.each { interfaces << it.pool }
            it.floatingIps.each { interfaces << it.pool }
        }
        params.weight = 10
        [pool: pool, instances: instances, parent: "/lbaas/showPool/${params.id}",
                constraints: ConstraintsProcessor.getConstraints(ServiceCreateCommand.class),
                interfaces: interfaces]
    }

    def savePool = { PoolCreateCommand cmd ->
        if (params.monitors && !cmd.monitors) {
            cmd.monitors = params.monitors
            cmd.validate()
        }
        if (cmd.hasErrors()) {
            withFormat {
                html { chain(action: 'addPool', model: [cmd: cmd], params: params) }
                xml { new XML([errors: cmd.errors]).render(response) }
                json { new JSON([errors: cmd.errors]).render(response) }
            }
        } else {
            try {
                params.monitors = Requests.ensureList(params.monitors)
                def resp = lbaasService.createPool(params)
                def model = [resp: resp]
                withFormat {
                    html { redirect(action: 'listJobs') }
                    xml { new XML(model).render(response) }
                    json { new JSON(model).render(response) }
                }
            } catch (RestClientRequestException e) {
                response.status = ExceptionUtils.getExceptionCode(e)
                def errors = ExceptionUtils.getExceptionMessage(e)
                withFormat {
                    html { flash.message = errors; chain(action: 'addPool', params: params) }
                    xml { new XML([errors: errors]).render(response) }
                    json { new JSON([errors: errors]).render(response) }
                }
            }
        }
    }

    def delete = {
        List<String> poolsNames = Requests.ensureList(params.selectedPools)
        def model = lbaasService.deletePools(poolsNames)
        def flashMessage = ResponseUtils.defineMessageByList("Could not delete pools: ", model.notRemovedItems)
        response.status = ResponseUtils.defineResponseStatus(model, flashMessage)
        withFormat {
            html {
                flash.message = flashMessage
                redirect(action: 'listJobs')
            }
            xml { new XML(model).render(response) }
            json { new JSON(model).render(response) }
        }
    }

    def deleteService = {
        List<String> servicesNames = Requests.ensureList(params.selectedServices)
        def model = lbaasService.deleteServices(servicesNames, params.pool)
        String flashMessage = ResponseUtils.defineMessageByList("Could not delete services: ", model.notRemovedItems)
        response.status = ResponseUtils.defineResponseStatus(model, flashMessage)
        withFormat {
            html {
                flash.message = flashMessage
                redirect(action: 'listJobs')
            }
            xml { new XML(model).render(response) }
            json { new JSON(model).render(response) }
        }
    }

    def enableService = {
        try {
            List<String> servicesNames = Requests.ensureList(params.selectedServices)
            lbaasService.changeEnabled(params.pool, servicesNames, true)
            withFormat {
                html { redirect(action: 'listJobs', params: [id: params.pool]) }
                xml { new XML([status: 'OK']).render(response) }
                json { new JSON([status: 'OK']).render(response) }
            }
        } catch (RestClientRequestException e) {
            def error = ExceptionUtils.getExceptionMessage(e)
            response.status = ExceptionUtils.getExceptionCode(e)
            withFormat {
                html { flash.message = error; redirect(action: 'showPool', params: [id: params.pool]) }
                xml { new XML([errors: error]).render(response) }
                json { new JSON([errors: error]).render(response) }
            }
        }
    }

    def disableService = {
        try {
            List<String> servicesNames = Requests.ensureList(params.selectedServices)
            lbaasService.changeEnabled(params.pool, servicesNames, false)
            withFormat {
                html { redirect(action: 'listJobs', params: [id: params.pool]) }
                xml { new XML([status: 'OK']).render(response) }
                json { new JSON([status: 'OK']).render(response) }
            }
        } catch (RestClientRequestException e) {
            response.status = ExceptionUtils.getExceptionCode(e)
            def error = ExceptionUtils.getExceptionMessage(e)
            def model = [errors: error]
            withFormat {
                html { flash.message = error; redirect(action: 'showPool', params: [id: params.pool]) }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        }
    }

    def saveServiceValidation = { ServiceCreateCommand cmd ->
        if (cmd.hasErrors()){
            withFormat {
                html { chain(action: "addServices", model: [cmd: cmd], params: params) }
                xml { new XML([errors: cmd.errors]).render(response) }
                json { new JSON([errors: cmd.errors]).render(response) }
            }
        }else{
            List <String> instances = Requests.ensureList(params.instanceId.split(', '))
            boolean sameGroup = ValidatorUtils.sameGroup(instances, instanceService)
            if (!sameGroup){
                response.status = HttpServletResponse.SC_BAD_REQUEST
            }
            Map model = [params : params, sameGroup : sameGroup]
            withFormat{
                xml {new XML(model).render(response)}
                json {new JSON(model).render(response)}
            }
        }
    }

    def saveService = { ServiceCreateCommand cmd ->
        if (cmd.hasErrors()) {
            withFormat {
                html { chain(action: "addServices", model: [cmd: cmd], params: params) }
                xml { new XML([errors: cmd.errors]).render(response) }
                json { new JSON([errors: cmd.errors]).render(response) }
            }
        } else {
            try {
                lbaasService.addServices(Requests.ensureList(params.instanceId),
                        params.id,
                        params.name,
                        params.netInterface,
                        params.port,
                        params.weight,
                        params.enabled == 'on'
                )
                withFormat {
                    html { redirect(action: 'listJobs', params: [id: params.id]) }
                    xml { new XML([status: 'OK']).render(response) }
                    json { new JSON([status: 'OK']).render(response) }
                }
            } catch (RestClientRequestException e) {
                response.status = ExceptionUtils.getExceptionCode(e)
                def error = ExceptionUtils.getExceptionMessage(e)
                def model = [errors: error]
                withFormat {
                    html { flash.message = error; redirect(action: 'showPool', params: [id: params.id]) }
                    xml { new XML(model).render(response) }
                    json { new JSON(model).render(response) }
                }
            }
        }
    }

    def addPool = {
        [methods: getMethods(),
                monitors: getMonitors(),
                parent: "/lbaas",
                constraints: ConstraintsProcessor.getConstraints(PoolCreateCommand.class)]
    }

    def editPool = {
        try {
            Pool pool = lbaasService.getPool(params.id)
            def model = [name: params.name != null ? params.name : pool.name,
                    enabled: params.enabled ?: pool.enabled,
                    lbMethod: params.lbMethod ?: pool.method,
                    monitors: params.monitors ?: pool.monitors,
                    methods: getMethods(),
                    allMonitors: getMonitors(),
                    parent: "/lbaas/showPool/$params.id",
                    id: params.id,
            ]
            withFormat {
                html { [parent: "/lbaas/showPool/$params.id", params: model, constraints: ConstraintsProcessor.getConstraints(PoolCreateCommand.class)] }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        } catch (RestClientRequestException e) {
            def error = ExceptionUtils.getExceptionMessage(e)
            response.status = ExceptionUtils.getExceptionCode(e)
            withFormat {
                html { flash.message = error; redirect(action: 'showPool', params: [id: params.id]) }
                xml { new XML([errors: error]).render(response) }
                json { new JSON([errors: error]).render(response) }
            }
        }
    }

    def updatePool = { PoolCreateCommand cmd ->
        if (params.monitors && !cmd.monitors) {
            cmd.monitors = params.monitors
            cmd.validate()
        }
        if (cmd.hasErrors()) {
            withFormat {
                html { chain(action: 'editPool', model: [cmd: cmd], params: params) }
                xml { new XML([errors: cmd.errors]).render(response) }
                json { new JSON([errors: cmd.errors]).render(response) }
            }
        } else {
            try {
                params.monitors = Requests.ensureList(params.monitors)
                def model = lbaasService.updatePool(params)
                withFormat {
                    html { chain(action: 'listJobs', params: [id: params.name]) }
                    xml { new XML(model).render(response) }
                    json { new JSON(model).render(response) }
                }
            } catch (RestClientRequestException e) {
                response.status = ExceptionUtils.getExceptionCode(e)
                def errors = ExceptionUtils.getExceptionMessage(e)
                withFormat {
                    html { flash.message = errors; chain(action: 'editPool', params: params) }
                    xml { new XML([errors: errors]).render(response) }
                    json { new JSON([errors: errors]).render(response) }
                }
            }
        }
    }

    def getMonitors() {
        sessionStorageService.services['lbms']?.monitors ?: lbaasService.monitors
    }

    def getMethods() {
        sessionStorageService.services['lbms']?.methods ?: lbaasService.methods
    }

    def getAllowedProtocols() {
        sessionStorageService.services['lbms']?.allowedProtocols ?: []
    }

    def listPolicies = {
        def error
        if (params.tenantName) {
            def tenant = tenantService.getTenantByName(params.tenantName)
            List<Policy> policies
            try {
                policies = lbaasService.getPolicies(params.tenantName)
            } catch (RestClientRequestException e) {
                error = ExceptionUtils.getExceptionMessage(e)
                response.status = ExceptionUtils.getExceptionCode(e)
            }
            def map = [parent: "/tenant/show/${tenant.id}", policies: policies, tenantName: params.tenantName]
            withFormat {
                html { flash.message = error; map }
                xml { new XML([policies: policies, errors: error]).render(response) }
                json { new JSON([policies: policies, errors: error]).render(response) }
            }
        } else {
            List<Policy> policies
            try {
                policies = lbaasService.getPolicies()
            } catch (RestClientRequestException e) {
                error = ExceptionUtils.getExceptionMessage(e)
                response.status = ExceptionUtils.getExceptionCode(e)
            }
            def map = [policies: policies, errors: error, flash: [message: error]]
            withFormat {
                html { map }
                xml { new XML(map).render(response) }
                json { new JSON(map).render(response) }
            }
        }
    }

    def createPolicy = {
        if (params.tenantName) {
            [parent: "/lbaas/listPolicies?tenantName=${params.tenantName}", constraints: ConstraintsProcessor.getConstraints(PolicyValidationCommand.class)]
        } else {
            [parent: '/lbaas/listPolicies', constraints: ConstraintsProcessor.getConstraints(PolicyValidationCommand.class)]
        }

    }

    def deletePolicy = {
        List<String> policyNames = Requests.ensureList(params.selectedPolicies ?: params.id)
        def model = lbaasService.deletePolicies(policyNames)
        String flashMessage = ResponseUtils.defineMessageByList("Could not delete policies: ", model.notRemovedItems)
        response.status = ResponseUtils.defineResponseStatus(model, flashMessage)
        withFormat {
            html {
                flash.message = flashMessage
                redirect(action: 'listJobs')
            }
            xml { new XML(model).render(response) }
            json { new JSON(model).render(response) }
        }
    }

    def editPolicy = {
        Policy policy = lbaasService.getPolicy(params.id, params.tenantName)
        if (params.tenantName) {
            [parent: "/lbaas/listPolicies?tenantName=${params.tenantName}", policy: policy, constraints: ConstraintsProcessor.getConstraints(PolicyValidationCommand.class)]
        } else {
            [parent: '/lbaas/listPolicies', policy: policy, constraints: ConstraintsProcessor.getConstraints(PolicyValidationCommand.class)]
        }
    }

    def updatePolicy = { PolicyValidationCommand cmd ->
        if (cmd.hasErrors()) {
            withFormat {
                html { chain(action: 'editPolicy', model: [cmd: cmd], params: params) }
                xml { new XML([errors: cmd.errors]).render(response) }
                json { new JSON([errors: cmd.errors]).render(response) }
            }
        } else {
            try {
                def resp = lbaasService.updatePolicy(params, params.tenantName)
                def model = [resp: resp]
                withFormat {
                    html { redirect(action: 'listJobs') }
                    xml { new XML(model).render(response) }
                    json { new JSON(model).render(response) }
                }
            } catch (RestClientRequestException e) {
                response.status = ExceptionUtils.getExceptionCode(e)
                def errors = ExceptionUtils.getExceptionMessage(e)
                withFormat {
                    html { flash.message = errors; chain(action: 'editPolicy', params: params) }
                    xml { new XML([errors: errors]).render(response) }
                    json { new JSON([errors: errors]).render(response) }
                }
            }
        }
    }

    def savePolicy = { PolicyValidationCommand cmd ->
        if (cmd.hasErrors()) {
            withFormat {
                html { chain(action: 'createPolicy', model: [cmd: cmd], params: params) }
                xml { new XML([errors: cmd.errors]).render(response) }
                json { new JSON([errors: cmd.errors]).render(response) }
            }
        } else {
            try {
                def resp = lbaasService.createPolicy(params, params.tenantName)
                def model = [resp: resp]
                withFormat {
                    html { redirect(action: 'listJobs') }
                    xml { new XML(model).render(response) }
                    json { new JSON(model).render(response) }
                }
            } catch (RestClientRequestException e) {
                response.status = ExceptionUtils.getExceptionCode(e)
                def errors = ExceptionUtils.getExceptionMessage(e)
                withFormat {
                    html { flash.message = errors; chain(action: 'createPolicy', params: params) }
                    xml { new XML([errors: errors]).render(response) }
                    json { new JSON([errors: errors]).render(response) }
                }
            }
        }
    }

    def defineRedirectParams(def params) {
        if (params.tenantName) {
            redirect(action: 'listPolicies', params: [tenantName: params.tenantName])
        } else {
            redirect(action: 'listPolicies')
        }
    }

}

class PoolCreateCommand {
    String name
    String lbMethod
    def monitors
    String enabled
    static constraints = {
        name(nullable: false, blank: false)
        lbMethod(nullable: false, blank: false)
        monitors(nullable: false)
        enabled(nullable: true, blank: true, matches: /on/)
    }
}

class ServiceCreateCommand {

    String instanceId
    String netInterface
    String port
    String weight
    String enabled

    static constraints = {
        instanceId(nullable: false, blank: false)
        netInterface(nullable: false, blank: false)
        port(nullable: false, blank: false, matches: /\d+/)
        weight(nullable: false, blank: false, matches: /\d+/)
        enabled(nullable: true, blank: true, matches: /on/)
    }
}


class VipValidationCommand {
    String ip
    String name
    String port
    String protocol
    String enabled

    static constraints = {
        ip(nullable: false, blank: false, matches: /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/)
        name(nullable: false, blank: false)
        port(nullable: false, blank: false, validator: { port, obj ->
            return ValidatorUtils.checkInteger(port)
        })
        enabled(nullable: true, blank: true, matches: /on/)
        protocol(nullable: false, blank: false)
    }
}

class PolicyValidationCommand {

    String name
    String rule

    static constraints = {
        name(nullable: false, blank: false, matches: /\w[\w\-]*/)
        rule(nullable: false, blank: false)
    }
}

