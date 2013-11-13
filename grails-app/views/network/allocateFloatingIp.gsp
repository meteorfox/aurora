<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="networking"/>
    <meta name="menu-level-2" content="floatingips"/>   
    <meta name="menu-level-3" content="Allocate"/>  
    <title>Allocate Floating IP</title>
  </head>

  <body>
    <script type="text/javascript">
        jQuery(function() {
            var stuff = jQuery(".hideable");
            stuff.css('display', 'none');
            jQuery('.iCheck-helper').click(function(){
                var stuff = jQuery(".hideable");
                if (jQuery('.icheckbox_flat-aero').hasClass("checked"))
                    stuff.css('display', 'block');
                else
                    stuff.css('display', 'none');
            });
        });
    </script>
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
        <g:form method="post" class="validate form-horizontal fill-up">
          <input type="hidden" name="parent" value="${parent}">
          <div class="box">
            <div class="box-header">
              <span class="title">Allocate Floating IP</span>
            </div>
            <div class="box-content padded">
                 <div class="form-group">
                  <label class="control-label col-lg-2">Pool</label>
                  <div class="col-lg-4">
                    <g:select id="pool" name="pool" from="${pools}" optionKey="name" optionValue="name"/>
                  </div>
                </div>  
              <g:if test="${isDns}">
                <div class="form-group">
                  <label class="control-label col-lg-2">FQDN Enabled</label>
                  <div class="col-lg-4">
                    <g:checkBox id="enabled" class="icheck" name="enabled" value="${params.enabled}"/>
                  </div>
                </div> 
                <div class="form-group hideable">
                  <label class="control-label col-lg-2">DNS Name</label>
                  <div class="col-lg-4">
                    <g:textField id="hostname" name="hostname"/>
                  </div>
                </div> 
                <div class="form-group hideable">
                  <label class="control-label col-lg-2">DNS Zone</label>
                  <div class="col-lg-4">
                    <g:select id="zone" name="zone" from="${zones}"/>
                  </div>
                </div>                 
              </g:if>
              
              <div class="form-actions">
                <g:buttonSubmit id="submit" class="btn btn-green" action="allocateIp" 
                                title="Allocate floating IP address with selected parameters">Allocate Floating IP</g:buttonSubmit>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
