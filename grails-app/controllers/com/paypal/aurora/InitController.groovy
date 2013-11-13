package com.paypal.aurora

class InitController {

    def configService

    def index = {
        [auroraHome: configService.auroraHome, errorMessage : configService.errorMessage]
    }
}
