package com.paypal.aurora

class ConfigTagLib {

    def configService
    def sessionStorageService

    def chooseEnvironment = { attrs ->
        attrs.put('from', configService.environments)
        out << g.select(attrs)
    }

    def chooseDatacenter = { attrs ->
        attrs.put('from', sessionStorageService.dataCentersMap)
        attrs.put('value',  sessionStorageService.dataCenterName)
        out << g.select(attrs)
    }
    def dataCenterName = {
        String name = sessionStorageService.dataCenterName
        out << name +''
    }
    def dataCenterDisplayName = {
        String name = sessionStorageService.dataCenterName.toUpperCase()
        
        out << name +''
    }
    def chooseTenant = { attrs ->
        attrs.put('from',  sessionStorageService.tenants.sort{ it.name })
        attrs.put('value',  sessionStorageService.tenant.id)
        out << g.select(attrs)
    }

    def environmentName = {
        String envName = sessionStorageService.environmentName
        out << envName +''
    }
    def environmentCode = {
        out << sessionStorageService.environmentName        
    }
    def environmentDisplayName = {
        out << sessionStorageService.environmentName        
    }    
}
