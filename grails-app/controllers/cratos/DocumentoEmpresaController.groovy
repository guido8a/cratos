package cratos

import org.springframework.dao.DataIntegrityViolationException

class DocumentoEmpresaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {

        [documentoEmpresaInstanceList: DocumentoEmpresa.list(params), params: params]
    } //list

    def form_ajax() {
        def documentoEmpresaInstance = new DocumentoEmpresa(params)
        if(params.id) {
            documentoEmpresaInstance = DocumentoEmpresa.get(params.id)
            if(!documentoEmpresaInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Documento Empresa con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [documentoEmpresaInstance: documentoEmpresaInstance]
    } //form_ajax

    def save() {
        def documentoEmpresaInstance
        if(params.id) {
            documentoEmpresaInstance = DocumentoEmpresa.get(params.id)
            if(!documentoEmpresaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Documento Empresa con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            documentoEmpresaInstance.properties = params
        }//es edit
        else {
            documentoEmpresaInstance = new DocumentoEmpresa(params)
        } //es create
        if (!documentoEmpresaInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Documento Empresa " + (documentoEmpresaInstance.id ? documentoEmpresaInstance.id : "") + "</h4>"

            str += "<ul>"
            documentoEmpresaInstance.errors.allErrors.each { err ->
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
            flash.message = "Se ha actualizado correctamente Documento Empresa " + documentoEmpresaInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Documento Empresa " + documentoEmpresaInstance.id
        }
        redirect(action: 'list')
    } //save

    def show_ajax() {
        def documentoEmpresaInstance = DocumentoEmpresa.get(params.id)
        if (!documentoEmpresaInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Documento Empresa con id " + params.id
            redirect(action: "list")
            return
        }
        [documentoEmpresaInstance: documentoEmpresaInstance]
    } //show

    def delete() {
        def documentoEmpresaInstance = DocumentoEmpresa.get(params.id)
        if (!documentoEmpresaInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Documento Empresa con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            documentoEmpresaInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message =  "Se ha eliminado correctamente Documento Empresa " + documentoEmpresaInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message =  "No se pudo eliminar Documento Empresa " + (documentoEmpresaInstance.id ? documentoEmpresaInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
