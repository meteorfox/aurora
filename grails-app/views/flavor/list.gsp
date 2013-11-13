<%@ page import="com.paypal.aurora.OpenStackRESTService; grails.converters.JSON; com.paypal.aurora.Constant" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="compute"/> 
    <meta name="menu-level-2" content="flavors"/> 
    <title>Flavors</title>
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
        <div class="row">
          <div class="col-md-12">    
            <g:form method="post" class="validate">
              <div class="box">
                <div class="box-header">
                  <span class="title">Flavors</span>
                  <ul class="box-toolbar">
                    <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                      <li><g:link elementId="create" class="btn btn-green btn-xs" action="create" title="Create new flavor">
                        Create</g:link></li>
                      <li><g:if test="${flavors}">
                        <g:buttonSubmit id="delete" class="btn btn-red btn-xs delete" action="delete"
                                        data-warning="Really remove flavor(s)?" title="Remove selected flavor(s)">
                          Delete</g:buttonSubmit></li>
                      </g:if>
                    </shiro:hasRole>            
                  </ul>
                </div>
                <div class="box-content">
                  <table id="table_listFlavor" class="sortable instanceType table table-normal filtered">
                    <thead>
                      <tr>
                    <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                      <td class="checkboxTd">&thinsp;x</td>
                    </shiro:hasRole>
                    <td>Name</td>
                    <td class="sorttable_nosort">Memory (MB)</td>
                    <td class="sorttable_nosort">Disk (GB)</td>
                    <td>Ephemeral</td>
                    <td>Swap</td>
                    <td class="sorttable_nosort">VCPUs</td>
                    <td>RXTX Factor</td>
                    <td>Is Public</td>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${flavors}" var="flavor">
                      <tr>
                      <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                        <td><g:if test="${flavor.id}"><g:checkBox name="selectedFlavors" 
                                                                  id="checkBox_${flavor.id}" value="${flavor.id}"
                                                                  checked="0" class="requireLogin"/></g:if>
                        </td></shiro:hasRole>
                      <td>${flavor.name}</td>
                      <td>${flavor.memory}</td>
                      <td>${flavor.disk}</td>
                      <td>${flavor.ephemeral}</td>
                      <td>${flavor.swap}</td>
                      <td>${flavor.vcpu}</td>
                      <td>${flavor.rxtxFactor}</td>
                      <td>${flavor.isPublic}</td>
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
