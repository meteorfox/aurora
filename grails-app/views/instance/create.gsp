<%@ page import="com.paypal.aurora.InstanceController; com.paypal.aurora.OpenStackRESTService" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="compute"/>
    <meta name="menu-level-2" content="instances"/>
    <meta name="menu-level-3" content="Launch Instance"/>
    <title>Launch Instance</title>
    <script type="text/javascript">
        var snapshotString = "${InstanceController.InstanceSources.SNAPSHOT}";
        var imageString = "${InstanceController.InstanceSources.IMAGE}";
        var bootFromSnapshotString = "${InstanceController.VolumeOptions.BOOT_FROM_SNAPSHOT}";
        var notBootString = "${InstanceController.VolumeOptions.NOT_BOOT}";
        var bootFromVolumeString = "${InstanceController.VolumeOptions.BOOT_FROM_VOLUME}";
    </script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'ddautorefresh.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'instances-ui.js')}"></script>
    <script>
        jQuery(document).ready(function () {
            initCreatePage();
        });
    </script>
</head>

<body>
<div class="body">
<div class="container">
<div class="row">
    <div class="col-md-12">
        <g:if test="${flash.message}">
            <div id="message" class="message alert alert-info">${flash.message}</div>
        </g:if>
        <div id="info_box" class="hide">${flash.message}</div>
        <g:hasErrors bean="${cmd}">
            <div class="alert alert-error">
                <g:renderErrors bean="${cmd}" as="list"/>
            </div>
        </g:hasErrors>
    </div>
</div>

<div class="row">
<div class="col-md-8">
<g:form action="save" method="post" class="validate allowEnterKeySubmit form-horizontal fill-up">
<div class="box">
<div class="box-header">
    <div class="title">Launch Instance</div>

    <ul class="nav nav-tabs nav-tabs-right">
        <li class="active"><a data-toggle="tab" href="#detailsTab" id="details">Details</a></li>

        <li><a data-toggle="tab" href="#accessAndSecurityTab"
               id="accessAndSecurity">Access and security</a></li>
        <g:if test="${params.quantumEnabled}">
            <li class="hide"><a data-toggle="tab" href="#networkingTab"
                                id="networking">Networking</a></li>
        </g:if>
        <g:ifServiceEnabled name="${OpenStackRESTService.NOVA_VOLUME}">
            <li><a data-toggle="tab" href="#volumeOptionsTab"
                   id="volumeOptions">Volume options</a></li>
        </g:ifServiceEnabled>
        <li><a data-toggle="tab" href="#postCreationTab" id="postCreation">Post-Creation</a>
        </li>
    </ul>

</div>

<div class="box-content padded">
    <div class="tab-content" style="min-height:240px;">
        <div id="detailsTab" class="tab-pane active">
            <div class="form-group">
                <label class="control-label col-lg-3">Instance source</label>

                <div class="col-lg-5">
                    <g:select id="cb_instance_source" name="instanceSources"
                              from="${params.instanceSourcesArray}"
                              optionValue="displayName"
                              value="${params.selectedInstanceSource}"/>
                </div>
            </div>

            <div class="form-group" id="imageSources">
                <label class="control-label col-lg-3">Image</label>

                <div class="col-lg-5">
                    <g:select id="cb_image" name="image" from="${params.images}"
                              optionKey="id" optionValue="name" value="${params.image}"/>
                </div>
            </div>

            <div class="form-group" id="snapshotSources">
                <label class="control-label col-lg-3">Snapshot</label>

                <div class="col-lg-5">
                    <g:select id="select_instCreate_snapshot" name="snapshot"
                              from="${params.snapshots}"
                              optionKey="id" optionValue="name" value="${params.snapshot}"/>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-3">Name</label>

                <div class="col-lg-5">
                    <g:textField id="input_instCreate_name" name="name" value="${params.name}"/>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-3">Flavor</label>

                <div class="col-lg-5">
                    <g:select id="cb_flavor" name="flavor" from="${params.flavors}"
                              optionKey="id" optionValue="name" value="${params.flavor}"/>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-3">Instance Count</label>

                <div class="col-lg-5">
                    <g:textField id="input_instCreate_count" name="count"
                                 value="${params.count}"/>
                </div>
            </div>
            <g:if test="${params.needDatacenter}">
                <input type="hidden" name="datacenter" value="${params.datacenter}"/>
            </g:if>

        </div>

        <div id="accessAndSecurityTab" class="tab-pane">
            <div class="form-group">
                <label class="control-label col-lg-3">Keypair</label>

                <div class="col-lg-5">
                    <g:select id="cb_keypair" name="keypair" from="${params.keypairs}"
                              value="${params.keypair}"/>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-lg-3">Security Groups</label>

                <div class="col-lg-5">
                    <g:each in="${params.securityGroupsArray}" var="securityGroup">
                        <g:checkBox name="securityGroups" id="checkbox_${securityGroup.name}"
                                    value="${securityGroup.name}" class="icheck"
                                    checked="${params.securityGroups?.contains(securityGroup.name)}"/>
                        <label>${securityGroup.name}</label><br/>
                    </g:each>
                </div>
            </div>

        </div>

        <g:if test="${params.networksArray}">

            <div id="networkingTab" class="hide tab-pane">
                <div class="form-group">
                    <label class="control-label col-lg-3">Networking</label>

                    <div class="col-lg-7">
                        <g:each in="${params.networksArray}" var="network">
                            <g:checkBox name="networks" id="checkbox_${network.name}"
                                        value="${network.id}" class="icheck"
                                        checked="${params.networks?.contains(network.id)}"/>
                            <label>${network.name}</label><br/>
                        </g:each>
                    </div>
                </div>
            </div>
        </g:if>
        <g:ifServiceEnabled name="${OpenStackRESTService.NOVA_VOLUME}">
            <div id="volumeOptionsTab" class="tab-pane">
                <div class="form-group">
                    <label class="control-label col-lg-3">Volume options</label>

                    <div class="col-lg-5">
                        <g:select id="cb_options" name="volumeOptions"
                                  from="${params.volumeOptionsArray}"
                                  optionValue="displayName" value="${params.volumeOptions}"/>
                    </div>
                </div>

                <div class="form-group" id="volumes">
                    <label class="control-label col-lg-3">Volume</label>

                    <div class="col-lg-5">
                        <g:select id="cb_vol_type" name="volume" from="${params.volumes}"
                                  optionKey="id" optionValue="displayName"
                                  value="${params.volume}"/>
                    </div>
                </div>

                <div class="form-group" id="volumeSnapshots">
                    <label class="control-label col-lg-3">Volume snapshot</label>

                    <div class="col-lg-4">
                        <g:select id="cb_volumeSnapshot" name="volumeSnapshot"
                                  from="${params.volumeSnapshots}"
                                  optionKey="id" optionValue="name"
                                  value="${params.snapshotId}"/>
                    </div>
                </div>

                <div class="form-group" id="deviceName">
                    <label class="control-label col-lg-3">Device Name</label>

                    <div class="col-lg-5">
                        <g:textField id="input_instCreate_deviceName" name="deviceName"
                                     value="${params.deviceName}"/>
                    </div>
                </div>

                <div class="form-group" id="deleteOnTerminate">
                    <label class="control-label col-lg-3">Delete on Terminate</label>

                    <div class="col-lg-5">
                        <g:checkBox class="icheck" id="checkbox_instCreate_deleteOnTerminate"
                                    name="deleteOnTerminate"
                                    value="${params.deleteOnTerminate ?: false}"/>
                    </div>
                </div>
            </div>
        </g:ifServiceEnabled>

        <div id="postCreationTab" class="tab-pane">
            <div class="form-group">
                <label class="control-label col-lg-3">Customization script</label>

                <div class="col-lg-7">
                    <g:textArea rows="6" id="customizationScript" name="customizationScript"
                                value="${params.customizationScript}"/>
                </div>
            </div>
        </div>
    </div>

</div>

<div class="box-footer">
    <div class="form-actions">
        <g:buttonSubmit class="save btn btn-green" id="submit" action="save"
                        title="Create new instance with selected parameters">Launch Instance</g:buttonSubmit>
    </div>
</div>
</div>
</g:form>
</div>
</div>
</div>
</div>
</body>
</html>