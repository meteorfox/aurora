<%@ page import="com.paypal.aurora.Constant" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="networking"/>
    <meta name="menu-level-2" content="networks"/>   
    <title>Networks</title>
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
        <g:form method="post" class="validate">
          <div class="box">
            <div class="box-header">
              <span class="title">Networks</span>
              <ul class="box-toolbar">
                <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                  <li><g:link elementId="create" class="btn btn-xs btn-green" action="create" 
                              title="Create new network">Create New Network</g:link></li>
                  <g:if test="${networks}">
                    <li><g:buttonSubmit id="delete" class="btn btn-xs btn-red delete" 
                                        value="Remove Network(s)" action="delete"
                                        data-warning="Really remove network(s)?" title="Remove selected network(s)"/></li>
                  </g:if>
                </shiro:hasRole>
              </ul>
            </div>
            <div class="box-content">
              <table class="table table-normal sortable filtered" id="networks">
                <thead>
                <tr>
                <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                  <td class="checkboxTd">&thinsp;x</td>
                </shiro:hasRole>
                <td>Project</td>
                <td>Network name</td>
                <td>Subnets Associated</td>
                <td>Shared</td>
                <td>Status</td>
                <td>Admin State</td>
                </tr>
                </thead>
                <tbody>
                <g:each in="${networks}" var="network" status="i">
                  <tr>
                  <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                    <td>
                    <g:if test="${network.id}"><g:checkBox id="checkBox_${network.id}" name="selectedNetworks" value="${network.id}"
                                                           checked="0" class="requireLogin"/></g:if>
                    </td>
                  </shiro:hasRole>
                  <td>${network.project ? network.project.name : '-'}</td>
                  <td>
                  <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                    <g:linkObject type="network"  displayName="${network.name == '' ? '(' + network.id.substring(0,8) + ')' : network.name}"
                                  id ="${network.id}" elementId="network-${network.id}"/>
                  </shiro:hasRole>
                  <shiro:lacksRole name="${Constant.ROLE_ADMIN}">
${network.name == '' ? '(' + network.id.substring(0,8) + ')' : network.name}
                  </shiro:lacksRole>
                  </td>
                  <td>
                  <g:each in="${network.subnets}" var="subnet">
                    <g:if test="${subnet}">
                      <strong>${subnet.name}</strong> ${subnet.cidr}<br/>
                    </g:if>
                  </g:each>
                  </td>
                  <td>${network.shared ? 'YES' : 'NO'}</td>
                  <td>${network.status}</td>
                  <td>${network.adminStateUp ? 'UP' : 'DOWN'}</tr>
                </g:each>
              </table>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>

</html>
