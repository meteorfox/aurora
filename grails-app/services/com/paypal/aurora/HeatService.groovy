package com.paypal.aurora

import com.paypal.aurora.model.Stack
import grails.converters.JSON

class HeatService {
    def openStackRESTService
    def sessionStorageService

    List<Stack> listAll() {
        def resp = openStackRESTService.get(openStackRESTService.HEAT, 'stacks')
        List<Stack> result = [] as LinkedList
        for (stack in resp.stacks) {
            result.push(new Stack(stack))
        }
        return result
    }

    List<Object> parseParams(String templateText) {
        def json = JSON.parse(templateText)
        List<Object> result = []
        if (json.Parameters) {
            json.Parameters.entrySet().each{
                def allowedValues = it.value.AllowedValues
                if (allowedValues != null) {
                    allowedValues = allowedValues.toList()
                }
                result << [name: it.key, default: it.value.Default, allowedValues: allowedValues]
            }
        }
        return result
    }

    def createStack(String template, String name, Map<String, String> params) {
        openStackRESTService.post(openStackRESTService.HEAT, 'stacks', [
                stack_name: name,
                template: template,
                timeout_mins: 60,
                parameters: params
        ])
    }

    Stack getById(String id) {
        def resp = openStackRESTService.get(openStackRESTService.HEAT, "stacks/$id")
        Stack stack = new Stack(resp['stack']);
        return stack
    }

    def delete(String id) {
        Stack stack = getById(id)
        String name = stack.name
        openStackRESTService.delete(openStackRESTService.HEAT, "stacks/$name/$id");
    }

    def deleteStacks(List <String> stackIds){
        def model = ServiceUtils.removeItems(this, "delete", stackIds)
        return model
    }

}

