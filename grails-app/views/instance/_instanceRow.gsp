<%@ page import="com.paypal.aurora.Constant" %>
<tr class="instance_row">
  <td class="instance_select">
<g:if test="${instance.instanceId}">
  <g:checkBox name="selectedInstances" value="${instance.instanceId}"
              id="checkBox_${instance.instanceId}"
              checked="0" class="requireLogin"/>
</g:if>
</td>
<td class='instance_show_link'>
  <g:linkObject type="instance" displayName="${instance.name}" id="${instance.instanceId}"/>
</td>

<g:if test="${allTenants}">
  <td>${instance.tenantName}</td>
</g:if>
<td class='instance_ip'>
  <g:if test="${isUseExternalFLIP}">${instance.displayedIp}</g:if>
  <g:else>
    <ul class="links">
      <g:each in="${instance.networks}" var="network">
        <li><b>${network.pool}</b> <a class="showIpHelp">${network.ip}</a></li>
      </g:each>
      <g:each in="${instance.floatingIps}" var="fip">
        <li>
        <g:if test="${fip.pool}"><b>${fip.pool}</b></g:if>
        <a class="showIpHelp">${fip.ip}</a>
        </li>
      </g:each>
    </ul>
  </g:else>
</td>
<shiro:hasRole name="${Constant.ROLE_ADMIN}">
  <td class="instance_host">${instance.host}</td>
</shiro:hasRole>
<td class='instance_status'>${instance.status}</td>
<td class='instance_taskStatus'>${instance.taskStatus}</td>
<td class='instance_powerStatus'>${instance.powerStatus}</td>
<g:if test="${isUseExternalFLIP}">
  <td class="instance_help"><button type="button" class="btn btn-xs btn-blue" 
                                    onclick="showLoginHelp('${instance.displayedIp}')" 
                                    title="${instance.displayedIp}">Login</button></td>
</g:if>
<td class="hide"><span class="instance_id">${instance.instanceId}</span><span class="instance_name">${instance.name}</span></td>
</tr>