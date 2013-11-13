<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="security"/> 
    <meta name="menu-level-2" content="keypairs"/> 
    <meta name="menu-level-3" content="Download Keypair"/> 
    <title>Download Keypair</title>
  </head>

  <body onload="">
    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="alert alert-info">The keypair "${keypair.name}" was created.</div>
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
        <g:form action="download" method="post" class="validate">
          <input type="hidden" id="key" name="key" value="${keypair.privateKey}"/>
          <input type="hidden" id="name" name="name" value="${keypair.name}"/>

          <div class="box">
            <div class="box-header">
              <span class="title">Download Keypair</span>
            </div>
            <div class="box-content padded">
              <div class="alert alert-warn">WARNING: Don't forget to download your new keypair. You will not be able to do it later.</div>


              <div class="form-actions">

                <g:buttonSubmit class="btn btn-green" id="download" action="download" title="Download created keypair">Download keypair</g:buttonSubmit>
              </div>

            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>