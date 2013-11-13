<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="networking"/> 
    <meta name="menu-level-2" content="routers"/> 
    <meta name="menu-level-3" content="Set Gateway"/>  
    <title>Set Gateway</title>
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
        <g:form action="saveGateway" method="post" class="validate form-horizontal fill-up">
          <input type="hidden" id="id" name="id" value="${params.router.id}"/>
          <div class="box">
            <div class="box-header">
              <span class="title">Set Gateway</span>
            </div>
            <div class="box-content padded"> 
              <div class="form-group">
                <label class="control-label col-lg-2">Network</label>
                <div class="col-lg-4">
                  <select id="network" name="network">
                    <g:each in="${params.networks}" var="network">
                      <option value="${network.id}">${network.name}</option>
                    </g:each>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-lg-2">Router Name</label>
                <div class="col-lg-4">
                  <g:textField id="name" name="name" value="${params.router.name == '' ? 'None' : params.router.name}" readonly="readonly"/>
                </div>
              </div>              

              <div class="form-actions">
                <g:buttonSubmit id="submit" class="btn btn-green" action="saveGateway" 
                                title="Set Gateway for network">Set Gateway</g:buttonSubmit>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
