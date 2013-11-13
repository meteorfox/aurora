<table class="table table-normal sortable filtered">
  <thead>
  <tr>
    <td class="checkboxTd">&thinsp;x</td>
    <td>Name</td>
    <td>CIDR</td>
    <td>IP Version</td>
    <td>Gateway IP</td>
  </tr>
  </thead>
  <tbody>
  <g:each in="${network.subnets}" var="subnet" status="i">
    <tr>
      <td><g:if test="${subnet}"><g:checkBox name="selectedSubnets" value="${subnet.id}"
                                           checked="0" class="requireLogin"/></g:if></td>
    <td><g:linkObject type="network" displayName="${subnet.name == "" ? '(' + subnet.id.substring(0,8) + ')' : subnet.name}"
                      id ="${subnet.id}" action="showSubnet" elementId="subnet-${subnet.id}"/></td>
    <td>${subnet.cidr}</td>
    <td>IPv${subnet.ipVersion}</td>
    <td>${subnet.gatewayIp}</td>
    </tr>
  </g:each>
  </tbody>
</table>