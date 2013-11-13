package com.paypal.aurora

class InfoService {

    static final String BUILD_DATE = 'app.build_date'
    static final String BUILD_NUMBER = 'app.build_number'
    static final String JAVA_VERSION = 'java.version'
    static final String OS_NAME = 'os.name'
    static final String USER_TIME_ZONE = 'user.timezone'

    def grailsApplication

    def getInfo() {
        def properties = System.properties
        return ['Build number': grailsApplication.metadata[BUILD_NUMBER],
         'Build date': grailsApplication.metadata[BUILD_DATE],
         'Java version': properties.get(JAVA_VERSION),
         'OS name': properties.get(OS_NAME),
         'User timezone': properties.get(USER_TIME_ZONE)
        ]
    }

}
