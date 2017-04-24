package cratos

import org.springframework.dao.DataIntegrityViolationException

class NacionalidadController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [nacionalidadInstanceList: Nacionalidad.list(params), nacionalidadInstanceTotal: Nacionalidad.count()]
//    }

    def create() {
        [nacionalidadInstance: new Nacionalidad(params)]
    }

    def save() {
        def nacionalidadInstance = new Nacionalidad(params)

        if(params.id) {
            nacionalidadInstance = Nacionalidad.get(params.id)
            nacionalidadInstance.properties = params
        }

        if (!nacionalidadInstance.save(flush: true)) {
            if(params.id) {
                render(view: "edit", model: [nacionalidadInstance: nacionalidadInstance])
            } else {
                render(view: "create", model: [nacionalidadInstance: nacionalidadInstance])
            }
            return
        }

        if(params.id) {
            flash.message = "Nacionalidad actualizado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        } else {
		    flash.message = "Nacionalidad creado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        }
        redirect(action: "show", id: nacionalidadInstance.id)
    }

    def show() {
        def nacionalidadInstance = Nacionalidad.get(params.id)
        if (!nacionalidadInstance) {
            flash.message = "No se encontró Nacionalidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [nacionalidadInstance: nacionalidadInstance]
    }

    def edit() {
        def nacionalidadInstance = Nacionalidad.get(params.id)
        if (!nacionalidadInstance) {
            flash.message = "No se encontró Nacionalidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [nacionalidadInstance: nacionalidadInstance]
    }

    def delete() {
        def nacionalidadInstance = Nacionalidad.get(params.id)
        if (!nacionalidadInstance) {
			flash.message = "No se encontró Nacionalidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        try {
            nacionalidadInstance.delete(flush: true)
			flash.message = "Nacionalidad  con id "+params.id+" eliminado"
            flash.clase = "success"
            flash.ico ="ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = "No se pudo eliminar Nacionalidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def nacionalidadInstanceList = Nacionalidad.list(params)
        def nacionalidadInstanceCount = Nacionalidad.count()
        if (nacionalidadInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        nacionalidadInstanceList = Nacionalidad.list(params)
        return [nacionalidadInstanceList: nacionalidadInstanceList, nacionalidadInstanceCount: nacionalidadInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def nacionalidadInstance = Nacionalidad.get(params.id)
            if (!nacionalidadInstance) {
                notFound_ajax()
                return
            }
            return [nacionalidadInstance: nacionalidadInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def nacionalidadInstance = new Nacionalidad(params)
        if (params.id) {
            nacionalidadInstance = Nacionalidad.get(params.id)
            if (!nacionalidadInstance) {
                notFound_ajax()
                return
            }
        }
        return [nacionalidadInstance: nacionalidadInstance]
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
//        params.codigo = params.codigo.toUpperCase()


        //original
        def nacionalidadInstance = new Nacionalidad()
        if (params.id) {
            nacionalidadInstance = Nacionalidad.get(params.id)
            nacionalidadInstance.properties = params
            if (!nacionalidadInstance) {
                notFound_ajax()
                return
            }
        }else {

            nacionalidadInstance = new Nacionalidad()
            nacionalidadInstance.properties = params
//            nacionalidadInstance.estado = '1'
//            nacionalidadInstance.empresa = session.empresa


        } //update


        if (!nacionalidadInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Nacionalidad."
            msg += renderErrors(bean: nacionalidadInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Nacionalidad."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def nacionalidadInstance = Nacionalidad.get(params.id)
            if (nacionalidadInstance) {
                try {
                    nacionalidadInstance.delete(flush: true)
                    render "OK_Eliminación de Profesión."
                } catch (e) {
                    render "NO_No se pudo eliminar Nacionalidad"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Nacionalidad."
    } //notFound para ajax



}
