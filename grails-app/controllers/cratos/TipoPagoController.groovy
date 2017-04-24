package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoPagoController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [tipoPagoInstanceList: TipoPago.list(params), tipoPagoInstanceTotal: TipoPago.count()]
//    }

    def create() {
        [tipoPagoInstance: new TipoPago(params)]
    }

    def save() {
        def tipoPagoInstance = new TipoPago(params)


        println("id" + params.id)

        if (params.id) {
            tipoPagoInstance = TipoPago.get(params.id)
            tipoPagoInstance.properties = params
        }

        if (!tipoPagoInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [tipoPagoInstance: tipoPagoInstance])
            } else {
                render(view: "create", model: [tipoPagoInstance: tipoPagoInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "TipoPago actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "TipoPago creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: tipoPagoInstance.id)
    }

    def show() {
        def tipoPagoInstance = TipoPago.get(params.id)
        if (!tipoPagoInstance) {
            flash.message = "No se encontró TipoPago con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoPagoInstance: tipoPagoInstance]
    }

    def edit() {
        def tipoPagoInstance = TipoPago.get(params.id)
        if (!tipoPagoInstance) {
            flash.message = "No se encontró TipoPago con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoPagoInstance: tipoPagoInstance]
    }

    def delete() {
        def tipoPagoInstance = TipoPago.get(params.id)
        if (!tipoPagoInstance) {
            flash.message = "No se encontró TipoPago con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoPagoInstance.delete(flush: true)
            flash.message = "TipoPago  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar TipoPago con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoPagoInstanceList = TipoPago.list(params)
        def tipoPagoInstanceCount = TipoPago.count()
        if (tipoPagoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoPagoInstanceList = TipoPago.list(params)
        return [tipoPagoInstanceList: tipoPagoInstanceList, tipoPagoInstanceCount: tipoPagoInstanceCount]
    } //list

    def show_ajax() {
        if (params.id) {
            def tipoPagoInstance = TipoPago.get(params.id)
            if (!tipoPagoInstance) {
                notFound_ajax()
                return
            }
            return [tipoPagoInstance: tipoPagoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoPagoInstance = new TipoPago(params)
        if (params.id) {
            tipoPagoInstance = TipoPago.get(params.id)
            if (!tipoPagoInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoPagoInstance: tipoPagoInstance]
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

        //original
        def tipoPagoInstance = new TipoPago()
        if (params.id) {
            tipoPagoInstance = TipoPago.get(params.id)
            tipoPagoInstance.properties = params
            if (!tipoPagoInstance) {
                notFound_ajax()
                return
            }
        }else {

            tipoPagoInstance = new TipoPago()
            tipoPagoInstance.properties = params
//            tipopagoInstance.estado = '1'
//            tipopagoInstance.empresa = session.empresa


        } //update


        if (!tipoPagoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo de Pago."
            msg += renderErrors(bean: tipoPagoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo de Pago exitosa."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def tipoPagoInstance = TipoPago.get(params.id)
            if (tipoPagoInstance) {
                try {
                    tipoPagoInstance.delete(flush: true)
                    render "OK_Eliminación de Tipo de Pago exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Tipo de Pago."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Tipo de pago."
    } //notFound para ajax




}
