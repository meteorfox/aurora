
<header role="banner" class="navbar navbar-inverse">
  <div class="container-full">
    <div class="navbar-header">
      <button data-target=".bs-navbar-collapse" data-toggle="collapse" type="button" class="navbar-toggle">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="/">
      <div id="titleLogo"><div id="aurora-text">aurora</div><div id="poweredby">powered by<span class="open">open</span><span class="stack">stack</span><span class="tm">&trade;</span></div></div>
      </a>
    </div>
    <nav role="navigation" class="">
      <shiro:isLoggedIn>
      <ul class="nav navbar-nav pull-left">
      <li <g:if test="${(pageProperty(name: 'meta.menu-level-1')) == 'myprojects'}">class="active"</g:if>>
      <g:link controller="dashboard" action="index">My Projects</g:link></li>
      </ul>
  </shiro:isLoggedIn>
      <ul class="nav navbar-nav pull-right">
        <shiro:isLoggedIn>
          <li class="dropdown"> 
            <a data-toggle="dropdown" class="dropdown-toggle" href="#"><shiro:principal/> <b class="caret"></b></a> 
            <ul class="dropdown-menu"> 
              <li><g:link elementId="signOut" controller="auth" action="signOut">Sign Out</g:link></li>
            </ul>
          </li>
        </shiro:isLoggedIn>
        <shiro:isNotLoggedIn>
          <li>
          <g:link controller="auth" action="login" class="login">Sign In</g:link>
          </li>
        </shiro:isNotLoggedIn>
      </ul>
    </nav>
  </div>
</header>