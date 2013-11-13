package com.paypal.aurora

import com.paypal.aurora.exception.RestClientRequestException
import grails.converters.JSON
import grails.converters.XML

import javax.servlet.http.HttpServletResponse

class DashboardController {
    def sessionStorageService
    
    def index = { redirect(action: 'projects', params: params) }
    def projects = {

        def tenants = sessionStorageService.tenants.sort{ it.name }
        withFormat {
            html { [tenants : tenants] }
            xml { new XML(tenants).render(response) }
            json { new JSON(tenants).render(response) }
        }
      
    }
}
