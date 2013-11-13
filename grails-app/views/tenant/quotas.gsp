<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="settings"/>
    <meta name="menu-level-2" content="quotas"/>
    <meta name="menu-level-3" content="Edit Quotas"/>    
    <title>Quotas for '${tenantName}'</title>
  </head>

  <body>
    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div class="message alert alert-info">${flash.message}</div>
            </g:if>  
            <g:if test="${params.error}">
              <div class="error alert alert-error">
                <ul><li>${params.error}</li></ul>
              </div>
            </g:if>
          </div>
        </div>
        <g:form method="post">
          <input type="hidden" name="id" value="${tenantId}"/>
          <input type="hidden" name="parent" value="${parent}"/>
          <div class="box">
            <div class="box-header">
              <span class="title">Quotas for '${tenantName}'</span>
              <ul class="box-toolbar">
                <li>&nbsp;</li>
                </li>
              </ul>
            </div>
            <div class="box-content list">
              <table id="table_tenantQuotas" class="sortable table table-normal filtered">
                <thead>
                  <tr>
                    <td style="width:25%">Name</td>
                    <td>Limit</td>
                  </tr>
                </thead>
                <tbody>
                <g:each var="quota" in="${quotas}" status="i">
                  <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td>${quota.displayName}</td>
                    <td><g:textField id="quota-${quota.name}" name="quota.${quota.name}" value = "${params.get("quota." + quota.name) ?: quota.limit}"/></td>
                  </tr>
                </g:each>
                </tbody>
              </table>
            </div>
            <div class="box-footer">  
              <div class="form-actions">
                <g:buttonSubmit class="save btn btn-green" id="submit" value="Save Quotas" action="saveQuotas" title="Save changes"/>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
