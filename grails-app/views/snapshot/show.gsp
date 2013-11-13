<%@ page import="com.paypal.aurora.InstanceController" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="storage"/> 
    <meta name="menu-level-2" content="snapshots"/> 
    <meta name="menu-level-3" content="Volume Snapshot Detail"/> 
    <title>Volume Snapshot Detail</title>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'autorefresh.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'volume-snapshot-ui.js')}"></script>
  </head>
  <body>


    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div id="message" class="alert alert-info">${flash.message}</div>
            </g:if>          
            <g:hasErrors bean="${cmd}">
              <div id="error_message" class="alert alert-error">
                <g:renderErrors bean="${cmd}" as="list"/>
              </div>
            </g:hasErrors>
          </div>
        </div>
        <div class="box">
          <div class="box-header">
            <span class="title">Create New Volume</span>

            <g:form>
              <ul class="box-toolbar">

                <input type="hidden" id="id" name="id" value="${snapshot.id}"/>
                <li><g:link class="btn btn-xs btn-green" controller="instance" 
                            action="create" elementId="create"
                            params="[volumeOptions: InstanceController.VolumeOptions.BOOT_FROM_SNAPSHOT, snapshotId: snapshot.id]" 
                            title="Launch new instance with volume, created from this snapshot">Launch</g:link></li>
                <li><g:buttonSubmit class="btn btn-xs btn-red delete" id="delete" 
                                    action="delete" value="Delete Snapshot" 
                                    data-warning="Really delete snapshot '${snapshot.id}'?" 
                                    title="Delete this volume snapshot"/></li>

              </ul>
            </g:form>
          </div>
          <div class="box-content">
            <table id="table_snapshotShow" class="table table-normal">
              <tbody>
                <tr>
                  <td title="Snapshot ID">Snapshot ID</td>
                  <td>${snapshot.id}</td>
                </tr>
                <tr>
                  <td title="Volume ID">Volume ID</td>
                  <td><g:linkObject type="volume" id="${snapshot.volumeId}"/></td>
              </tr>
              <tr>
                <td title="Status">Status</td>
                <td id="snapshot_status_value" >${snapshot.status}</td>
              </tr>
              <tr>
                <td title="Size">Size</td>
                <td>${snapshot.size} GB</td>
              </tr>
              <tr>
                <td title="Description">Description</td>
                <td>${snapshot.description}</td>
              </tr>
              <tr>
                <td title="Created">Created</td>
                <td>${snapshot.created}</td>
              </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
