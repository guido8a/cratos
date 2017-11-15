package cratos

import org.springframework.dao.DataIntegrityViolationException

class DocumentoEmpresaController extends cratos.seguridad.Shield {

    def dbConnectionService

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

    /***
     * Se debe validar dentro de cada empresa que no hayan libretines cruzados del mismo tipo
     * se puede editar un libretin mientras no esté en PRCS: Controlado en "list"
     * */
    def save_ajax() {

        println("params " + params)
        def documentoEmpresa
        def empresa = Empresa.get(session.empresa.id)
        def fechaFin = new Date().parse("dd-MM-yyyy",params."fechaFin_input")
        def fechaInicio = new Date().parse("dd-MM-yyyy",params."fechaAutorizacion_input")
//        def fechaAutorizacion = new Date().parse("dd-MM-yyyy",params."fechaAutorizacion_input")
        def cn = dbConnectionService.getConnection()
        def st = ''

        def sql = "select fcdtatrz from fcdt where empr__id = ${empresa.id} and fcdttipo = '${params.tipo}' and " +
                "(${params.numeroDesde} between fcdtdsde and fcdthsta or " +
                "${params.numeroHasta} between fcdtdsde and fcdthsta) and fcdt__id <> ${params.id?:0}"
        println "sql: $sql"
        def cruzado = cn.rows(sql.toString())[0]?.fcdtatrz
        println "cruzado: $cruzado"

        if(cruzado){
            render "no_1_El rango de valores de ${params.numeroDesde} a ${params.numeroHasta} ya está contenido en el Libretin con autorización: $cruzado"
            return
        }

        if(fechaInicio >= fechaFin){
            render "no_2_La fecha de autorización es mayor a la fecha de finalización"
            return
        }

        if(params.id){
            documentoEmpresa = DocumentoEmpresa.get(params.id)
            documentoEmpresa.properties = params
        } else {
            documentoEmpresa = new DocumentoEmpresa(params)
            documentoEmpresa.fechaIngreso = new Date()
        }

        documentoEmpresa.fechaAutorizacion = fechaInicio
        documentoEmpresa.fechaInicio = fechaInicio
        documentoEmpresa.fechaFin = fechaFin
        documentoEmpresa.empresa = empresa

        try {
            documentoEmpresa.save(flush: true)
            println "grabó....."
            render "OK_Libretín creado correctamente"
        }catch (e){
            println("error libretin " + e + documentoEmpresa.errors)
            render "no_Error al guardar la información del libretín"
        }

        println "listo..."

/*
        if(fechaAutorizacion >= fechaFin){
            render "no_2_La fecha de autorización es mayor a la fecha de finalización"
        }else{
            if(params.numeroDesde.toInteger() >= params.numeroHasta.toInteger()){
                render "no_2_Los números ingresados en el rango de facturas son incorrectos!"
            }else{
                if(!band){
                    if((libretines.numeroHasta.contains(params.numeroHasta.toInteger()) || libretines.numeroHasta.contains(params.numeroDesde.toInteger())
                            || libretines.numeroDesde.contains(params.numeroDesde.toInteger()) || libretines.numeroDesde.contains(params.numeroHasta.toInteger()))){
                        render "no_2_El número ingresado ya se encuentra en otro libretín de facturas"
                    }else {
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
*/
//        }
    }

    def verificar_ajax () {
        def documentoEmpresa = DocumentoEmpresa.get(params.id)
        def usado = Proceso.findByDocumentoEmpresa(documentoEmpresa)
        println ".....verificar_ajax: $usado"
        render (usado?.size() > 0)
/*
        def r
        if (v.size() > 0) {
            r = true
        } else {
            r = false
        }
        render r
*/
    }

} //fin controller
