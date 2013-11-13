<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="security"/>
    <meta name="menu-level-2" content="securitygroups"/>        
    <title>Security Groups</title>
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
              <span class="title">Security Groups</span>
              <ul class="box-toolbar">
                <li><g:link elementId="create" class="btn btn-green btn-xs" action="create" 
                            title=" Create New Security Group">Create New</g:link></li>
              </ul>
            </div>
            <div class="box-content">
              <table id="table_securityGroupList" class="table table-normal sortable filtered">
                <thead>
                  <tr>
                    <td>Name</td>
                    <td>Description</td>
                  </tr>
                </thead>
                <tbody>
                <g:each var="grp" in="${securityGroups}" status="i">
                  <tr>
                    <td><g:linkObject elementId="securityGroup-${grp.id}" displayName="${grp.name}" type="securityGroup" id="${grp.id}"/></td>
                  <td>${grp.description}</td>
                  </tr>
                </g:each>
                </tbody>
              </table>
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
