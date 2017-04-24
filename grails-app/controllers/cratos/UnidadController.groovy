package cratos

import org.springframework.dao.DataIntegrityViolationException

class UnidadController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [unidadInstanceList: Unidad.list(params), unidadInstanceTotal: Unidad.count()]
//    }

    def create() {
        [unidadInstance: new Unidad(params)]
    }

    def save() {
        def unidadInstance = new Unidad(params)

        if(params.id) {
            unidadInstance = Unidad.get(params.id)
            unidadInstance.properties = params
        }

        if (!unidadInstance.save(flush: true)) {
            if(params.id) {
                render(view: "edit", model: [unidadInstance: unidadInstance])
            } else {
                render(view: "create", model: [unidadInstance: unidadInstance])
            }
            return
        }

        if(params.id) {
            flash.message = "Unidad actualizado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        } else {
		    flash.message = "Unidad creado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        }
        redirect(action: "show", id: unidadInstance.id)
    }

    def show() {
        def unidadInstance = Unidad.get(params.id)
        if (!unidadInstance) {
            flash.message = "No se encontró Unidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [unidadInstance: unidadInstance]
    }

    def edit() {
        def unidadInstance = Unidad.get(params.id)
        if (!unidadInstance) {
            flash.message = "No se encontró Unidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [unidadInstance: unidadInstance]
    }

    def delete() {
        def unidadInstance = Unidad.get(params.id)
        if (!unidadInstance) {
			flash.message = "No se encontró Unidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        try {
            unidadInstance.delete(flush: true)
			flash.message = "Unidad  con id "+params.id+" eliminado"
            flash.clase = "success"
            flash.ico ="ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = "No se pudo eliminar Unidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def unidadInstanceList = Unidad.list(params)
        def unidadInstanceCount = Unidad.count()
        if (unidadInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        unidadInstanceList = Unidad.list(params)
        return [unidadInstanceList: unidadInstanceList, unidadInstanceCount: unidadInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def unidadInstance = Unidad.get(params.id)
            if (!unidadInstance) {
                notFound_ajax()
                return
            }
            return [unidadInstance: unidadInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def unidadInstance = new Unidad(params)
        if (params.id) {
            unidadInstance = Unidad.get(params.id)
            if (!unidadInstance) {
                notFound_ajax()
                return
            }
        }
        return [unidadInstance: unidadInstance]
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
        params.codigo = params.codigo.toUpperCase()
//        params.empresa = session.empresa


        //original
        def unidadInstance = new Unidad()
        if (params.id) {
            unidadInstance = Unidad.get(params.id)
            unidadInstance.properties = params
            if (!unidadInstance) {
                notFound_ajax()
                return
            }
        }else {

            unidadInstance = new Unidad()
            unidadInstance.properties = params
//            unidadInstance.estado = '1'
//            unidadInstance.empresa = session.empresa


        } //update


        if (!unidadInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Unidad."
            msg += renderErrors(bean: unidadInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Unidad."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def unidadInstance = Unidad.get(params.id)
            if (unidadInstance) {
                try {
                    unidadInstance.delete(flush: true)
                    render "OK_Eliminación de Unidad."
                } catch (e) {
                    render "NO_No se pudo eliminar el Unidad"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Unidad."
    } //notFound para ajax




}
