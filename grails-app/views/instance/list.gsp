<%@ page import="com.paypal.aurora.Constant" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="compute"/> 
    <meta name="menu-level-2" content="instances"/> 
    <script type="text/javascript" src="${resource(dir: 'js', file: 'instances-ui.js')}"></script>
    <title>Instances</title>
      <script>
        var userName = "<shiro:principal/>"
        var useExternalFLIP = "${useExternalFLIP}"        
        jQuery(document).ready(function() {
            loadFloatingIPs();
        });
  </script>
  </head>

  <body>

    <div id='credentialsHint'>
      <g:render template="credentialsHint"/>
    </div>
    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div id="message" class="message alert alert-info">${flash.message}</div>
            </g:if>      
            <div id="info_box" class="hide">${flash.message}</div>
            <g:hasErrors bean="${cmd}">
              <div class="alert alert-error">
                <g:renderErrors bean="${cmd}" as="list"/>
              </div>
            </g:hasErrors>
          </div>
        </div>
        <g:form method="post" class="validate">
          <input type="hidden" id="input-hidden_instList_appNames" name="appNames" value="${params.id}"/>
          <div class="box">
            <div class="box-header">
              <span class="title">Running Instances</span>
              <ul class="box-toolbar">
                <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                  <li class="hide">
                  <g:checkBox class="" name="allTenants" id="allTenants" title="Show for all tenants" checked="${session.sessionStorage.allTenants}" />
                  <label for="allTenants">Show for all tenants</label>
                  </li>
                </shiro:hasRole>
                <li><g:link class="create btn btn-green btn-xs" elementId="launchInstance" 
                            action="create" title="Launch new instance">Launch Instance</g:link></li>
                <g:if test="${instances}">
                  <li>
                  <g:buttonSubmit class="delete btn btn-red btn-xs stop" value="Terminate Instance(s)" id="terminate" action="terminate"
                                  data-warning="Really terminate instance(s)?" title="Shut down and delete selected instance(s)"/>
                  </li>
                </g:if>
              </ul>
            </div>
            <div class="box-content">
              <div id='table_container'>
                <g:render template="instances"/>
              </div>
              <div id="temp_table_holder" class="hide">
                
              </div>
              <div class="paginateButtons">
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>

    
</html>
