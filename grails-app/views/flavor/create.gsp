<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="compute"/> 
    <meta name="menu-level-2" content="flavors"/> 
    <meta name="menu-level-3" content="Create New"/> 
    <title>Create New Flavor</title>

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
            <span class="title">Create New Flavor</span>
          </div>
          <div class="box-content">
            <g:form action="save" method="post" class="form-horizontal fill-up validate">
              <input type="hidden" name="fromUser" value="true"/>

              <div class="padded">
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Name *</label>
                  <div class="col-lg-4">
                    <g:textField id="name" name="name" value="${params.name}"/>
                  </div>
                </div>
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Memory size (MB) *</label>
                  <div class="col-lg-4">
                    <g:textField id="ram" name="ram" value="${params.ram}"/>
                  </div>
                </div>         
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Disk size (GB) *</label>
                  <div class="col-lg-4">
                    <g:textField id="disk" name="disk" value="${params.disk}"/>
                  </div>
                </div>

                <div class="form-group">
                  <label class="control-label col-lg-2 required">Number of vcpus *</label>
                  <div class="col-lg-4">
                    <g:textField id="vcpus" name="vcpus" value="${params.vcpus}"/>
                  </div>
                </div>

                <div class="form-group">
                  <label class="control-label col-lg-2">Accessible to the public</label>
                  <div class="col-lg-4">
                    <div style="padding-top:5px;">
                      <g:checkBox id="isPublic" class="icheck" name="isPublic" checked="${params.isPublic == 'on' ? 'true' : ''}"/>
                    </div>                
                  </div>
                </div>

                <div class="form-group">
                  <label class="control-label col-lg-2">Ephemeral space size in GB (optional)</label>
                  <div class="col-lg-4">
                    <g:textField id="ephemeral" name="ephemeral" value="${params.ephemeral}"/>
                  </div>
                </div>

                <div class="form-group">
                  <label class="control-label col-lg-2">Swap space size in MB (optional)</label>
                  <div class="col-lg-4">
                    <g:textField id="swap" name="swap" value="${params.swap}"/>
                  </div>
                </div>  

                <div class="form-group">
                  <label class="control-label col-lg-2">RX/TX factor (optional)</label>
                  <div class="col-lg-4">
                    <g:textField id="rxtxFactor" name="rxtxFactor" value="${params.rxtxFactor}"/>
                  </div>
                </div> 
              </div>

              <div class="form-actions">
                <g:buttonSubmit id="submit" class="save btn btn-blue" action="save" title="Create new flavor with selected parameters">Create New Flavor</g:buttonSubmit>
              </div>

          </g:form>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
