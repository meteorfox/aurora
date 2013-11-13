<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="storage"/> 
    <meta name="menu-level-2" content="volumes"/> 
    <meta name="menu-level-3" content="Volume Type Detail"/> 
    <title>Volume Type Detail</title>
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
        <div class="box">
          <div class="box-header">
            <span class="title">Volume Type Detail</span>
          </div>
    <div class="box-content">
      <table id="table_volumeShowType" class="table table-normal">
            <tbody>
            <tr>
                <td title="Volume ID">Volume Type ID</td>
                <td >${volumeType.id}</td>
            </tr>
            <tr>
                <td title="Display Name">Name</td>
                <td >${volumeType.name}</td>
            </tr>
        </table>
    </div>
        </div>
</div>
</div>
</body>
</html>
