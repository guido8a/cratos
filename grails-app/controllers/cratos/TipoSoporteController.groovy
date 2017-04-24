package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoSoporteController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [tipoSoporteInstanceList: TipoSoporte.list(params), tipoSoporteInstanceTotal: TipoSoporte.count()]
//    }

    def create() {
        [tipoSoporteInstance: new TipoSoporte(params)]
    }

    def save() {
        def tipoSoporteInstance
        if (params.id) {
            tipoSoporteInstance = TipoSoporte.get(params.id)
            if (!tipoSoporteInstance) {
                flash.message = "No se encontr&oacute; TipoSoporte a modificar"
                render "NO"
                return
            }
            tipoSoporteInstance.properties = params
        } else {
            tipoSoporteInstance = new TipoSoporte(params)
        }
        if (!tipoSoporteInstance.save(flush: true)) {
            render "NO"
            println tipoSoporteInstance.errors
            flash.message = "Ha ocurrido un error al guardar TipoSoporte"
            return
        }

        flash.message = "TipoSoporte guardado exitosamente"
//    redirect(action: "show", id: tipoSoporteInstance.id)
        render "OK"
    }

    def show() {
        def tipoSoporteInstance = TipoSoporte.get(params.id)
        if (!tipoSoporteInstance) {
            flash.message = "No se encontr&oacute; TipoSoporte a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoSoporteInstance: tipoSoporteInstance]
    }

    def edit() {
        def tipoSoporteInstance = TipoSoporte.get(params.id)
        if (!tipoSoporteInstance) {
            flash.message = "No se encontr&oacute; TipoSoporte a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoSoporteInstance: tipoSoporteInstance]
    }

    def delete() {
        def tipoSoporteInstance = TipoSoporte.get(params.id)
        if (!tipoSoporteInstance) {
            flash.message = "No se encontr&oacute; TipoSoporte a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            tipoSoporteInstance.delete(flush: true)
            flash.message = "TipoSoporte eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar TipoSoporte"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoSoporteInstanceList = TipoSoporte.list(params)
        def tipoSoporteInstanceCount = TipoSoporte.count()
        if (tipoSoporteInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoSoporteInstanceList = TipoSoporte.list(params)
        return [tipoSoporteInstanceList: tipoSoporteInstanceList, tipoSoporteInstanceCount: tipoSoporteInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def tipoSoporteInstance = TipoSoporte.get(params.id)
            if (!tipoSoporteInstance) {
                notFound_ajax()
                return
            }
            return [tipoSoporteInstance: tipoSoporteInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoSoporteInstance = new TipoSoporte(params)
        if (params.id) {
            tipoSoporteInstance = TipoSoporte.get(params.id)
            if (!tipoSoporteInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoSoporteInstance: tipoSoporteInstance]
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

        params.descripcion = params.descripcion.toUpperCase()
        params.codigo = params.codigo.toUpperCase()


        //original
        def tipoSoporteInstance = new TipoSoporte()
        if (params.id) {
            tipoSoporteInstance = TipoSoporte.get(params.id)
            tipoSoporteInstance.properties = params
            if (!tipoSoporteInstance) {
                notFound_ajax()
                return
            }
        }else {

            tipoSoporteInstance = new TipoSoporte()
            tipoSoporteInstance.properties = params
//            tiposoporteInstance.estado = '1'
//            tipoSoporteInstance.empresa = session.empresa


        } //update


        if (!tipoSoporteInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo de Sustento."
            msg += renderErrors(bean: tipoSoporteInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo de Sustento."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def tipoSoporteInstance = TipoSoporte.get(params.id)
            if (tipoSoporteInstance) {
                try {
                    tipoSoporteInstance.delete(flush: true)
                    render "OK_Eliminación de Tipo de Sustento."
                } catch (e) {
                    render "NO_No se pudo eliminar el Tipo de Sustento"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Tipo de Sustento."
    } //notFound para ajax
    
}
