<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="security"/>
    <meta name="menu-level-2" content="securitygroups"/>  
    <meta name="menu-level-3" content="Edit"/> 
    <title>Edit Security Group</title>
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
            <span class="title">Edit Security Group</span>
          </div>
          <div class="box-content">  
            <g:form method="post" class="form-horizontal fill-up">
              <input type="hidden" name="id" id="input-hidden_sgEdit_id" value="${securityGroup.id}"/>
              <input type="hidden" name="name" id="input-hidden_sgEdit_name" value="${securityGroup.name}"/>
               <div class="padded">
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Name *</label>
                  <div class="col-lg-4">
                    <g:textField type="text" id="input_sgEdit_name" name="name" value="${securityGroup.name}"/>
                  </div>
                </div>
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Description *</label>
                  <div class="col-lg-4">
                    <g:textField type="text" id="input_sgEdit_description" name="description"
                               value="${securityGroup.description}"/>
                  </div>
                </div>    

              </div>
              <div class="form-actions">
                <g:buttonSubmit class="btn btn-green" id="submit" value="Update Security Group" action="update" title="Save changes"/>
              </div>
            </g:form>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
