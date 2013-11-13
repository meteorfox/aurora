package com.paypal.aurora.model

import groovy.transform.AutoClone
import groovy.transform.AutoCloneStyle

@AutoClone(style=AutoCloneStyle.SERIALIZATION)
class Environment implements Serializable{
    String name
    String signInUrl
    String redirect_url
    String loginHint
    List<DataCenter> datacenters = []
    transient Map<String, DataCenter> dataCenterMap

    Environment() {

    }

    void initMap() {
        dataCenterMap = [:]
        datacenters.each {
            dataCenterMap.put(it.name, it)
        }
    }

    @Override
    public String toString() {
        return "Environment{" +
                "name='" + name + '\'' +
                ", signInUrl='" + signInUrl + '\'' +
                ", redirect_url='" + redirect_url + '\'' +
                ", loginHint='" + loginHint + '\'' +
                ", datacenters=" + datacenters +
                '}';
    }
}
