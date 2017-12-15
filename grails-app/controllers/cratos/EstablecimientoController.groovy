package cratos

import org.springframework.dao.DataIntegrityViolationException

class EstablecimientoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [establecimientoInstanceList: Establecimiento.list(params), params: params]
    } //list

    def form_ajax() {
        def establecimientoInstance = new Establecimiento(params)
        if(params.id) {
            establecimientoInstance = Establecimiento.get(params.id)
            if(!establecimientoInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Establecimiento con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [establecimientoInstance: establecimientoInstance]
    } //form_ajax

    def save() {
        def establecimientoInstance
        if(params.id) {
            establecimientoInstance = Establecimiento.get(params.id)
            if(!establecimientoInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Establecimiento con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            establecimientoInstance.properties = params
        }//es edit
        else {
            establecimientoInstance = new Establecimiento(params)
        } //es create
        if (!establecimientoInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Establecimiento " + (establecimientoInstance.id ? establecimientoInstance.id : "") + "</h4>"

            str += "<ul>"
            establecimientoInstance.errors.allErrors.each { err ->
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
            flash.message = "Se ha actualizado correctamente Establecimiento " + establecimientoInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Establecimiento " + establecimientoInstance.id
        }
        redirect(action: 'list')
    } //save

    def show_ajax() {
        def establecimientoInstance = Establecimiento.get(params.id)
        if (!establecimientoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Establecimiento con id " + params.id
            redirect(action: "list")
            return
        }
        [establecimientoInstance: establecimientoInstance]
    } //show

    def delete() {
        def establecimientoInstance = Establecimiento.get(params.id)
        if (!establecimientoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Establecimiento con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            establecimientoInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message =  "Se ha eliminado correctamente Establecimiento " + establecimientoInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message =  "No se pudo eliminar Establecimiento " + (establecimientoInstance.id ? establecimientoInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
