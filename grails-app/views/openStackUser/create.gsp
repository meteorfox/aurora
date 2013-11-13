<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="settings"/> 
    <meta name="menu-level-2" content="users"/> 
    <meta name="menu-level-3" content="Create New"/>     
    <title>Create New User</title>
  </head>

  <body>
    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div id="message" class="alert alert-info">${flash.message}</div>
            </g:if>    
            <g:hasErrors bean="${cmd}">
              <div id="error_message" class="alert alert-error">
                <g:renderErrors bean="${cmd}" as="list"/>
              </div>
            </g:hasErrors>
          </div>
        </div>
        <div class="box">
          <div class="box-header">
            <span class="title">Create New User</span>
          </div>
          <div class="box-content">      
            <g:form action="save" method="post" class="form-horizontal fill-up validate">
              <div class="padded">
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Name *</label>
                  <div class="col-lg-4">
                    <g:textField id="name" name="name" value="${params.name}"/>
                  </div>
                </div>   
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Email *</label>
                  <div class="col-lg-4">
                    <g:textField id="email" name="email" value="${params.email}" autocomplete="off"/>
                  </div>
                </div>  
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Password *</label>
                  <div class="col-lg-4">
                    <input type="password" id="password" name="password" autocomplete="off"/>
                  </div>
                </div>   
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Confirm Password *</label>
                  <div class="col-lg-4">
                    <input type="password" id="confirm_password" name="confirm_password"/>
                  </div>
                </div> 
                <div class="form-group">
                  <label class="control-label col-lg-2">Default Project</label>
                  <div class="col-lg-4">
                    <g:select id="tenant_id" name="tenant_id" from="${tenants}" 
                              optionKey="id" optionValue="name" value="${currentTenantId}" />
                  </div>
                </div>  
                <div class="form-group">
                  <label class="control-label col-lg-2">Role</label>
                  <div class="col-lg-4">
                    <g:select id="role_id" name="role_id" from="${roles}" optionKey="id" optionValue="name" />
                  </div>
                </div> 
                <div class="form-actions">
                  <g:buttonSubmit class="create btn btn-green" id="submit" 
                                  action="save" title="Create new user">Create User</g:buttonSubmit>
                </div> 
              </div>
            </g:form>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
