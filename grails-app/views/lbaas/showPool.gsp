<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="lbaas"/>
    <meta name="menu-level-2" content="pools"/> 
    <meta name="menu-level-3" content="Pool Detail"/>    
    <title>Pool Detail</title>
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
            <span class="title">Pool Overview</span>
                          <g:if test="${pool}">
                <g:form controller="lbaas">
            <ul class="box-toolbar">

                  <input type="hidden" id="id" name="id" value="${pool.name}"/>
                  <li><g:link class="btn btn-xs btn-blue" elementId="editPool" action="editPool"
                              params="[id: pool.name]" title="Edit pool parameters">Edit Pool</g:link>
                  </li>
                  </ul>
                </g:form>
              </g:if>
          </div>
          <div class="box-content">

            <table id="table_lbassPool" class="table table-normal">
              <tbody>
                <tr>
                  <td>Name</td>
                  <td>${pool.name}</td>
                </tr>
                <tr>
                  <td>Method</td>
                  <td>${pool.method}</td>
                </tr>
                <tr>
                  <td>Monitors</td>
                  <td>${pool.monitors?.join(', ')}</td>
                </tr>
                <tr>
                  <td>Enabled</td>
                  <td>${pool.enabled}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <g:form method="post">
          <input type="hidden" id="pool" name="pool" value="${pool.name}"/>
          <div class="box">
            <div class="box-header">
              <span class="title">Services</span>
              <ul class="box-toolbar">
                <li><g:link action="addServices" class="btn btn-xs btn-green" params="[id: pool.name]"
                            title="Add new service to this pool">Add New Services</g:link></li>
                <g:if test="${services}">
                  <li><g:buttonSubmit class="btn btn-xs btn-blue" value="Enable" id="enable" action="enableService"
                                      params="[id: pool.name]" data-warning="Really enable service(s)?"
                                      tittle="Enable selected service(s)"/></li>
                  <li><g:buttonSubmit class="btn btn-xs btn-gold" value="Disable" id="disable" action="disableService"
                                      params="[id: pool.name]" data-warning="Really disable service(s)?"
                                      tittle="Disable selected service(s)"/></li>
                  <li><g:buttonSubmit class="btn btn-xs btn-red delete" value="Delete" id="delete" action="deleteService"
                                      params="[id: pool.name]" data-warning="Really delete service(s)?"
                                      tittle="Delete selected service(s)"/></li>
                </g:if>
              </ul> 
            </div>
            <div class="box-content">

              <table id="table_lbassServices" class="table table-normal sortable filtered">
                <thead>
                  <tr>
                    <td class="checkboxTd">&thinsp;x</td>
                    <td>Name</td>
                    <td>Ip:Port</td>
                    <td>Enabled</td>
                    <td>Weight</th>
                  </tr>
                </thead>
                <tbody>
                <g:each var="service" in="${services}">
                  <tr>
                    <td><g:checkBox id="checkBox_${service.name}" name="selectedServices" value="${service.name}"
                                  checked="0" class="requireLogin"/></td>
                  <td>${service.name}</td>
                  <td>${service.ip}:${service.port}</td>
                  <td>${service.enabled}</td>
                  <td>${service.weight}</td>
                  </tr>
                </g:each>
                </tbody>
              </table>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>