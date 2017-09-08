package cratos

import org.springframework.dao.DataIntegrityViolationException

class CantonController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [cantonInstanceList: Canton.list(params).sort{it.nombre}, params: params]
    } //list

    def form_ajax() {
        def cantonInstance = new Canton(params)
        if(params.id) {
            cantonInstance = Canton.get(params.id)
            if(!cantonInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Canton con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [cantonInstance: cantonInstance]
    } //form_ajax

    def save() {
        def cantonInstance
        if(params.id){
            cantonInstance = Canton.get(params.id)
        }else{
            cantonInstance = new Canton()
        }

        cantonInstance.nombre = params.nombre

        try{
            cantonInstance.save(flush: true)
            render "ok"
        }catch (e){
            println("Error al guardar el cantón" + e)
            render "no"
        }

    } //save

    def show_ajax() {
        def cantonInstance = Canton.get(params.id)
        if (!cantonInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Canton con id " + params.id
            redirect(action: "list")
            return
        }
        [cantonInstance: cantonInstance]
    } //show

    def delete() {
        def canton = Canton.get(params.id)

        try{
            canton.delete(flush: true)
            render "ok"
        }catch (e){
            println("error al borrar canton " + e )
            render "no"
        }


    } //delete
} //fin controller
