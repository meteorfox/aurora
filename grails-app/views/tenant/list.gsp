<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="settings"/>    
    <meta name="menu-level-2" content="projects"/>  
    <title>Projects</title>
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
        <g:form method="post" class="validate">
          <div class="box">
            <div class="box-header">
              <span class="title">Projects</span>
              <ul class="box-toolbar">
                <li><g:link elementId="create" class="create btn btn-green btn-xs" 
                            action="create" title="Create New Project">Create Project</g:link></li>
                <g:if test="${tenants}">
                  <li>
                  <g:buttonSubmit class="delete btn btn-red btn-xs" id="delete" action="delete"
                                  data-warning="Really Remove Project(s)?" title="Remove Selected Tenant(s)">
                    Remove Project(s)</i>
                  </g:buttonSubmit>
                  </li>
                </g:if>
              </ul>
            </div>        
            <div class="box-content list">
              <table id="table_tenantList" class="sortable table table-normal filtered">
                <thead>
                  <tr>
                    <td class="checkboxTd">&thinsp;x</td>
                    <td>Name</td>
                    <td>Description</td>
                    <td>Enabled</td>
                  </tr>
                </thead>
                <tbody>
                <g:each var="tenant" in="${tenants}" status="i">
                  <tr>
                    <td><g:if test="${tenant.id}"><g:checkBox id="checkBox_${tenant.id}" name="selectedTenants" value="${tenant.id}"
                                                            checked="0"/></g:if></td>
                  <td><g:linkObject elementId="tenant-${tenant.id}" displayName="${tenant.name}" type="tenant" id="${tenant.id}"/></td>
                  <td>${tenant.description}</td>
                  <td>${tenant.enabled}</td>
                  </tr>
                </g:each>
                </tbody>
              </table>
            </div>
            <div class="box-footer">
              <div class="paginateButtons">
              </div>
            </div>
          </div>
        </g:form>

      </div>
    </div>
  </body>
</html>
