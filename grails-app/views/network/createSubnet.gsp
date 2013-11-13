<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="networking"/>
    <meta name="menu-level-2" content="networks"/>  
    <meta name="menu-level-3" content="Create Subnet"/>  
    <title>Create Subnet</title>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'xxsubnet-ui.js')}"></script>
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
        <g:form action="saveSubnet" method="post" class="validate form-horizontal fill-up">
          <g:hiddenField id="networkId" name="networkId" value="${params.networkId}"/>
          <g:hiddenField id="tenantId" name="tenantId" value="${params.tenantId}"/>
          <div class="box">
            <div class="box-header">
              <span class="title">Create Subnet</span>
              <ul class="nav nav-tabs nav-tabs-left">
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
                      <g:textField id="name" name="name" value="${params.name}"
                                   title="Subnet name. This field is optional."/>
                    </div>  
                  </div>  
                  <div class="form-group">
                    <label class="control-label col-lg-2">Network Address</label>
                    <div class="col-lg-4">
                      <g:textField id="networkAddress" name="networkAddress" value="${params.networkAddress}"
                                   title="Network address in cidr format (e.g., 192.168.0.0/24)"/>
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
                      <g:textField id="gatewayIp" name="gatewayIp" value="${params.gatewayIp}" title="IP address of gateway (e.g. 192.168.0.254). The default value is the first IP of the
                                   network address (e.g. 192.168.0.1 for 192.168.0.0/24). If you use the default leave blank."/>
                    </div>  
                  </div>  
                </div>

                <div id="subnetDetailTab" class="tab-pane">
                  <div class="form-group">
                    <label class="control-label col-lg-2">Enable DHCP</label>
                    <div class="col-lg-4">
                      <input class="icheck" id="enableDHCP" type="checkbox" name="enableDHCP"/>
                    </div>  
                  </div> 
                  <div class="form-group">
                    <label class="control-label col-lg-2">Allocation Pools</label>
                    <div class="col-lg-4">
                      <g:textArea id="allocationPools" name="allocationPools" value="${params.allocationPools}"
                                  title="IP addresses allocation pools. Each entry is ${"<"}start_ip_address${">"},${"<"}end_ip_address${">"} (e.g., 10.117.1.2,10.117.1.12) and one entry per line"/>
                    </div>  
                  </div>   
                  <div class="form-group">
                    <label class="control-label col-lg-2">DNS Name Servers</label>
                    <div class="col-lg-4">
                      <g:textArea id="dnsName" name="dnsName" value="${params.dnsName}" wrap="soft"
                                  title="IP address list of DNS name servers for this subnet. One entry per line."/>
                    </div>  
                  </div> 
                  <div class="form-group">
                    <label class="control-label col-lg-2">Host Routes</label>
                    <div class="col-lg-4">
                       <g:textArea id="hostRoutes" name="hostRoutes" value="${params.hostRoutes}"
                                  title="Additional routes announced to the hosts. Each entry is ${"<destination_cidr>,<nexthop>"} (e.g., 192.168.200.0/24,10.56.1.254)"/>
                           
                    </div>  
                  </div>                  


                </div>
              </div>
            </div>
            <div class="box-footer">
              <div class="form-actions">
                <g:buttonSubmit id="submit" class="btn btn-green" action="saveSubnet"
                                title="Create subnet with selected parameters">Create Subnet</g:buttonSubmit>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
