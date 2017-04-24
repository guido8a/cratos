package cratos

import org.springframework.dao.DataIntegrityViolationException

class EstadoCivilController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [estadoCivilInstanceList: EstadoCivil.list(params), estadoCivilInstanceTotal: EstadoCivil.count()]
//    }

    def create() {
        [estadoCivilInstance: new EstadoCivil(params)]
    }

    def save() {
        def estadoCivilInstance = new EstadoCivil(params)

        if (params.id) {
            estadoCivilInstance = EstadoCivil.get(params.id)
            estadoCivilInstance.properties = params
        }

        if (!estadoCivilInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [estadoCivilInstance: estadoCivilInstance])
            } else {
                render(view: "create", model: [estadoCivilInstance: estadoCivilInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "EstadoCivil actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "EstadoCivil creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: estadoCivilInstance.id)
    }

    def show() {
        def estadoCivilInstance = EstadoCivil.get(params.id)
        if (!estadoCivilInstance) {
            flash.message = "No se encontró EstadoCivil con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [estadoCivilInstance: estadoCivilInstance]
    }

    def edit() {
        def estadoCivilInstance = EstadoCivil.get(params.id)
        if (!estadoCivilInstance) {
            flash.message = "No se encontró EstadoCivil con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [estadoCivilInstance: estadoCivilInstance]
    }

    def delete() {
        def estadoCivilInstance = EstadoCivil.get(params.id)
        if (!estadoCivilInstance) {
            flash.message = "No se encontró EstadoCivil con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            estadoCivilInstance.delete(flush: true)
            flash.message = "EstadoCivil  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar EstadoCivil con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def estadoCivilInstanceList = EstadoCivil.list(params)
        def estadoCivilInstanceCount = EstadoCivil.count()
        if (estadoCivilInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        estadoCivilInstanceList = EstadoCivil.list(params)
        return [estadoCivilInstanceList: estadoCivilInstanceList, estadoCivilInstanceCount: estadoCivilInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def estadoCivilInstance = EstadoCivil.get(params.id)
            if (!estadoCivilInstance) {
                notFound_ajax()
                return
            }
            return [estadoCivilInstance: estadoCivilInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def estadoCivilInstance = new EstadoCivil(params)
        if (params.id) {
            estadoCivilInstance = EstadoCivil.get(params.id)
            if (!estadoCivilInstance) {
                notFound_ajax()
                return
            }
        }
        return [estadoCivilInstance: estadoCivilInstance]
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
        def estadoCivilInstance = new EstadoCivil()
        if (params.id) {
            estadoCivilInstance = EstadoCivil.get(params.id)
            estadoCivilInstance.properties = params
            if (!estadoCivilInstance) {
                notFound_ajax()
                return
            }
        }else {

            estadoCivilInstance = new EstadoCivil()
            estadoCivilInstance.properties = params
//            estadocivilInstance.estado = '1'
//            estadoCivilInstance.empresa = session.empresa


        } //update


        if (!estadoCivilInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Estado Civil."
            msg += renderErrors(bean: estadoCivilInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Estado Civil."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def estadoCivilInstance = EstadoCivil.get(params.id)
            if (estadoCivilInstance) {
                try {
                    estadoCivilInstance.delete(flush: true)
                    render "OK_Eliminación de Estado Civil."
                } catch (e) {
                    render "NO_No se pudo eliminar Estado Civil"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Estado Civil."
    } //notFound para ajax


}
