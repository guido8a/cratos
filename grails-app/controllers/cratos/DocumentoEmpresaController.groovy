package cratos

import org.springframework.dao.DataIntegrityViolationException

class DocumentoEmpresaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {

        def empresa = Empresa.get(session.empresa.id)
        def lista = DocumentoEmpresa.findAllByEmpresa(empresa)
        def documentoEmpresaInstanceCount = DocumentoEmpresa.findAllByEmpresa(empresa).size()

//        [documentoEmpresaInstanceList: DocumentoEmpresa.list(params), params: params]
        [documentoEmpresaInstanceList: lista, documentoEmpresaInstanceCount:documentoEmpresaInstanceCount]
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


        def estb = Empresa.get(session.empresa.id).establecimientos.tokenize(',')
        def mp = [:]
        estb.each {
            mp[it] = it
        }


        def lista = ['F':'Factura', "R": 'Retención', "ND": 'Nota de Débito', "NC": 'Nota de Crédito']

        return [documentoEmpresaInstance: documentoEmpresaInstance, lista: lista, establecimientos: mp]
    } //form_ajax

    def save() {
        println("params " + params)
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
            documentoEmpresaInstance.fechaIngreso = new Date()
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
        def documentoEmpresa = DocumentoEmpresa.get(params.id)

        try{
            documentoEmpresa.delete(flush: true)
            render "OK_Libretín borrado correctamente!"
        }catch (e){
            println("error al borrar libretín " + e)
            render "NO_Error al borrar el libretín"
        }
    } //delete

    def save_ajax() {

//        println("params " + params)

        def documentoEmpresa
        def empresa = Empresa.get(session.empresa.id)
        def fechaInicio = new Date().parse("dd-MM-yyyy",params."fechaInicio_input")
        def fechaFin = new Date().parse("dd-MM-yyyy",params."fechaFin_input")
        def fechaAutorizacion = new Date().parse("dd-MM-yyyy",params."fechaAutorizacion_input")
        def st = ''
        def libretines = DocumentoEmpresa.findAllByEmpresa(empresa)

        if(params.numeroDesde.toInteger() >= params.numeroHasta.toInteger()){
            render "no_2_Los números ingresados en el rango de facturas son incorrectos!"
        }else{

            if(libretines.numeroHasta.contains(params.numeroHasta.toInteger()) || libretines.numeroHasta.contains(params.numeroDesde.toInteger())
                    || libretines.numeroDesde.contains(params.numeroDesde.toInteger()) || libretines.numeroDesde.contains(params.numeroHasta.toInteger())){
                render "no_2_El número ingresado ya se encuentra en otro libretín de facturas"
            }else{

                if(fechaInicio >= fechaFin){
                    render "no_2_La fecha de inicio es mayor a la fecha de finalización"
                }else{
                    if(params.id){
                        documentoEmpresa = DocumentoEmpresa.get(params.id)
                        st = 'Información del libretín actualizada correctamente'
                    }else{
                        documentoEmpresa = new DocumentoEmpresa()
                        documentoEmpresa.fechaIngreso = new Date()
                        documentoEmpresa.empresa = empresa
                        st = 'Libretín creado correctamente'
                    }

                    documentoEmpresa.autorizacion = params.autorizacion
                    documentoEmpresa.numeroDesde = params.numeroDesde.toInteger()
                    documentoEmpresa.numeroHasta = params.numeroHasta.toInteger()
                    documentoEmpresa.numeroEmision = params.numeroEmision
                    documentoEmpresa.numeroEstablecimiento = params.numeroEstablecimiento
                    documentoEmpresa.digitosEnSecuencial = params.digitosEnSecuencial.toInteger()
                    documentoEmpresa.fechaAutorizacion = fechaAutorizacion
                    documentoEmpresa.fechaInicio = fechaInicio
                    documentoEmpresa.fechaFin = fechaFin
                    documentoEmpresa.tipo = params.tipo

                    try {
                        documentoEmpresa.save(flush: true)
                        render "OK_" + st
                    }catch (e){
                        println("error libretin " + e + documentoEmpresa.errors)
                        render "no_Error al guardar la información del libretín"
                    }
                }
            }
        }

    }

    def verificar_ajax () {
        def documentoEmpresa = DocumentoEmpresa.get(params.id)
        def v = Proceso.findAllByDocumentoEmpresa(documentoEmpresa)
        def r
        if (v.size() > 0) {
            r = true
        } else {
            r = false
        }

//        render (v.size() > 0) ? true : false
        render r
    }

} //fin controller
