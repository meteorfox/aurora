<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="settings"/> 
    <meta name="menu-level-2" content="projects"/> 
    <meta name="menu-level-3" content="Project Detail - ${tenant.name}"/>      
    <title>Project Detail - ${tenant.name}</title>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'tenants.js')}"></script>
    <script>
      jQuery(function() {
        ManageTenants.loadTenantUsers('${tenant.id}');
      });
    </script>
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
            <ul class="nav nav-tabs nav-tabs-left">
              <li class="active"><a data-toggle="tab" href="#tenant-details">Project Details</a></li>
              <li><a data-toggle="tab" href="#tenant-quotas"><i class="icon-hdd"></i> <span>Quotas</span></a></li>
              <li><a data-toggle="tab" href="#tenant-users"><i class="icon-group"></i> <span>Users</span></a></li>
            </ul>
            <ul class="box-toolbar">
              <li><g:link class="edit btn btn-blue btn-xs" elementId="edit" action="edit" params="[id:tenant.id]" 
                          title="Edit this project">Edit Project</g:link></li>
              <li><g:link class="edit btn btn-blue btn-xs" elementId="editQuotas" action="quotas" params="[id:tenant.id]" 
                          title="Edit quotas for this project">Edit Quotas</g:link></li>
              <li><button class="btn btn-green btn-xs" elementId="addUsers" 
                          onclick="ManageTenants.showAddUserForm('${tenant.id}');">Add Users</button></li>
              <li>
              <g:form>
                <input type="hidden" name="id" value="${tenant.id}"/>
                <input type="hidden" name="name" value="${tenant.name}"/>

                <g:buttonSubmit class="btn btn-red btn-xs delete" 
                                id="delete" value="Remove Project" action="delete" 
                                data-warning="Really remove project?" title="Remove this project"/>
              </g:form>            
              </li>
            </ul>
          </div>

          <div class="box-content">
            <div class="tab-content">
              <div id="tenant-details" class="tab-pane active">
                <table id="table_tenantShow" class="table table-normal">
                  <tbody>
                    <tr><td>Id</td><td>${tenant.id}</td></tr>
                    <tr><td>Name</td><td>${tenant.name}</td></tr>
                    <tr><td>Description</td><td>${tenant.description}</td></tr>
                    <tr>
                      <td>Enabled</td>
                      <td>${tenant.enabled?'Enabled':'Disabled'}</td>
                    </tr>
                    <tr>
                      <td>Zones</td>
                      <td>
                  <g:each in="${tenant.zones}" var="zone">
                    ${zone}<br/>
                  </g:each>
                  </td>
                  </tr>
                  </tbody>
                </table>
              </div>
              <div id="tenant-quotas" class="tab-pane">
                  <g:render template="quotas"/>     
              </div>
              <div id="tenant-users" class="tab-pane">
                  
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
  </body>
</html>
