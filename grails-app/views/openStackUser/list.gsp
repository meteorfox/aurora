<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="settings"/> 
    <meta name="menu-level-2" content="users"/>  
    <title>Users</title>
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
              <span class="title">Users</span>
              <ul class="box-toolbar">
                <li><g:link elementId="create" class="btn btn-green btn-xs" action="create" 
                            title="Create New User">Create User</g:link></li>
                <li><g:if test="${openStackUsers}">
                  <g:buttonSubmit class="delete btn btn-red btn-xs" id="delete" action="delete"
                                  data-warning="Really delete user(s)?" title="Delete selected user(s)">
                    Delete User(s)
                  </g:buttonSubmit>
                </g:if></li>
              </ul>
            </div>
            <div class="box-content list">
              <table id="table_OSUserList" class="sortable table table-normal filtered">
                <thead>
                  <tr>
                    <td class="checkboxTd">&thinsp;x</td>
                    <td>User Name</td>
                    <td>User Email</td>
                    <td>Enabled</td>
                  </tr>
                </thead>
                <tbody>
                <g:each var="openStackUser" in="${openStackUsers}" status="i">
                  <tr>
                    <td><g:checkBox id="checkBox_${openStackUser.id}" name="selectedUsers" value="${openStackUser.id}" checked="0"/></td>
                  <td><g:linkObject displayName="${openStackUser.name}" elementId="openStackUser-${openStackUser.id}" type="openStackUser" id="${openStackUser.id}"/></td>
                  <td>${openStackUser.email}</td>
                  <td>${openStackUser.enabled ? 'enabled' : 'disabled'}</td>
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
