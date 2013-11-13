<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>    
    <meta name="menu-level-1" content="networking"/>
    <meta name="menu-level-2" content="floatingips"/>    
    <meta name="menu-level-3" content="Floating IP Detail"/> 
    <title>Floating IP Detail</title>
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
    <g:form method="post">
        <input type="hidden" id="ip" name="ip" value="${floatingIp.ip}">
        <input type="hidden" id="id" name="id" value="${floatingIp.id}">
      <div class="box">
          <div class="box-header">
            <span class="title">Floating IP ${floatingIp.ip}</span>
            <ul class="box-toolbar">
              <g:if test="${floatingIp.instanceId}">
                <li><input type="hidden" id="instanceId" name="instanceId" value="${floatingIp.instanceId}"/>
                <g:buttonSubmit id='disassociate' class="btn btn-xs btn-red" action="disassociateIp"
                                value="Disassociate floating IP" title="Disassociate this floating IP address"/></li>
            </g:if>
            <g:else>
                <li><g:link class="btn btn-xs btn-green" elementId="associate" 
                            action="associateFloatingIp" params="[ip:floatingIp.ip]" 
                            title="Associate this floating IP address">Associate floating IP</g:link></li>
                
            </g:else>
            </ul>
          </div>
        <div class="box-content">
            <table id="FloatingIpShow" class="table table-normal">
                <tbody>
                <tr>
                    <td>ID</td>
                    <td>${floatingIp.id}</td>
                </tr>
                <tr>
                    <td>Floating IP</td>
                    <td>${floatingIp.ip}</td>
                </tr>
                <tr>
                    <td>Pool</td>
                    <td>${floatingIp.pool}</td>
                </tr>
                <g:if test="${floatingIp.instanceId}">
                    <tr>
                        <td class="email">Instance</td>
                        <td><g:linkObject type="instance" id="${floatingIp.instanceId}"
                                                        displayName="${instances.find { it.instanceId == floatingIp.instanceId }.name}"/></td>
                    </tr>
                    <tr>
                        <td class="email">Fixed IP</td>
                        <td>${floatingIp.fixedIp}</td>
                    </tr>
                </g:if>
            </table>
        </div>
      </div>
    </g:form>
      </div>
</div>
</body>
</html>