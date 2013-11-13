package com.paypal.aurora

import com.paypal.aurora.auth.UserLoginToken
import grails.converters.JSON
import grails.converters.XML
import org.apache.shiro.SecurityUtils
import org.apache.shiro.grails.ConfigUtils

import javax.servlet.http.Cookie
import javax.servlet.http.HttpServletResponse

class AuthController {

    static final String ENVIRONMENT = "environment"
    
    def static allowedMethods = [signIn: 'POST', signOut: 'GET']

    def authService
    def sessionStorageService
    def configService
    
    def index = {
        redirect(action: "login", params: params)
    }

    def login = {
        if (SecurityUtils.subject?.isAuthenticated()) {
            redirect(uri: getServletContext().getContextPath())
            return true
        }
        if(configService.getSignInUrl()?.trim()) {
            redirect(url: configService.getSignInUrl())

        } else {
            params.vpc = g.cookie(name: ENVIRONMENT)
            return [username: params.username]
        }

    }

    def signIn = { ConnectionCommand cmd ->
        //log off prev prev signin.
        def principalPrevLogin = SecurityUtils.subject?.principal
        SecurityUtils.subject?.logout()
        ConfigUtils.removePrincipal(principalPrevLogin)
        
        sessionStorageService.logoutUrl = ''
        def baseLoginUrl = cmd.loginUrl
        
        if (cmd.hasErrors()) {
            def target = cmd.errors
            def loginUrl = baseLoginUrl+'?errorMsg='+cmd.getErrorMessage()
            log.info(new JSON(target))
            
            withFormat {
                html {redirect(url:loginUrl)}
                xml { new XML(target).render(response) }
                json { new JSON(target).render(response) }
            }
            return false
        }

        //need for netflix asgard
        def redirectUrl = authService.getEnvironmentRedirectUrl(params.vpc)
        if (redirectUrl) {
            def target = ['redirectUrl': redirectUrl]
            withFormat {
                xml { new XML(target).render(response) }
                json { new JSON(target).render(response) }
            }
            return true
        }

        def userLoginToken = new UserLoginToken((String) params.username, (String) params.password, (String) params.vpc)

        SecurityUtils.subject.login(userLoginToken)
        
        if (authService.isAuthFailed()) {
            response.status = HttpServletResponse.SC_UNAUTHORIZED
        } else {
            response.addCookie(new Cookie(ENVIRONMENT, params.vpc))
            response.status = HttpServletResponse.SC_OK
        }

        def target = [errors: authService.getDataCenterErrors()]
        def loginUrl = baseLoginUrl+'?errorMsg='+'Invalid+username+or+password.'
        if (authService.isAuthFailed()) {
            withFormat {
                html {redirect(url:loginUrl)}
                xml { new XML(target).render(response) }
                json { new JSON(target).render(response) }
            }
            //clean signout.. remove principal if login has failed.
            def principal = SecurityUtils.subject?.principal
            SecurityUtils.subject?.logout()
            ConfigUtils.removePrincipal(principal)
            sessionStorageService.logoutUrl=''
        } else {
            sessionStorageService.logoutUrl=baseLoginUrl
            withFormat {
                html {redirect(uri: '/')}
                xml { new XML(target).render(response) }
                json { new JSON(target).render(response) }
            } 
        }
        
    }
    
    def signOut = {
        def logoutUrl = sessionStorageService.logoutUrl
        
        def principal = SecurityUtils.subject?.principal
        SecurityUtils.subject?.logout()
        
        // For now, redirect back to the home page.
        if (ConfigUtils.getCasEnable() && ConfigUtils.isFromCas(principal)) {
            redirect(uri: ConfigUtils.getLogoutUrl())
        } else {
            redirect(url: logoutUrl)
        }
        sessionStorageService.logoutUrl=''
        ConfigUtils.removePrincipal(principal)
    }

    def unauthorized = {
        if (!SecurityUtils.subject?.isAuthenticated()) {
            redirect(uri: getServletContext().getContextPath())
            return true
        }
        render (status: HttpServletResponse.SC_UNAUTHORIZED, text: "You do not have permission to access this page. <a href='${resource(dir: '/')}'>Return to main page</a>")
    }

}

class ConnectionCommand {
    String username
    String password
    String vpc
    String loginUrl
    static constraints = {
        username(nullable: false, blank: false)
        password(nullable: false, blank: false)
        vpc(nullable: false, blank: false)
    }
    def String getErrorMessage() {
       return 'Username,+password+and+vpc+are+required.'

    }
}
