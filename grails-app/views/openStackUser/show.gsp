<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="settings"/> 
    <meta name="menu-level-2" content="users"/> 
    <meta name="menu-level-3" content="User Details"/>

    <title>User '${user.name}'</title>
</head>

<body>
<div class="body">
  
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div id="message" class="message alert alert-info">${flash.message}</div>
            </g:if>          
            <g:hasErrors bean="${cmd}">
                <div id="error_message" class="error alert alert-error">
                    <g:renderErrors bean="${cmd}" as="list"/>
                </div>
            </g:hasErrors>            
          </div>
        </div>

    <g:form method="post">
      <input type="hidden" id="id" name="id" value="${user.id}"/>
      <div class="box">
        <div class="box-header">
          <span class="title">User Details</span>
          <ul class="box-toolbar">
            <li><g:link elementId="edit" class="btn btn-xs btn-blue" action="edit" params="[id: user.id]" title="Edit user attributes">Edit User</g:link></li>
            <li><g:buttonSubmit class="delete btn btn-xs btn-red" id="delete" value="Delete User" action="delete"
                            data-warning="Really delete user?" title="Delete this user"/></li>
          </ul>
        </div>
        <div class="box-content">
            <table id="OSUserShow" class="table table-normal">
                <tbody>
                <tr>
                    <td>Name</td>
                    <td>${user.name}</td>
                </tr>
                <tr>
                    <td class="email">Email</td>
                    <td>${user.email}</td>
                </tr>
                <tr>
                    <td>Default Project</td>
                    <td>${tenant.name}</td>
                </tr>
                <g:if test="${tenant.id}">
                    <tr>
                        <td>Default Project ID</td>
                        <td><g:linkObject elementId="${tenant.id}" type="tenant" id="${tenant.id}"/></td>
                    </tr>
                </g:if>
            </table>
        </div>
      </div>
    </g:form>
      </div>
      </div>
</body>
</html>
