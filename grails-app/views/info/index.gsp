<%@ page import="com.paypal.aurora.Constant" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="settings"/>
    <meta name="menu-level-2" content="about"/>      
    <title>About</title>
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
        <div class="box">
          <div class="box-content">
            <table id="table_infoList" class="sortable table table-normal">
              <thead>
                <tr>
                  <td style="width:25%">Parameter</td>
                  <td>Value</td>
                </tr>
              </thead>
              <tbody>
              <g:each var="quota" in="${info}" status="i">
                <tr>
                  <td>${quota.key}</td>
                  <td>${quota.value}</td>
                </tr>
              </g:each>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
