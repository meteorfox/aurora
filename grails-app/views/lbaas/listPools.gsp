<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="lbaas"/>
    <meta name="menu-level-2" content="pools"/>     
    <title>Pools & Services</title>
  </head>
  <body>
    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
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
        <g:form method="post">
          <div class="box">
            <div class="box-header">
              <span class="title">Pools</span>
              <ul class="box-toolbar">
                <li><g:link class="btn btn-xs btn-green" elementId="addPool" action="addPool">Add New Pool</g:link></li>
                <g:if test="${pools}">
                  <li><g:buttonSubmit class="btn btn-xs btn-red delete" id="delete" value="Delete" action="delete" 
                                  data-warning="Really delete pool(s)?" title="Delete selected pool(s)"/></li>
                </g:if>
              </ul>
            </div>
            <div class="box-content">

              <table id="table_lbassListPools" class="table table-normal filtered">
                <thead>
                  <tr>
                    <td class="checkboxTd">&thinsp;x</td>
                    <td>Name</td>
                    <td>Method</td>
                    <td>Monitors</td>
                    <td>Enabled</td>
                  </tr>
                </thead>
                <tbody>
                <g:each var="pool" in="${pools}" status="i">
                  <tr>
                    <td><g:checkBox id="checkBox_${pool.name}" name="selectedPools" value="${pool.name}" checked="0" class="requireLogin"/></td>
                  <td><g:link id="${pool.name}" controller="lbaas" action="showPool">${pool.name}</g:link></td>
                  <td>${pool.method}</td>
                  <td>${pool.monitors?.join(', ')}</td>
                  <td>${pool.enabled}</td>
                  </tr>
                </g:each>
                </tbody>
              </table>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>