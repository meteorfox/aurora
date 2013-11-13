package com.paypal.aurora.model

import org.apache.commons.logging.LogFactory
import org.springframework.beans.factory.DisposableBean
import org.springframework.beans.factory.InitializingBean

class SessionStorage implements InitializingBean, DisposableBean {
    private static final logger = LogFactory.getLog(this)

    Environment environment
    String logoutUrl
    String dataCenterName
    String userName
    boolean allTenants

    DataCenter getDataCenter() {
        environment?.dataCenterMap?.get(dataCenterName)
    }

    Map<String, OpenStackService> getServices() {
        dataCenter?.serviceMap
    }

    Tenant getTenant() {
        tenants.find { it.name == dataCenter.tenant }
    }

    List<Tenant> getTenants() {
        dataCenter?.tenants
    }

    String getTokenId() {
        dataCenter?.tokenId
    }

    List<String> getRoles() {
        dataCenter?.roles
    }

    String getEnvironmentName() {
        environment.name
    }

    Map<String, DataCenter> getDataCentersMap() {
        environment.dataCenterMap
    }

    boolean isFlagEnabled(String flag) {
        dataCenter?.flags?.contains(flag)
    }

    String getOpenStackVersion() {
        dataCenter?.openStackVersion
    }

    @Override
    void afterPropertiesSet() throws Exception {
        logger.info "Initializing for user $userName ..."
    }

    @Override
    void destroy() throws Exception {
        logger.info "Destroying for user $userName ..."
    }

    @Override
    public String toString() {
        return "SessionStorage{" +
                "environment=" + environment +
                ", dataCenterName='" + dataCenterName + '\'' +
                ", userName='" + userName + '\'' +
                '}';
    }
}
