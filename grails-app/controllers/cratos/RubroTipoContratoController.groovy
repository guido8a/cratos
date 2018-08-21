package cratos

import org.springframework.dao.DataIntegrityViolationException

class RubroTipoContratoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.sort = 'tipoContrato'
        [rubroTipoContratoInstanceList: RubroTipoContrato.list(params), params: params,
         rubroTipoContratoInstanceCount: RubroTipoContrato.count() ]
    } //list

    def form_ajax() {
        def rubroTipoContratoInstance = new RubroTipoContrato(params)
        def empresa = Empresa.get(session.empresa.id)
        def tipoContrato = TipoContrato.findAllByEmpresa(empresa)
        if(params.id) {
            rubroTipoContratoInstance = RubroTipoContrato.get(params.id)
            if(!rubroTipoContratoInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Rubro Tipo Contrato con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [rubroTipoContratoInstance: rubroTipoContratoInstance, tipoContrato: tipoContrato]
    } //form_ajax

    def save() {

        def errores = ''
        def texto = ''
        def rubroTipoContratoInstance

        if(params.id){
            rubroTipoContratoInstance = RubroTipoContrato.get(params.id)
        }else{
            rubroTipoContratoInstance = new RubroTipoContrato()
        }

        rubroTipoContratoInstance.properties = params

        try{
            rubroTipoContratoInstance.save(flush: true)
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
        def rubroTipoContratoInstance = RubroTipoContrato.get(params.id)
        if (!rubroTipoContratoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Rubro Tipo Contrato con id " + params.id
            redirect(action: "list")
            return
        }
        [rubroTipoContratoInstance: rubroTipoContratoInstance]
    } //show

    def delete() {
        def rubroTipoContratoInstance = RubroTipoContrato.get(params.id)
        if (!rubroTipoContratoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Rubro Tipo Contrato con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            rubroTipoContratoInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message =  "Se ha eliminado correctamente Rubro Tipo Contrato " + rubroTipoContratoInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message =  "No se pudo eliminar Rubro Tipo Contrato " + (rubroTipoContratoInstance.id ? rubroTipoContratoInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
