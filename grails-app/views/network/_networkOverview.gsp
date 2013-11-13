<table class="table table-normal">
  <tbody>
    <tr title="Application name from Cloud Application Registry">
      <td>Name</td>
      <td>${network.name == "" ? 'None' : network.name}</td>
    </tr>
    <tr>
      <td>ID</td>
      <td>${network.id}</td>
    </tr>
    <tr>
      <td>Project ID</td>
      <td>${network.projectId}</td>
    </tr>
    <tr>
      <td>Status</td>
      <td>${network.status}</td>
    </tr>
    <tr>
      <td>Admin State</td>
      <td>${network.adminStateUp ? 'UP' : 'DOWN'}</td>
    </tr>
    <tr>
      <td>Shared</td>
      <td>${network.shared ? 'YES' : 'NO'}</td>
    </tr>
    <tr>
      <td>External Network</td>
      <td>${network.external ? 'YES' : 'NO'}</td>
    </tr>
  </tbody>
</table>