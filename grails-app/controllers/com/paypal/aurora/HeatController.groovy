package com.paypal.aurora

import com.paypal.aurora.exception.RestClientRequestException
import com.paypal.aurora.model.HeatTemplate
import com.paypal.aurora.model.Stack
import grails.converters.JSON
import grails.converters.XML

import javax.servlet.http.HttpServletResponse

class HeatController {

    def static allowedMethods = [list: ['GET', 'POST'], show: ['GET', 'POST'], create: ['GET', 'POST'], delete: ['GET', 'POST'], createStack: ['POST']]

    def heatService

    def index = { redirect(action: 'list', params: params) }

    def list = {
        List<Stack> stacks = []
        try {
            stacks = heatService.listAll()
            def model = [stacks: stacks]
            withFormat {
                html { model }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        } catch (RestClientRequestException e) {
            def error = ExceptionUtils.getExceptionMessage(e)
            def model = [stacks: stacks, errors: error, flash: [message: error]]
            response.status = ExceptionUtils.getExceptionCode(e)
            withFormat {
                html { model }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        }
    }

    def delete = {
        List<String> stackIds = Requests.ensureList(params.selectedStacks ?: params.stackId)
        def model = heatService.deleteStacks(stackIds)
        def flashMessage = ResponseUtils.defineMessageByList("Could not delete stacks: ", model.notRemovedItems)
        response.status = ResponseUtils.defineResponseStatus(model, flashMessage)
        withFormat {
            html {
                flash.message = model.errors;
                redirect(action: 'list', model: model)
            }
            xml { new XML(model).render(response) }
            json { new JSON(model).render(response) }
        }
    }


    def show = {
        try {
            Stack stack = heatService.getById(params.id)
            Map model = [parent: "/heat", stack: stack]
            withFormat {
                html { model }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        } catch (RestClientRequestException e) {
            response.status = ExceptionUtils.getExceptionCode(e)
            def error = ExceptionUtils.getExceptionMessage(e)
            def model = [errors: error]
            withFormat {
                html { flash.message = error; redirect(action: 'list') }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        }
    }

    def createStack = {
        try {
            heatService.createStack((String) params.template,
                    (String) params.stack_name,
                    (Map<String, String>) params.params)
            withFormat {
                xml { new XML([status: 'OK']).render(response) }
                json { new JSON([status: 'OK']).render(response) }
            }
        } catch (RestClientRequestException e) {
            response.status = ExceptionUtils.getExceptionCode(e)
            def error = ExceptionUtils.getExceptionMessage(e)
            withFormat {
                xml { new XML([errors: error]).render(response) }
                json { new JSON([errors: error]).render(response) }
            }
        }
    }
    def templateForm = {
        
    }
    def createFlow = {
        parameters {
            action {
                def fileTemplate = request.getFile('template')
                String template = "{}"
                if (!fileTemplate.empty) {
                    template = fileTemplate.inputStream.text
                }
                HeatTemplate heatTemplate = new HeatTemplate(template)
                heatTemplate.parameters = heatService.parseParams(template)
                [template: heatTemplate]
            }
            on("success").to "launch"
        }
        launch {
            on("submit") {
                try {
                    Map<String, String> stackParams = params;
                    String name = stackParams.get('stack_name')
                    ['_eventId_submit', 'execution', 'stack_name'].each { stackParams.remove(it) }
                    def template = flow.get("template").template
                    heatService.createStack(template, name, stackParams)
                } catch (RestClientRequestException e) {
                    response.status = ExceptionUtils.getExceptionCode(e)
                    def errors = ExceptionUtils.getExceptionMessage(e)
                    flash.message = errors
                    return error()
                }

            }.to "end"
            on("error").to "launch"
        }
        end {
            redirect(action: "list")
        }
    }
}
