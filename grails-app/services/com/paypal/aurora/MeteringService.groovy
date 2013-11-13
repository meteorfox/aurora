package com.paypal.aurora

import org.joda.time.DateTime
import org.joda.time.DateTimeZone

import java.text.DateFormat
import java.text.SimpleDateFormat

class MeteringService {

    def sessionStorageService
    def openStackRESTService
    static DateFormat SAMPLE_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss")
    static DateFormat SAMPLE_DATE_FORMAT_WITH_ZONE = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss z")
    TimeUtils timeUtils = new TimeUtils()

    def getUsages(String type, int interval, int count, boolean showCurrentTenant = true) {
        def request = ['q[0].field': 'timestamp',
                'q[0].op': 'ge',
                'q[0].value': timeUtils.getDate(DateTimeZone.UTC).minusSeconds(interval * count),
                period: interval]
        if (showCurrentTenant) {
            request << ['q[1].field': 'project_id',
                    'q[1].op': 'eq',
                    'q[1].value': sessionStorageService.tenant.id]
        }
        def resp = openStackRESTService.get(OpenStackRESTService.METERING, "/v2/meters/$type/statistics", request)
        def usages = []
        resp.each {
            String str = it.duration_end
            if (str.endsWith('000')) {
                str = str.substring(0, str.size() - 7)
            }
            usages << [x: str, y: it.avg]
        }
        return usages
    }

    def getMeters() {
        openStackRESTService.get(OpenStackRESTService.METERING, '/v2/meters')
    }

    def getSamples(String type, Integer period = null, boolean showCurrentTenant = true) {
        def request = [:]
        if (period) {
            request = ['q[0].field': 'timestamp',
                    'q[0].op': 'ge',
                    'q[0].value': timeUtils.getDate(DateTimeZone.UTC).minusSeconds(period)]
        }
        if (showCurrentTenant) {
            request << ['q[1].field': 'project_id',
                    'q[1].op': 'eq',
                    'q[1].value': sessionStorageService.tenant.id]
        }
        def resp = openStackRESTService.get(OpenStackRESTService.METERING, "/v2/meters/$type", request)
        def usages = []
        resp.each {
            String timestamp = it.timestamp
            if (timestamp.endsWith('000')) {
                timestamp = timestamp.substring(0, timestamp.size() - 7)
            }
            usages << [x: timestamp, y: it.counter_volume]
        }
        return usages
    }

    def getProcessedSamples(String type, Integer period = 1, boolean showCurrentTenant = true) {
        String[] audit_period = sessionStorageService.dataCenter.instance_usage_audit_period.split('@')
        DateTime time = timeUtils.getDate(DateTimeZone.default).minusSeconds(period).withSecondOfMinute(0).withMillisOfSecond(0)
        if (audit_period[0] == 'hour') {
            if (audit_period.length == 2) {
                time = time.withMinuteOfHour(Integer.valueOf(audit_period[1]))
                if (time.isAfterNow()) {
                    time = time.minusHours(1)
                }
            } else {
                time = time.withMinuteOfHour(0)
            }
        } else if (audit_period[0] == 'day') {
            time = time.withMinuteOfHour(0)
            if (audit_period.length == 2) {
                time = time.withHourOfDay(Integer.valueOf(audit_period[1]))
                if (time.isAfterNow()) {
                    time = time.minusDays(1)
                }
            } else {
                time = time.withHourOfDay(0)
            }
        } else if (audit_period[0] == 'month') {
            time = time.withMinuteOfHour(0).withHourOfDay(0)
            if (audit_period.length == 2) {
                time = time.withDayOfMonth(Integer.valueOf(audit_period[1]))
                if (time.isAfterNow()) {
                    time = time.minusMonths(1)
                }
            } else {
                time = time.withDayOfMonth(1)
            }
        } else if (audit_period[0] == 'year') {
            time = time.withMinuteOfHour(0).withHourOfDay(0).withDayOfMonth(1)
            if (audit_period.length == 2) {
                time = time.withMonthOfYear(Integer.valueOf(audit_period[1]))
                if (time.isAfterNow()) {
                    time = time.minusYears(1)
                }
            } else {
                time = time.withMonthOfYear(1)
            }
        }
        def request = ['q[0].field': 'timestamp',
                'q[0].op': 'ge',
                'q[0].value': time.withZone(DateTimeZone.UTC)]
        if (showCurrentTenant) {
            request << ['q[1].field': 'project_id',
                    'q[1].op': 'eq',
                    'q[1].value': sessionStorageService.tenant.id]
        }
        def resp = openStackRESTService.get(OpenStackRESTService.METERING, "/v2/meters/$type", request)
        def usages = []
        resp.each {
            String timestamp = it.timestamp
            if (timestamp.endsWith('000')) {
                timestamp = timestamp.substring(0, timestamp.size() - 7)
            }
            it.dateTime = new DateTime(SAMPLE_DATE_FORMAT_WITH_ZONE.parse("$timestamp UTC"))
        }
        DateTime first5Min = time.plusMinutes(5)
        int count = 0
        Set<String> existingResource = new HashSet<String>();
        for (def sample : resp) {
            if (first5Min.isBefore(sample.dateTime)) {
                break
            }
            if (sample.resource_metadata.event_type == 'compute.instance.exists') {
                count += sample.counter_volume
                existingResource.add(sample.resource_id)
            }
        }
        usages << [x: SAMPLE_DATE_FORMAT.format(time.toDate()), y: count]
        resp.each {
            if (it.resource_metadata.event_type == 'compute.instance.create.end' && !existingResource.contains(it.resource_id)) {
                count += it.counter_volume
                usages << [x: SAMPLE_DATE_FORMAT.format(it.dateTime.toDate()), y: count]
            }
            if (it.resource_metadata.event_type == 'compute.instance.delete.start') {
                existingResource.remove(it.resource_id)
                count -= it.counter_volume
                usages << [x: SAMPLE_DATE_FORMAT.format(it.dateTime.toDate()), y: count]
            }
        }
        usages << [x: SAMPLE_DATE_FORMAT.format(timeUtils.getDate(DateTimeZone.default).toDate()), y: count]
        return usages
    }

}
