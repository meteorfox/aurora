package com.paypal.aurora

import com.paypal.aurora.model.DataCenter
import com.paypal.aurora.model.Environment

class AuthService {

    def configService
    def sessionStorageService

    String getEnvironmentRedirectUrl(String name) {
        Environment environment = configService.getEnvironmentByName(name)
        environment?.redirect_url
    }

    Map<String, String> getDataCenterErrors() {
        Map<String, String> dataCenterErrors = [:]
        def dataCenters = sessionStorageService.getDataCentersMap().values()
        for (DataCenter dataCenter in dataCenters) {
            if (!dataCenter.tokenId) {
                dataCenterErrors.put(dataCenter.name, dataCenter.error)
            }
        }
        return dataCenterErrors
    }

    boolean isAuthFailed() {
        def dataCenterMap = sessionStorageService.getDataCentersMap()
        return !dataCenterMap || !dataCenterMap.values().find { it.tokenId != null }
    }

}
