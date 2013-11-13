<%@ page import="com.paypal.aurora.Constant" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="settings"/>
    <meta name="menu-level-2" content="services"/> 
    <title>Services</title>
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
              <span class="title">Services</span>
              <ul class="box-toolbar"></ul>
            </div>
            <div class="box-content list">
              <table id="table_ossList" class="sortable filtered table table-normal">
                <thead>
                  <tr>
                    <td>Name</td>
                    <td>Service</td>
                    <td>URL</td>
                  </tr>
                </thead>
                <tbody>
                <g:each var="openStackService" in="${openStackServices}" status="i">
                  <tr>
                    <td>${openStackService.name}</td>
                    <td>${openStackService.type}</td>
                    <td>
                  <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                    <g:if test="${openStackService.adminUri}">
                      <b>Admin URL:</b>  ${openStackService.adminUri} <br>
                    </g:if>
                    <b>Public URL:</b>
                  </shiro:hasRole>
                  ${openStackService.uri}
                  </td>
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
