<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="compute"/> 
    <meta name="menu-level-2" content="instances"/> 
    <meta name="menu-level-3" content="Instance Detail"/> 
    <script type="text/javascript" src="${resource(dir: 'js', file: 'instances-ui.js')}"></script>
    <script type="text/javascript">
      
        var userName = "<shiro:principal/>";
        var instanceId = "${instance.instanceId}";
        jQuery(document).ready(function() {
            loadFloatingIPsForShow();
        });
  </script>    
    <title>${instance?.name} Instance</title>
  </head>

  <body>

    <div id="credentialsHint">
      <g:render template="credentialsHint"/>
    </div>
    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div id="message" class="message alert alert-info">${flash.message}</div>
            </g:if>      
          </div>
        </div>
        <div class="box">
          <div class="box-header">
            <span class="title">Instance Details</span>
            <g:if test="${instance}">
              <g:form class="validate">
                <input type="hidden" id="input-hidden_instShow_instanceId" name="instanceId"
                       value="${instance.instanceId}"/>
                <ul class="box-toolbar" id="instance_show_buttons_area">     
                  <g:if test="${!instance.taskStatus}">
                    <li><g:link class="btn btn-xs btn-blue" elementId="rename" action="edit"
                                params="[id: instance.instanceId]" title="Change instance name">Rename</g:link></li>
                    <g:if test="${instance.status == 'Active'}">
                      <li><g:link class="btn btn-xs btn-green" action="snapshot" elementId="snapshot"
                                  params="[id: instance.instanceId]" title="Create snapshot from this instance">Create Snapshot</g:link></li>
                      <li><g:buttonSubmit class="btn btn-xs btn-gray" id="log" 
                                          action="log" value="View Log" title="View instance work log"/></li>
                      <li><g:buttonSubmit class="btn btn-xs btn-gray" id="vnc" 
                                          action="vnc" value="VNC Console" title="Open VNC console for instance"/></li>
                      <li><g:buttonSubmit class="btn btn-xs btn-gold" id="pause" 
                                          data-warning="Really Pause: ${instance.name}?"
                                          action="pause" value="Pause Instance" title="Stop VM with saving content in RAM"/></li>
                      <li><g:buttonSubmit class="btn btn-xs btn-gold" id="suspend" 
                                          data-warning="Really Suspend: ${instance.name}?"
                                          action="suspend" value="Suspend Instance" title="Stop VM with saving content on disk"/></li>
                    </g:if>
                    <g:if test="${instance.status == 'Active' || instance.status == 'Shutoff'}">
                      <li><g:buttonSubmit class="btn btn-xs btn-gold" id="reboot" 
                                          data-warning="Really Reboot: ${instance.name}?"
                                          action="reboot" value="Reboot Instance" title="Restart the OS of the instance"/></li>
                    </g:if>
                    <g:if test="${instance.status == 'Paused'}">
                      <li><g:buttonSubmit class="btn btn-xs btn-green" id="unpause" action="unpause" value="Unpause Instance" title="Resume VM work"/></li>
                    </g:if>
                    <g:if test="${instance.status == 'Suspended'}">
                      <li><g:buttonSubmit class="btn btn-xs btn-green" id="resume" action="resume" value="Resume Instance" title="Resume VM work"/></li>
                    </g:if>
                    <li><g:buttonSubmit class="btn btn-xs btn-red" id="terminate" data-warning="Really Terminate: ${instance.instanceId}?"
                                        action="terminate" value="Terminate Instance"
                                        title="Shut down and delete this instance"/></li>
                  </g:if>
                  <g:else>
                    <li><b id="taskStatus">${instance.taskStatus}</b><i class="icon-cog icon-spin"></i></li>
                  </g:else>
                </ul>
              </g:form>
            </g:if>
          </div>

          <div class="box-content">
            <div class=row>
              <div class="col-lg-6">
                <table class="table table-normal table-bordered">
                  <thead><tr><td colspan="2">Soemthinnd</td></tr></thead>
                  <tbody>
                    <tr><td>Name</td><td>${instance.name}</td></tr>
                    <tr><td>ID</td><td>${instance.instanceId}</td></tr>
                    <tr><td>Status</td><td>${instance.status}</td></tr>
                    <tr><td>Flavor</td>
                      <td>${flavor.name}&nbsp;&nbsp;
                        <span class="badge badge-purple">RAM ${flavor.memory} MB</span>&nbsp;
                        <span class="badge badge-purple">VCPUs ${flavor.vcpu}</span>&nbsp;
                        <span class="badge badge-purple">Disk ${flavor.disk} GB</span>
                      </td>
                    </tr>
                  </tbody>
                </table>

                <table id="table_servicesInstance" class="hide table table-normal table-bordered">
                    <thead>
                    <tr>
                        <td colspan="4">Load Balancer Services</td>
                    </tr>  
                    <g:if test="${services.size() != 0}">
                    <tr>
                        <td>Name</td>
                        <td>IP:Port</td>
                        <td>Pool</td>
                        <td>Enabled</td>
                    </tr>
                    </g:if>
                    </thead>
                    <tbody>
                    <g:each in="${services}" var="service">
                        <tr>
                            <td>${service.name}</td>
                            <td>${service.ip}:${service.port}</td>
                            <td>${service.pool}</td>
                            <td>${service.enabled}</td>
                        </tr>
                    </g:each>
                    <g:if test="${services.size()==0}">
                    <tr><td colspan="4">Not added to any pools.</td></tr>
                    </g:if>
                    </tbody>
                </table>              
              </div>
              <div class="col-lg-6">
                <table class="table table-normal table-bordered">
                  <thead><tr><td colspan="2">IP addresses and FQDN</td></tr></thead>
                  <tbody>
                  <g:each in="${instance.networks}" var="network">
                    <tr>
                      <td>${network.pool}</td>
                      <td>
                        
                        ${network.ip}&nbsp;<g:if test="${network.fqdn}">(${network.fqdn})</g:if>
                    <button type="button" class="btn btn-xs btn-blue" 
                                    onclick="showLoginHelp('${network.ip}')" 
                                    title="${network.ip}">Login</button>
                    </td>
                    </tr>
                  </g:each>
                  </tbody>
                </table> 
                <br/>                  
                <table class="table table-normal table-bordered">
                  <thead>
                    <tr>
                      <td colspan="2">
                          Floating IP Addresses & FQDN 
                          <g:if test="${showAssociateButton}">
                            <g:link controller="network" elementId="associate" action="associateFloatingIp" 
                                    title="Associate floating IP to instance" 
                                    params="[instanceId:instance.instanceId]"
                                    class="hide btn btn-xs btn-blue">
                                <i class="icon-plus"></i></g:link></g:if>
                      </td>
                    </tr>
                  </thead>
                  <tbody>
                    <tr id="instanceFloatingIps"><td></td></tr>
                      <tr><td>Security Groups</td><td>${instance.securityGroups.join('<br/>')}</td></tr>
                      <tr><td>Key Name</td><td>${instance.keyName}</td></tr>
                      <tr><td>Image Name</td><td>${image.name}</td></tr>
                      <tr><td>Image ID</td><td><g:linkObject type="image" id="${image.id}"/></td></tr>
                </tbody>
                </table>
                
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>


</tr>