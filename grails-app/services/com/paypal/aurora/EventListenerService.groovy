package com.paypal.aurora

import com.paypal.aurora.listeners.EventAfter
import com.paypal.aurora.listeners.ServiceListener

class EventListenerService {

    def grailsApplication

    void initialize() {
        grailsApplication.serviceClasses.each { serviceClass ->
            serviceClass.metaClass.invokeMethod = { name, arguments ->
                if (name == 'hasProperty') {
                    return delegate.metaClass.getMetaMethod(name, arguments).doMethodInvoke(delegate, arguments)
                }
                EventAfter event = new EventAfter(
                        arguments: arguments,
                        delegate: delegate)
                Set<ServiceListener> listeners = new HashSet<>()
                if (delegate.hasProperty('listeners')) {
                    delegate.listeners.get(name)?.each { listeners << it.listener }
                }
                listeners.each { it.beforeInvoke(event) }
                try {
                    def result = delegate.metaClass.getMetaMethod(name, arguments).doMethodInvoke(delegate, arguments)
                    event.result = result
                    listeners.each { it.afterInvoke(event) }
                    return result
                } catch (e) {
                    event.exception = e
                    listeners.each { it.onException(event) }
                    throw e
                }
            }
        }
    }
}
