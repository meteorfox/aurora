package com.paypal.aurora

import com.paypal.aurora.auth.UserLoginToken
import com.paypal.aurora.exception.RestClientRequestException
import com.paypal.aurora.model.DataCenter
import com.paypal.aurora.model.OpenStackService
import com.paypal.aurora.model.Tenant
import com.paypal.aurora.model.UserState
import groovyx.net.http.ParserRegistry
import groovyx.net.http.RESTClient
import org.apache.http.HttpResponse
import org.apache.http.conn.scheme.Scheme
import org.apache.http.conn.ssl.SSLSocketFactory
import org.apache.http.entity.ContentType
import org.apache.shiro.SecurityUtils
import org.apache.shiro.authc.AuthenticationException

import javax.net.ssl.SSLContext
import javax.net.ssl.TrustManager
import javax.net.ssl.X509TrustManager
import java.security.cert.CertificateException
import java.security.cert.X509Certificate

class OpenStackRESTService {

    static transactional = false
    static final Integer CONNECTION_TIMEOUT_MILLIS = 45000
    static final String NOVA = 'compute'
    static final String NOVA_VOLUME = 'volume'
    static final String GLANCE = 'image'
    static final String LBMS = 'lbms'
    static final String KEYSTONE = 'identity'
    static final String HEAT = 'orchestration'
    static final String QUANTUM = 'network'
    static final String PSERV = 'pserv'
    static final String DNS = 'dns'
    static final String METERING = 'metering'
    static final String TEXT_PLAIN = 'text/plain'
    static final String APPLICATION_JSON = 'application/json'
    static final def ADDITIONAL_HEADERS = [(NOVA_VOLUME): ['User-Agent': 'python-cinderclient']]
    static final def CONTENT_TYPE = [(TEXT_PLAIN): ContentType.TEXT_PLAIN]
    static final def RESPONSE_PARSER = [
            (APPLICATION_JSON): [
                    (TEXT_PLAIN): { HttpResponse resp ->
                        ParserRegistry parser = new ParserRegistry()
                        resp.setHeader('Content-Type', 'text/plain')
                        BufferedReader convert = new BufferedReader(parser.parseText(resp))
                        def result = [str: convert.readLine()]
                        return result
                    }
            ]
    ]
    def sessionStorageService
    def configService

    void setProxy(def proxy) {
        if (proxy) {
            String[] split = proxy.split(':')
            System.setProperty('socksProxySet', 'true')
            System.setProperty('socksProxyHost', split[0])
            System.setProperty('socksProxyPort', split[1])
        } else {
            System.setProperty('socksProxySet', 'false')
            System.setProperty('socksProxyHost', '')
            System.setProperty('socksProxyPort', '')
        }
    }

    void login(UserLoginToken userLoginToken) {
        def environment = configService.getEnvironmentByName(userLoginToken.environment)
        if (environment) {
            environment.initMap()
            sessionStorageService.environment = environment
            sessionStorageService.userName = userLoginToken.username
            log.debug "Log in environment '$environment'"
            for (DataCenter dataCenter in environment.datacenters) {
                setProxy(dataCenter.proxy)
                RESTClient client = makeClient(dataCenter.keystone)

                try {
                    dataCenter.tokenId = getTokenId(client, userLoginToken.principal, userLoginToken.credentials.toString())
                } catch (Exception e) {
                    dataCenter.error = ExceptionUtils.getExceptionMessage(e)
                    log.info(e)
                }

                if (dataCenter.tokenId) {
                    dataCenter.customservices.each {
                        if (!it.disabled && it.user) {
                            try {
                                it.tokenId = getTokenId(client, it.user, it.password, it.tenant)
                            } catch (Exception e) {
                                log.error "Can't login for service $it.type"
                                it.disabled = true
                            }
                        }
                    }
                    client.setHeaders('X-Auth-Token': dataCenter.tokenId)
                    dataCenter.tenants = getTenants(client)
                    changeTenant(client, dataCenter, findDefaultTenantId(dataCenter.tenants, userLoginToken.username))
                }
            }
            for (DataCenter dataCenter in environment.datacenters) {
                if (dataCenter.tokenId) {
                    sessionStorageService.dataCenterName = dataCenter.name
                    break
                }
            }
        }
    }

    private String findDefaultTenantId(List<Tenant> tenants, String userName) {
        Tenant tenant = tenants.find {
            it.name == userName
        }
        return tenant ? tenant.id : tenants.last().id
    }

    private static String getTokenId(RESTClient client, String user, String password, String tenantName = null) {
        def body = ['auth': ['passwordCredentials': ['username': user, 'password': password]]]
        if (tenantName) {
            body.auth.tenantName = tenantName
        }
        def resp = client.post(path: 'tokens', body: body, requestContentType: ContentType.APPLICATION_JSON.mimeType)

        resp.data.access.token.id
    }

    private static List<Tenant> getTenants(RESTClient client) {
        def resp = client.get(path: 'tenants')

        def tenants = []
        for (tenant in resp.data.tenants) {
            tenants << new Tenant(tenant)
        }
        return tenants
    }

    def private changeTenant(RESTClient client, DataCenter dataCenter, String tenantId) {
        def body = ['auth': ['token': ['id': dataCenter.tokenId], 'tenantId': tenantId]]
        def resp = client.post(path: 'tokens', body: body, requestContentType: ContentType.APPLICATION_JSON.mimeType)

        dataCenter.tokenId = resp.data.access.token.id
        dataCenter.initMap()
        // merge custom services with services from keystone
        for (service in resp.data.access.serviceCatalog) {
            if (!dataCenter.serviceMap.get(service.type)) {
                dataCenter.serviceMap.put(service.type, new OpenStackService(service.name, service.type, service.endpoints[0].publicURL, service.endpoints[0].adminURL))
            }
        }

        dataCenter.tenant = resp.data.access.token.tenant.name
        dataCenter.roles = resp.data.access.user.roles.name
    }

    def private disableVerify(RESTClient client) {
        SSLContext ctx = SSLContext.getInstance('TLS');
        X509TrustManager tm = new X509TrustManager() {
            @Override
            void checkClientTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {
            }


            @Override
            void checkServerTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {
            }

            @Override
            X509Certificate[] getAcceptedIssuers() {
                return []
            }
        };
        ctx.init(null, [tm].toArray(new TrustManager[1]), null);
        SSLSocketFactory ssf = new SSLSocketFactory(ctx);
        ssf.setHostnameVerifier(SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER)
        client.client.connectionManager.schemeRegistry.register(new Scheme('https', ssf, 443))
    }

    UserState changeUserState(String dataCenterName, String tenantId) {
        DataCenter dataCenter = sessionStorageService.environment.dataCenterMap[dataCenterName]

        if (!dataCenter) {
            throw new AuthenticationException("Cannot access to ${dataCenterName}")
        }

        if (dataCenterName != sessionStorageService.dataCenterName) {
            setProxy(dataCenter.proxy)
            sessionStorageService.dataCenterName = dataCenterName
        } else {
            RESTClient client = makeClient(dataCenter.keystone)
            changeTenant(client, dataCenter, tenantId)
        }
        return new UserState(sessionStorageService.dataCenterName, sessionStorageService.tenant.id)
    }

    def getContentType(def contentType) {
        if (contentType && contentType in CONTENT_TYPE.keySet())
            return CONTENT_TYPE[contentType]
        return ContentType.APPLICATION_JSON.mimeType
    }

    def makeClient(def host, def customParser = null) {
        RESTClient client = new RESTClient(host + '/')

        client.getClient().getParams().setParameter("http.connection.timeout", CONNECTION_TIMEOUT_MILLIS)
        client.getClient().getParams().setParameter("http.socket.timeout", CONNECTION_TIMEOUT_MILLIS)

        if (customParser) {
            def header = customParser.header
            def body = customParser.body
            def responseParser = RESPONSE_PARSER[header]?.getAt(body)
            if (responseParser)
                client.parser."${header}" = responseParser
        }

        disableVerify(client)
        return client
    }

    def private performRequest(String serviceName, String path, String request, def body = null, Map tokens = null, String returnValue = 'data', def query = null, def contentType = null, def customParser = null) {
        if (!isServiceEnabled(serviceName)) {
            return [:]
        }

        OpenStackService service = sessionStorageService.services[serviceName]

        def authToken = service.tokenId ?: sessionStorageService.tokenId

        String host = service.uri
        if (SecurityUtils.subject.hasRole(Constant.ROLE_ADMIN) && service.adminUri) {
            host = service.adminUri
        }

        RESTClient client = makeClient(host, customParser)

        def headers = ['X-Auth-Token': authToken]

        if (ADDITIONAL_HEADERS.get(serviceName)) {
            headers.putAll(ADDITIONAL_HEADERS.get(serviceName))
        }
        if (tokens) {
            headers.putAll(tokens)
        }
        client.setHeaders(headers)

        log.info("Performing '${request.toUpperCase()}' request to service '${service.type}': '${host.endsWith('/') ? host : host + '/' }${path}'")
        log.info("${headers}")
        try {
            def requestContentType = getContentType(contentType)
            def resp = client."${request}"(path: path, requestContentType: requestContentType, body: body, query: query)
            resp."${returnValue}" ?: [:]
        } catch (Exception e) {
            throw new RestClientRequestException(e.getMessage() + " '" + host + path + "'", e)
        }
    }

    def get(String service, String path, def query = null, def contentType = null, def customParser = null) {
        performRequest(service, path, 'get', null, null, 'data', query, contentType, customParser)
    }

    def delete(String service, String path, def contentType = null, def customParser = null) {
        performRequest(service, path, 'delete', null, null, 'data', null, contentType, customParser)
    }

    def post(String service, String path, def body, Map tokens = null, def contentType = null, def customParser = null) {
        performRequest(service, path, 'post', body, tokens, 'data', null, contentType, customParser)
    }

    def put(String service, String path, Map tokens, def body = null, def contentType = null, def customParser = null) {
        performRequest(service, path, 'put', body, tokens, 'data', null, contentType, customParser)
    }

    def head(String service, String path, def contentType = null, def customParser = null) {
        performRequest(service, path, 'head', null, null, 'allHeaders', null, contentType, customParser)
    }

    boolean isServiceEnabled(String name) {
        def services = sessionStorageService.services
        services[name] && !services[name].disabled
    }

}