package cratos.sri

import org.springframework.dao.DataIntegrityViolationException

class SustentoTributarioController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        def sustentoTributarioInstanceCount = SustentoTributario.list().size()
        [sustentoTributarioInstanceList: SustentoTributario.list(params), params: params, sustentoTributarioInstanceCount : sustentoTributarioInstanceCount]
    } //list

    def form_ajax() {
        def sustentoTributarioInstance = new SustentoTributario(params)
        if(params.id) {
            sustentoTributarioInstance = SustentoTributario.get(params.id)
            if(!sustentoTributarioInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Sustento Tributario con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [sustentoTributarioInstance: sustentoTributarioInstance]
    } //form_ajax

    def save() {
        def sustentoTributarioInstance

        println("params " + params)
        def tipo
        if(params.id){
            tipo = SustentoTributario.get(params.id)
        }else{
            tipo = new SustentoTributario()
        }
        tipo.codigo = params.codigo.toUpperCase()
        tipo.descripcion = params.descripcion

        try{
            tipo.save(flush: true)
            render "OK"
        }catch (e){
            render "no"
            println("Error al guardar el Tipo de Sustento Tributario " + e)
        }


    } //save

    def show_ajax() {
        def sustentoTributarioInstance = SustentoTributario.get(params.id)
        if (!sustentoTributarioInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Sustento Tributario con id " + params.id
            redirect(action: "list")
            return
        }
        [sustentoTributarioInstance: sustentoTributarioInstance]
    } //show

    def delete() {
        def sustentoTributarioInstance = SustentoTributario.get(params.id)

        try {
            sustentoTributarioInstance.delete(flush: true)
            render "OK"
        }
        catch (DataIntegrityViolationException e) {
            render "no"
            println("Error al eliminar el tipo de sustento tributario " + e)
        }
    } //delete
} //fin controller
