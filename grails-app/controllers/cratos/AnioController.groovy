package cratos

import org.springframework.dao.DataIntegrityViolationException

class AnioController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [anioInstanceList: Anio.list(params), params: params, anioInstanceCount: Anio.count()]
    } //list

    def form_ajax() {
        def anioInstance = new Anio(params)
        if(params.id) {
            anioInstance = Anio.get(params.id)
            if(!anioInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Anio con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [anioInstance: anioInstance]
    } //form_ajax

    def save() {
        println("params " + params)
        def anio
        def texto = ''
        if(params.id){
            anio = Anio.get(params.id)
            texto = "Año actualizado correctamente"
        }else{
            anio = new Anio()
            texto = "Año creado correctamente"
        }
        anio.anio = params.anio
        anio.sueldoBasico = params.sueldoBasico.toDouble()

        if(!anio.save(flush: true)){
            render "NO_Error al guardar el año"
        }else{
            render "OK_" + texto
        }

    } //save

    def show_ajax() {
        def anioInstance = Anio.get(params.id)
        if (!anioInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Anio con id " + params.id
            redirect(action: "list")
            return
        }
        [anioInstance: anioInstance]
    } //show

    def delete() {
        def anioInstance = Anio.get(params.id)
        def texto = ''

        try{
            anioInstance.delete(flush: true)
            texto = "OK"
        }catch (e){
            texto = "NO"
        }

        render texto
    } //delete
} //fin controller
