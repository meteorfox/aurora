package com.paypal.aurora

class DefaultMappingController {

    def openStackRESTService

    def index() {
        redirect(controller: 'dashboard', action: 'index')
    } 

}
