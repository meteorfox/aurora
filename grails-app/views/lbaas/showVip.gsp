<html>
  <head>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="lbaas"/>
    <meta name="menu-level-2" content="vips"/> 
    <meta name="menu-level-3" content="VIP Detail"/> 
    <title>Vip Detail ${vip.name}</title>
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
            <span class="title">VIP Detail ${vip.name}</span>
            <g:form>
              <input type="hidden" id="id" name="id" value="${vip.name}"/>
              <ul class="box-toolbar">
                <li><g:buttonSubmit class="btn btn-xs btn-red delete" id="delete" 
                                    value="Remove VIP" action="deleteVip" 
                                    data-warning="Really remove vip?" title="Remove this virtual IP address"/></li>
              </ul>
            </g:form>
          </div>
          <div class="box-content">   
            <table id="table_lbassShowVip" class="table table-normal">
              <tbody>
                <tr>
                  <td>Ip</td>
                  <td>${vip.ip}</td>
                </tr>
                <tr>
                  <td>Name</td>
                  <td>${vip.name}</td>
                </tr>
                <tr>
                  <td>Port</td>
                  <td>${vip.port}</td>
                </tr>
                <tr>
                  <td>Protocol</td>
                  <td>${vip.protocol}</td>
                </tr>
                <tr>
                  <td>Enabled</td>
                  <td>${vip.enabled}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
