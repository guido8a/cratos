package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoDocumentoController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [tipoDocumentoInstanceList: TipoDocumento.list(params), tipoDocumentoInstanceTotal: TipoDocumento.count()]
//    }

    def create() {
        [tipoDocumentoInstance: new TipoDocumento(params)]
    }

    def save() {
        def tipoDocumentoInstance = new TipoDocumento(params)

        if (params.id) {
            tipoDocumentoInstance = TipoDocumento.get(params.id)
            tipoDocumentoInstance.properties = params
        }

        if (!tipoDocumentoInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [tipoDocumentoInstance: tipoDocumentoInstance])
            } else {
                render(view: "create", model: [tipoDocumentoInstance: tipoDocumentoInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "TipoDocumento actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "TipoDocumento creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: tipoDocumentoInstance.id)
    }

    def show() {
        def tipoDocumentoInstance = TipoDocumento.get(params.id)
        if (!tipoDocumentoInstance) {
            flash.message = "No se encontró TipoDocumento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoDocumentoInstance: tipoDocumentoInstance]
    }

    def edit() {
        def tipoDocumentoInstance = TipoDocumento.get(params.id)
        if (!tipoDocumentoInstance) {
            flash.message = "No se encontró TipoDocumento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoDocumentoInstance: tipoDocumentoInstance]
    }

    def delete() {
        def tipoDocumentoInstance = TipoDocumento.get(params.id)
        if (!tipoDocumentoInstance) {
            flash.message = "No se encontró TipoDocumento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoDocumentoInstance.delete(flush: true)
            flash.message = "TipoDocumento  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar TipoDocumento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoDocumentoInstanceList = TipoDocumento.list(params)
        def tipoDocumentoInstanceCount = TipoDocumento.count()
        if (tipoDocumentoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoDocumentoInstanceList = TipoDocumento.list(params)
        return [tipoDocumentoInstanceList: tipoDocumentoInstanceList, tipoDocumentoInstanceCount: tipoDocumentoInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def tipoDocumentoInstance = TipoDocumento.get(params.id)
            if (!tipoDocumentoInstance) {
                notFound_ajax()
                return
            }
            return [tipoDocumentoInstance: tipoDocumentoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoDocumentoInstance = new TipoDocumento(params)
        if (params.id) {
            tipoDocumentoInstance = TipoDocumento.get(params.id)
            if (!tipoDocumentoInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoDocumentoInstance: tipoDocumentoInstance]
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
        def tipoDocumentoInstance = new TipoDocumento()
        if (params.id) {
            tipoDocumentoInstance = TipoDocumento.get(params.id)
            tipoDocumentoInstance.properties = params
            if (!tipoDocumentoInstance) {
                notFound_ajax()
                return
            }
        }else {

            tipoDocumentoInstance = new TipoDocumento()
            tipoDocumentoInstance.properties = params
//            tipodocumentoInstance.estado = '1'
//            tipoDocumentoInstance.empresa = session.empresa


        } //update


        if (!tipoDocumentoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo de Documento."
            msg += renderErrors(bean: tipoDocumentoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo de Documento."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def tipoDocumentoInstance = TipoDocumento.get(params.id)
            if (tipoDocumentoInstance) {
                try {
                    tipoDocumentoInstance.delete(flush: true)
                    render "OK_Eliminación de Tipo de Documento."
                } catch (e) {
                    render "NO_No se pudo eliminar el Tipo de Documento"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Tipo de Documento."
    } //notFound para ajax
    
}
