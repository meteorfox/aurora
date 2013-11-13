<%@ page import="com.paypal.aurora.Constant" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="settings"/>
    <meta name="menu-level-2" content="quotas"/>      
    <title>Quotas</title>
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
              <span class="title">Quotas</span>
              <ul class="box-toolbar">
                <li>
                <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                  <g:link elementId="edit" class="btn btn-blue btn-xs" action="quotas" controller="tenant" 
                          params="[parent: '/quota/list']" title="Edit quotas for this tenant">Edit Quotas</g:link>
                </shiro:hasRole>
                </li>
              </ul>
            </div>
            <div class="box-content list">
              <table id="table_quotaList" class="sortable table table-normal filtered">
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
                    <td>${quota.limit}</td>
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
