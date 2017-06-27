package cratos.inventario

import org.springframework.dao.DataIntegrityViolationException

class SubgrupoItemsController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        println("params " + params)
        [subgrupoItemsInstanceList: SubgrupoItems.list(params), params: params]
    } //list

    def form_ajax() {
        def subgrupoItemsInstance = new SubgrupoItems(params)
        if(params.id) {
            subgrupoItemsInstance = SubgrupoItems.get(params.id)
            if(!subgrupoItemsInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Subgrupo Items con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [subgrupoItemsInstance: subgrupoItemsInstance]
    } //form_ajax

    def save() {
        def subgrupoItemsInstance
        if(params.id) {
            subgrupoItemsInstance = SubgrupoItems.get(params.id)
            if(!subgrupoItemsInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Subgrupo Items con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            subgrupoItemsInstance.properties = params
        }//es edit
        else {
            subgrupoItemsInstance = new SubgrupoItems(params)
        } //es create
        if (!subgrupoItemsInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Subgrupo Items " + (subgrupoItemsInstance.id ? subgrupoItemsInstance.id : "") + "</h4>"

            str += "<ul>"
            subgrupoItemsInstance.errors.allErrors.each { err ->
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
            flash.message = "Se ha actualizado correctamente Subgrupo Items " + subgrupoItemsInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Subgrupo Items " + subgrupoItemsInstance.id
        }
        redirect(action: 'list')
    } //save

    def show_ajax() {
        def subgrupoItemsInstance = SubgrupoItems.get(params.id)
        if (!subgrupoItemsInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Subgrupo Items con id " + params.id
            redirect(action: "list")
            return
        }
        [subgrupoItemsInstance: subgrupoItemsInstance]
    } //show

    def delete() {
        def subgrupoItemsInstance = SubgrupoItems.get(params.id)
        if (!subgrupoItemsInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Subgrupo Items con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            subgrupoItemsInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message =  "Se ha eliminado correctamente Subgrupo Items " + subgrupoItemsInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message =  "No se pudo eliminar Subgrupo Items " + (subgrupoItemsInstance.id ? subgrupoItemsInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
