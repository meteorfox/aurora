<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="networking"/>
    <meta name="menu-level-2" content="networks"/>   
    <meta name="menu-level-3" content="Network Detail"/>   
    <title>Network Detail</title>
    
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
        <div class="box">
          <div class="box-header">
            <ul class="nav nav-tabs nav-tabs-left">
              <li class="active"><a data-toggle="tab" href="#overview">Network Overview</a></li>
              <li><a data-toggle="tab" href="#subnets">Subnets</a></li>
              <li><a data-toggle="tab" href="#ports">Ports</a></li>
            </ul>
          </div>
          <div class="box-content">
            <div class="tab-content">
              <div id="overview" class="tab-pane active">
                <div class="box">
                  <div class="box-header">
                    <ul class="box-toolbar">
                      <li><g:link class="btn btn-xs btn-blue" action="edit" elementId="edit" 
                                  params="[id:network.id]" title="Edit this network">Edit Network</g:link></li>
                    </ul>
                  </div>
                  <div class="box-content">
                    <g:render template="networkOverview"/>
                  </div>
                </div>  
              </div>
              <div id="subnets" class="tab-pane">
                <g:form method="post" class="validate">
                  <g:hiddenField name="networkId" id="networkId" value="${network.id}"/>
                  <div class="box">
                    <div class="box-header">
                      <ul class="box-toolbar">
                        <li><g:link elementId="createSubnet" class="btn btn-xs btn-green" 
                                    action="createSubnet" params="[networkId:network.id,tenantId:network.projectId]" 
                                    title="Create new subnet for this network">Create Subnet</g:link></li>
                        <g:if test="${network.subnets.size > 0}">
                          <li><g:buttonSubmit id="deleteSubnet" class="btn btn-xs btn-red delete" 
                                              value="Remove Subnet(s)" action="deleteSubnet"
                                              data-warning="Really remove Subnet(s)?" title="Remove selected subnet(s)"/></li>
                        </g:if>                        
                      </ul>
                    </div>
                    <div class="box-content">
                      <g:render template="subnets"/>
                    </div>
                  </div> 
                </g:form>       
              </div>
              <div id="ports" class="tab-pane">
                <g:form method="post" class="validate">
                  <g:hiddenField name="networkId" id="networkId" value="${network.id}"/>
                  <div class="box">
                    <div class="box-header">
                      <ul class="box-toolbar">
                        <li><g:link elementId="createPort" class="btn btn-xs btn-green" 
                                    action="createPort" params="[networkId:network.id,tenantId:network.projectId]" 
                                    title="Create new port for this network">Create Port</g:link></li>
                        <g:if test="${ports}">
                          <li><g:buttonSubmit id="deletePort" class="btn btn-xs btn-red delete" 
                                              value="Remove Port(s)" action="deletePort"
                                              data-warning="Really remove Port(s)?" title="Remove selected port(s)"/></li>
                        </g:if>                        
                      </ul>
                    </div>
                    <div class="box-content">
                      <g:render template="ports"/>
                    </div>
                  </div> 
                </g:form>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>
  </body>
</html>
