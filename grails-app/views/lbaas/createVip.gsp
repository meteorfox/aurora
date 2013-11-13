<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="lbaas"/>
    <meta name="menu-level-2" content="vips"/> 
    <meta name="menu-level-3" content="Create VIP"/> 
    <title>Create VIP</title>
    <script>
        jQuery(function() {
            // on page load script
            var portVal = jQuery('#port').val();
            var selectProtocolVal = jQuery('#protocol').val();
            if (portVal == '')
                if (selectProtocolVal=='HTTP') jQuery('#port').val("80") ;

            // on #protocol change script
            jQuery('#protocol').change(function() {
                var selectVal = jQuery(this).val();
                if (selectVal=='HTTP')  jQuery('#port').val("80") ;
                else jQuery('#port').val("") ;
            });
        });
    </script>
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

          <g:form method="post" controller="lbaas" class="validate form-horizontal fill-up">
            <div class="box">
              <div class="box-header">
                <span class="title">Create New VIP</span>
              </div>
              <div class="box-content padded"> 
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Ip *</label>
                  <div class="col-lg-4">
                    <input type="text" id="ip" name="ip" value="${params.ip}"/>
                  </div>  
                </div>                
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Name *</label>
                  <div class="col-lg-4">
                    <input type="text" id="name" name="name" value="${params.name}"/>
                  </div>  
                </div>  
                <div class="form-group">
                  <label class="control-label col-lg-2">Protocol</label>
                  <div class="col-lg-4">
                    <g:select id="protocol" name="protocol" value="${params.protocol}" from="${params.allowedProtocols}"/>
                  </div>  
                </div> 
                <div class="form-group">
                  <label class="control-label col-lg-2 required">Port *</label>
                  <div class="col-lg-4">
                    <input type="text" id="port" name="port" value="${params.port}"/>
                  </div>  
                </div>  
                <div class="form-group">
                  <label class="control-label col-lg-2">Enabled</label>
                  <div class="col-lg-4">
                    <g:checkBox id="enabled" class="icheck" name="enabled" checked="${params.enabled == 'on'}"/>
                  </div>  
                </div>
                <div class="form-actions">
                  <g:buttonSubmit class="btn btn-green" id="submit" 
                                  action="saveVip" title="Create new virtual IP address with selected parameters">Create VIP</g:buttonSubmit>
                </div>
              </div>
            </div>
          </g:form>
        </div>
      </div>
  </body>
</html>
