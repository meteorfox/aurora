<g:each in="${instance.floatingIps}" var="fip">
    <tr>
        <td>
            <g:if test="${fip.pool}">
                ${fip.pool}
            </g:if>
        </td>
        <td class="value">
            <g:form controller="network" action="disassociateIp" method="post">${fip.ip}
            <g:if test="${fip.fqdn}">(${fip.fqdn})</g:if>
            <g:if test="${fip.canDelete}">
                <input type="hidden" name="instanceId" value="${instance.instanceId}">
                <input type="hidden" name="fromInstance" value=true>
                <input type="hidden" name="ip" value="${fip.ip}">
                <g:buttonSubmit class="hide btn btn-xs btn-red delete" id="associate" action="disassociateIp" 
                                value="disassociateIp" title="Disassociate this IP" data-warning="Really Disassociate IP: ${fip.ip}?">
                  <i class="icon-minus"></i>  
                </g:buttonSubmit>
            </g:if>
        </g:form>
      </td>
    </tr>
</g:each>
