package com.paypal.aurora

import grails.converters.JSON
import grails.converters.XML

class MeteringController {

    def meteringService

    def index() {
        redirect(redirect(action: 'usages', params: params))
    }

    def usages() {
        
    }
    
    def getUsages() {
        String instanceId = params.instanceId
        int interval = Integer.valueOf(params.interval?:3600)
        int count = Integer.valueOf(params.count?:20)
        String type = params.type?:'instance:m1.tiny'
        def percents = meteringService.getUsages(type, interval, count, Boolean.valueOf(params.showCurrentTenant?:'true'))
        withFormat {
            xml { new XML(percents).render(response) }
            json { new JSON(percents).render(response) }
        }
    }

    def getMeters() {
        def meters = meteringService.meters
        withFormat {
            xml { new XML([meters:meters]).render(response) }
            json { new JSON([meters:meters]).render(response) }
        }
    }

    def getSamples() {
        def samples = meteringService.getSamples(params.type, Integer.valueOf(params.period), Boolean.valueOf(params.showCurrentTenant?:'true'))
        withFormat {
            xml { new XML(samples).render(response) }
            json { new JSON(samples).render(response) }
        }
    }

    def getProcessedSamples() {
        def samples = meteringService.getProcessedSamples(params.type, Integer.valueOf(params.period), Boolean.valueOf(params.showCurrentTenant?:'true'))
        withFormat {
            xml { new XML(samples).render(response) }
            json { new JSON(samples).render(response) }
        }
    }
}
