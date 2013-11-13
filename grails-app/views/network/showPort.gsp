<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>    
    <meta name="menu-level-1" content="networking"/>
    <meta name="menu-level-2" content="networks"/>   
    <meta name="menu-level-3" content="Port Detail"/> 

    <title>Port Detail</title>
    
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
        <div class="box">
          <div class="box-header">
            <span class="title">Port Overview</span>
            <ul class="box-toolbar">
              <li><g:link elementId="edit" class="btn btn-xs btn-blue" 
                          action="editPort" params="[id:port.id]" 
                          title="Edit this port">Edit Port</g:link></li>
            </ul>
          </div>
          <div class="box-content">

            <table id="table_showPort" class="table table-normal">
              <tbody>

                <tr title="Application name from Cloud Application Registry">
                  <td>Name</td>
                  <td>${port.name == "" ? 'None' : port.name}</td>
                </tr>
                <tr>
                  <td>ID</td>
                  <td>${port.id}</td>
                </tr>
                <tr>
                  <td>Network ID</td>
                  <td>${port.networkId}</td>
                </tr>
                <tr>
                  <td>Project ID</td>
                  <td>${port.tenantId}</td>
                </tr>
                <tr>
                  <td>Fixed IPs</td>
                  <td>
              <g:each in="${port.fixedIps}" var="fixedIp">
                <strong>Subnet ID</strong> ${fixedIp.subnet_id},  <strong>IP Address</strong> ${fixedIp.ip_address} <br/> <br/>
              </g:each>
              </td>
              </tr>
              <tr>
                <td>Mac Address</td>
                <td>${port.macAddress}</td>
              </tr>
              <tr>
                <td>Status</td>
                <td>${port.status}</td>
              </tr>
              <tr>
                <td>Admin State</td>
                <td>${port.adminStateUp ? 'UP' : 'DOWN'}</td>
              </tr>
              <tr>
                <td>Device ID</td>
                <td>${port.deviceId ? port.deviceId : '-'}</td>
              </tr>
              <tr>
                <td>Device Owner</td>
                <td>${port.deviceOwner ? port.deviceOwner : '-'}</td>
              </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
