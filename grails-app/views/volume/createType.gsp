<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="storage"/> 
    <meta name="menu-level-2" content="volumes"/> 
    <meta name="menu-level-3" content="Create New"/> 
    <title>Create Volume Type</title>
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
        <g:form method="post" class="validate form-horizontal fill-up">
          <div class="box">
            <div class="box-header">
              <span class="title">Create New Volume Type</span>
            </div>
            <div class="box-content padded">
              <div class="form-group">
                <label class="control-label col-lg-2 required">Name *</label>
                <div class="col-lg-4">
                  <g:textField id="name" name="name" value="${params.name}"/>
                </div>
              </div>              
              <div class="form-actions">
                <g:buttonSubmit class="btn btn-green" id="submit" action="saveType" 
                                title="Create new volume type with selected parameters">Create Volume Type</g:buttonSubmit>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
