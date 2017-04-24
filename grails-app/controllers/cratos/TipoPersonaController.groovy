package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoPersonaController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [tipoPersonaInstanceList: TipoPersona.list(params), tipoPersonaInstanceTotal: TipoPersona.count()]
//    }

    def create() {
        [tipoPersonaInstance: new TipoPersona(params)]
    }

    def save() {
        def tipoPersonaInstance = new TipoPersona(params)

        if (params.id) {
            tipoPersonaInstance = TipoPersona.get(params.id)
            tipoPersonaInstance.properties = params
        }

        if (!tipoPersonaInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [tipoPersonaInstance: tipoPersonaInstance])
            } else {
                render(view: "create", model: [tipoPersonaInstance: tipoPersonaInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "TipoPersona actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "TipoPersona creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: tipoPersonaInstance.id)
    }

    def show() {
        def tipoPersonaInstance = TipoPersona.get(params.id)
        if (!tipoPersonaInstance) {
            flash.message = "No se encontró TipoPersona con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoPersonaInstance: tipoPersonaInstance]
    }

    def edit() {
        def tipoPersonaInstance = TipoPersona.get(params.id)
        if (!tipoPersonaInstance) {
            flash.message = "No se encontró TipoPersona con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoPersonaInstance: tipoPersonaInstance]
    }

    def delete() {
        def tipoPersonaInstance = TipoPersona.get(params.id)
        if (!tipoPersonaInstance) {
            flash.message = "No se encontró TipoPersona con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoPersonaInstance.delete(flush: true)
            flash.message = "TipoPersona  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar TipoPersona con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoPersonaInstanceList = TipoPersona.list(params)
        def tipoPersonaInstanceCount = TipoPersona.count()
        if (tipoPersonaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoPersonaInstanceList = TipoPersona.list(params)
        return [tipoPersonaInstanceList: tipoPersonaInstanceList, tipoPersonaInstanceCount: tipoPersonaInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def tipoPersonaInstance = TipoPersona.get(params.id)
            if (!tipoPersonaInstance) {
                notFound_ajax()
                return
            }
            return [tipoPersonaInstance: tipoPersonaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoPersonaInstance = new TipoPersona(params)
        if (params.id) {
            tipoPersonaInstance = TipoPersona.get(params.id)
            if (!tipoPersonaInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoPersonaInstance: tipoPersonaInstance]
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
        def tipoPersonaInstance = new TipoPersona()
        if (params.id) {
            tipoPersonaInstance = TipoPersona.get(params.id)
            tipoPersonaInstance.properties = params
            if (!tipoPersonaInstance) {
                notFound_ajax()
                return
            }
        }else {

            tipoPersonaInstance = new TipoPersona()
            tipoPersonaInstance.properties = params
//            tipopersonaInstance.estado = '1'
//            tipoPersonaInstance.empresa = session.empresa


        } //update


        if (!tipoPersonaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo de Persona."
            msg += renderErrors(bean: tipoPersonaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo de Persona."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def tipoPersonaInstance = TipoPersona.get(params.id)
            if (tipoPersonaInstance) {
                try {
                    tipoPersonaInstance.delete(flush: true)
                    render "OK_Eliminación de Tipo de Persona."
                } catch (e) {
                    render "NO_No se pudo eliminar el Tipo de Persona"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Tipo de Persona."
    } //notFound para ajax
    
}
