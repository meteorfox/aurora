<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="lbaas"/>
    <meta name="menu-level-2" content="jobs"/> 
    <script type="text/javascript" src="${resource(dir: 'js', file: 'autorefresh.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'lbaasJobs-ui.js')}"></script>
    <title>Jobs</title>
  </head>
  <body>

    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div id="message" class="alert alert-info">${flash.message}</div>
            </g:if>          
          </div>
        </div>
        <g:form method="post">
          <div class="box">
            <div class="box-header">
              <span class="title">Jobs</span>
              <ul class="box-toolbar">

              </ul>
            </div>
            <div class="box-content">
              <g:render template="jobs"/>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>