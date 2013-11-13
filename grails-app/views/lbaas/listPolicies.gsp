<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="lbaas"/>
    <meta name="menu-level-2" content="policies"/> 
    <title>Policies</title>
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

        <g:form method="post" class="validate">
          <input type="hidden" name="tenantName" value="${params.tenantName}"/>
          <div class="box">
            <div class="box-header">
              <span class="title">Policies</span>
              <ul class="box-toolbar">
                <li><g:link elementId="create" class="btn btn-xs btn-green" action="createPolicy" 
                            params="${params.tenantName ? [tenantName: params.tenantName]:[:]}" 
                            title="Create new policy">Create New Policy</g:link></li>
                <g:if test="${policies}">
                  <li><g:buttonSubmit class="btn btn-xs btn-red delete" id="delete" 
                                      value="Remove Policy(s)" action="deletePolicy" 
                                      data-warning="Really remove policy(s)?" title="Remove selected policy(s)"/></li>
                </g:if>
              </ul>
            </div>
            <div class="box-content">  
              <table class="table table-normal sortable filtered" id="policies">
                <thead>
                  <tr>
                    <td class="checkboxTd">&thinsp;x</td>
                    <td>Name</td>
                    <td>Rule</td>
                  </tr>
                </thead>
                <tbody>
                <g:each var="policy" in="${policies}" status="i">
                  <tr>
                    <td><g:if test="${policy.name}"><g:checkBox name="selectedPolicies" id="checkBox_${policy.name}" value="${policy.name}" checked="0" class="requireLogin"/></g:if></td>
                  <td><g:linkObject elementId="editPolicy" type="lbaas" id="${policy.name}" action="editPolicy" params="${params.tenantName ? [id: policy.name, tenantName: params.tenantName]:[id: policy.name]}"/></td>
                  <td><g:textArea id="name-${policy.name}" name="${policy.name}_ruleArea" value="${policy.rule}" cols="100" rows="10" style="overflow-y:scroll" readonly="readonly"/></td>
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
