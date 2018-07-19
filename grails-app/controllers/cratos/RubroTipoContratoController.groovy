package cratos

import org.springframework.dao.DataIntegrityViolationException

class RubroTipoContratoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [rubroTipoContratoInstanceList: RubroTipoContrato.list(params), params: params, rubroTipoContratoInstanceCount: RubroTipoContrato.count() ]
    } //list

    def form_ajax() {
        def rubroTipoContratoInstance = new RubroTipoContrato(params)
        if(params.id) {
            rubroTipoContratoInstance = RubroTipoContrato.get(params.id)
            if(!rubroTipoContratoInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Rubro Tipo Contrato con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [rubroTipoContratoInstance: rubroTipoContratoInstance]
    } //form_ajax

    def save() {
        def rubroTipoContratoInstance
        if(params.id) {
            rubroTipoContratoInstance = RubroTipoContrato.get(params.id)
            if(!rubroTipoContratoInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Rubro Tipo Contrato con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            rubroTipoContratoInstance.properties = params
        }//es edit
        else {
            rubroTipoContratoInstance = new RubroTipoContrato(params)
        } //es create
        if (!rubroTipoContratoInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Rubro Tipo Contrato " + (rubroTipoContratoInstance.id ? rubroTipoContratoInstance.id : "") + "</h4>"

            str += "<ul>"
            rubroTipoContratoInstance.errors.allErrors.each { err ->
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
            flash.message = "Se ha actualizado correctamente Rubro Tipo Contrato " + rubroTipoContratoInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Rubro Tipo Contrato " + rubroTipoContratoInstance.id
        }
        redirect(action: 'list')
    } //save

    def show_ajax() {
        def rubroTipoContratoInstance = RubroTipoContrato.get(params.id)
        if (!rubroTipoContratoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Rubro Tipo Contrato con id " + params.id
            redirect(action: "list")
            return
        }
        [rubroTipoContratoInstance: rubroTipoContratoInstance]
    } //show

    def delete() {
        def rubroTipoContratoInstance = RubroTipoContrato.get(params.id)
        if (!rubroTipoContratoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Rubro Tipo Contrato con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            rubroTipoContratoInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message =  "Se ha eliminado correctamente Rubro Tipo Contrato " + rubroTipoContratoInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message =  "No se pudo eliminar Rubro Tipo Contrato " + (rubroTipoContratoInstance.id ? rubroTipoContratoInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
