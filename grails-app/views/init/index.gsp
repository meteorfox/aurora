<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithoutNav"/>     
    <title>Aurora Config Error</title>
  </head>

  <body>
    <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div id="message" class="message alert alert-info">${flash.message}</div>
            </g:if>          
          </div>
        </div>
      <div class="row">
        <div class="jumbotron">
          <h1>Welcome to Aurora!</h1>
          <p>&nbsp;</p>
          <p>Aurora has not been configured properly.</p>
          <p>Error details: <small>${errorMessage}</small></p>
          <p>File location: ${auroraHome}/Config.json</p>

        </div>

      </div>
    </div>
  </body>
</html>
