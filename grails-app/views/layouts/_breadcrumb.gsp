<g:if test="${menu == 'dashboard'}">
  <a href=""><i class="icon-dashboard"></i> Dashboard</a>
</g:if>
<g:if test="${menu == 'myprojects'}">
<i class="icon-building"></i> My Projects
</g:if>
<g:if test="${menu == 'compute'}">
<i class="icon-th-list"></i> Compute
</g:if>
<g:if test="${menu == 'instances'}">
<g:link controller="instance" action="list"><i class="icon-th"></i> Instances</g:link>
</g:if>
<g:if test="${menu == 'images'}">
<g:link controller="image" action="list"><i class="icon-camera"></i> Images</g:link>
</g:if>
<g:if test="${menu == 'flavors'}">
<g:link controller="flavor" action="list"><i class="icon-tags"></i> Flavors</g:link>
</g:if>
<g:if test="${menu == 'storage'}">
<i class="icon-hdd"></i> Storage
</g:if>
<g:if test="${menu == 'volumes'}">
<g:link controller="volume" action="list"><i class="icon-hdd"></i> Volumes</g:link>
</g:if>
<g:if test="${menu == 'snapshots'}">
<g:link controller="snapshot" action="list"><i class="icon-camera-retro"></i> Snapshots</g:link>
</g:if>
<g:if test="${menu == 'lbaas'}">
<i class="icon-code-fork"></i> Load Balancer
</g:if>
<g:if test="${menu == 'pools'}">
<g:link controller="lbaas" action="listPools"><i class="icon-sitemap"></i> Pools & Services</g:link>
</g:if>
<g:if test="${menu == 'vips'}">
<g:link controller="lbaas" action="listVips"><i class="icon-flag-alt"></i> VIPs</g:link>
</g:if>
<g:if test="${menu == 'policies'}">
<g:link controller="lbaas" action="listPolicies"><i class="icon-eye-open"></i> Policies</g:link>
</g:if>
<g:if test="${menu == 'jobs'}">
<g:link controller="lbaas" action="listJobs"><i class="icon-briefcase"></i> Jobs</g:link>
</g:if>
<g:if test="${menu == 'networking'}">
<i class="icon-globe"></i> Networking
</g:if>
<g:if test="${menu == 'floatingips'}">
<g:link controller="network" action="floatingIpList"><i class="icon-bolt"></i> Floating IPs</g:link>
</g:if>
<g:if test="${menu == 'networks'}">
<g:link controller="network" action="list"><i class="icon-globe"></i> Networks</g:link>
</g:if>
<g:if test="${menu == 'routers'}">
<g:link controller="router" action="list"><i class="icon-code-fork"></i> Routers</g:link>
</g:if>
<g:if test="${menu == 'heat'}">
<i class="icon-edit"></i> Cloud Formation
</g:if>
<g:if test="${menu == 'security'}">
<i class="icon-lock"></i> Security
</g:if>
<g:if test="${menu == 'securitygroups'}">
<g:link controller="securityGroup" action="list"><i class="icon-group"></i> Security Groups</g:link>
</g:if>
<g:if test="${menu == 'keypairs'}">
<g:link controller="keypair" action="list"><i class="icon-key"></i> Keypairs</g:link>
</g:if>
<g:if test="${menu == 'settings'}">
<i class="icon-magic"></i> Settings
</g:if>
<g:if test="${menu == 'quotausages'}">
<g:link controller="quotaUsage" action="list"><i class="icon-tasks"></i> Quota Usages</g:link>
</g:if>
<g:if test="${menu == 'quotas'}">
<g:link controller="quota" action="list"><i class="icon-tasks"></i> Quotas</g:link>
</g:if>
<g:if test="${menu == 'services'}">
<g:link controller="openStackService" action="list"><i class="icon-cog"></i> Services</g:link>
</g:if>
<g:if test="${menu == 'projects'}">
<g:link controller="tenant" action="list"><i class="icon-building"></i> Projects</g:link>
</g:if>
<g:if test="${menu == 'users'}">
<g:link controller="openStackUser" action="list"><i class="icon-group"></i> Users</g:link>
</g:if>
<g:if test="${menu == 'about'}">
<g:link controller="info" action="index"><i class="icon-info-sign"></i> About</g:link>
</g:if>