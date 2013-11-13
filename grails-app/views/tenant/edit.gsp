<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="settings"/>    
    <meta name="menu-level-2" content="projects"/>   
    <meta name="menu-level-3" content="Edit Project"/>   

    <title>Edit Project</title>

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
        <div class="row">
          <div class="col-md-12"> 
            <g:hasErrors bean="${cmd}">
              <div id="error_message" class="alert alert-error">
                <g:renderErrors bean="${cmd}" as="list"/>
              </div>
            </g:hasErrors>
          </div>
        </div>

        <div class="box">
          <div class="box-header">
            <span class="title">Edit Project</span>
          </div>
          <div class="box-content">
            <div class="padded">
              <g:form method="post" class="form-horizontal fill-up allowEnterKeySubmit">
                <input type="hidden" name="id" value="${tenant.id}"/>
                <input type="hidden" name="tenantName" value="${tenant.name}"/> 
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Name *</label>
                  <div class="col-lg-4">
                    <g:textField type="text" id="name" name="name" value="${tenant.name}"/>
                  </div>
                </div>    
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Description *</label>
                  <div class="col-lg-4">
                    <g:textField type="text" id="description" name="description"
                                 value="${tenant.description}"/>
                  </div>
                </div> 
                <div class="form-group">
                  <label class="control-label col-lg-2">Enabled</label>
                  <div class="col-lg-4">
                    <div style="padding-top:5px;">
                      <g:checkBox id="enabled" name="enabled" class="icheck" checked="${tenant.enabled}"/>
                    </div>                
                  </div>
                </div>              
                <g:if test="${keystoneCustomTenancy}">
                  <div class="form-group">
                    <label class="control-label col-lg-2">DNS zones</label>
                    <div class="col-lg-4">
                      <g:textArea rows="6" cols="60" id="zones" name="zones" value="${tenant.zones?.join('\n')}"/>
                    </div>
                  </div>                   
                </g:if>

                <div class="form-actions">
                  <g:buttonSubmit class="save btn btn-green" id="submit" 
                                  value="Update Project" action="update" title="Save changes"/>
                </div>
            </div>
          </div>
          </g:form>
        </div>

      </div>
    </div>
  </body>
</html>
