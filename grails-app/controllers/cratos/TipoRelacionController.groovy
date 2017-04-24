package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoRelacionController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [tipoRelacionInstanceList: TipoRelacion.list(params), tipoRelacionInstanceTotal: TipoRelacion.count()]
//    }

    def create() {
        [tipoRelacionInstance: new TipoRelacion(params)]
    }

    def save() {
        def tipoRelacionInstance
        if (params.id) {
            tipoRelacionInstance = TipoRelacion.get(params.id)
            if (!tipoRelacionInstance) {
                flash.message = "No se encontr&oacute; TipoRelacion a modificar"
                render "NO"
                return
            }
            tipoRelacionInstance.properties = params
        } else {
            tipoRelacionInstance = new TipoRelacion(params)
        }
        if (!tipoRelacionInstance.save(flush: true)) {
            render "NO"
            println tipoRelacionInstance.errors
            flash.message = "Ha ocurrido un error al guardar TipoRelacion"
            return
        }

        flash.message = "TipoRelacion guardado exitosamente"
//    redirect(action: "show", id: tipoRelacionInstance.id)
        render "OK"
    }

    def show() {
        def tipoRelacionInstance = TipoRelacion.get(params.id)
        if (!tipoRelacionInstance) {
            flash.message = "No se encontr&oacute; TipoRelacion a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoRelacionInstance: tipoRelacionInstance]
    }

    def edit() {
        def tipoRelacionInstance = TipoRelacion.get(params.id)
        if (!tipoRelacionInstance) {
            flash.message = "No se encontr&oacute; TipoRelacion a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoRelacionInstance: tipoRelacionInstance]
    }

    def delete() {
        def tipoRelacionInstance = TipoRelacion.get(params.id)
        if (!tipoRelacionInstance) {
            flash.message = "No se encontr&oacute; TipoRelacion a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            tipoRelacionInstance.delete(flush: true)
            flash.message = "TipoRelacion eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar TipoRelacion"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoRelacionInstanceList = TipoRelacion.list(params)
        def tipoRelacionInstanceCount = TipoRelacion.count()
        if (tipoRelacionInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoRelacionInstanceList = TipoRelacion.list(params)
        return [tipoRelacionInstanceList: tipoRelacionInstanceList, tipoRelacionInstanceCount: tipoRelacionInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def tipoRelacionInstance = TipoRelacion.get(params.id)
            if (!tipoRelacionInstance) {
                notFound_ajax()
                return
            }
            return [tipoRelacionInstance: tipoRelacionInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoRelacionInstance = new TipoRelacion(params)
        if (params.id) {
            tipoRelacionInstance = TipoRelacion.get(params.id)
            if (!tipoRelacionInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoRelacionInstance: tipoRelacionInstance]
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
        def tipoRelacionInstance = new TipoRelacion()
        if (params.id) {
            tipoRelacionInstance = TipoRelacion.get(params.id)
            tipoRelacionInstance.properties = params
            if (!tipoRelacionInstance) {
                notFound_ajax()
                return
            }
        }else {

            tipoRelacionInstance = new TipoRelacion()
            tipoRelacionInstance.properties = params
//            tiporelacionInstance.estado = '1'
//            tipoRelacionInstance.empresa = session.empresa


        } //update


        if (!tipoRelacionInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo de Relación."
            msg += renderErrors(bean: tipoRelacionInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo de Relación."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def tipoRelacionInstance = TipoRelacion.get(params.id)
            if (tipoRelacionInstance) {
                try {
                    tipoRelacionInstance.delete(flush: true)
                    render "OK_Eliminación de Tipo de Relación."
                } catch (e) {
                    render "NO_No se pudo eliminar el Tipo de Relación"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Tipo de Relación."
    } //notFound para ajax


}
