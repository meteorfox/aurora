<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="networking"/> 
    <meta name="menu-level-2" content="routers"/> 
    <meta name="menu-level-3" content="Add Interface"/>  
    <title>Add Interface</title>
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
        <g:form action="saveInterface" method="post" class="validate form-horizontal fill-up">
          <input type="hidden" id="id" name="id" value="${params.router.id}"/>
          <div class="box">
            <div class="box-header">
              <span class="title">Add Interface</span>
            </div>
            <div class="box-content padded">
              <div class="form-group">
                <label class="control-label col-lg-2">Subnet</label>
                <div class="col-lg-4">
                  <select id="subnet" name="subnet">
                    <g:each in="${params.networks}" var="network">
                      <g:each in="${network.subnets}" var="subnet">
                        <option value="${subnet.id}">${network.name}: ${subnet.cidr} ${subnet.name != '' ? '(' + subnet.name + ')':''}</option>
                      </g:each>
                    </g:each>
                  </select>
                </div>
              </div>      
              <div class="form-group">
                <label class="control-label col-lg-2">IP Address (optional)</label>
                <div class="col-lg-4">
                  <g:textField id="ip" name="ip"/>
                </div>
              </div>   
              <div class="form-group">
                <label class="control-label col-lg-2">Router Name</label>
                <div class="col-lg-4">
                  <g:textField id="name" name="name" value="${params.router.name == '' ? 'None' : params.router.name}" readonly="readonly"/>
                </div>
              </div>              

              <div class="form-actions">
                <g:buttonSubmit id="submit" class="btn btn-green" action="saveInterface" 
                                title="Add new interface with selected parameters">Add New Interface</g:buttonSubmit>
              </div>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>
