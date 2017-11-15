package cratos.inventario

import cratos.Empresa
import org.springframework.dao.DataIntegrityViolationException

class UnidadController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def create() {
        [unidadInstance: new Unidad(params)]
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        def empresa = Empresa.get(session.empresa.id)
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
//        def unidadInstanceList = Unidad.list(params)
        def unidadInstanceList = Unidad.findAllByEmpresa(empresa)
        def unidadInstanceCount = Unidad.count()
        if (unidadInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
//        unidadInstanceList = Unidad.list(params)
        unidadInstanceList = Unidad.findAllByEmpresa(empresa)
        return [unidadInstanceList: unidadInstanceList, unidadInstanceCount: unidadInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def unidadInstance = Unidad.get(params.id)
            if (!unidadInstance) {
                notFound_ajax()
                return
            }
            return [unidadInstance: unidadInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def unidadInstance = new Unidad(params)
        if (params.id) {
            unidadInstance = Unidad.get(params.id)
            if (!unidadInstance) {
                notFound_ajax()
                return
            }
        }
        return [unidadInstance: unidadInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {

        println("params:" + params)
//        params.descripcion = params.descripcion.toUpperCase()
        params.codigo = params.codigo.toUpperCase()

        def empresa = Empresa.get(session.empresa.id)
        def unidad

        if(params.id){
            unidad = Unidad.get(params.id)
        }else{
            unidad = new Unidad()
        }

        unidad.codigo = params.codigo
        unidad.descripcion = params.descripcion
        unidad.empresa = empresa

        try{
            unidad.save(flush: true)
            render "OK_${params.id ? 'Actualización' : 'Creación'} de Unidad."
        }catch (e){
            println("error al crear unidad " + e + unidad.errors)
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Unidad."
            render msg
        }

    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def unidadInstance = Unidad.get(params.id)
            if (unidadInstance) {
                try {
                    unidadInstance.delete(flush: true)
                    render "OK_Unidad eliminada correctamente."
                } catch (e) {
                    render "NO_No se pudo eliminar la Unidad"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Unidad."
    } //notFound para ajax




}
