<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="compute"/> 
    <meta name="menu-level-2" content="instances"/> 
    <meta name="menu-level-3" content="Rename Instance"/> 
    <title>Rename Instance</title>
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
              <div class="alert alert-error">
                <g:renderErrors bean="${cmd}" as="list"/>
              </div>
            </g:hasErrors>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <g:form method="post" class="form-horizontal fill-up">
              <input type="hidden" id="input-hidden_instList_id" name="id" value="${params.id}"/>
              <div class="box">
                <div class="box-header">
                  <span class="title">Rename Instance</span>
                </div>
                <div class="box-content padded">
                  <div class="form-group">
                    <label class="control-label col-lg-2 required">Name *</label>
                    <div class="col-lg-10">
                      <g:textField type="text" id="name" name="name" value="${params.name}"/>
                    </div>
                  </div> 
                  <div class="form-actions">
                    <g:buttonSubmit class="btn btn-green" id="submit" value="Save Changes" action="update" title="Save changes"/>
                  </div>
                </div>
              </div>
            </g:form>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
