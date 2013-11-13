<%@ page import="com.paypal.aurora.Constant" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="networking"/> 
    <meta name="menu-level-2" content="routers"/>  
    <title>Routers</title>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'heat-ui.js')}"></script>
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
              <span class="title">Routers</span>
              <ul class="box-toolbar">

                <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                  <li><g:link elementId="create" class="btn btn-xs btn-green" action="create" 
                              title="Create new router">Create Router</g:link></li>
                  <g:if test="${routers}">
                    <li><g:buttonSubmit id="delete" class="btn btn-xs btn-red delete" value="Remove Router(s)" action="delete"
                                        data-warning="Really remove router(s)?" title="Remove selected router(s)"/></li>
                  </g:if>
                </shiro:hasRole>
              </ul>
            </div>
            <div class="box-content">
              <table id="routers" class="table table-normal sortable filtered">
                <tr>
                  <td class="checkboxTd">&thinsp;x</td>
                  <td>Name</td>
                  <td>Status</td>
                  <td>External Network</td>
                </tr>
                <g:each in="${routers}" var="router" status="i">
                  <tr>
                    <td><g:if test="${router.id}"><g:checkBox id="checkBox_${router.id}" name="selectedRouters" value="${router.id}"
                                                            checked="0" class="requireLogin"/></g:if></td>
                  <td><g:linkObject type="router"  displayName="${router.name == '' ? '(' + router.id.substring(0,8) + ')' : router.name}"
                                    id ="${router.id}" elementId="router-${router.id}"/></td>
                  <td>${router.status}</td>
                  <td>${router.externalGatewayInfo ? router.externalGatewayInfo.networkName : '-'}</tr>
                </g:each>
              </table>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
