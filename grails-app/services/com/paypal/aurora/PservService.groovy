package com.paypal.aurora

import org.apache.commons.logging.LogFactory

class PservService {

    private static final String PSERV = 'pserv'
    private static final String TICKETS = 'tracking-rest-service/rest/tickets'
    private static final logger = LogFactory.getLog(this)

    def openStackRESTService
    def sessionStorageService


    boolean isEnabled() {
        openStackRESTService.isServiceEnabled(openStackRESTService.PSERV)
    }

    def createTicket(String action, String description) {
        def body = [
                application: ["type": "AURORA", "subType": "LB Management"],
                title: action,
                description: description,
                environment: sessionStorageService.getEnvironmentName(),
                dataCenterName: sessionStorageService.getDataCenterName(),
                assignee: "auroramanager",
                status: "IN_PROGRESS",
                requester: ["login": sessionStorageService.getUserName()],
                submitter: sessionStorageService.getUserName()
        ]
        logger.info("LOG:\n " + body.description + " on environment '" + body.environment + "'. Requester '" + body.requester.login + "', submitter '" + body.submitter + "'. Status '" + body.status + "'")
        openStackRESTService.post(PSERV, TICKETS, body, null, null, [header : 'application/json', body: 'text/plain']).str.toString()
    }

    def getTicket(def ticketId) {
        logger.info("LOG:\n Get ticket with id '" + ticketId + "'")
        openStackRESTService.get(PSERV, "${TICKETS}/${ticketId}")
    }

    def addNote(def ticketId, def note) {
        logger.info("LOG:\n Note: " + note + "'  added to ticket '" + ticketId )
        openStackRESTService.post(PSERV, "${TICKETS}/${ticketId}/note", note, null, 'text/plain')
    }

    def closeTicket(def ticketId) {
        logger.info("LOG:\n Closing ticket '" + ticketId + "'")
        openStackRESTService.put(PSERV, (String)"${TICKETS}/${ticketId}/status", null, '\"COMPLETED\"')
    }
}
