package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoDocumentoPagoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        def tipoDocumentoPagoInstanceList = TipoDocumentoPago.list(params)
        [tipoDocumentoPagoInstanceList: tipoDocumentoPagoInstanceList, params: params,
         tipoDocumentoPagoInstanceCount: tipoDocumentoPagoInstanceList?.size()]
    } //list

    def form_ajax() {
        def tipoDocumentoPagoInstance = new TipoDocumentoPago(params)
        if(params.id) {
            tipoDocumentoPagoInstance = TipoDocumentoPago.get(params.id)
            if(!tipoDocumentoPagoInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Tipo Documento Pago con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoDocumentoPagoInstance: tipoDocumentoPagoInstance]
    } //form_ajax

    def save() {
        def tipoDocumentoPagoInstance
        if(params.id) {
            tipoDocumentoPagoInstance = TipoDocumentoPago.get(params.id)
            if(!tipoDocumentoPagoInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Tipo Documento Pago con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            tipoDocumentoPagoInstance.properties = params
        }//es edit
        else {
            tipoDocumentoPagoInstance = new TipoDocumentoPago(params)
        } //es create
        if (!tipoDocumentoPagoInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Tipo Documento Pago " + (tipoDocumentoPagoInstance.id ? tipoDocumentoPagoInstance.id : "") + "</h4>"

            str += "<ul>"
            tipoDocumentoPagoInstance.errors.allErrors.each { err ->
                def msg = err.defaultMessage
                err.arguments.eachWithIndex {  arg, i ->
                    msg = msg.replaceAll("\\{" + i + "}", arg.toString())
                }
                str += "<li>" + msg + "</li>"
            }
            str += "</ul>"

            flash.message = str
            redirect(action: 'list')
            return
        }

        if(params.id) {
            flash.clase = "alert-success"
            flash.message = "Se ha actualizado correctamente Tipo Documento Pago " + tipoDocumentoPagoInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Tipo Documento Pago " + tipoDocumentoPagoInstance.id
        }
        redirect(action: 'list')
    } //save

    def show_ajax() {
        def tipoDocumentoPagoInstance = TipoDocumentoPago.get(params.id)
        if (!tipoDocumentoPagoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Tipo Documento Pago con id " + params.id
            redirect(action: "list")
            return
        }
        [tipoDocumentoPagoInstance: tipoDocumentoPagoInstance]
    } //show

    def delete() {
        def tipoDocumentoPagoInstance = TipoDocumentoPago.get(params.id)
        if (!tipoDocumentoPagoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Tipo Documento Pago con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            tipoDocumentoPagoInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message =  "Se ha eliminado correctamente Tipo Documento Pago " + tipoDocumentoPagoInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message =  "No se pudo eliminar Tipo Documento Pago " + (tipoDocumentoPagoInstance.id ? tipoDocumentoPagoInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
