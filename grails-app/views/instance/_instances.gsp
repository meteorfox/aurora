<%@ page import="com.paypal.aurora.Constant" %>
<table id="table_listInstance" class="sortable table table-normal filtered">
    <thead>
    <tr>
        <td class="checkboxTd">&thinsp;x</td>
        <td>Name</td>
        <g:if test="${session.sessionStorage.allTenants}">
            <td>Tenant</td>
        </g:if>
        <g:if test="${isUseExternalFLIP}">
            <td>IP Address</td>
        </g:if>
        <g:else>
            <td>IP Addresses</td>
        </g:else>
        <shiro:hasRole name="${Constant.ROLE_ADMIN}">
            <td>Host</td>
        </shiro:hasRole>
        <td>Status</td>
        <td>Task</td>
        <td>Power</td>
        <g:if test="${isUseExternalFLIP}">
            <td>Action</td>
        </g:if>
        <td hidden="hidden" style="display: none;"> </td>
    </tr>
    </thead>
    <tbody id="originalTbody">
    <g:each var="mi" in="${instances}">
      <g:set var="instance" value="${mi}"/>
      <g:render template="instanceRow"/>
        
    </g:each>
    </tbody>
</table>

