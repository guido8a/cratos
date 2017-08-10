package cratos.sri

import cratos.TipoComprobante
import org.springframework.dao.DataIntegrityViolationException

class TipoComprobanteSriController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        def tipoComprobanteSriInstanceCount = TipoComprobanteSri.list().size()
        [tipoComprobanteSriInstanceList: TipoComprobanteSri.list(params).sort{it.codigo}, params: params, tipoComprobanteSriInstanceCount: tipoComprobanteSriInstanceCount]
    } //list

    def form_ajax() {
        def tipoComprobanteSriInstance = new TipoComprobanteSri(params)
        if(params.id) {
            tipoComprobanteSriInstance = TipoComprobanteSri.get(params.id)
            if(!tipoComprobanteSriInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Tipo Comprobante Sri con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoComprobanteSriInstance: tipoComprobanteSriInstance]
    } //form_ajax

    def save() {
        println("params " + params)
        def tipo
        if(params.id){
            tipo = TipoComprobanteSri.get(params.id)
        }else{
            tipo = new TipoComprobanteSri()
        }
        tipo.codigo = params.codigo
        tipo.descripcion = params.descripcion

        try{
            tipo.save(flush: true)
            render "OK"
        }catch (e){
            render "no"
            println("Error al guardar el Tipo de comprobante sri " + e)
        }
    } //save

    def show_ajax() {
        def tipoComprobanteSriInstance = TipoComprobanteSri.get(params.id)
        if (!tipoComprobanteSriInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Tipo Comprobante Sri con id " + params.id
            redirect(action: "list")
            return
        }
        [tipoComprobanteSriInstance: tipoComprobanteSriInstance]
    } //show

    def delete() {
        def tipoComprobanteSriInstance = TipoComprobanteSri.get(params.id)

        try {
            tipoComprobanteSriInstance.delete(flush: true)
            render "OK"
        }
        catch (DataIntegrityViolationException e) {
            render "no"
            println("Error al eliminar el tipo de comprobante SRI " + e)
        }
    } //delete
} //fin controller
