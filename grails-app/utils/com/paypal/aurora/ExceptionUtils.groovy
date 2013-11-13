package com.paypal.aurora

import com.paypal.aurora.exception.RestClientRequestException
import org.apache.commons.logging.LogFactory

import javax.servlet.http.HttpServletResponse

class ExceptionUtils {

    private static final logger = LogFactory.getLog(this)
    private static final String HEAT_ERROR_MESSAGE_KEY_WORD = "ValueError: "

    def static getExceptionMessage(Exception exception) {
        if (exception instanceof RestClientRequestException) {
            getMessage(exception.getCause())
        } else if (exception instanceof UnknownHostException) {
            "Unknown host ${getMessage(exception)}"
        } else {
            getMessage(exception)
        }
    }

    static int getExceptionCode (Exception exception){
        int code
        try{
            code = exception.cause.statusCode
        } catch(Exception e){
            code = HttpServletResponse.SC_INTERNAL_SERVER_ERROR
        }
        return code
    }

    def private static getMessage(Throwable throwable) {
        try {
            if (throwable.respondsTo('getResponse')) {
                def throwableResponse = throwable.getResponse()
                if (throwableResponse) {
                    if (throwableResponse.respondsTo('getData')) {
                        def exceptionResponseData = throwableResponse.getData()
                        if (exceptionResponseData) {
                            if (exceptionResponseData instanceof Map) {
                                if (exceptionResponseData.QuantumError) {
                                    return exceptionResponseData.QuantumError
                                }
                                def value = exceptionResponseData.find { it }.value
                                if (value instanceof Map) {
                                    return value.message?:throwable.getMessage()
                                }
                            }
                            if(exceptionResponseData instanceof StringReader) {
                                for (String line: exceptionResponseData.text.split("\n")) {
                                    if (line.startsWith(HEAT_ERROR_MESSAGE_KEY_WORD)) {
                                        return line.substring(HEAT_ERROR_MESSAGE_KEY_WORD.length())
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception ex) {
            if (logger.errorEnabled) {
                logger.error(ex.getMessage(), ex)
            }
        }
        throwable.getMessage()
    }

    def static getExceptionBody(Exception exception) {
        def body = [error: getExceptionMessage(exception)]
        body.cause = org.apache.commons.lang.exception.ExceptionUtils.getRootCauseMessage(exception)
        body.stacktrace = org.apache.commons.lang.exception.ExceptionUtils.getFullStackTrace(exception)
        body
    }

}
