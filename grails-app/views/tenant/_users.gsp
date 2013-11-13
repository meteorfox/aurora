<table class="table table-normal">
  <thead>
    <tr>
      <td>User Name</td>
      <td>User Id</td>
      <td>User Email</td>
      <td>User Role</td>
      <td>Role Id</td>
      <td>Enabled</td>
      <td class="checkboxTd">Remove</td>
    </tr>
  </thead>
  <tbody>
  <g:each var="user" in="${users}">
    <g:each var="role" in="${usersRoles.get(user.id)}">
    <tr>
      <td><g:linkObject displayName="${user.name}" elementId="openStackUser-${user.id}" 
                      type="openStackUser" id="${user.id}"/></td>
    <td>${user.id}</td>
    <td>${user.email}</td>
    <td>${role.name}</td>
    <td>${role.id}</td>
    <td>${user.enabled ? 'Enabled' : 'Disabled'}</td>
    <td><form action="javascript:">
        <button class="btn btn-red btn-xs nowarn" 
                onclick="ManageTenants.validateAndRemoveUser(this, '${tenant.id}','${user.id}','${role.id}')"
                data-warning="Really remove user <em>${user.name}</em> with role <em>${role.name}</em> from Project <em>${tenant.name}</em>?">Remove</button>
      </form>
    </td>
    </tr>
    </g:each>
  </g:each>
</tbody>
</table>
