package com.paypal.aurora.model

import groovy.transform.AutoClone
import groovy.transform.AutoCloneStyle

@AutoClone(style=AutoCloneStyle.SERIALIZATION)
class OpenStackService implements Serializable {
    String name
    String type
    String uri
    String adminUri
    // todo getHost
    String host

    //hacks for PP
    String user
    String password
    transient String tokenId
    String tenant
    boolean disabled = false
    List<String> monitors = []
    List<String> methods = []
    List<String> allowedProtocols = []

    OpenStackService() {

    }

    OpenStackService(String name, String type, String uri, String adminUri) {
        this.name = name
        this.type = type
        setUri(uri)
        this.adminUri = adminUri
    }

    OpenStackService(String name, String type, String uri, String adminUri, String user, String password, String tenant, boolean disabled) {
        this(name, type, uri, adminUri)
        this.user = user
        this.password = password
        this.disabled = disabled
        this.tenant = tenant
    }

    def setUri(String publicURL) {
        this.uri = publicURL
        this.host = publicURL ? formatHost(publicURL) : null
    }


    // todo rewrite and Unit test
    public static String formatHost(String host) {
        (host =~ /(\w+:\/\/)?([^:^\/]+)(:\d+)?(\/.*)?/)[0][2]
    }

    @Override
    public String toString() {
        return "OpenStackService{" +
                "name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", uri='" + uri + '\'' +
                ", adminUri='" + adminUri + '\'' +
                ", host='" + host + '\'' +
                ", user='" + user + '\'' +
                ", password='" + password + '\'' +
                ", tokenId='" + tokenId + '\'' +
                ", tenant='" + tenant + '\'' +
                ", disabled=" + disabled +
                '}';
    }
}
