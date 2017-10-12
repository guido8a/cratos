package cratos.inventario

import org.springframework.dao.DataIntegrityViolationException

class KardexController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [kardexInstanceList: Kardex.list(params), params: params]
    } //list

    def form_ajax() {
        def kardexInstance = new Kardex(params)
        if(params.id) {
            kardexInstance = Kardex.get(params.id)
            if(!kardexInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Kardex con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [kardexInstance: kardexInstance]
    } //form_ajax

    def save() {
        def kardexInstance
        if(params.id) {
            kardexInstance = Kardex.get(params.id)
            if(!kardexInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Kardex con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            kardexInstance.properties = params
        }//es edit
        else {
            kardexInstance = new Kardex(params)
        } //es create
        if (!kardexInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Kardex " + (kardexInstance.id ? kardexInstance.id : "") + "</h4>"

            str += "<ul>"
            kardexInstance.errors.allErrors.each { err ->
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
            flash.message = "Se ha actualizado correctamente Kardex " + kardexInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Kardex " + kardexInstance.id
        }
        redirect(action: 'list')
    } //save

    def show_ajax() {
        def kardexInstance = Kardex.get(params.id)
        if (!kardexInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Kardex con id " + params.id
            redirect(action: "list")
            return
        }
        [kardexInstance: kardexInstance]
    } //show

    def delete() {
        def kardexInstance = Kardex.get(params.id)
        if (!kardexInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Kardex con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            kardexInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message =  "Se ha eliminado correctamente Kardex " + kardexInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message =  "No se pudo eliminar Kardex " + (kardexInstance.id ? kardexInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
