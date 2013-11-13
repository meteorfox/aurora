<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>    
    <meta name="menu-level-1" content="networking"/>
    <meta name="menu-level-2" content="networks"/>   
    <meta name="menu-level-3" content="Edit Port"/> 
    <title>Edit Port</title>
    
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

        <g:form action="savePort" method="post" class="validate form-horizontal fill-up" params="[id:port.id]">
          <div class="box">
            <div class="box-header">
              <span class="title">Edit Port</span>
            </div>
            <div class="box-content padded">  
              <div class="form-group">
                <label class="control-label col-lg-2">Name </label>
                <div class="col-lg-4">
                  <g:textField id="name" name="name" value="${port.name}"/>
                </div>  
              </div> 
              <div class="form-group">
                <label class="control-label col-lg-2">Admin State </label>
                <div class="col-lg-4">
                  <g:if test="${port.adminStateUp}">
                    <input class="icheck" id="adminState" type="checkbox" name="adminState"checked="checked"/>
                  </g:if>
                  <g:else>
                    <input class="icheck" id="adminState" type="checkbox" name="adminState"/>
                  </g:else>
                </div>  
              </div>
              <div class="form-group">
                <label class="control-label col-lg-2 required">Device ID *</label>
                <div class="col-lg-4">
                  <g:textField id="deviceId" name="deviceId" value="${port.deviceId}"/>
                </div>  
              </div>  
              <div class="form-group">
                <label class="control-label col-lg-2">Device Owner</label>
                <div class="col-lg-4">
                  <g:textField id="deviceOwner" name="deviceOwner" value="${port.deviceOwner}"/>
                </div>  
              </div>

              <div class="form-actions">
                <g:buttonSubmit id="submit" class="btn btn-green" 
                                action="savePortEdition" title="Save changes">Edit Port</g:buttonSubmit>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
