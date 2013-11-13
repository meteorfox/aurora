<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="security"/>
    <meta name="menu-level-2" content="securitygroups"/>   
    <meta name="menu-level-3" content="Details"/>  
    <title>Security Group : ${securityGroup.name} </title>
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
        <g:form>     
          <input type="hidden" id="input-hidden_sgShow_id" name="id" value="${securityGroup.id}"/>
          <input type="hidden" id="input-hidden_sgShow_name" name="name" value="${securityGroup.name}"/>
          <div class="row">
            <div class="col-md-6">
              <div class="box">
                <div class="box-header">
                  <span class="title">Security Group Details</span>
                  <ul class="box-toolbar">
                    <li>
                    <g:buttonSubmit class="delete btn btn-xs btn-red" id="delete" action="delete" value="Delete Security Group"
                                    data-warning="${params.isDefault? 'After deleting default security group you might probably lose access to your VMs. Please proceed with care.': "Really delete security group $securityGroup.name?"}"
                                    title="Delete this security group" />  
                    </li>
                  </ul>
                </div>
                <div class="box-content">
                  <table id="table_securityGroupShowDialog" class="table table-normal">
                    <tbody>
                      <tr>
                        <td class="name">Name</td>
                        <td class="value">${securityGroup.name}</td>
                      </tr>
                      <tr>
                        <td class="name">Description</td>
                        <td class="value">${securityGroup.description}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>

            <div class="col-md-6">
              <div class="box">
                <div class="box-header">
                  <span class="title">Rules</span>
                  <ul class="box-toolbar">
                    <li>
                    <g:link elementId="editRules" class="btn btn-xs btn-blue" action="editRules" 
                            params="[id: securityGroup.id]" title="Edit rules for this security group">Edit Rules</g:link>
                    </li>
                  </ul>
                </div>
                <div class="box-content">

                  <table id="table_securityGroupShow" class="table table-normal">
                    <thead>
                      <tr>
                        <td>Ip protocol</td>
                        <td>From port</td>
                        <td>To port</td>
                        <td>Source</td>
                      </tr>
                      </thead>
                      <tbody>
                      <g:each var="rule" in="${securityGroup.rules}">
                        <td>
                        <g:if test="${rule.ipProtocol}">${rule.ipProtocol}</g:if>
                        <g:else><span class="text-warning">Default Rule</span></g:else>
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
          </div>
      </div>
    </div>
          </body>
          </html>
