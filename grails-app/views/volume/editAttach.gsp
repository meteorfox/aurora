<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="storage"/> 
    <meta name="menu-level-2" content="volumes"/> 
    <meta name="menu-level-3" content="Edit Attachment"/> 
    <title>Edit Attachment</title>
  </head>
  <body>
    <div class="body">
      <div class="container">

        <g:if test="${volume.instanceName}">
          <g:form method="post" class="validate form-horizontal fill-up">
            <div class="box">
              <div class="box-header">
                <span class="title">Edit Attachment</span>
                <input type="hidden" name="instanceId" value="${volume.instanceId}">
                <input type="hidden" name="id" value="${volume.id}">
                <ul class="box-toolbar">
                  <li><g:buttonSubmit class="btn btn-xs btn-red delete" id="detach" action="detach" value="Detach"
                                      data-warning="Really detach this instance?" title="Detach instance"/></li>
                </ul>
              </div>
              <div class="box-content padded">
                <div class="form-group">
                  <label class="control-label col-lg-2">Attached to</label>
                  <div class="col-lg-4">
                    <label class="control-label">
                      <g:linkObject elementId="${volume.instanceId}" type="instance"  displayName="${volume.instanceName}" id ="${volume.instanceId}"/>
                    </label>
                  </div>
                </div>  
                <div class="form-group">
                  <label class="control-label col-lg-2">Device name</label>
                  <div class="col-lg-4">
                    <label class="control-label">${volume.device}</label>
                  </div>
                </div>                  
              </div>
            </div>
          </g:form>
        </g:if>
        <g:else>

          <g:form method="post" class="validate form-horizontal fill-up">
            <div class="box">
              <div class="box-header">
                <span class="title">Edit Attachment</span>
                <input type="hidden"  id="id" name="id" value="${params.id}"/>
                <ul class="box-toolbar">
                  <li><g:buttonSubmit class="btn btn xs btn-green" id="attach" action="attach" 
                                      value="Attach" title="Attach volume to selected instance"/></li>
                </ul>
              </div>
              <div class="box-content padded">
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Attach to Instance *</label>
                  <div class="col-lg-4">
                    <g:select id="instanceId" name="instanceId" from="${instances}" optionValue="name" optionKey="instanceId"/>
                  </div>
                </div>   
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Device name *</label>
                  <div class="col-lg-4">
                    <g:textField  id="device" name="device" value="/dev/vdc"/>
                  </div>
                </div> 
              </div>
            </div>
          </g:form>

        </g:else>
      </div>
    </div>
  </body>
</html>
