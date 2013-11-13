<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="heat"/> 
    <title>Cloud Formation</title>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'heat-ui.js')}"></script>
  </head>
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

    <g:form method="post" class="validate">
      <div class="box">
        <div class="box-header">
          <span class="title">Stacks</span>
          <ul class="box-toolbar">
            <li><g:buttonSubmit type="button" action="templateForm" class="btn btn-xs btn-green" value="Create Stack"/></li>

            <g:if test="${stacks}">
              <li><g:buttonSubmit class="btn btn-xs btn-red delete" id="delete" 
                                  value="Remove Stack(s)" action="delete"
                                  data-warning="Really remove stack(s)?" 
                                  title="Remove selected stack(s)"/></li>
            </g:if>
          </ul>
        </div>    
        <div class="box-content">
          <table id="table_listHeat" class="table table-normal sortable filtered">
            <tr>
              <td class="checkboxTd">&thinsp;x</td>
              <td>Name</td>
              <td>Created</td>
              <td>Updated</td>
              <td>Status</td>
            </tr>
            <g:each in="${stacks}" var="stack">
              <tr>
                <td><g:if test="${stack.id}"><g:checkBox name="selectedStacks" id="checkBox_${stack.id}" value="${stack.id}"
                                                       checked="0" class="requireLogin"/></g:if></td>
              <td><g:linkObject type="heat" displayName="${stack.name}" id="${stack.id}"/></td>
              <td>${stack.created}</td>
              <td>${stack.updated}</td>
              <td>${stack.status}</td>
              </tr>
            </g:each>
          </table>
        </div>
      </div>
    </g:form>
  </div>
</body>
</html>
