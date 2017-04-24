package cratos

import org.springframework.dao.DataIntegrityViolationException

class NivelController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [nivelInstanceList: Nivel.list(params), nivelInstanceTotal: Nivel.count()]
//    }

    def create() {
        [nivelInstance: new Nivel(params)]
    }

    def save() {
        def nivelInstance = new Nivel(params)



        nivelInstance.properties = params

        if(params.id) {
            nivelInstance = Nivel.get(params.id)
            nivelInstance.properties = params
        }

        if (!nivelInstance.save(flush: true)) {
            if(params.id) {
                render(view: "edit", model: [nivelInstance: nivelInstance])
            } else {
                render(view: "create", model: [nivelInstance: nivelInstance])
            }
            return
        }

        if(params.id) {
            flash.message = "Nivel actualizado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        } else {
		    flash.message = "Nivel creado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        }
        redirect(action: "show", id: nivelInstance.id)
    }

    def show() {
        def nivelInstance = Nivel.get(params.id)
        if (!nivelInstance) {
            flash.message = "No se encontró Nivel con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [nivelInstance: nivelInstance]
    }

    def edit() {
        def nivelInstance = Nivel.get(params.id)
        if (!nivelInstance) {
            flash.message = "No se encontró Nivel con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [nivelInstance: nivelInstance]
    }

    def delete() {
        def nivelInstance = Nivel.get(params.id)
        if (!nivelInstance) {
			flash.message = "No se encontró Nivel con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        try {
            nivelInstance.delete(flush: true)
			flash.message = "Nivel  con id "+params.id+" eliminado"
            flash.clase = "success"
            flash.ico ="ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = "No se pudo eliminar Nivel con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def nivelInstanceList = Nivel.list(params)
        def nivelInstanceCount = Nivel.count()
        if (nivelInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        nivelInstanceList = Nivel.list(params)
        return [nivelInstanceList: nivelInstanceList, nivelInstanceCount: nivelInstanceCount]
    } //list

    def show_ajax() {
        if (params.id) {
            def nivelInstance = Nivel.get(params.id)
            if (!nivelInstance) {
                notFound_ajax()
                return
            }
            return [nivelInstance: nivelInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def nivelInstance = new Nivel(params)
        if (params.id) {
            nivelInstance = Nivel.get(params.id)
            if (!nivelInstance) {
                notFound_ajax()
                return
            }
        }
        return [nivelInstance: nivelInstance]
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


        //original
        def nivelInstance = new Nivel()
        if (params.id) {
            nivelInstance = Nivel.get(params.id)
            nivelInstance.properties = params
            if (!nivelInstance) {
                notFound_ajax()
                return
            }
        }else {

            nivelInstance = new Nivel()
            nivelInstance.properties = params
//            nivelInstance.estado = '1'
//            nivelInstance.empresa = session.empresa


        } //update


        if (!nivelInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Nivel."
            msg += renderErrors(bean: nivelInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Nivel exitosa."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def nivelInstance = Nivel.get(params.id)
            if (nivelInstance) {
                try {
                    nivelInstance.delete(flush: true)
                    render "OK_Eliminación de Nivel exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Nivel."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Nivel."
    } //notFound para ajax







}
