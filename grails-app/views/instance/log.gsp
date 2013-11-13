<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="compute"/> 
    <meta name="menu-level-2" content="instances"/> 
    <meta name="menu-level-3" content="Instance Log"/> 
    <title>Instance log</title>
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
            <span class="title">Instance Log</span>
            <g:form class="validate">
              <input type="hidden" id="input-hidden_instLog_instanceId" name="instanceId" value="${log.instanceId}"/>
              <ul class="box-toolbar">
                <li>Log Length</li>
                <li><input id="submit" name="length" style="text-align: right; width: 50px;" value="${log.length}"/></li>
                <li><g:buttonSubmit class="btn btn-xs btn-gray" id="log" action="log" value="Lines View" 
                                    title="Show only some number of lines from log" /></li>
                <li><g:link class="btn btn-xs btn-gray" id="viewLog" action="log" title="Show full log"
                            params="[instanceId: log.instanceId, showAll: 'yes']">View Full Log</g:link></li>
              </ul>
            </g:form>
          </div>

          <div class="box-content padded">
            <form class="fill-up">
              <div class="form-group">
                <g:textArea rows="20" id="textarea_instLog_log" name="log" value="${log.log}"/>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
