package cratos

import org.springframework.dao.DataIntegrityViolationException

class CentroCostoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        if (!params.sort) {
//            params.sort = "nombre"
//        }
//        def c = CentroCosto.createCriteria()
//        def centroCostoInstanceList = c.list(params) {
//            eq("empresa", Empresa.get(session.empresa.id))
//        }
//        [centroCostoInstanceList: centroCostoInstanceList, centroCostoInstanceTotal: centroCostoInstanceList.totalCount]
//    }

    def create() {
        [centroCostoInstance: new CentroCosto(params)]
    }

    def save() {
        def centroCostoInstance

//        params.empresa.id = session.empresa.id
//        params["empesa.id"] = session.empresa.id
        params.empresa = Empresa.get(session.empresa.id)

        if (params.id) {
            centroCostoInstance = CentroCosto.get(params.id)
            if (!centroCostoInstance) {
                flash.message = "No se encontr&oacute; CentroCosto a modificar"
                render "NO"
                return
            }
            centroCostoInstance.properties = params
        } else {
            centroCostoInstance = new CentroCosto(params)
        }
        if (!centroCostoInstance.save(flush: true)) {
            render "NO"
            println centroCostoInstance.errors
            flash.message = "Ha ocurrido un error al guardar CentroCosto"
            return
        }

        flash.message = "CentroCosto guardado exitosamente"
//    redirect(action: "show", id: centroCostoInstance.id)
        render "OK"
    }

    def show() {
        def centroCostoInstance = CentroCosto.get(params.id)
        if (!centroCostoInstance) {
            flash.message = "No se encontr&oacute; CentroCosto a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [centroCostoInstance: centroCostoInstance]
    }

    def edit() {
        def centroCostoInstance = CentroCosto.get(params.id)
        if (!centroCostoInstance) {
            flash.message = "No se encontr&oacute; CentroCosto a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [centroCostoInstance: centroCostoInstance]
    }

    def delete() {
        def centroCostoInstance = CentroCosto.get(params.id)
        if (!centroCostoInstance) {
            flash.message = "No se encontr&oacute; CentroCosto a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            centroCostoInstance.delete(flush: true)
            flash.message = "CentroCosto eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar CentroCosto"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def centroCostoInstanceList = CentroCosto.list(params)
        def centroCostoInstanceCount = CentroCosto.count()
        if (centroCostoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        centroCostoInstanceList = CentroCosto.list(params)
        return [centroCostoInstanceList: centroCostoInstanceList, centroCostoInstanceCount: centroCostoInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def centroCostoInstance = CentroCosto.get(params.id)
            if (!centroCostoInstance) {
                notFound_ajax()
                return
            }
            return [centroCostoInstance: centroCostoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def centroCostoInstance = new CentroCosto(params)
        if (params.id) {
            centroCostoInstance = CentroCosto.get(params.id)
            if (!centroCostoInstance) {
                notFound_ajax()
                return
            }
        }
        return [centroCostoInstance: centroCostoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {

//        println("params:" + params)

//        params.each { k, v ->
//            if (v != "date.struct" && v instanceof java.lang.String) {
//                params[k] = v.toUpperCase()
//            }
//        }

        //nuevo

        def persona

//        params.descripcion = params.descripcion.toUpperCase()
//        params.codigo = params.codigo.toUpperCase()
          params.empresa = session.empresa


        //original
        def centroCostoInstance = new CentroCosto()
        if (params.id) {
            centroCostoInstance = CentroCosto.get(params.id)
            centroCostoInstance.properties = params
            if (!centroCostoInstance) {
                notFound_ajax()
                return
            }
        }else {

            centroCostoInstance = new CentroCosto()
            centroCostoInstance.properties = params
//            centrocostoInstance.estado = '1'
//            centroCostoInstance.empresa = session.empresa


        } //update


        if (!centroCostoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Centro de Costos."
            msg += renderErrors(bean: centroCostoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Centro de Costos."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def centroCostoInstance = CentroCosto.get(params.id)
            if (centroCostoInstance) {
                try {
                    centroCostoInstance.delete(flush: true)
                    render "OK_Eliminación de Centro de Costos."
                } catch (e) {
                    render "NO_No se pudo eliminar el Centro de Costos"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Centro de Costos."
    } //notFound para ajax


}
