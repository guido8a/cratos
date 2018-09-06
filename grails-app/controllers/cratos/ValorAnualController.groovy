package cratos

import org.springframework.dao.DataIntegrityViolationException

class ValorAnualController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [valorAnualInstanceList: ValorAnual.list(params).sort{it.porcentaje}, params: params, valorAnualInstanceCount: ValorAnual.count()]
    } //list

    def form_ajax() {
        def valorAnualInstance = new ValorAnual(params)
        if(params.id) {
            valorAnualInstance = ValorAnual.get(params.id)
            if(!valorAnualInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Valor Anual con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [valorAnualInstance: valorAnualInstance]
    } //form_ajax

    def save() {

        def vanual
        def errores = ''
        def texto = ''

        if(params.id){
            vanual = ValorAnual.get(params.id)
            texto = "Valor Anual actualizado correctamente"
        }else{
            vanual = new ValorAnual()
            texto = "Valor Anual creado correctamente"
        }

        vanual.anio = Anio.get(params."anio.id")
        vanual.excesoHasta = params.excesoHasta.toInteger()
        vanual.fraccionBasica = params.fraccionBasica.toInteger()
        vanual.impuesto = params.impuesto.toDouble()
        vanual.porcentaje = params.porcentaje.toInteger()

        try{
            vanual.save(flush: true)
        }catch (e){
            errores += e
        }

        if(errores == ''){
            render "OK_" + texto
        }else{
            render "NO"
        }

    } //save

    def show_ajax() {
        def valorAnualInstance = ValorAnual.get(params.id)
        if (!valorAnualInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Valor Anual con id " + params.id
            redirect(action: "list")
            return
        }
        [valorAnualInstance: valorAnualInstance]
    } //show

    def delete() {
        def valorAnualInstance = ValorAnual.get(params.id)
        def texto = ''

        try{
            valorAnualInstance.delete(flush: true)
            texto = "OK"
        }catch (e){
            texto = "NO"
        }

        render texto
    } //delete
} //fin controller
