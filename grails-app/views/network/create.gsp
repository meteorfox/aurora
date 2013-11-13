<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="networking"/>
    <meta name="menu-level-2" content="networks"/>   
    <meta name="menu-level-3" content="Create New Network"/>   
    <title>Create New Network</title>

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
        <g:form action="save" method="post" class="validate form-horizontal fill-up">
          <div class="box">
            <div class="box-header">
              <span class="title">Create Network</span>
            </div>
            <div class="box-content padded">   
              <div class="form-group">
                <label class="control-label col-lg-2 required">Name *</label>
                <div class="col-lg-4">
                  <g:textField id="name" name="name"/>
                </div>  
              </div>   
              <div class="form-group">
                <label class="control-label col-lg-2">Project</label>
                <div class="col-lg-4">
                  <select id="tenant" name="tenant">
                    <g:each in="${params.tenants}" var="tenant">
                      <option value="${tenant.id}">${tenant.name}</option>
                    </g:each>
                  </select>
                </div>  
              </div> 
              <div class="form-group">
                <label class="control-label col-lg-2">Admin State</label>
                <div class="col-lg-4">
                  <input id="adminState" type="checkbox" class="icheck" name="adminState"/>
                </div>  
              </div>  
              <div class="form-group">
                <label class="control-label col-lg-2">Shared</label>
                <div class="col-lg-4">
                  <input id="shared" type="checkbox" class="icheck" name="shared"/>
                </div>  
              </div>
              <div class="form-group">
                <label class="control-label col-lg-2">External Network</label>
                <div class="col-lg-4">
                  <input id="external" type="checkbox" class="icheck" name="external"/>
                </div>  
              </div>              

              <div class="form-actions">
                <g:buttonSubmit id="submit" class="btn btn-green" action="save" 
                                title="Create network with selected parameters">Create New Network</g:buttonSubmit>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
