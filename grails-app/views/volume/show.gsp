<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="storage"/> 
    <meta name="menu-level-2" content="volumes"/> 
    <meta name="menu-level-3" content="Volume Detail"/> 
    <title>Volume Detail</title>
      <script type="text/javascript" src="${resource(dir: 'js', file: 'autorefresh.js')}"></script>
      <script type="text/javascript" src="${resource(dir: 'js', file: 'volume-ui.js')}"></script>
  </head>
  <body>

    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div id="message" class="alert alert-info">${flash.message}</div>
            </g:if>          
          </div>
        </div>
        <div class="box">
          <div class="box-header">
            <span class="title">Volume Detail</span>
            <g:if test="${volume}">
              <g:form controller="volume">

                <input type="hidden" id="id" name="id" value="${volume.id}"/>

                <ul class="box-toolbar">
                  <li><g:link elementId="create" controller="snapshot" 
                              class="btn btn-xs btn-green" action="create" 
                              params="[id:volume.id]" 
                              title="Create snapshot from this volume">Create Volume Snapshot</g:link></li>
                  %{--<li><g:buttonSubmit class="btn btn-xs btn-blue" action="edit" value="Edit Volume"/></li>--}%
                  <li><g:buttonSubmit class="btn btn-xs btn-blue" id="editAttach" action="editAttach" 
                                      value="Edit Attachment" title="Edit volume attachment"/></li>
                  <li><g:buttonSubmit class="btn btn-xs btn-red delete" id="delete" action="delete" value="Delete Volume"
                                      data-warning="Really delete volume?" title="Delete this volume"/></li>
                </ul>
              </g:form>
            </g:if>          
          </div>

          <div class="box-content">
            <table id="table_volumeShow" class="table table-normal">
              <tbody>
                <tr>
                  <td title="Volume ID">Volume ID</td>
                  <td>${volume.id}</td>
                </tr>
                <tr>
                  <td title="Display Name">Display Name</td>
                  <td>${volume.displayName}</td>
                </tr>
                <tr>
                  <td title="Description">Description</td>
                  <td>${volume.description}</td>
                </tr>
                <tr class="prop" >
                  <td title="Status">Status</td>
                  <td id="volume_status_value" >${volume.status}</td>
                </tr>
                <tr>
                  <td title="Volume Type">Volume Type</td>
                  <td>${volume.volumeType}</td>
                </tr>
                <tr>
                  <td title="Size">Size</td>
                  <td>${volume.size} GB</td>
                </tr>
                <tr>
                  <td>Attached to</td>
                  <td><g:linkObject type="instance" displayName="${volume.instanceName}" id ="${volume.instanceId}"/></td>
              </tr>
              <tr>
                <td>Device name</td>
                <td>${volume.device}</td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
