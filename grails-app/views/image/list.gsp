<%@ page import="com.paypal.aurora.OpenStackRESTService; grails.converters.JSON; com.paypal.aurora.Constant" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="compute"/> 
    <meta name="menu-level-2" content="images"/> 
    <title>Images</title>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'autorefresh.js')}"></script>    
    <script type="text/javascript" src="${resource(dir: 'js', file: 'image-ui.js')}"></script>
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
    <g:form method="post">
        <div class="box">
          <div class="box-header">
            <span class="title">Images</span>
            <ul class="box-toolbar">
                <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                  <li><g:link elementId="create" class="btn btn-xs btn-green" action="create" title="Create new image">Create Image</g:link></li>
                </shiro:hasRole>
            </ul>
          </div>

          <div class="box-content">
            <table class="table table-normal sortable filtered" id="images">
                <thead>
                <tr>
                    <td>Name</td>
                    <td>Type</td>
                    <td>Status</td>
                    <td>Public</td>
                    <td>Format</td>
                </tr>
                </thead>
                <tbody>
                <g:each var="image" in="${images}" status="i">
                    <tr>
                        <td class='image_show_link'><g:linkObject elementId="image-${image.id}" displayName="${image.name}" type="image" id="${image.id}"/></td>
                        <td>${image.type}</td>
                        <td class='image_status'>${image.status}
                            <g:if test="${image.status != 'active' && image.status != 'killed'}">
                                <i class="icon-cog icon-spin"></i>
                            </g:if></td>
                        <td>${image.shared}</td>
                        <td>${image.diskFormat}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
        <div class="box-footer">
        <div class="paginateButtons"></div>
        </div>
        </div>      
    </g:form>

      </div>
      </div>
      <div class="row">
      <div class="col-md-12">

    <g:form method="post">
        <div class="box">
          <div class="box-header">
            <span class="title">Instance Snapshots</span>
            <ul class="box-toolbar">
            </ul>
          </div>

          <div class="box-content">
            <table class="table table-normal sortable filtered" id="snapshots">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Type</th>
                    <th>Status</th>
                    <th>Public</th>
                    <th>Format</th>
                </tr>
                </thead>
                <tbody>
                <g:each var="snapshot" in="${snapshots}" status="i">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        <td class='image_show_link'><g:linkObject displayName="${snapshot.name}" elementId="snapshot-${snapshot.id}" type="image" id="${snapshot.id}"/></td>
                        <td>${snapshot.type}</td>
                        <td class='image_status'>${snapshot.status}
                            <g:if test="${snapshot.status != 'active' && snapshot.status != 'killed'}">
                                <img src="${resource(dir: 'images', file: 'spinner.gif')}"/>
                            </g:if></td>
                        <td>${snapshot.shared}</td>
                        <td>${snapshot.diskFormat}</td>
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
