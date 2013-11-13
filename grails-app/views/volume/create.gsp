<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="storage"/> 
    <meta name="menu-level-2" content="volumes"/> 
    <meta name="menu-level-3" content="Create New"/> 
    <title>Create Volume</title>
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
              <span class="title">Create New Volume</span>
            </div>
            <div class="box-content padded">
              <div class="form-group">
                <label class="control-label col-lg-2 required">Name *</label>
                <div class="col-lg-4">
                  <g:textField id="name" name="name" value="${params.name}"/>
                </div>
              </div>             
              <div class="form-group">
                <label class="control-label col-lg-2">Description</label>
                <div class="col-lg-4">
                  <g:textField id="description" name="description" value="${params.description}"/>
                </div>
              </div>     
              <div class="form-group">
                <label class="control-label col-lg-2 required">Size(GB) *</label>
                <div class="col-lg-4">
                  <g:textField id="size" name="size" value="${params.size}"/>
                  <br/>
                  <span class="badge badge-purple">GB available ${GBAvailable}</span>
                  <span class="badge badge-purple">Number of volume available ${VAvailable}</span>
                </div>
              </div>  
              <div class="form-group">
                <label class="control-label col-lg-2">Volume Type</label>
                <div class="col-lg-4">
                  <g:select id="type" name="type" from="${volumeTypes}" optionKey="name" optionValue="name"/>
                </div>
              </div> 
              <div class="form-actions">
                <g:buttonSubmit class="btn btn-green" id="submit" action="save" title="Create new volume with selected parameters">Create Volume</g:buttonSubmit>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
