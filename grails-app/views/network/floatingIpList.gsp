<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="networking"/>
    <meta name="menu-level-2" content="floatingips"/>   
    <title>Floating IPs</title>
  </head>

  <body>
    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div id="message" class="message alert alert-info">${flash.message}</div>
            </g:if>          
          </div>
        </div>
        <g:form method="post">
          <div class="box">
            <div class="box-header">
              <span class="title">Floating IPs</span>
              <ul class="box-toolbar">
                <li><g:link elementId="allocate" class="btn btn-xs btn-green" 
                            action="allocateFloatingIp" 
                            title="Allocate new floating IP address">Allocate new IP</g:link></li>
                <g:if test="${floatingIps}">
                  <li><g:buttonSubmit id="release" class="btn btn-xs btn-red delete" value="Release floating IP(s)" action="releaseFloatingIp"
                                      data-warning="Really release IP(s)?" title="Release selected IP(s)"/></li>
                </g:if>
              </ul>
            </div>
            <div class="box-content">
              <table id="table_floatingIpList" class="table table-normal sortable filtered">
                <tr>
                  <td class="checkboxTd">&thinsp;x</td>
                  <td>IP</td>
                <g:if test="${showFqdn}">
                  <td>FQDN</td>
                </g:if>
                <td>Instance</td>
                <td>Pool</td>
                </tr>
                <g:each in="${floatingIps}" var="fip">
                  <tr>
                    <td>
                  <g:if test="${fip.id}">
                    <g:checkBox id="checkBox_${fip.id}" name="selectedIps"
                                value="${fip.id}"
                                checked="0" class="requireLogin"/>
                  </g:if>
                  </td>
                  <td>
                  <g:linkObject type="network" action="showFloatingIp" id="${fip.id}" displayName="${fip.ip}"/>
                  </td>
                  <g:if test="${showFqdn}">
                    <td>${fip.fqdn}</td>
                  </g:if>
                  <td>
                  <g:if test="${fip.instanceId}">
                    <g:linkObject type="instance" id="${fip.instanceId}"
                                  displayName="${instances.find { it.instanceId == fip.instanceId }.name}"/>
                  </g:if>
                  </td>
                  <td>${fip.pool}</td>

                  </tr>
                </g:each>
              </table>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>