package cratos

import cratos.sri.TipoCmprSustento
import org.springframework.dao.DataIntegrityViolationException

class ReembolsoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [reembolsoInstanceList: Reembolso.list(params), params: params]
    } //list

    def form_ajax() {
        def reembolsoInstance = new Reembolso(params)
        if(params.id) {
            reembolsoInstance = Reembolso.get(params.id)
            if(!reembolsoInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Reembolso con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [reembolsoInstance: reembolsoInstance]
    } //form_ajax

    def save() {
        def reembolsoInstance
        if(params.id) {
            reembolsoInstance = Reembolso.get(params.id)
            if(!reembolsoInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Reembolso con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            reembolsoInstance.properties = params
        }//es edit
        else {
            reembolsoInstance = new Reembolso(params)
        } //es create
        if (!reembolsoInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Reembolso " + (reembolsoInstance.id ? reembolsoInstance.id : "") + "</h4>"

            str += "<ul>"
            reembolsoInstance.errors.allErrors.each { err ->
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
            flash.message = "Se ha actualizado correctamente Reembolso " + reembolsoInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Reembolso " + reembolsoInstance.id
        }
        redirect(action: 'list')
    } //save

    def show_ajax() {
        def reembolsoInstance = Reembolso.get(params.id)
        if (!reembolsoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Reembolso con id " + params.id
            redirect(action: "list")
            return
        }
        [reembolsoInstance: reembolsoInstance]
    } //show

    def delete() {
        def reembolsoInstance = Reembolso.get(params.id)
        if (!reembolsoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Reembolso con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            reembolsoInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message =  "Se ha eliminado correctamente Reembolso " + reembolsoInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message =  "No se pudo eliminar Reembolso " + (reembolsoInstance.id ? reembolsoInstance.id : "")
            redirect(action: "list")
        }
    } //delete




    def guardarReembolso_ajax () {
        println("params gr " + params)
        def reembolso
        def proceso = Proceso.get(params.proceso)
        def proveedor = Proveedor.get(params.proveedor)
        def comprobante = TipoCmprSustento.get(params.comprobante)
        def fechaRegistro = new Date().parse("dd-MM-yyyy", params.fecha)
        if(params.id){
            reembolso = Reembolso.get(params.id)
        }else{
            reembolso = new Reembolso()
            reembolso.proceso = proceso
        }

        reembolso.proveedor = proveedor
        reembolso.tipoCmprSustento = comprobante
        reembolso.reembolsoEstb = params.establecimiento
        reembolso.reembolsoEmsn = params.emision
        reembolso.reembolsoSecuencial = params.secuencial
        reembolso.autorizacion = params.autorizacion
        reembolso.baseImponibleIva = params.baseImponibleIva.toDouble()
        reembolso.baseImponibleIva0 = params.baseImponibleIva0.toDouble()
        reembolso.baseImponibleNoIva = params.noAplicaIva.toDouble()
        reembolso.excentoIva = params.excentoIva.toDouble()
        reembolso.ivaGenerado = params.ivaGenerado.toDouble()
        reembolso.iceGenerado = params.iceGenerado.toDouble()
        reembolso.fecha = fechaRegistro
        reembolso.valor = params.baseImponibleIva.toDouble() + params.baseImponibleIva0.toDouble() +
                params.noAplicaIva.toDouble() + params.excentoIva.toDouble() +
                params.ivaGenerado.toDouble() + params.iceGenerado.toDouble()

        println "...antes de grabar ${reembolso}"
        try{
            reembolso.save(flush: true)
            render "ok"
        }catch (e)
        {
            render "no"
            println("Error al guardar el reembolso " + e)
        }
    }

    def borrarReembolso_ajax () {

        def reembolso = Reembolso.get(params.id)

        try{
            reembolso.delete(flush: true)
            render "ok"
        }catch (e){
            println("error al borrar el reembolso")
            render "no"
        }



    }




} //fin controller
