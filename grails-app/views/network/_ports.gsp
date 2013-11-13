<table class="table table-normal sortable filtered">
  <thead>
  <tr>
    <td class="checkboxTd">&thinsp;x</td>
    <td>Name</td>
    <td>Fixed IPs</td>
    <td>Device Attached</td>
    <td>Status</td>
    <td>Admin State</td>
  </tr>
  </thead>
  <tbody>
  <g:each in="${ports}" var="port" status="i">
    <tr>
      <td><g:if test="${port.id}"><g:checkBox name="selectedPorts" value="${port.id}"
                                            checked="0" class="requireLogin"/></g:if></td>
    <td><g:linkObject type="network" displayName="${port.name == "" ? '(' + port.id.substring(0,8) + ')': port.name}"
                      id ="${port.id}" action="showPort" elementId="port-${port.id}"/></td>
    <td>
    <g:each in="${port.fixedIps}" var="fixedIp">
${fixedIp.ip_address} <br/>
    </g:each>
    </td>
    <td>${port.deviceId == "" ? 'Not Attached' : 'Attached'} </td>
    <td>${port.status}</td>
    <td>${port.adminStateUp ? 'UP' : 'DOWN'}</td>
    </tr>
  </g:each>
  </tbody>
</table>