<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="networking"/> 
    <meta name="menu-level-2" content="routers"/> 
    <meta name="menu-level-3" content="Router Detail"/>  
    <title>Router Detail</title>
    
  </head>
  <body>
    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div id="message" class="alert alert-info">${flash.message}</div>
            </g:if>    
          </div>
        </div>
        <div class="box">
          <div class="box-header">
            <span class="title">Router Overview</span>
            <g:form>
              <input type="hidden" id="id" name="id" value="${router.id}"/>
              <ul class="box-toolbar">

                <g:if test="${router.externalGatewayInfo}">
                  <li><g:buttonSubmit id="clearGateway" class="btn btn-xs btn-red delete" 
                                      value="Clear gateway(s)" action="clearGateway"
                                      data-warning="Really clear gateway?" params="[id:router.id]" 
                                      title="Clear Gateway for this router"/></li>
                </g:if>
                <g:else>
                  <li><g:link class="btn btn-xs btn-blue" action="setGateway" 
                              elementId="setGateway" params="[id:router.id]" 
                              title="Set Gateway for this router">Set Gateway</g:link>
                </g:else>
              </ul>
            </g:form>
          </div>
          <div class="box-content">
            <table id="table_showRouter" class="table table-normal">
              <tbody>
                <tr>
                  <td>Name</td>
                  <td>${router.name == '' ? 'None' : router.name}</td>
                </tr>
                <tr>
                  <td>ID</td>
                  <td>${router.id}</td>
                </tr>
                <tr>
                  <td>Status</td>
                  <td>${router.status}</td>
                </tr>
                <tr>
                  <td>External Gateway Information</td>
                  <td>${router.externalGatewayInfo ? 'Connected External Network:' + router.externalGatewayInfo.networkName : '-'}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="box">
          <g:form method="post" class="validate">
            <div class="box-header">
              <span class="title">Interfaces</span>

              <ul class="box-toolbar">
                <li class="hide"><g:link elementId="addInterface" class="btn btn-xs btn-green" 
                            action="addInterface" params="[id:router.id]" 
                            title="Add new interface for this router">Add Interface</g:link></li>
                <li class="hide"><g:buttonSubmit id="deleteInterface" class="btn btn-xs btn-red delete" 
                                    value="Remove Interface(s)" action="deleteInterface"
                                    data-warning="Really remove Interface(s)?" 
                                    title="Delete selected interface(s)"/></li>
              </ul>
            </div>
            <div class="box-content">
              <table class="table table-normal sortable" id="subnets">
                <tr>
                  <td class="checkboxTd">&thinsp;x</td>
                  <td>Name</td>
                  <td>Fixed IPs</td>
                  <td>Status</td>
                  <td>Type</td>
                  <td>Admin State</td>
                </tr>
                <g:each in="${router.ports}" var="port" status="i">
                  <tr>
                    <td><g:if test="${port}"><g:checkBox name="selectedPorts" value="${port.id}"
                                                       checked="0" class="requireLogin"/></g:if></td>
                  <td><g:linkObject type="network" displayName="${port.name == "" ? '(' + port.id.substring(0,8) + ')' : port.name}"
                                    id ="${port.id}" action="showPort" elementId="port-${port.id}"/></td>
                  <td>
                  <g:each in="${port.fixedIps}" var="fixedIp">${fixedIp.ip_address} <br/>
                  </g:each>
                  </td>
                  <td>${port.status}</td>
                  <td>-</td>
                  <td>${port.adminStateUp ? 'UP' : 'DOWN'}</td>
                  </tr>
                </g:each>
              </table>
              <g:hiddenField name="id" id="id" value="${router.id}"/>
            </div>
          </g:form>
        </div>
      </div>
    </div>
  </body>
</html>
