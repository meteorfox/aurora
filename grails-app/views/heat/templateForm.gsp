<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="heat"/> 
    <meta name="menu-level-3" content="Create Stack"/> 
    <title>Cloud Formation - Create Stack</title>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'heat-ui.js')}"></script>
    <style>div.uploader span.filename{width:250px;}</style>
  </head>
</head>
<body>

  <div class="container">
    <div class="row">
      <div class="col-md-6">
    <div class="box">
      <div class="box-header">
        <span class="title">Choose Template for New Stack</span> 
      </div>
      <div class="box-content">
        <g:uploadForm action="create">
          <ul class="padded separate-sections">
            <li class="input">
              <label>Select template file to upload</label>
              <div class="uploader"><input id="file" type="file" name="template" /></div>
            </li>
            <li><input class="btn btn-green" type="submit" /></li>
          </ul>
        </g:uploadForm>
      </div>
    </div>
    </div>
    </div>
  </div>
</body>
</html>