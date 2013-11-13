package com.paypal.aurora.model

import groovy.transform.AutoClone
import groovy.transform.AutoCloneStyle

@AutoClone(style=AutoCloneStyle.SERIALIZATION)
class DataCenter implements Serializable{
    transient String tokenId
    String name
    String keystone
    String proxy
    String user_login_hint = 'Using USER Credentials:'
    String admin_login_hint = 'Using ROOT Credentials:'
    String instance_usage_audit_period = 'hour'
    String adminkeystone
    List<String> flags = []
    List<OpenStackService> customservices = []
    transient Map<String, OpenStackService> serviceMap
    transient List<Tenant> tenants = []
    transient List<String> roles = []
    transient String tenant
    String error
    String openStackVersion

    DataCenter() {

    }

    String getDisplayName() {
        return tokenId ? this.name : "?${this.name}"
    }

    void initMap() {
        serviceMap = [:]
        customservices.each {
            serviceMap.put(it.type, it)
        }
    }


    @Override
    public String toString() {
        return "DataCenter{" +
                "tokenId='" + tokenId + '\'' +
                ", name='" + name + '\'' +
                ", keystone='" + keystone + '\'' +
                ", proxy='" + proxy + '\'' +
                ", user_login_hint='" + user_login_hint + '\'' +
                ", admin_login_hint='" + admin_login_hint + '\'' +
                ", instance_usage_audit_period='" + instance_usage_audit_period + '\'' +
                ", adminkeystone='" + adminkeystone + '\'' +
                ", flags=" + flags +
                ", customservices=" + customservices +
                ", serviceMap=" + serviceMap +
                ", tenants=" + tenants +
                ", roles=" + roles +
                ", tenant='" + tenant + '\'' +
                ", error='" + error + '\'' +
                ", openStackVersion='" + openStackVersion + '\'' +
                '}';
    }
}
