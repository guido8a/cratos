package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoCuentaController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [tipoCuentaInstanceList: TipoCuenta.list(params), tipoCuentaInstanceTotal: TipoCuenta.count()]
//    }

    def create() {
        [tipoCuentaInstance: new TipoCuenta(params)]
    }

    def save() {
        def tipoCuentaInstance = new TipoCuenta(params)

        if(params.id) {
            tipoCuentaInstance = TipoCuenta.get(params.id)
            tipoCuentaInstance.properties = params
        }

        if (!tipoCuentaInstance.save(flush: true)) {
            if(params.id) {
                render(view: "edit", model: [tipoCuentaInstance: tipoCuentaInstance])
            } else {
                render(view: "create", model: [tipoCuentaInstance: tipoCuentaInstance])
            }
            return
        }

        if(params.id) {
            flash.message = "TipoCuenta actualizado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        } else {
		    flash.message = "TipoCuenta creado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        }
        redirect(action: "show", id: tipoCuentaInstance.id)
    }

    def show() {
        def tipoCuentaInstance = TipoCuenta.get(params.id)
        if (!tipoCuentaInstance) {
            flash.message = "No se encontró TipoCuenta con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [tipoCuentaInstance: tipoCuentaInstance]
    }

    def edit() {
        def tipoCuentaInstance = TipoCuenta.get(params.id)
        if (!tipoCuentaInstance) {
            flash.message = "No se encontró TipoCuenta con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [tipoCuentaInstance: tipoCuentaInstance]
    }

    def delete() {
        def tipoCuentaInstance = TipoCuenta.get(params.id)
        if (!tipoCuentaInstance) {
			flash.message = "No se encontró TipoCuenta con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoCuentaInstance.delete(flush: true)
			flash.message = "TipoCuenta  con id "+params.id+" eliminado"
            flash.clase = "success"
            flash.ico ="ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = "No se pudo eliminar TipoCuenta con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "show", id: params.id)
        }
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoCuentaInstanceList = TipoCuenta.list(params)
        def tipoCuentaInstanceCount = TipoCuenta.count()
        if (tipoCuentaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoCuentaInstanceList = TipoCuenta.list(params)
        return [tipoCuentaInstanceList: tipoCuentaInstanceList, tipoCuentaInstanceCount: tipoCuentaInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def tipoCuentaInstance = TipoCuenta.get(params.id)
            if (!tipoCuentaInstance) {
                notFound_ajax()
                return
            }
            return [tipoCuentaInstance: tipoCuentaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoCuentaInstance = new TipoCuenta(params)
        if (params.id) {
            tipoCuentaInstance = TipoCuenta.get(params.id)
            if (!tipoCuentaInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoCuentaInstance: tipoCuentaInstance]
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

        params.tipoCuenta = params.tipoCuenta.toUpperCase()
//        params.codigo = params.codigo.toUpperCase()

        //original
        def tipoCuentaInstance = new TipoCuenta()
        if (params.id) {
            tipoCuentaInstance = TipoCuenta.get(params.id)
            tipoCuentaInstance.properties = params
            if (!tipoCuentaInstance) {
                notFound_ajax()
                return
            }
        }else {

            tipoCuentaInstance = new TipoCuenta()
            tipoCuentaInstance.properties = params
//            tipocuentaInstance.estado = '1'
//            tipoCuentaInstance.empresa = session.empresa


        } //update


        if (!tipoCuentaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo de Cuenta."
            msg += renderErrors(bean: tipoCuentaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo de Cuenta."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def tipoCuentaInstance = TipoCuenta.get(params.id)
            if (tipoCuentaInstance) {
                try {
                    tipoCuentaInstance.delete(flush: true)
                    render "OK_Eliminación de Tipo de Cuenta."
                } catch (e) {
                    render "NO_No se pudo eliminar el Tipo de Cuenta"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Tipo de Cuenta."
    } //notFound para ajax
}
