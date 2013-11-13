<%@ page import="com.paypal.aurora.OpenStackRESTService; grails.converters.JSON; com.paypal.aurora.Constant" %>
<div class="sidebar-background">
  <div class="primary-sidebar-background cos-<g:environmentCode/>"></div>
</div>
<div class="primary-sidebar">
<g:set var="menu1">${(pageProperty(name: 'meta.menu-level-1'))}</g:set>
<g:set var="menu2">${(pageProperty(name: 'meta.menu-level-2'))}</g:set>
  <!-- Main nav -->
  <ul class="nav navbar-collapse collapse navbar-collapse-primary">
        <li id="nav-compute" class="dark-nav">
          <span class="glow"></span>
          <a href="#compute-menu" data-toggle="collapse" class="accordion-toggle collapsed ">
              <i class="icon-th-list icon-2x"></i><span>Compute<i class="icon-caret-down"></i></span>
          </a>
          <ul class="collapse" id="compute-menu">
            <li id="nav-compute-instances"><g:link controller="instance" action="list"><i class="icon-th"></i> Instances</g:link></li>
            <li id="nav-compute-images"><g:link controller="image" action="list"><i class="icon-camera"></i> Images</g:link></li>
            <li id="nav-compute-flavors"><g:link controller="flavor" action="list"><i class="icon-tags"></i> Flavors</g:link></li>
          </ul>
        </li>
        <g:ifServiceEnabled name="${OpenStackRESTService.NOVA_VOLUME}">        
        <li class="dark-nav" id="nav-storage">
          <span class="glow"></span>
          <a href="#storage-menu" data-toggle="collapse" class="accordion-toggle collapsed ">
              <i class="icon-hdd icon-2x"></i><span>Storage<i class="icon-caret-down"></i></span>
          </a>
          <ul class="collapse" id="storage-menu">
              <li id="nav-storage-volumes"><g:link controller="volume" action="list"><i class="icon-hdd"></i>Volumes</g:link></li>
              <li id="nav-storage-snapshots"><g:link controller="snapshot" action="list"><i class="icon-camera-retro"></i> Snapshots</g:link></li>
          </ul>
        </li>        
        </g:ifServiceEnabled>
        <g:ifServiceEnabled name="${OpenStackRESTService.LBMS}">
        <li class="dark-nav" id="nav-lbaas">
          <span class="glow"></span>
          <a href="#lbms-menu" data-toggle="collapse" class="accordion-toggle collapsed ">
              <i class="icon-code-fork icon-2x"></i><span>Load Balancer<i class="icon-caret-down"></i></span>
          </a>
          <ul class="collapse" id="lbms-menu">
              <li id="nav-lbaas-pools"><g:link controller="lbaas" action="listPools"><i class="icon-sitemap"></i> Pools & Services</g:link></li>
              <li id="nav-lbaas-vips"><g:link controller="lbaas" action="listVips"><i class="icon-flag-alt"></i> VIPs</g:link></li>
              <li id="nav-lbaas-policies"><g:link controller="lbaas" action="listPolicies"><i class="icon-eye-open"></i> Policies</g:link></li>
              <li id="nav-lbaas-jobs"><g:link controller="lbaas" action="listJobs"><i class="icon-briefcase"></i> Jobs</g:link></li>
          </ul>
        </li>
        </g:ifServiceEnabled>
        <g:ifServiceEnabled name="${OpenStackRESTService.QUANTUM}">
        <li class="dark-nav" id="nav-networking">
          <span class="glow"></span>
          <a href="#networking-menu" data-toggle="collapse" class="accordion-toggle collapsed ">
              <i class="icon-globe icon-2x"></i><span>Networking<i class="icon-caret-down"></i></span>
          </a>
          <ul class="collapse" id="networking-menu">
              <li id="nav-networking-floatingips"><g:link controller="network" action="floatingIpList"><i class="icon-bolt"></i> Floating IPs</g:link></li>
              <li id="nav-networking-networks"><g:link controller="network" action="list"><i class="icon-sitemap"></i> Networks</g:link></li>
              <li id="nav-networking-routers"><g:link controller="router" action="list"><i class="icon-code-fork"></i> Routers</g:link></li>
          </ul>
        </li>
        </g:ifServiceEnabled>
        <g:ifServiceEnabled name="${OpenStackRESTService.HEAT}">
        <li class="dark-nav"id="nav-heat">
          <span class="glow"></span>
          <g:link controller="heat" action="list"><i class="icon-edit icon-2x"></i> <span>Cloud Formation</span></g:link>
        </li>
        </g:ifServiceEnabled>    
        <li class="dark-nav"id="nav-security">
          <span class="glow"></span>
          <a href="#security-menu" data-toggle="collapse" class="accordion-toggle collapsed ">
              <i class="icon-lock icon-2x"></i><span>Security<i class="icon-caret-down"></i></span>
          </a>
          <ul class="collapse" id="security-menu">
              <li id="nav-security-securitygroups"><g:link controller="securityGroup" action="list"><i class="icon-group"></i> Security Groups</g:link></li>
              <li id="nav-security-keypairs"><g:link controller="keypair" action="list"><i class="icon-key"></i> Keypairs</g:link></li>
          </ul>
        </li>
        <li class="dark-nav" id="nav-settings">
          <span class="glow"></span>
          <a href="#settings-menu" data-toggle="collapse" class="accordion-toggle collapsed ">
              <i class="icon-magic icon-2x"></i><span>Settings<i class="icon-caret-down"></i></span>
          </a>
          <ul class="collapse" id="settings-menu">
              <li id="nav-settings-quotausages"><g:link controller="quotaUsage" action="list"><i class="icon-tasks"></i> Quota Usages</g:link></li>
              <li id="nav-settings-quotas"><g:link controller="quota" action="list"><i class="icon-tasks"></i> Quotas</g:link></li>
              <li id="nav-settings-services"><g:link controller="openStackService" action="list"><i class="icon-cog"></i> Services</g:link></li>
              <shiro:hasRole name="${Constant.ROLE_ADMIN}">
              <li id="nav-settings-projects"><g:link controller="tenant" action="list"><i class="icon-building"></i> Projects</g:link></li>
              <li id="nav-settings-users"><g:link controller="openStackUser" action="list"><i class="icon-group"></i> Users</g:link></li>
              </shiro:hasRole>
              <li id="nav-settings-about"><g:link controller="info" action="index"><i class="icon-info-sign"></i> About</g:link></li>
          </ul>
        </li>
        <g:ifServiceEnabled name="${OpenStackRESTService.METERING}">
        <li class="dark-nav" id="nav-usages">
          <span class="glow"></span>
          <g:link controller="metering" action="usages"><i class="icon-bar-chart icon-2x"></i> <span>Usages</span></g:link>
        </li>          
        </g:ifServiceEnabled>   
  </ul>
</div>
<script>
  function showCurrentNavInSidebar() {
   var menu1 = 'nav-${menu1}'.toLowerCase();
   var level1LiItem = $('li#'+menu1);

   if(level1LiItem) {
      level1LiItem.addClass('active');
      
      if(level1LiItem.find('a.accordion-toggle').length>0 && level1LiItem.find('ul.collapse').length>0) {
        level1LiItem.find('a.accordion-toggle').removeClass('collapsed');
        level1LiItem.find('ul.collapse').addClass('in');
        var menu2 = 'nav-${menu1}-${menu2}'.toLowerCase();
        var level2LiItem = level1LiItem.find('li#'+menu2)[0];
           
        if(level2LiItem) {
          $(level2LiItem).addClass('active');
        }
      }                   
    }
  }
showCurrentNavInSidebar();
</script>