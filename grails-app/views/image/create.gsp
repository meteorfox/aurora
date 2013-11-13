<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="compute"/> 
    <meta name="menu-level-2" content="images"/> 
    <meta name="menu-level-3" content="Create New"/>     
    <title>Create Image</title>
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
              <span class="title">Create New Image</span>
            </div>
            <div class="box-content padded">       
              <div class="form-group">
                <label class="control-label col-lg-2 required">Name *</label>
                <div class="col-lg-4">
                  <g:textField id="name" name="name" value="${params.name}"/>
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-lg-2 required">Image Location (URL) *</label>
                <div class="col-lg-4">
                  <g:textField id="location" name="location" value="${params.location}"/>
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-lg-2">Format</label>
                <div class="col-lg-4">
                  <g:select id="diskFormat" name="diskFormat" from="${formats}" value="${params.diskFormat}"/>
                </div>
              </div>  
              <div class="form-group">
                <label class="control-label col-lg-2 required">Minimum Disk (GB)*</label>
                <div class="col-lg-4">
                  <g:textField id="minDisk" name="minDisk" value="${params.minDisk}"/>
                </div>
              </div>  
              <div class="form-group">
                <label class="control-label col-lg-2 required">Minimum Ram (MB)*</label>
                <div class="col-lg-4">
                  <g:textField id="minRam" name="minRam" value="${params.minRam}"/>
                </div>
              </div> 
              <div class="form-group">
                <label class="control-label col-lg-2">Public</label>
                <div class="col-lg-4">
                  <g:checkBox id="shared" class="icheck" name="shared" value="${params.shared}"/>
                </div>
              </div>  

              <div class="form-actions">
                <g:buttonSubmit id="submit" class="btn btn-green" action="save" title="Create new image with selected parameters">Create Image</g:buttonSubmit>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>