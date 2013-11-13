<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="heat"/> 
    <meta name="menu-level-3" content="Stack Detail"/> 
    <title>Cloud Formation - Stack Detail</title>
  </head>
  <body>
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <g:if test="${flash.message}">
            <div id="message" class="alert alert-info">${flash.message}</div>
          </g:if>          
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="box">
            <div class="box-header">
              <div class="title">Stack Info</div>
            </div>
            <div class="box-content">
              <table class="table table-normal table-striped">
                <tbody>
                  <tr><td>Name</td><td>${stack.name}</td></tr>
                  <tr><td>ID</td><td>${stack.id}</td></tr>
                  <tr><td>Description</td><td>${stack.description}</td></tr>
                  <tr><td>Timeout</td><td>${stack.timeout} Minutes</td></tr>
                  <tr><td>Rollback</td><td><g:if test="${stack.disable_rollback == false}">Enabled</g:if><g:else>Disabled</g:else></td></tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="box">
            <div class="box-header">
              <div class="title">Stack Status</div>
            </div>
            <div class="box-content">
              <table class="table table-normal table-striped">
                <tbody>
                  <tr><td>Created</td><td>${stack.created}</td></tr>
                  <tr><td>Last Updated</td><td>${stack.updated}</td></tr>
                  <tr><td>Status</td><td>${stack.status}</td></tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>


      <div class="box">
        <div class="box-header">
          <div class="title">Parameters</div>
        </div>
        <div class="box-content">
          <table class="table table-normal table-striped">

            <tbody>
            <g:each in="${stack.parameters}" var="parameter">
              <tr><td>${parameter.key}</td><td>${parameter.value}</td></tr>
            </g:each>

            </tbody>
          </table>
        </div>
      </div>
    </div>
  </body>
</html>
