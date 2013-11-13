<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="security"/> 
    <meta name="menu-level-2" content="keypairs"/> 
    <title>Keypairs</title>
  </head>

  <body>
    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div id="message" class="message alert alert-info">${flash.message}</div>
            </g:if>          
          </div>
        </div>
        <g:form method="post" class="validate">
          <div class="box">
            <div class="box-header">
              <span class="title">Keypairs</span>
              <ul class="box-toolbar">
                <li><g:link elementId="create" class="btn btn-xs btn-green" action="create" 
                            title="Create new keypair">Create New Keypair</g:link></li>
                <li><g:link elementId="insert" class="btn btn-xs btn-green" action="insert" 
                            title="Import existing public key">Import Keypair</g:link></li>
                <g:if test="${keypairs}">
                  <li><g:buttonSubmit class="btn btn-xs btn-red delete" id="delete" 
                                      value="Remove Keypair(s)" action="delete"
                                      data-warning="Really remove keypair(s)?" 
                                      title="Remove selected keypair(s)"/></li>
                </g:if>
              </ul>
            </div>          
            <div class="box-content">

              <table id="table_keypairList" class="table table-normal sortable filtered">
                <tr>
                  <td class="checkboxTd">&thinsp;x</td>
                  <td>Name</td>
                  <td class="sorttable_nosort">Fingerprint</td>
                </tr>
                <g:each in="${keypairs}" var="keypair">
                  <tr>
                    <td><g:if test="${keypair.name}">
                    <g:checkBox id="checkBox_${keypair.name}" 
                                name="selectedKeypairs" value="${keypair.name}"
                                checked="0" class="requireLogin"/></g:if></td>
                  <td>${keypair.name}</td>
                  <td>${keypair.fingerprint}</td>
                  </tr>
                </g:each>
              </table>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
