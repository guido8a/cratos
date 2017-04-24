package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoTarjetaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
//
//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [tipoTarjetaInstanceList: TipoTarjeta.list(params), tipoTarjetaInstanceTotal: TipoTarjeta.count()]
//    }

    def create() {
        [tipoTarjetaInstance: new TipoTarjeta(params)]
    }

    def save() {
        def tipoTarjetaInstance
        if (params.id) {
            tipoTarjetaInstance = TipoTarjeta.get(params.id)
            if (!tipoTarjetaInstance) {
                flash.message = "No se encontr&oacute; TipoTarjeta a modificar"
                render "NO"
                return
            }
            tipoTarjetaInstance.properties = params
        } else {
            tipoTarjetaInstance = new TipoTarjeta(params)
        }
        if (!tipoTarjetaInstance.save(flush: true)) {
            render "NO"
            println tipoTarjetaInstance.errors
            flash.message = "Ha ocurrido un error al guardar TipoTarjeta"
            return
        }

        flash.message = "TipoTarjeta guardado exitosamente"
//    redirect(action: "show", id: tipoTarjetaInstance.id)
        render "OK"
    }

    def show() {
        def tipoTarjetaInstance = TipoTarjeta.get(params.id)
        if (!tipoTarjetaInstance) {
            flash.message = "No se encontr&oacute; TipoTarjeta a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoTarjetaInstance: tipoTarjetaInstance]
    }

    def edit() {
        def tipoTarjetaInstance = TipoTarjeta.get(params.id)
        if (!tipoTarjetaInstance) {
            flash.message = "No se encontr&oacute; TipoTarjeta a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoTarjetaInstance: tipoTarjetaInstance]
    }

    def delete() {
        def tipoTarjetaInstance = TipoTarjeta.get(params.id)
        if (!tipoTarjetaInstance) {
            flash.message = "No se encontr&oacute; TipoTarjeta a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            tipoTarjetaInstance.delete(flush: true)
            flash.message = "TipoTarjeta eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar TipoTarjeta"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoTarjetaInstanceList = TipoTarjeta.list(params)
        def tipoTarjetaInstanceCount = TipoTarjeta.count()
        if (tipoTarjetaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoTarjetaInstanceList = TipoTarjeta.list(params)
        return [tipoTarjetaInstanceList: tipoTarjetaInstanceList, tipoTarjetaInstanceCount: tipoTarjetaInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def tipoTarjetaInstance = TipoTarjeta.get(params.id)
            if (!tipoTarjetaInstance) {
                notFound_ajax()
                return
            }
            return [tipoTarjetaInstance: tipoTarjetaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoTarjetaInstance = new TipoTarjeta(params)
        if (params.id) {
            tipoTarjetaInstance = TipoTarjeta.get(params.id)
            if (!tipoTarjetaInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoTarjetaInstance: tipoTarjetaInstance]
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
//        params.codigo = params.codigo.toUpperCase()


        //original
        def tipoTarjetaInstance = new TipoTarjeta()
        if (params.id) {
            tipoTarjetaInstance = TipoTarjeta.get(params.id)
            tipoTarjetaInstance.properties = params
            if (!tipoTarjetaInstance) {
                notFound_ajax()
                return
            }
        }else {

            tipoTarjetaInstance = new TipoTarjeta()
            tipoTarjetaInstance.properties = params
//            tipotarjetaInstance.estado = '1'
//            tipoTarjetaInstance.empresa = session.empresa


        } //update


        if (!tipoTarjetaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo de Tarjeta."
            msg += renderErrors(bean: tipoTarjetaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo de Empresa."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def tipoTarjetaInstance = TipoTarjeta.get(params.id)
            if (tipoTarjetaInstance) {
                try {
                    tipoTarjetaInstance.delete(flush: true)
                    render "OK_Eliminación de Tipo de Tarjeta."
                } catch (e) {
                    render "NO_No se pudo eliminar el Tipo de Tarjeta"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Tipo de Tarjeta."
    } //notFound para ajax



}
