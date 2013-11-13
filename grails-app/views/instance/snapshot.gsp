<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="compute"/> 
    <meta name="menu-level-2" content="instances"/> 
    <meta name="menu-level-3" content="Create Instance Snapshot"/> 
    <title>Create Instance Snapshot</title>
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
          <input type="hidden" id="input-hidden_instSnapshot_id" name="id" value="${params.id}"/>
          <div class="box">
            <div class="box-header">
              <span class="title">Create Instance Snapshot</span>
            </div>
            <div class="box-content padded">
              <div class="form-group">
                <label class="control-label col-lg-3 required">Snapshot Name *</label>
                <div class="col-lg-9">
                  <g:textField id="name" type="text" name="name" value="${params.name}"/>
                </div>
              </div>
            </div>

            <div class="form-actions">
              <g:buttonSubmit class="btn btn-green" value="Create Snapshot" id="submit" action="makeSnapshot" title="Create snapshot from this instance"/>
            </div>
          </div>
        </g:form>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
