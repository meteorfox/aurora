<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="networking"/>
    <meta name="menu-level-2" content="networks"/>    
    <meta name="menu-level-3" content="Edit Subnet"/>  

    <title>Edit Subnet</title>
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

        <g:form action="saveSubnetEdition" method="post" class="validate form-horizontal fill-up" params="[id:params.id]">
          <g:hiddenField id="networkId" name="networkId" value="${params.networkId}"/>
          <div class="box">
            <div class="box-header">
              <span class="title">Edit Subnet</span>
              <ul class="nav nav-tabs nav-tabs-right">
                <li class="active"><a data-toggle="tab" href="#subnetTab">Subnet</a></li>
                <li><a data-toggle="tab" href="#subnetDetailTab">Subnet Detail</a></li>
              </ul>
            </div>
            <div class="box-content padded">
              <div class="tab-content">
                <div id="subnetTab" class="tab-pane active">
                  <div class="form-group">
                    <label class="control-label col-lg-2">Subnet Name</label>
                    <div class="col-lg-4">
                      <g:textField id="name" name="name" value="${params.name}"/>
                    </div>  
                  </div>
                  <div class="form-group">
                    <label class="control-label col-lg-2">Network Address</label>
                    <div class="col-lg-4">
                      <g:textField id="networkAddress" name="networkAddress" value="${params.networkAddress}" readonly="readonly"/>
                    </div>  
                  </div>      
                  <div class="form-group">
                    <label class="control-label col-lg-2">IP Version</label>
                    <div class="col-lg-4">
                      <select id="ipVersion" name="ipVersion">
                        <option value="4">IPv4</option>
                        <option value="6">IPv6</option>
                      </select>
                    </div>  
                  </div> 
                  <div class="form-group">
                    <label class="control-label col-lg-2">Gateway IP (optional)</label>
                    <div class="col-lg-4">
                      <g:textField id="gatewayIp" name="gatewayIp" value="${params.gatewayIp}"/>
                    </div>  
                  </div>   
                </div>

                <div id="subnetDetailTab" class="tab-pane">
                  <div class="form-group">
                    <label class="control-label col-lg-2">Enable DHCP</label>
                    <div class="col-lg-4">
                      <g:if test="${params.enableDHCP}">
                        <input class="icheck" id="enableDHCP" type="checkbox" name="enableDHCP" checked="checked"/>
                      </g:if>
                      <g:else>
                        <input class="icheck" id="enableDHCP" type="checkbox" name="enableDHCP"/>
                      </g:else>
                    </div>  
                  </div> 
                  <div class="form-group">
                    <label class="control-label col-lg-2">DNS Name Servers</label>
                    <div class="col-lg-4">
                      <g:textArea id="dnsName" name="dnsName" value="${params.dnsName}" wrap="soft"/>
                    </div>  
                  </div> 
                  <div class="form-group">
                    <label class="control-label col-lg-2">Host Routes</label>
                    <div class="col-lg-4">
                      <g:textArea id="hostRoutes" name="hostRoutes" value="${params.hostRoutes}"/>
                    </div>  
                  </div>
                </div>
              </div>
            </div>
            <div class="box-footer">
              <div class="form-actions">
                <g:buttonSubmit id="submit" class="btn btn-green" action="saveSubnetEdition" 
                                title="Save changes">Save Changes</g:buttonSubmit>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
