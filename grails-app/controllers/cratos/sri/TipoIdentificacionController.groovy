package cratos.sri

import org.springframework.dao.DataIntegrityViolationException

class TipoIdentificacionController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        def tipoIdentificacionInstanceCount = TipoIdentificacion.list().size()
        [tipoIdentificacionInstanceList: TipoIdentificacion.list(params), params: params, tipoIdentificacionInstanceCount: tipoIdentificacionInstanceCount]
    } //list

    def form_ajax() {
        def tipoIdentificacionInstance = new TipoIdentificacion(params)
        if(params.id) {
            tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
            if(!tipoIdentificacionInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Tipo Identificacion con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoIdentificacionInstance: tipoIdentificacionInstance]
    } //form_ajax

    def save() {
        println("params " + params)
        def tipo
        if(params.id){
            tipo = TipoIdentificacion.get(params.id)
        }else{
            tipo = new TipoIdentificacion()
        }
        tipo.codigo = params.codigo
        tipo.descripcion = params.descripcion
        tipo.codigoSri = params.codigoSri

        try{
            tipo.save(flush: true)
            render "OK"
        }catch (e){
            render "no"
            println("Error al guardar el Tipo de Identificacion " + e)
        }

    } //save

    def show_ajax() {
        def tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
        if (!tipoIdentificacionInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Tipo Identificacion con id " + params.id
            redirect(action: "list")
            return
        }
        [tipoIdentificacionInstance: tipoIdentificacionInstance]
    } //show

    def delete() {
        def tipoIdentificacionInstance = TipoIdentificacion.get(params.id)

        try {
            tipoIdentificacionInstance.delete(flush: true)
            render "OK"
        }
        catch (DataIntegrityViolationException e) {
            render "no"
            println("Error al eliminar el tipo de identificación " + e)
        }
    } //delete
} //fin controller
