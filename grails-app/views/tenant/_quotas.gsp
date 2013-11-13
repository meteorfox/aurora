  <table id="table_tenantQuotas" class="table table-normal">
      <thead>
      <tr>
        <td style="width:25%">Name</td>
        <td>Limit</td>
      </tr>
      </thead>
      <tbody>
      <g:each var="quota" in="${quotas}" status="i">
          <tr>
              <td>${quota.displayName}</td>
              <td>${quota.limit}</td>
          </tr>
      </g:each>
      </tbody>
  </table>
