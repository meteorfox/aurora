<%@ page import="com.paypal.aurora.OpenStackRESTService; grails.converters.JSON; com.paypal.aurora.Constant" %>
<!DOCTYPE html>
<html>
<head>
    <title><g:layoutTitle default="Aurora"/></title>
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.js')}?v=${build}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.cookie.js')}"></script>
    <script type="text/javascript">
        var cssPath = "${resource(dir: 'css')}";
        var requiredFieldsArray = {<g:each var="constraint" in="${constraints}">
            "${constraint.key}": "${constraint.value}",
            </g:each>};
        var rootContextPath = "${resource(dir: '')}";
    </script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'loader.js')}"></script>
    <!--[if IE]>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ie.css')}?v=${build}"/>
  <![endif]-->
    <link rel="shortcut icon" href="${resource(dir: '/', file: 'favicon.ico')}" type="image/x-icon"/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.10.3.custom.min.js')}"></script>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'font-awesome/css/font-awesome.css')}"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css/bootstrap/css', file: 'bootstrap.min.css')}"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'ebay-navbar.css')}"/>
    <script type="text/javascript" src="${resource(dir: 'css/bootstrap/js', file: 'bootstrap.min.js')}"></script>
    <g:layoutHead/>
<style>
  .dropdown-menu a {
    color: #000000 !important;
    font-family: "HelveticaNeue-Light","Helvetica Neue Light","Helvetica Neue",Helvetica,Arial,"Lucida Grande",sans-serif !important;
    font-size: 16px !important;
    font-weight: 300 !important;
    padding: 10px 15px;
}
.dropdown-menu > li > a:hover, .dropdown-menu > li > a:focus, .dropdown-submenu:hover > a, .dropdown-submenu:focus > a {
  color: #ffffff !important;
  text-decoration: none;
  background-color: #0064D2;
  background-image: #0064D2;
  background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#0064D2), to(#0064D2));
  background-image: -webkit-linear-gradient(top, #0064D2, #0064D2);
  background-image: -o-linear-gradient(top, #0064D2, #0064D2);
  background-image: linear-gradient(to bottom, #0064D2, #0064D2);
  background-repeat: repeat-x;
  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#0064D2', endColorstr='#0064D2', GradientType=0);
}
.navbar-inverse .navbar-brand {
    color: #F0EFEC;
    padding-left: 30px;
}
  </style>
</head>
<g:render template="/layouts/c3header"/>

<body id="body">
<div id="spinner" class="spinner" style="display:none;">
    <img src="${resource(dir: 'images', file: 'spinner.gif')}" alt="Spinner"/>
</div>
<div>
<div id="browserAlert" style="display: none;">Warning! You are using an unsupported browser. Some features may not work correctly. The supported browsers are Chrome, Firefox 3.0 and higher, and Safari 3.1.2 and higher, IE8 and higher. <a href="#" id="oldBrowserAgreement">Got it! Please turn off this warning message.</a></div>
<div class="topBar">
    <div class="titlebar">
        <div class="header">
            <a href="${resource(dir: '/')}">
                <div id="titleLogo"><div id="aurora-text">aurora</div><div id="poweredby">powered by<span class="open">open</span><span class="stack">stack</span><span class="tm">&trade;</span></div></div>
            </a>
        </div>
        <g:if test="${!pageProperty(name: 'meta.hideNav')}">

        <g:set var='targetUri' value="${request.requestURL + (request.queryString ? '?' + request.queryString : '')}"/>
        <shiro:isLoggedIn>
            <div id="authentication" class="authentication">
                <span>Logged in as</span> <shiro:principal/>
                <ul>
                    <li><g:link elementId="signOut" controller="auth" action="signOut"
                                params="${[targetUri: targetUri]}">Logout</g:link></li>
                </ul>
            </div>

            <div class="tenants">
                <g:form controller="userState" action="changeDataCenter" method="POST"
                        params="${[targetUri: targetUri]}">
                    <span>Datacenter:</span> <g:chooseDatacenter title="Switch to a different datacenter" name="dataCenterName" optionKey="key" optionValue="key" />
                </g:form>
            </div>

            <div class="tenants">
                <g:form controller="userState" action="changeTenant" method="POST" params="${[targetUri: targetUri]}">
                    <span>Tenant:</span> <g:chooseTenant title="Switch to a different tenant" id="tenantId" name="tenantId" optionKey="id" optionValue="name" onchange="submit()"/>
                </g:form>
            </div>
            <div class="tenants classofservice">
                <span>Class of Service:&nbsp;</span><span><input type="text" class="text ui-corner-all env-<g:environmentCode/>" value="<g:environmentName/>" readonly="readonly" disabled="disabled"/></span>
            </div>
        </shiro:isLoggedIn>
        <shiro:isNotLoggedIn>
            <g:link controller="auth" action="login" class="login" params="${[targetUri: '/']}">Login</g:link>
        </shiro:isNotLoggedIn>
        <div class="search" title="Find entities by name">
            <form action="/search" method="GET" class="allowEnterKeySubmit">
                %{--<input type="search" results="10" autosave="aurora${env}globalsearch" name="q" placeholder="Global search by names" value="${params.q}">--}%
            </form>
        </div>
    </g:if>
    </div>
</div>
<shiro:isLoggedIn>
<div id="navigationBar">
    <g:if test="${!pageProperty(name: 'meta.hideNav')}">
        <ul id="topNav" class="appnav">
            <li class="menuButton"><g:link class="instances" elementId="nav-instance-list-root" controller="instance" action="list">Compute</g:link>
                <ul>
                    <li class="menuButton"><g:link class="instances" elementId="nav-instance-list" controller="instance"
                                                   action="list">Instances</g:link></li>
                    <li class="menuButton"><g:link class="images" elementId="nav-image-list" controller="image" action="list">Images</g:link></li>
                    <li class="menuButton"><g:link class="instanceTypes" elementId="nav-flavor-list" controller="flavor"
                                                   action="list">Flavors</g:link></li>
                </ul>
            </li>
            <g:ifServiceEnabled name="${OpenStackRESTService.NOVA_VOLUME}">
            <li class="menuButton"><g:link class="volumes" elementId="nav-volume-list-root" controller="volume" action="list">Storage</g:link>
                <ul>
                    <li class="menuButton"><g:link class="volumes" elementId="nav-volume-list" controller="volume" action="list">Volumes</g:link></li>
                    <li class="menuButton"><g:link class="volumeSnapshot" elementId="nav-snapshot-list" controller="snapshot"
                                                   action="list">Snapshots</g:link></li>
                </ul>
            </li>
            </g:ifServiceEnabled>
            <g:ifServiceEnabled name="${OpenStackRESTService.LBMS}">
                <li class="menuButton">
                    <g:link class="networks"  elementId="nav-lbaas-listPools-root" controller="lbaas" action="listPools">LBaaS</g:link>
                    <ul>
                        <li class="menuButton"><g:link class="lbaas" elementId="nav-lbaas-listPools" controller="lbaas" action="listPools">Pools & Services</g:link></li>
                        <li class="menuButton"><g:link class="vips" elementId="nav-lbaas-listVips"  controller="lbaas" action="listVips">Vips</g:link></li>
                        <li class="menuButton"><g:link class="policies" elementId="nav-lbaas-listPolicies"  controller="lbaas" action="listPolicies">Policies</g:link></li>
                        <li class="menuButton"><g:link class="jobs" elementId="nav-lbaas-listJobs" controller="lbaas" action="listJobs">Jobs</g:link></li>
                    </ul>
                </li>
            </g:ifServiceEnabled>

            <li class="menuButton"><g:link class="quantum"  elementId="nav-network-index-root" controller="network" action="index">Networking</g:link>
                <ul>
                    <li class="menuButton"><g:link class="networks"  elementId="nav-network-floatingIpList" controller="network" action="floatingIpList">Floating IPs</g:link></li>
                    <g:ifServiceEnabled name="${OpenStackRESTService.QUANTUM}">
                        <li class="menuButton"><g:link class="quantum"  elementId="nav-networks-list" controller="network" action="list">Networking</g:link></li>
                        <li class="menuButton"><g:link class="routers" elementId="nav-routers-list" controller="router" action="list">Routers</g:link></li>
                    </g:ifServiceEnabled>
                </ul>
            </li>

            <g:ifServiceEnabled name="${OpenStackRESTService.HEAT}">
                <li class="menuButton"><g:link class="heatService" elementId="nav-heat-list-root" controller="heat" action="list">Cloud Formation</g:link></li>
            </g:ifServiceEnabled>

            <li class="menuButton"><g:link class="securityGroups" elementId="nav-securityGroup-list-root" controller="securityGroup" action="list">Security</g:link>
                <ul>
                    <li class="menuButton"><g:link class="securityGroups" elementId="nav-securityGroup-list" controller="securityGroup"
                                                   action="list">Security Groups</g:link></li>
                    <li class="menuButton"><g:link class="keyPairs" elementId="nav-keypair-list" controller="keypair"
                                                   action="list">Keypairs</g:link></li>
                </ul>
            </li>
            <li class="menuButton"><g:link class="quotas" elementId="nav-quota-list-root" controller="quota" action="list">Settings</g:link>
                <ul>
                    <li class="menuButton"><g:link class="quotas" elementId="nav-quotaUsage-list" controller="quotaUsage" action="list">Quota Usage</g:link></li>
                    <li class="menuButton"><g:link class="quotas" elementId="nav-quota-list" controller="quota" action="list">Quotas</g:link></li>
                    <li class="menuButton"><g:link class="openStackService" elementId="nav-openStackService-list" controller="openStackService"
                                                   action="list">Services</g:link></li>
                    <shiro:hasRole name="${Constant.ROLE_ADMIN}">
                        <li class="menuButton"><g:link class="tenants" elementId="nav-tenant-list" controller="tenant"
                                                       action="list">Tenants</g:link></li>
                        <li class="menuButton"><g:link class="openStackUser" elementId="nav-openStackUser-list" controller="openStackUser"
                                                       action="list">Users</g:link></li>
                    </shiro:hasRole>
                    <li class="menuButton"><g:link class="about" elementId="nav-about" controller="info"
                                               action="index">About</g:link></li>
<!--                    <li class="menuButton"><g:link class="about" elementId="nav-environment" controller="info"
                                               action="environment">Environment Info</g:link></li>-->
                </ul>
            </li>
            <g:ifServiceEnabled name="${OpenStackRESTService.METERING}">
                <li class="menuButton"><g:link class="meteringService" elementId="nav-metering-root" controller="metering" action="usages">Usages</g:link></li>
            </g:ifServiceEnabled>
        </ul>
    </g:if>
    </div>
</shiro:isLoggedIn>
<div id="mainBar">
    <div id="main">
        
        <g:if test="${(pageProperty(name: 'meta.menu-level-2'))}">
          <div class="body"><h1>${pageProperty(name: 'meta.menu-level-2')}</h1></div>
        </g:if>
        <g:layoutBody/>
    </div>
</div>

<div id="footer hide">
    <div id="footer_row">
        <span>©2013 Aurora (Apache 2.0 Licensed).</span>
    </div>
</div>
<div id="confirmationDialog" title="Confirmation Dialog">  </div>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.browser.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<script defer type="text/javascript" src="${resource(dir: 'js', file: 'custom.js')}?v=${build}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'combobox-widjet.js')}"></script>
<g:javascript src="back-btn.js"/>
<script type="text/javascript">
    drawBackButton("${parent}");
</script>
<!-- Script to remove the readonly attribute of the tenant drop down -->
 <script>
     jQuery(function() {
         jQuery('#select_tenantId').removeAttr('readonly');
    });
 </script>
<g:render template="/layouts/occasion"/>
</body>
</html>
