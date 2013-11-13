package com.paypal.aurora

import com.paypal.aurora.exception.RestClientRequestException
import com.paypal.aurora.util.ConstraintsProcessor
import grails.converters.JSON
import grails.converters.XML

import javax.servlet.http.HttpServletResponse

class SnapshotController {

    def static allowedMethods = [list: ['GET', 'POST'], show: ['GET', 'POST'], save: ['GET', 'POST'], delete: ['GET', 'POST']]

    def index = { redirect(action: 'list', params: params) }

    def snapshotService

    def list = {
        def snapshots
        def error
        try{
            snapshots = snapshotService.getAllSnapshots()
        } catch (RestClientRequestException e){
            error = ExceptionUtils.getExceptionMessage(e)
            response.status = ExceptionUtils.getExceptionCode(e)
        }
        def model = [snapshots : snapshots, errors : error]
        withFormat {
            html { model }
            xml { new XML(model).render(response) }
            json { new JSON(model).render(response) }
        }
    }

    def _snapshots = {
        def snapshots = []
        def error
        try{
            snapshots = snapshotService.getAllSnapshots()
        } catch (RestClientRequestException e){
            error = ExceptionUtils.getExceptionMessage(e)
            response.status = ExceptionUtils.getExceptionCode(e)
        }
        def model = [snapshots : snapshots, errors : error]
        withFormat {
            html { model }
            xml { new XML(model).render(response) }
            json { new JSON(model).render(response) }
        }
    }

    def show = {
        try{
            def snapshot = snapshotService.getSnapshotById(params.id)
            def model = [snapshot : snapshot]
            withFormat {
                html { [parent:"/snapshot",snapshot: snapshot] }
                xml { new XML(model).render(response) }
                json { new JSON(model).render(response) }
            }
        } catch (RestClientRequestException e) {
            response.status = ExceptionUtils.getExceptionCode(e)
            def errors = ExceptionUtils.getExceptionMessage(e)
            withFormat {
                html { flash.message = errors; redirect([parent:"/snapshot", action: 'list'])}
                xml { new XML([errors: errors]).render(response) }
                json { new JSON([errors: errors]).render(response) }
            }
        }
    }

    def delete = {
        List<String> snapshotIds = Requests.ensureList(params.selectedSnapshots ?: params.id)
        def model = snapshotService.deleteSnapshotsById(snapshotIds)
        def flashMessage = ResponseUtils.defineMessageByList("Could not delete snapshots with id: ", model.notRemovedItems)
        response.status = ResponseUtils.defineResponseStatus(model, flashMessage)
        withFormat {
            html {
                flash.message = flashMessage;
                redirect(action: 'list')
            }
            xml { new XML(model).render(response) }
            json { new JSON(model).render(response) }
        }
    }

    def create = {
        withFormat {
            html {[parent:"/snapshot", constraints: ConstraintsProcessor.getConstraints(SnapshotCreateCommand.class)]}
        }
    }

    def save = { SnapshotCreateCommand cmd ->

        if (cmd.hasErrors()) {
            response.status = 400
            withFormat {
                html { chain(action: 'create', model: [cmd : cmd], params: params) }
                xml {new XML([errors : cmd.errors]).render(response)}
                json {new JSON([errors : cmd.errors]).render(response)}
            }
        } else {
            try {
                def resp = snapshotService.createSnapshot(params);
                def model = [resp : resp]
                withFormat {
                    html { redirect(action: 'list') }
                    xml { new XML(resp).render(response) }
                    json { new JSON(resp).render(response) }
                }
            } catch (RestClientRequestException e) {
                response.status = ExceptionUtils.getExceptionCode(e)
                def errors = ExceptionUtils.getExceptionMessage(e)
                withFormat {
                    html { flash.message = errors; chain(action: 'create', params: params)}
                    xml { new XML([errors: errors]).render(response) }
                    json { new JSON([errors: errors]).render(response) }
                }
            }
        }
    }

}
class SnapshotCreateCommand {

    String name
    String description

    static constraints = {
        name(nullable: false, blank: false)
        description(nullable: false, blank: false)
    }
}
