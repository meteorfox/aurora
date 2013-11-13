<%@ page import="com.paypal.aurora.Constant" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="settings"/>
    <meta name="menu-level-2" content="quotausages"/>      
    <title>Quota Usages</title>
</head>

<body>
<div class="body">
       <div class="container">
        <div class="box">
        <div class="box-header">
          <span class="title">Quota Summary</span>
        </div>
        <div class="box-content">

          <div id="quotaContainer" class="padded">
          <g:each var="quotaUsage" in="${quotaUsages}">
            <g:if test="${quotaUsage.limit > 0}">
              <div class="quotaTitle">Used ${quotaUsage.usage} of ${quotaUsage.limit} ${quotaUsage.displayName}</div>
            <div class="progress">
              <div class="progress-bar" role="progressbar" aria-valuenow="${quotaUsage.usage}" aria-valuemin="0" aria-valuemax="${quotaUsage.limit}" style="width:${100*(quotaUsage.usage/quotaUsage.limit)}%">
                <span class="sr-only">${100*(quotaUsage.usage/quotaUsage.limit)}% Complete</span>
              </div>
            </div>

            </g:if>
          </g:each>
          </div>
        </div>
      </div>
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
          <span class="title">Quota Usages</span>
          <ul class="box-toolbar">
            <li class="">
            <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                  <g:link elementId="edit" class="btn btn-blue btn-xs" action="quotas" controller="tenant" 
                          params="[parent: '/quotaUsage/list']" title="Edit quotas for this tenant">Edit Quotas</g:link>
            </shiro:hasRole>
          </li>
          </ul>
        </div>
        <div class="box-content list">

            <table id="table_quotaList" class="sortable table table-normal">
                <thead>
                <tr>
                    <td>Name</td>
                    <td>Limit</td>
                    <td>Usage</td>
                    <td>Left</td>
                </tr>
                </thead>
                <tbody>
                <g:each var="quotaUsage" in="${quotaUsages}" status="i">
                    <g:if test="${quotaUsage.limit > 0}">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td>${quotaUsage.displayName}</td>
                            <td>${quotaUsage.limit}</td>
                            <td>${quotaUsage.usage}</td>
                            <td>${quotaUsage.left}</td>
                        </tr>
                    </g:if>
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