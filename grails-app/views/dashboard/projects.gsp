<%@ page import="com.paypal.aurora.OpenStackRESTService; grails.converters.JSON; com.paypal.aurora.Constant" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="myprojects"/> 
    <title>My Projects</title>
  </head>
  <g:set var="regionName"><g:dataCenterDisplayName/></g:set>
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
        <div class="row">
          <div class="col-md-12">    
            <g:form method="post" class="validate">
              <div class="box">
                <div class="box-header">
                  <span class="title">My Projects</span>
                  <ul class="box-toolbar">
                    
                  </ul>
                </div>
                <div class="box-content">
                  <table class="sortable table table-normal filtered">
                    <thead>
                      <tr>
                    <td>Name</td>
                    <td class="sorttable_nosort">Description</td>
                    <td class="sorttable_nosort">Region</td>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tenants}" var="tenant">
                      <tr>
                      
                      <td><g:link controller="userState" action="changeTenant" 
                                  params="[tenantId: tenant.id, projectSwitch:'/instance/list']">${tenant.name}</g:link></td>
                      <td>${tenant.description}</td>
                      <td>${regionName}</td>
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
      </div>
    </div>
  </body>
</html>
