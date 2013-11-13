<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="storage"/> 
    <meta name="menu-level-2" content="snapshots"/> 
    <title>Volume Snapshots</title>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'autorefresh.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'volume-snapshot-ui.js')}"></script>
</head>

<body>
<div class="body">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <g:if test="${flash.message}">
          <div id="message" class="message alert alert-info">${flash.message}</div>
        </g:if>          
      </div>
    </div>
    <g:form method="post">
      <div class="box">
            <div class="box-header">
              <span class="title">Volume Snapshots</span>
              <ul class="box-toolbar">
                <g:if test="${snapshots}">
                  <li><g:buttonSubmit class="btn btn-xs btn-red delete" id="delete" action="delete" 
                                      value="Delete Volume Snapshot(s)"
                                    data-warning="Really delete volume snapshot(s)?" title="Delete selected snapshot(s)"/></li>
                </g:if>
              </ul>
            </div>
        <div class="box-content">
                <g:render template="snapshots"/>
        </div>
            <div class="box-footer">
              <div class="paginateButtons">
              </div>
            </div>
      </div>
    </g:form>
      </div>
</div>
</body>
</html>
