<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="lbaas"/>
    <meta name="menu-level-2" content="policies"/> 
    <meta name="menu-level-3" content="Create New Policy"/> 
    <title>Create New Policy</title>
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
            <span class="title">Create New Policy</span>
          </div>
          <div class="box-content padded">
            <g:form action="savePolicy" method="post" class="validate form-horizontal fill-up">
              <input type="hidden" id="tenantName" name="tenantName" value="${params.tenantName}"/>
              <div class="form-group">
                <label class="control-label col-lg-2 required">Name *</label>
                <div class="col-lg-4">
                  <g:textField id="name" name="name" value="${params.name}"/>
                </div>  
              </div>
              <div class="form-group">
                <label class="control-label col-lg-2 required">Rule *</label>
                <div class="col-lg-4">
                  <g:textArea rows="10" cols="60" id="rule" name="rule" value="${params.rule}"/>
                </div>  
              </div>  
              
              <div class="form-actions">
                <g:buttonSubmit id="submit" class="btn btn-green" action="savePolicy" 
                                title="Create new policy with selected parameters">Create Policy</g:buttonSubmit>
              </div>
            </g:form>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
