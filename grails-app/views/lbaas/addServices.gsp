<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="lbaas"/>
    <meta name="menu-level-2" content="pools"/> 
    <meta name="menu-level-3" content="Add Services"/>     
    <title>Add Services</title>
    
    <script type="text/javascript">
        var instanceIdsToInterfacesMap = {
            <g:each var="instance" in="${instances}">"${instance.instanceId}": {
                <g:each in="${instance.networks}" var="network">"${network.pool}": "${network.ip}",</g:each>
                <g:each in="${instance.floatingIps}" var="flip">"${flip.pool?:flip.ip}": "${flip.ip}",</g:each>
            },
            </g:each>
        };
        var instanceSelected = "${params.instanceId}";
        var interfaceSelected = "${params.netInterface}";
    </script>

    <script type="text/javascript" src="${resource(dir: 'js', file: 'addServices.js')}"></script>
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
        <g:form method="post" name="addServiceForm" action="saveService" class="validate form-horizontal fill-up">
          <input type="hidden" name="id" id="input-hidden_lbaasAdd_id" value="${params.id}"/>

          <div class="box">
            <div class="box-content padded">
              <div class="row">
                <div class="col-lg-4">
                  <div class="form-group">
                    <label class="control-label col-md-6 required">Network Interface *</label>
                    <div class="col-md-6">
                      <select id="netInterface" name="netInterface">
                        <g:if test="${instances.size() != 0}">
                          <g:each var="netInterface" in="${interfaces}">
                            <option value="${netInterface}"
                                    selected="${params.netInterface == netInterface}">${netInterface}</option>
                          </g:each>
                        </g:if>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-6 required">Service Port *</label>
                    <div class="col-md-6"><input type="text" id="port" name="port" value="${params.port}"/></div>
                  </div>
                </div>
                <div class="col-lg-4">
                  <div class="form-group">
                    <label class="control-label col-md-6 required">Service Weight *</label>
                    <div class="col-md-6"><input type="text" id="weight" name="weight" value="${params.weight ?: 10}"/></div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-6">Service Enabled</label>
                    <div class="col-md-6"><g:checkBox id="enabled" class="icheck" name="enabled" value="${params.enabled}"/></div>
                  </div> 
                </div>
              </div>
            </div>
          </div>
          <div class="box">
            <div class="box-header">
              <span class="title">Select services to add to ${pool.name}</span>
            </div>
            <div class="box-content">
              <table id="table_lbaasNewServices" class="table table-normal">
                <thead>
                  <tr>
                    <td class="checkboxTd">&thinsp;x</td>
                    <td>Instance Name</td>
                    <td>Service Name</td>
                  </tr>
                </thead>
                <tbody>
                <g:each in="${instances}" var="instance">
                  <tr>
                    <td>
                  <g:checkBox id="checkBox_${instance.instanceId}" name="instanceId"
                              value="${instance.instanceId}"
                              checked="${params.instanceId?.contains(instance.instanceId)}" disabled="disabled"/>
                  </td>
                  <td>${instance.name}</td>
                  <td class="serviceName"></td>
                  </tr>
                </g:each>
                </tbody>
              </table>

              <div class="form-actions">
                <btn class="btn btn-green" id="submitButton" title="Add Selected Services">Add Selected Services</btn>
              </div>
            </div>
          </div>

        </g:form>
      </div>
    </div>

  </body>