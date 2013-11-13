<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="networking"/>
    <meta name="menu-level-2" content="networks"/>   
    <meta name="menu-level-3" content="Subnet Detail"/> 
    <title>Subnet Detail</title>
    
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
            <span class="title">Subnet Overview</span>
            <ul class="box-toolbar">
              <li><g:link elementId="edit" class="btn btn-xs btn-blue" 
                          action="editSubnet" params="[id:subnet.id]" title="Edit this subnet">Edit Subnet</g:link></li>
            </ul>
          </div>
          <div class="box-content">
            <table id="table_showSubnet" class="table table-normal">
              <tbody>

                <tr title="Application name from Cloud Application Registry">
                  <td>Name</td>
                  <td>${subnet.name == "" ? 'None' : subnet.name}</td>
                </tr>
                <tr>
                  <td>ID</td>
                  <td>${subnet.id}</td>
                </tr>
                <tr>
                  <td>Network ID</td>
                  <td>${subnet.networkId}</td>
                </tr>
                <tr>
                  <td>CIDR</td>
                  <td>${subnet.cidr}</td>
                </tr>
                <tr>
                  <td>IP Version</td>
                  <td>${subnet.ipVersion}</td>
                </tr>
                <tr>
                  <td>Gateway IP</td>
                  <td>${subnet.gatewayIp}</td>
                </tr>
                <tr>
                  <td>DHCP Enable</td>
                  <td>${subnet.enableDhcp ? 'YES' : 'NO'}</td>
                </tr>
                <tr>
                  <td>IP allocation pool</td>
                  <td>
              <g:each in="${subnet.allocationPools}" var="allocationPool">
                Start ${allocationPool.start} - End ${allocationPool.end}
              </g:each>
              </td>
              </tr>
              <tr>
                <td>DNS</td>
                <td>
              <g:each in="${subnet.dnsNameservers}" var="dnsNameServer">
${dnsNameServer}
              </g:each>
              </td>
              </tr>
              <tr>
                <td>Additional routes</td>
                <td>
              <g:each in="${subnet.hostRoutes}" var="hostRouter">
                Destination ${hostRouter.destination} Next hop ${hostRouter.nexthop} <br/> <br/>
              </g:each>
              </td>
              </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
