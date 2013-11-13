package com.paypal.aurora.log

import org.apache.log4j.Logger
import org.apache.log4j.PatternLayout
import org.apache.log4j.spi.LoggingEvent

class CustomPatternLayout extends PatternLayout {

    @Override
    String format(LoggingEvent event) {
        if (event.getMessage() instanceof String) {
            String message = event.getRenderedMessage()
            String maskedMessage = message.replaceAll('\"(username|password)\"\\s*:\\s*"[^\"]+\"', '\"\$1\":\"**********\"')
            Throwable throwable = event.getThrowableInformation() != null ?
                event.getThrowableInformation().getThrowable() : null;
            LoggingEvent maskedEvent = new LoggingEvent(event.fqnOfCategoryClass,
                    Logger.getLogger(event.getLoggerName()), event.timeStamp,
                    event.getLevel(), maskedMessage, throwable)

            return super.format(maskedEvent);
        }
        return super.format(event);
    }

}
