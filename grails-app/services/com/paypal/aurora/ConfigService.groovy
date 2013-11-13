package com.paypal.aurora

import com.paypal.aurora.model.Environment
import groovy.json.JsonSlurper
import org.codehaus.jackson.map.ObjectMapper
import org.codehaus.jackson.type.TypeReference

class ConfigService {

    static final String CONFIG_FILE = 'Config.json'

    def grailsApplication
    ObjectMapper objectMapper
    JsonSlurper jsonSlurper
    String errorMessage

    String getAuroraHome() {
        grailsApplication.config.auroraHome
    }

    boolean isProduction() {
        return grailsApplication.metadata['grails.env'] == 'production'
    }

    void reloadConfig() {
        try {
            def file = new File(auroraHome, CONFIG_FILE)
            jsonSlurper.parse(new FileReader(file))
            grailsApplication.config.properties.environments = objectMapper.readValue(file, new TypeReference<HashMap<String, List<Environment>>>() {}).environments
            errorMessage = null
        } catch (Exception e) {
            log.error(e.getMessage(), e)
            errorMessage = ExceptionUtils.getExceptionMessage(e)
        }
    }

    Environment getEnvironmentByName(String name) {
        return environments.find { it.name.toUpperCase() == name.toUpperCase() }.clone()
    }

    boolean isAppConfigured() {
        return !errorMessage
    }

    List<Environment> getEnvironments() {
        return grailsApplication.config.properties.environments
    }
    String getSignInUrl() {
        return grailsApplication.config.properties.environments.get(0).signInUrl
    }
}
