<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="lbaas"/>
    <meta name="menu-level-2" content="pools"/> 
    <meta name="menu-level-3" content="Add New Pool"/>     
    <title>Add New Pool</title>
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
          <div class="box">
            <div class="box-header">
              <span class="title">Add New Pool</span>
            </div>
            <div class="box-content padded">  
              <div class="form-group">
                <label class="control-label col-lg-2 required">Pool Name *</label>
                <div class="col-lg-4">
                  <g:textField type="text" id="name" name="name" value="${params.name}"/>
                </div>  
              </div> 
              <div class="form-group">
                <label class="control-label col-lg-2">Enabled</label>
                <div class="col-lg-4">
                  <g:checkBox id="enabled" class="icheck" name="enabled" value="${params.enabled}"/>
                </div>  
              </div> 
              <div class="form-group">
                <label class="control-label col-lg-2">LB Method</label>
                <div class="col-lg-4">
                  <g:select id="lbMethod" name="lbMethod" from="${methods}" value="${params.lbMethod}"/>
                </div>  
              </div>    
              <div class="form-group">
                <label class="control-label col-lg-2">Monitor(s)</label>
                <div class="col-lg-4">
                  <g:each in="${monitors}" var="monitor">
                  <g:checkBox id="monitors-${monitor}" class="icheck" name="monitors"
                              value="${monitor}"
                              checked="${params.monitors?.contains(monitor)}"/><label class="control-label">${monitor}</label><br>
                </g:each>
                </div>  
              </div> 
              <div class="form-actions">
                <g:buttonSubmit class="btn btn-green" id="submit" value="Add new pool" action="savePool"
                                title="Add new pool with selected parameters"/>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>