package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoDocumentoPagoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        def tipoDocumentoPagoInstanceList = TipoDocumentoPago.list(params).sort{it.descripcion}
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

//        println("params " + params)
        def tipo
        if(params.id){
            tipo = TipoDocumentoPago.get(params.id)
        }else{
            tipo = new TipoDocumentoPago()
        }

        tipo.descripcion = params.descripcion

        try{
            tipo.save(flush: true)
            render "OK"
        }catch (e){
            println("error al guardar el tipo de documento pago " + e)
            render "NO"
        }


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

        try {
            tipoDocumentoPagoInstance.delete(flush: true)
            render "ok"
        }
        catch (DataIntegrityViolationException e) {
            println("error al borrar el tipo de pago")
            render "no"
        }
    } //delete
} //fin controller
