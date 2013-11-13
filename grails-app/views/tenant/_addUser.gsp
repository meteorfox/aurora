
<div class="box">
  <div class="box-header">
    <span class="title">Add New Users</span>
  </div>
  <div class="box-content padded">
    <div class="row">
      <div class="col-md-6">
        <div>User Name</div>
        <select id="all-users">
          <g:each var="user" in="${allUsers}">
            <option value="${user.id}">${user.name}</option>
          </g:each>
        </select>
      </div>
      <div class="col-md-6">
        <div>Role</div>
        <select id="all-roles">
          <g:each var="role" in="${allRoles}">
            <option value="${role.id}">${role.name}</option>
          </g:each>
        </select>
      </div>
    </div>
  </div>

</div>
