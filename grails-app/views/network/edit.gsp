<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="networking"/>
    <meta name="menu-level-2" content="networks"/>    
    <meta name="menu-level-3" content="Edit Network"/>   
    <title>Edit Network</title>
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

        <g:form action="saveEdition" method="post" class="validate form-horizontal fill-up">
          <div class="box">
            <div class="box-header">
              <span class="title">Edit Network</span>
            </div>
            <div class="box-content padded">   
              <div class="form-group">
                <label class="control-label col-lg-2 required">Name *</label>
                <div class="col-lg-4">
                  <g:textField id="name" name="name" value="${network.name}"/>
                </div>  
              </div>
              <div class="form-group">
                <label class="control-label col-lg-2">ID</label>
                <div class="col-lg-4">
                  <g:textField id="id" name="id" value="${network.id}" readonly="readonly"/>
                </div>  
              </div>    
              <div class="form-group">
                <label class="control-label col-lg-2">Admin State</label>
                <div class="col-lg-4">
                  <g:if test="${network.adminStateUp}">
                    <input id="adminState" class="icheck" type="checkbox" name="adminState" checked="checked">
                  </g:if>
                  <g:else>
                    <input id="adminState" class="icheck" type="checkbox" name="adminState">
                  </g:else>
                </div>  
              </div>
              <div class="form-group">
                <label class="control-label col-lg-2">Shared</label>
                <div class="col-lg-4">
                  <g:if test="${network.shared}">
                    <input id="shared" type="checkbox" class="icheck" name="shared" checked="checked">
                  </g:if>
                  <g:else>
                    <input id="shared" type="checkbox" class="icheck" name="shared">
                  </g:else>
                </div>  
              </div>
              <div class="form-group">
                <label class="control-label col-lg-2">External Network</label>
                <div class="col-lg-4">
                  <g:if test="${network.external}">
                    <input id="external" type="checkbox" class="icheck" name="external" checked="checked">
                  </g:if>
                  <g:else>
                    <input id="external" type="checkbox" class="icheck" name="external">
                  </g:else>
                </div>  
              </div>

              <div class="form-actions">
                <g:buttonSubmit id="submit" class="btn btn-green" action="saveEdition" title="Save changes">Save Changes</g:buttonSubmit>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
