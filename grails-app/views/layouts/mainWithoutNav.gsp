<%@ page import="com.paypal.aurora.OpenStackRESTService; grails.converters.JSON; com.paypal.aurora.Constant" %>
<!DOCTYPE html>
<html>
<head>
  <title><g:layoutTitle default="Aurora"/></title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="viewport" content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,800">
  <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
  
  <script type="text/javascript" src="${resource(dir: 'js', file: 'application.js')}"></script> 
  
  <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.cookie.js')}"></script>

  <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'application.css')}"/>
  <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'aurora-navbar.css')}"/>
  <link rel="stylesheet" type="text/css" href="${resource(dir: 'css/font-awesome/css', file: 'font-awesome.min.css')}"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,800">
  <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'newtheme.css')}"/>
  <link rel="shortcut icon" href="${resource(dir: '/', file: 'favicon.ico')}" type="image/x-icon"/>
<script>
var rootContextPath = "${resource(dir: '')}";
</script>  
  <g:layoutHead/>
</head>

<g:set var='targetUri' value="${request.requestURL + (request.queryString ? '?' + request.queryString : '')}"/>
<body>
<div id="wrap">
<g:render template="/layouts/auroraHeader"/>
<div id="main-content-body">
<div id="browserAlert" style="display: none;">Warning! You are using an unsupported browser. Some features may not work correctly. The supported browsers are Chrome, Firefox 3.0 and higher, and Safari 3.1.2 and higher, IE8 and higher. <a href="#" id="oldBrowserAgreement">Got it! Please turn off this warning message.</a></div>
<div id="spinner" class="spinner" style="display:none;">
    <img src="${resource(dir: 'images', file: 'spinner.gif')}" alt="Spinner"/>
</div>

<div id="mainBar">
    <g:layoutBody/>
</div>

</div>
<div id="nonavfooter">
<g:render template="/layouts/auroraFooter"/>
</div>
</div>
<div id="loading-modal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-header">
        <h4 class="modal-title">Processing request</h4>
      </div>
    <div class="modal-body">
        <p id="loading-modal-message">Processing your request. This might take a few minutes. Please wait...</p>
        <p><center><i class="icon icon-cog icon-spin icon-2x"></i></center></p>
    </div>
  </div>
</div>
<div id="dialog-confirm" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Modal title</h4>
      </div>
      <div class="modal-body">
        <p>One fine body&hellip;</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-blue ok-btn" data-dismiss="modal">Confirm</button>
        <button type="button" class="btn btn-default cancel-btn">Cancel</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div id="popup" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Modal title</h4>
      </div>
      <div class="modal-body">
        <p>One fine body&hellip;</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-blue ok-btn" data-dismiss="modal">Ok</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.browser.min.js')}"></script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap-migration.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'updated-ui.js')}?v=${build}"></script>

</body>
</html>
