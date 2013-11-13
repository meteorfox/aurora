<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="compute"/> 
    <meta name="menu-level-2" content="images"/>  
    <meta name="menu-level-3" content="Edit ${bType}"/> 
    <title>Edit ${bType}</title>
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
        <g:form method="post" class="form-horizontal fill-up">
          <input type="hidden" id="id" name="id" value="${image.id}"/>
          <div class="row">
            <div class="col-md-6">
          <div class="box">
            <div class="box-header">
              <span class="title">Edit ${bType} Attributes</span>
            </div>
            <div class="box-content">
              <div class="form-group">
                <label class="control-label col-lg-2">ID</label>
                <div class="col-lg-8">
                  <label class="control-label">${image.id}</label>
                  
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-lg-2 required">Name *</label>
                <div class="col-lg-8">
                  <g:textField type="text" id="name" name="name" value="${image.name}"/>
                </div>
              </div>  
              <div class="form-group">
                <label class="control-label col-lg-2">Public</label>
                <div class="col-lg-8">
                  <g:checkBox id="shared" class="icheck" name="shared" checked="${image.shared}"/>
                </div>
              </div>  
              <div class="form-actions">
                <g:buttonSubmit id="submit" class="btn btn-green" 
                                value="Save Changes" action="update" title="Save changes"/>
              </div>
            </div>

          </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
