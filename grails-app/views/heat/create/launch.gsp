<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="heat"/> 
    <meta name="menu-level-3" content="Create Stack"/> 
    <title>Cloud Formation - Create Stack</title>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'heat-ui.js')}"></script>
    <style>
      form.fill-up input.btn{
        width: auto;
        min-width: 0;
      }
    </style>

</head>
<body>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <g:if test="${message}">
          <div id="error_message" class="message alert alert-info">${message}</div>
        </g:if>
      </div>
    </div>

    <g:form action="create" method="post" class="validate form-horizontal fill-up">
      <div class="box">
        <div class="box-header">
          <div class="title">Parameters for New Stack</div>
        </div>
        <div class="box-content padded">
          <div class="form-group">
            <label class="control-label col-md-2 required">Stack Name *</label>
            <div class="col-md-6"><input id="stack_name" name="stack_name"/></div>
          </div>
          <g:each in="${template.parameters}" var="param">
            <div class="form-group">
              <label class="control-label col-md-2">${param.name}</label>
              <div class="col-md-6">
                <g:if test="${param.allowedValues}">
                  <g:select id="names-${param.name}" name="${param.name}" from="${param.allowedValues}"/>
                </g:if>
                <g:else>
                  <input id="name-${param.name}" name="${param.name}" value="${param.default}"/>
                </g:else>
              </div>
            </div>
          </g:each>

        </div>
        <div class="box-footer">
          <div class="form-actions">
            <g:submitButton type="submit" class="btn btn-green" id="submit" 
                            value="Create Stack" title="Create new stack with selected parameters" name="submit"/>

          </div>

        </div>
      </div>
    </g:form>
  </div>
</body>
</html>
