<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>    
    <meta name="menu-level-1" content="networking"/>
    <meta name="menu-level-2" content="floatingips"/>   
    <meta name="menu-level-3" content="Associate Floating IP"/> 
    <title>Associate Floating IP</title>

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
          <input type="hidden" name="fromInstance" value="${fromInstance}">
          <div class="box">
            <div class="box-header">
              <span class="title">Associate Floating IP</span>
            </div>
            <div class="box-content padded">
              <div class="form-group">
                <label class="control-label col-lg-2">IP </label>
                <div class="col-lg-4">
                  <g:select name="ip" id="ip" from="${floatingIps}" optionKey="ip" optionValue="ip"
                          value="${defaultIp}"/>
                  <br/>
                  <g:buttonSubmit id="allocate" class="btn btn-xs btn-blue"
                                action="allocateFloatingIp"
                                value="allocate"
                                title="Allocate new floating IP address"/>
                </div>  
              </div>    
              <div class="form-group">
                <label class="control-label col-lg-2">Instance </label>
                <div class="col-lg-4">
                  <g:select id="instanceId" name="instanceId" from="${instances}" optionKey="instanceId"
                          optionValue="name" value="${defaultInstance}"/>
                </div>  
              </div>  

              <div class="form-actions">
                <g:buttonSubmit id="submit" class="btn btn-green" action="associateIp" 
                                title="Associate floating IP address">Associate Floating IP</g:buttonSubmit>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>