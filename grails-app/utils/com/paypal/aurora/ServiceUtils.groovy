package com.paypal.aurora

import com.paypal.aurora.exception.RestClientRequestException
import com.paypal.aurora.model.Tenant
import org.apache.commons.lang.StringUtils
import org.apache.shiro.SecurityUtils

class ServiceUtils {

    static def removeItems(def service, String action = 'delete', List<String> itemsId, List auxiliaryArgs = []) {
        List<String> notRemovedItems = []
        List<String> removedItems = []
        Map<String, String> errors = [:]
        for (id in itemsId) {
            try {
                service."${action}"(* ([id] + auxiliaryArgs))
                removedItems << id
            } catch (RestClientRequestException e) {
                notRemovedItems << id
                errors[id] = ExceptionUtils.getExceptionMessage(e)
            }
        }
        return [removedItems: removedItems, notRemovedItems: notRemovedItems, errors: errors]
    }

    static def clearMap(Map items) {
        items.findAll {
            StringUtils.isNotBlank((String) it.value) && it.value
        }
    }

    static void fillTenantName(def entity, List<Tenant> tenants) {
        Tenant tenant = tenants.find { it.id == entity.tenantId }
        entity.tenantName = tenant ? tenant.name : '-'
    }

}
