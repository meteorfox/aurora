<%@ page grails.converters.JSON; com.paypal.aurora.Constant" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="health"/> 
    <title>Cloud Health</title>
  </head>

  <body>
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
          <ul class="nav nav-tabs" data-tabs="tabs">
            <g:each var="dc" in="${dataCenters}" status="i"> 
              <li class="${i==0?'active':''}"><a data-toggle="tab" href="#${dc}-tab">${dc}</a></li>
            </g:each>    
          </ul>
        </div>
        <div class="box-content">
          <div class="tab-content">
            <g:each var="dc" in="${dataCenters}" status="i"> 
              <div class="tab-pane ${i==0?'active':''}" id="${dc}-tab">
                <div class="box">
                  <div class="box-content">
                <g:render template="dataCenterList" model="[dc:dc,healthReport:healthReport]"/>  
                  </div>
                </div>
              </div>
            </g:each>

          </div>
        </div>
      </div>
    </div>
  </body>
</html>
