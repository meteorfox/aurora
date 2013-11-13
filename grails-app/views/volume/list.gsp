<%@ page import="com.paypal.aurora.OpenStackRESTService; grails.converters.JSON; com.paypal.aurora.Constant" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="storage"/> 
    <meta name="menu-level-2" content="volumes"/> 
    <title>Volumes</title>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'autorefresh.js')}"></script>     
    <script type="text/javascript" src="${resource(dir: 'js', file: 'volume-ui.js')}"></script>
  </head>
  <body>

    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div id="volumes_info_box" class="alert alert-info"></div>
            <g:if test="${flash.message}">
              <div id="message" class="message alert alert-info">${flash.message}</div>
            </g:if>          
          </div>
        </div>

        <g:form method="post" class="validate">
          <div class="box">
            <div class="box-header">
              <span class="title">Volumes</span>
              <ul class="box-toolbar">
                <li><g:buttonSubmit class="btn btn-xs btn-green" id="create" action="create" value="Create Volume" title="Create new volume"/></li>
                <g:if test="${volumes}">
                  <li><g:buttonSubmit class="btn btn-xs btn-red delete" id="delete" action="delete" value="Delete Volume(s)"
                                  data-warning="Really delete volume(s)?" title="Delete selected volume(s)"/></li>
                </g:if>
              </ul>
            </div>
            <div class="box-content" id="table_container">
              <g:render template="volumes"/>
            </div>
            <div class="box-footer">
              <div class="paginateButtons">
              </div>
            </div>
          </div>
        </g:form>
        <shiro:hasRole name="${Constant.ROLE_ADMIN}">
          <g:form method="post" class="validate">
          <div class="box">
            <div class="box-header">
              <span class="title">Volumes Types</span>
              <ul class="box-toolbar">
                <li><g:buttonSubmit class="btn btn-xs btn-green" action="createType" value="Create Volume Type" title="Create new volume type"/></li>
                <g:if test="${volumeTypes}">
                  <li><g:buttonSubmit class="btn btn-xs btn-red delete" id="deleteType" action="deleteType" value="Delete Volume Type(s)"
                                  data-warning="Really delete volume type(s)?" title="Delete selected volume type(s)"/>
                </g:if>
              </ul>
            </div>
          
            <div class="box-content">
              <g:render template="volumeTypes"/>
            </div>

            <div class="box-footer">
              <div class="paginateButtons">
              </div>
            </div>
          </div>
          </g:form>
        </shiro:hasRole>
      </div>
      </div>
  </body>
</html>
