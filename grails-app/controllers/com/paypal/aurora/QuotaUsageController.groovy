package com.paypal.aurora

import com.paypal.aurora.exception.RestClientRequestException
import com.paypal.aurora.model.QuotaUsage
import grails.converters.JSON
import grails.converters.XML

import javax.servlet.http.HttpServletResponse

class QuotaUsageController {

    def quotaService
    def sessionStorageService

    def index() { redirect(action: 'list', params: params)}

    def list = {
        try {
            List<QuotaUsage> quotaUsages = quotaService.getQuotaUsage(sessionStorageService.tenant.id)
            def model = [quotaUsages : quotaUsages]
            withFormat {
                html { [quotaUsages: quotaUsages] }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        } catch (RestClientRequestException e) {
            response.status = ExceptionUtils.getExceptionCode(e)
            def exceptionMessage = ExceptionUtils.getExceptionMessage(e)
            def model = [errors: exceptionMessage]
            withFormat {
                html { [quotaUsages: [], flash: [message: exceptionMessage]] }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        }
    }
}
