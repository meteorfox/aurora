import com.paypal.aurora.format.CustomJsonDomainMarshaller
import com.paypal.aurora.format.CustomXmlDomainMarshaller
import grails.converters.JSON
import grails.converters.XML

class BootStrap {

    def restApiHandlerService
    def eventSubscribeService
    def configService
    def eventListenerService

    def init = { servletContext ->

        configService.reloadConfig()

        eventListenerService.initialize()

        restApiHandlerService.initialize()

        eventSubscribeService.initialize()

        JSON.registerObjectMarshaller(new CustomJsonDomainMarshaller())

        XML.registerObjectMarshaller(new CustomXmlDomainMarshaller())
    }

}
