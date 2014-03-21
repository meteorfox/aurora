<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithoutNav"/>   

    <script type="text/javascript" src="${resource(dir: 'js', file: 'login.js')}"></script>
    <script type="text/javascript">
        var signInUrl = "${resource(dir: 'auth', file: 'signIn.json')}";
        var signOutUrl = "${resource(dir: 'auth', file: 'signOut')}";
    </script>
    <title>Sign In</title>

  </head>

  <body>
  <g:javascript>
    var awsEnvironments = [];
    var loginHints = [];
  </g:javascript>
  <g:each in="${grailsApplication.config.properties.environments}" var="environment">
    <g:if test="${environment.redirect_url}">
      <g:javascript>
        awsEnvironments.push("${environment.name}")
      </g:javascript>
    </g:if>
    <g:if test="${environment.loginHint}">
      <g:javascript>
        loginHints["${environment.name}"] = "${environment.loginHint}";
      </g:javascript>
    </g:if>
  </g:each>
  <div class="container">
    <div class="col-md-4 col-md-offset-4">

      <div class="padded">
        <div class="login box" style="margin-top: 80px;">

          <div class="box-header">
            <span class="title">Aurora Sign In</span>
          </div>
          <div class="box-content padded">
            <g:if test="${flash.message}">
              <div id="message" class="message">${flash.message}</div>
            </g:if>
            <div id="failedLoginConfirmation" class="panel panel-danger" style="display:none;">
              <div class="panel-heading">Failed to connect to the following data centers:</div>
              <table class="message-area table table-bordered">
              </table>
            </div>     
            <g:form action="signIn" class="separate-sections">
              <div class="input-group">
                <g:chooseEnvironment title="Switch to a different environment" 
                                     id="vpc" name="vpc" value="${params.vpc}" optionKey="name" optionValue="name"/>
              </div>

              <div class="input-group addon-left c3specific">
                <span class="input-group-addon" href="#">
                  <i class="icon-user"></i>
                </span>
                <input type="text" id="username" placeholder="Username" name="username" value="${username}"/>
              </div>

              <div class="input-group addon-left c3specific">
                <span class="input-group-addon" href="#">
                  <i class="icon-key"></i>
                </span>
                <input type="password" id="password" placeholder="Password" name="password" value=""/>
              </div>

              <div>
                <g:buttonSubmit id="submit" action="submit" class="btn btn-blue btn-block" title="Sign In with typed credentials">
                  Sign In <i></i>
                </g:buttonSubmit>
              </div>
            </g:form>
            <div class="loginHint"></div>
            <div id="partialLoginConfirmation" style="display:none;">
              <div class="panel panel-warning">
                <div class="panel-heading">Failed to connect to the following data centers:</div>
                <table class="message-area table table-bordered"></table>
              </div>
              <div class="clearfix">
                <div class="pull-right">
                  <a href="/auth/signOut" class="btn btn-gold"><i class="icon-off"></i> Sign Out</a>
                  <a href="${targetUri}" class="btn btn-sea">Proceed Anyway <i class="icon-signin"></i></a>
                </div>
              </div>
            </div>         
          </div>

        </div>

      </div>
    </div>  
  </div>

</body>
</html>
