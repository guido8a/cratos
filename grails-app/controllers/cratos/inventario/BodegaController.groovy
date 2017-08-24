package cratos.inventario

import cratos.Empresa
import org.springframework.dao.DataIntegrityViolationException

class BodegaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        def empresa = Empresa.get(session.empresa.id)
        def bodegaInstanceCount = Bodega.findAllByEmpresa(empresa).size()
        def bodegas = Bodega.findAllByEmpresa(empresa)
        [bodegaInstanceList: bodegas, params: params, bodegaInstanceCount: bodegaInstanceCount]
    } //list

    def form_ajax() {
        def bodegaInstance = new Bodega(params)
        if(params.id) {
            bodegaInstance = Bodega.get(params.id)
            if(!bodegaInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Bodega con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [bodegaInstance: bodegaInstance]
    } //form_ajax

    def save() {
        def bodega
        def empresa = Empresa.get(session.empresa.id)
        if(params.id){
            bodega = Bodega.get(params.id)
        }else{
            bodega = new Bodega()
            bodega.empresa = empresa
        }
        
        bodega.descripcion = params.descripcion
        bodega.codigo = params.codigo.toUpperCase()
        
        try{
            bodega.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("Error al guardar la bodega " + e)
        }

    } //save

    def show_ajax() {
        def bodegaInstance = Bodega.get(params.id)
        if (!bodegaInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Bodega con id " + params.id
            redirect(action: "list")
            return
        }
        [bodegaInstance: bodegaInstance]
    } //show

    def delete() {
        def bodegaInstance = Bodega.get(params.id)

        try{
            bodegaInstance.delete(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("Error al borrar la bodega " + e)
        }

    } //delete
} //fin controller
