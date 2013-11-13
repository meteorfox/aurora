<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="lbaas"/>
    <meta name="menu-level-2" content="vips"/> 
    <title>Vips</title>
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
        <g:form method="post">
          <div class="box">
            <div class="box-header">
              <span class="title">VIPs</span>
              <ul class="box-toolbar">
                <li><g:link elementId="create" class="btn btn-xs btn-green" action="createVip" 
                            title="Create New Virtual IP Address">Create VIP</g:link></li>
                <g:if test="${vips}">
                  <li><g:buttonSubmit class="btn btn-xs btn-red delete" id="delete" 
                                      value="Remove VIP(s)" action="deleteVip"
                                      data-warning="Really remove vip(s)?" title="Remove selected vip(s)"/></li>
                </g:if>
              </ul>
            </div>
            <div class="box-content">      
              <table id="table_lbassListVips" class="table table-normal sortable filtered">
                <thead>
                  <tr>
                    <td class="checkboxTd">&thinsp;x</td>
                    <td>VIP Name</td>
                    <td>IP</td>
                    <td>Port</td>
                  </tr>
                </thead>
                <tbody>
                <g:each var="vip" in="${vips}" status="i">
                  <tr>
                    <td><g:if test="${vip.name}"><g:checkBox id="checkBox_${vip.name}" name="selectedVips" value="${vip.name}"
                                                           checked="0"/></g:if></td>
                  <td><g:link id="${vip.name}" action="showVip">${vip.name}</g:link>
                  <td>${vip.ip}</td>
                  <td>${vip.port}</td>
                  </tr>
                </g:each>
                </tbody>
              </table>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>