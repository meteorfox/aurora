package com.paypal.aurora

import org.joda.time.DateTime
import org.joda.time.DateTimeZone

class TimeUtils {

    DateTime getDate(DateTimeZone zone) {
        return new DateTime(zone)
    }

}
