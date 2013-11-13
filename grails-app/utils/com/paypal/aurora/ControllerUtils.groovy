package com.paypal.aurora

import org.apache.shiro.SecurityUtils

class ControllerUtils {

    static void toggleTenants(def sessionStorageService) {
        if (SecurityUtils.subject.hasRole(Constant.ROLE_ADMIN)) {
            sessionStorageService.allTenants = !sessionStorageService.allTenants
        }
    }

}
