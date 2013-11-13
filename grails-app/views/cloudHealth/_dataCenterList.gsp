
<table class="sortable table table-normal filtered">
  <thead>
    <tr>
      <td class="sorttable_nosort">Region</td>
      <td>Service Name</td>
      <td class="center">Status</td>
      <td>Time</td>
      <td>Duration</td>
    </tr>
  </thead>
  <tbody>

  <g:each var="report" in="${healthReport}">
    <g:if test="${report.datacenter == dc}">
      <tr>
        <td>${report.datacenter}</td>
        <td>${report.serviceName}</td>
      <g:if test="${report.status == 'SUCCESS'}">
        <td class="center text-success"><i class="icon-ok"></i></td>
      </g:if> 
      <g:if test="${report.status != 'SUCCESS'}">
        <td class="center text-danger"><i class="icon-remove"></i></td>
      </g:if>
      <td>${report.executionTime}</td>
      <td>${report.executionDuration}</td>
      </tr>
    </g:if>
  </g:each>
</tbody>

</table>
