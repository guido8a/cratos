package cratos.sri

import org.springframework.dao.DataIntegrityViolationException

class TipoTransaccionController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        def tipoTransaccionInstanceCount = TipoTransaccion.list().size()
        [tipoTransaccionInstanceList: TipoTransaccion.list(params), params: params, tipoTransaccionInstanceCount: tipoTransaccionInstanceCount]
    } //list

    def form_ajax() {
        def tipoTransaccionInstance = new TipoTransaccion(params)
        if(params.id) {
            tipoTransaccionInstance = TipoTransaccion.get(params.id)
            if(!tipoTransaccionInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Tipo Transaccion con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoTransaccionInstance: tipoTransaccionInstance]
    } //form_ajax

    def save() {
        println("params " + params)
        def tipo
        if(params.id){
            tipo = TipoTransaccion.get(params.id)
        }else{
            tipo = new TipoTransaccion()
        }
        tipo.codigo = params.codigo
        tipo.descripcion = params.descripcion

        try{
            tipo.save(flush: true)
            render "OK"
        }catch (e){
            render "no"
            println("Error al guardar el Tipo de Transacción " + e)
        }
    } //save

    def show_ajax() {
        def tipoTransaccionInstance = TipoTransaccion.get(params.id)
        if (!tipoTransaccionInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Tipo Transaccion con id " + params.id
            redirect(action: "list")
            return
        }
        [tipoTransaccionInstance: tipoTransaccionInstance]
    } //show

    def delete() {
        def tipoTransaccionInstance = TipoTransaccion.get(params.id)

        try {
            tipoTransaccionInstance.delete(flush: true)
            render "OK"
        }
        catch (DataIntegrityViolationException e) {
            render "no"
            println("Error al eliminar el tipo de transacción " + e)
        }
    } //delete
} //fin controller
