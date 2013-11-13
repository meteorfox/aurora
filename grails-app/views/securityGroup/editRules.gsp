<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="security"/>
    <meta name="menu-level-2" content="securitygroups"/> 
    <meta name="menu-level-3" content="Manage Rules"/> 
    <title>Security Group Rules</title>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'securityGroup-ui.js')}"></script>
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
        <div class="row">
          <div class="col-md-6">
            <g:form method="post">
              <div class="box">
                <div class="box-header">
                  <span class="title">Rules</span>
                  <ul class="box-toolbar">
                    <li><g:if test="${params.securityGroup.rules}">
                      <g:buttonSubmit class="delete btn btn-xs btn-red" value="Remove Rule(s)" id="delete" action="deleteRule"
                                      data-warning="${params.isDefault? 'After deleting default rules you might probably lose access to your VMs. Please proceed with care.': 'Really remove rule(s)?'}"
                                      title="Delete selected rule(s)"/>
                    </g:if>
                    </li>
                  </ul>
                </div>
                <div class="box-content"> 
                  <input type="hidden" id="input-hidden_sgShow_id" name="id" value="${params.securityGroup.id}"/>
                  <table id="table_securityGroupEditRules" class="securityGroups table table-normal">
                    <thead>
                      <tr>
                        <td class="checkboxTd">&thinsp;x</td>
                        <td>Ip protocol</td>
                        <td>From port</td>
                        <td>To port</td>
                        <td>Source</td>
                      </tr>
                    </thead>
                    <tbody>
                    <g:each var="rule" in="${params.securityGroup.rules}" status="i">
                      <tr>
                        <td>
                      <g:if test="${rule.id && rule.ipProtocol}">
                        <g:checkBox name="selectedRules" id="checkBox_${rule.id}" value="${rule.id}" checked="0"/>
                      </g:if>
                      <g:else>&nbsp;</g:else>
                      </td>
                      <td>
                      <g:if test="${rule.ipProtocol}">${rule.ipProtocol}</g:if>
                      <g:else><span class="text-warning">Default Rule (non-removable)</span></g:else>
                      </td>
                      <td>${rule.fromPort}</td>
                      <td>${rule.toPort}</td>
                      <td>${rule.source}</td>
                      </tr>
                    </g:each>
                    </tbody>
                  </table>
                </div>
              </div>
            </g:form>
          </div>
          <div class="col-md-6">
            <g:form method="post" class="form-horizontal fill-up">

              <input type="hidden" id="input-hidden_sgShow_id" name="id" value="${params.securityGroup.id}"/>
              <div class="box">
                <div class="box-header">
                  <span class="title">Add Rule</span>
                </div>
                <div class="box-content"> 
                  <div class="padded">
                    <div class="form-group">
                      <label class="control-label col-lg-3">Ip protocol</label>
                      <div class="col-lg-4">
                        <g:select id="select_sgShow_ipProtocol" name="ipProtocol" from="${params.ipProtocols}"
                                  value="${params.ipProtocol}"/>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-lg-3 required" id="fromPortLabel">From Port *</label>
                      <div class="col-lg-4">
                        <input type="text" id="input_sgShow_fromPort" name="fromPort" value="${params.fromPort}"/>
                      </div>
                    </div>                    
                    <div class="form-group">
                      <label class="control-label col-lg-3 required" id="toPortLabel">To port *</label>
                      <div class="col-lg-4">
                        <input type="text" id="input_sgShow_toPort" name="toPort" value="${params.toPort}"/>
                      </div>
                    </div>                    
                    <div class="form-group">
                      <label class="control-label col-lg-3">Source group</label>
                      <div class="col-lg-4">
                        <g:select id="select_sgShow_sourceGroup" name="sourceGroup"
                                  from="${params.sourceGroups.entrySet()}" value="${params.sourceGroup}" optionKey="key"
                                  optionValue="value"/>
                      </div>
                    </div>                    
                    <div class="form-group" id="cidrSection">
                      <label class="control-label col-lg-3">CIDR</label>
                      <div class="col-lg-4">
                        <input type="text" id="input_sgShow_cidr" name="cidr" value="${params.cidr ?: '0.0.0.0/0'} "/>
                      </div>
                    </div>                    

                  </div>

                  <div class="form-actions">
                    <g:buttonSubmit class="btn btn-green" id="submit" action="addRule" title="Add new rule">Add Rule</g:buttonSubmit>
                  </div>
                </div>
              </div>

            </g:form>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
