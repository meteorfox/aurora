<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="lbaas"/>
    <meta name="menu-level-2" content="policies"/> 
    <meta name="menu-level-3" content="Edit Policy"/> 
    <title>Edit Policy</title>
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
            <span class="title">Edit Policy</span>

            <g:form class="">
              <input type="hidden" name="id" value="${params.id}"/>
              <ul class="box-toolbar">
                <li><g:buttonSubmit class="btn btn-xs btn-red delete" id="deletePolicy" value="Remove Policy" action="deletePolicy"
                                    data-warning="Really remove policy?" title="Remove this policy"/></li>
              </ul>
            </g:form>
          </div>
          <div class="box-content padded">
            <g:form method="post" class="validate form-horizontal fill-up">
              <input type="hidden" name="id" value="${params.id}"/>
              <input type="hidden" name="tenantName" value="${params.tenantName}"/>
              <div class="form-group">
                <label class="control-label col-lg-2 required">Name *</label>
                <div class="col-lg-4">
                  <g:textField id="name" name="name" value="${policy.name}"/>
                </div>  
              </div>
              <div class="form-group">
                <label class="control-label col-lg-2 required">Rule *</label>
                <div class="col-lg-4">
                  <g:textArea rows="10" cols="60" id="rule" name="rule" value="${policy.rule}"/>
                </div>  
              </div>              
              <div class="form-actions">
                <g:buttonSubmit class="btn btn-green" id="submit" 
                                action="updatePolicy" title="Save changes">Update Policy</g:buttonSubmit>
              </div>
          </div>
        </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
