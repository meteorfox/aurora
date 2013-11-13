package com.paypal.aurora

import grails.converters.JSON
import grails.converters.XML

class InfoController {

    final static allowedMethods = [index: ['GET']]

    def infoService
    def configService
    def sessionStorageService

    def index = {
        def info = infoService.getInfo()
        def model = [info: info]
        withFormat {
            html { model }
            xml { new XML(model).render(response) }
            json { new JSON(model).render(response) }
        }

    }

    def environment = {
        String environmentName = sessionStorageService.getEnvironmentName()
        def environment = configService.getEnvironmentByName(environmentName)
        withFormat {
            html { [environment: new JSON(environment)] }
            xml { new XML(environment).render(response) }
            json { new JSON(environment).render(response) }
        }
    }
}
