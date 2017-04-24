package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoComprobanteController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [tipoComprobanteInstanceList: TipoComprobante.list(params), tipoComprobanteInstanceTotal: TipoComprobante.count()]
//    }

    def create() {
        [tipoComprobanteInstance: new TipoComprobante(params)]
    }

    def save() {
        def tipoComprobanteInstance = new TipoComprobante(params)

        if (params.id) {
            tipoComprobanteInstance = TipoComprobante.get(params.id)
            tipoComprobanteInstance.properties = params
        }

        if (!tipoComprobanteInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [tipoComprobanteInstance: tipoComprobanteInstance])
            } else {
                render(view: "create", model: [tipoComprobanteInstance: tipoComprobanteInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "TipoComprobante actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "TipoComprobante creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: tipoComprobanteInstance.id)
    }

    def show() {
        def tipoComprobanteInstance = TipoComprobante.get(params.id)
        if (!tipoComprobanteInstance) {
            flash.message = "No se encontró TipoComprobante con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoComprobanteInstance: tipoComprobanteInstance]
    }

    def edit() {
        def tipoComprobanteInstance = TipoComprobante.get(params.id)
        if (!tipoComprobanteInstance) {
            flash.message = "No se encontró TipoComprobante con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoComprobanteInstance: tipoComprobanteInstance]
    }

    def delete() {
        def tipoComprobanteInstance = TipoComprobante.get(params.id)
        if (!tipoComprobanteInstance) {
            flash.message = "No se encontró TipoComprobante con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoComprobanteInstance.delete(flush: true)
            flash.message = "TipoComprobante  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar TipoComprobante con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoComprobanteInstanceList = TipoComprobante.list(params)
        def tipoComprobanteInstanceCount = TipoComprobante.count()
        if (tipoComprobanteInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoComprobanteInstanceList = TipoComprobante.list(params)
        return [tipoComprobanteInstanceList: tipoComprobanteInstanceList, tipoComprobanteInstanceCount: tipoComprobanteInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def tipoComprobanteInstance = TipoComprobante.get(params.id)
            if (!tipoComprobanteInstance) {
                notFound_ajax()
                return
            }
            return [tipoComprobanteInstance: tipoComprobanteInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoComprobanteInstance = new TipoComprobante(params)
        if (params.id) {
            tipoComprobanteInstance = TipoComprobante.get(params.id)
            if (!tipoComprobanteInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoComprobanteInstance: tipoComprobanteInstance]
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
        def tipoComprobanteInstance = new TipoComprobante()
        if (params.id) {
            tipoComprobanteInstance = TipoComprobante.get(params.id)
            tipoComprobanteInstance.properties = params
            if (!tipoComprobanteInstance) {
                notFound_ajax()
                return
            }
        }else {

            tipoComprobanteInstance = new TipoComprobante()
            tipoComprobanteInstance.properties = params
//            tipocomprobanteInstance.estado = '1'
//            tipoComprobanteInstance.empresa = session.empresa


        } //update


        if (!tipoComprobanteInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo de Comprobante."
            msg += renderErrors(bean: tipoComprobanteInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo de Comprobante."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def tipoComprobanteInstance = TipoComprobante.get(params.id)
            if (tipoComprobanteInstance) {
                try {
                    tipoComprobanteInstance.delete(flush: true)
                    render "OK_Eliminación de Tipo de Comprobante exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar el Tipo de Comprobante"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Tipo de Comprobante."
    } //notFound para ajax
    
}
