<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="compute"/> 
    <meta name="menu-level-2" content="instances"/> 
    <meta name="menu-level-3" content="Instance VNC Console"/> 
    <title>Instance VNC Console</title>
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
    If VNC console is not responding to keyboard input, <a class="btn btn-xs btn-gray" href="${vncUrl}" > Click here to show only VNC</a>
    <div class="box">
        <iframe src="${vncUrl}" width="735" height="441"></iframe>
    </div>
</div>
</div>
</body>
</html>
