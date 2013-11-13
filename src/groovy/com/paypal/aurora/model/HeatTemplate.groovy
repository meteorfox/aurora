package com.paypal.aurora.model

import org.apache.commons.logging.LogFactory
import org.springframework.beans.factory.DisposableBean
import org.springframework.beans.factory.InitializingBean

class HeatTemplate implements InitializingBean, DisposableBean, Serializable {
    private static final logger = LogFactory.getLog(this)

    String template
    List<Object> parameters

    HeatTemplate(String template) {
        this.template = template
    }

    HeatTemplate() {
    }

    @Override
    void afterPropertiesSet() throws Exception {
        logger.info 'Initializing...'
    }

    @Override
    void destroy() throws Exception {
        logger.info 'Destroying...'
    }

    @Override
    public String toString() {
        return "HeatTemplate{" +
                "template='" + template + '\'' +
                ", parameters=" + parameters +
                '}';
    }
}
