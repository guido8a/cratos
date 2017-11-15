package cratos.inventario

import cratos.Empresa
import org.springframework.dao.DataIntegrityViolationException

class MarcaController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }


    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
//        def marcaInstanceList = Marca.list(params)
        def empresa = Empresa.get(session.empresa.id)
        def marcaInstanceList = Marca.findAllByEmpresa(empresa)
        def marcaInstanceCount = Marca.count()
        if (marcaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
//        marcaInstanceList = Marca.list(params)
        marcaInstanceList = Marca.findAllByEmpresa(empresa)
        return [marcaInstanceList: marcaInstanceList, marcaInstanceCount: marcaInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def marcaInstance = Marca.get(params.id)
            if (!marcaInstance) {
                notFound_ajax()
                return
            }
            return [marcaInstance: marcaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def marcaInstance = new Marca(params)
        if (params.id) {
            marcaInstance = Marca.get(params.id)
            if (!marcaInstance) {
                notFound_ajax()
                return
            }
        }
        return [marcaInstance: marcaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {

//        println("params:" + params)
        def empresa = Empresa.get(session.empresa.id)
        params.descripcion = params.descripcion.toUpperCase()
        def marca

        if(params.id){
            marca = Marca.get(params.id)
        }else{
            marca = new Marca()
            marca.empresa = empresa
        }

        marca.descripcion = params.descripcion

        try{
            marca.save(flush: true)
            render "OK_${params.id ? 'Actualización' : 'Creación'} de Marca."
        }catch (e){
            println("error al guardar la marca " + e)
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Marca."
            render msg
        }
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def marcaInstance = Marca.get(params.id)
            if (marcaInstance) {
                try {
                    marcaInstance.delete(flush: true)
                    render "OK_Marca eliminada correctamente."
                } catch (e) {
                    render "NO_No se pudo eliminar la Marca"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Marca."
    } //notFound para ajax


}

