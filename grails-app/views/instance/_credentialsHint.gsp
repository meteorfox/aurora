

<div id="credentialsArea" hidden="hidden">
  <g:if test="${showAdminCredentials}">
    <address>
      <strong>${adminLoginHint}</strong>
      <br/>
      <span id="root_credentials" title="Press Ctrl+C to copy selected row into the clipboard"></span>
    </address>

  </g:if>
  <g:if test="${showUserCredentials}">
    <address>
      <strong>${userLoginHint}</strong>
      <br/>
      <span id="corp_credentials" title="Press Ctrl+C to copy selected row into the clipboard"></span>
    </address>
  </g:if>
</div>