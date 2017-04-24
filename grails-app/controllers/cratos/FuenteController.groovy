package cratos

import org.springframework.dao.DataIntegrityViolationException

class FuenteController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [fuenteInstanceList: Fuente.list(params), fuenteInstanceTotal: Fuente.count()]
//    }

    def create() {
        [fuenteInstance: new Fuente(params)]
    }

    def save() {
        def fuenteInstance = new Fuente(params)

        if (params.id) {
            fuenteInstance = Fuente.get(params.id)
            fuenteInstance.properties = params
        }

        if (!fuenteInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [fuenteInstance: fuenteInstance])
            } else {
                render(view: "create", model: [fuenteInstance: fuenteInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Fuente actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Fuente creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: fuenteInstance.id)
    }

    def show() {
        def fuenteInstance = Fuente.get(params.id)
        if (!fuenteInstance) {
            flash.message = "No se encontró Fuente con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [fuenteInstance: fuenteInstance]
    }

    def edit() {
        def fuenteInstance = Fuente.get(params.id)
        if (!fuenteInstance) {
            flash.message = "No se encontró Fuente con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [fuenteInstance: fuenteInstance]
    }

    def delete() {
        def fuenteInstance = Fuente.get(params.id)
        if (!fuenteInstance) {
            flash.message = "No se encontró Fuente con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            fuenteInstance.delete(flush: true)
            flash.message = "Fuente  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Fuente con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def fuenteInstanceList = Fuente.list(params)
        def fuenteInstanceCount = Fuente.count()
        if (fuenteInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        fuenteInstanceList = Fuente.list(params)
        return [fuenteInstanceList: fuenteInstanceList, fuenteInstanceCount: fuenteInstanceCount]
    } //list

    def show_ajax() {
        if (params.id) {
            def fuenteInstance = Fuente.get(params.id)
            if (!fuenteInstance) {
                notFound_ajax()
                return
            }
            return [fuenteInstance: fuenteInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def fuenteInstance = new Fuente(params)
        if (params.id) {
            fuenteInstance = Fuente.get(params.id)
            if (!fuenteInstance) {
                notFound_ajax()
                return
            }
        }
        return [fuenteInstance: fuenteInstance]
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

        //original
        def fuenteInstance = new Fuente()
        if (params.id) {
            fuenteInstance = Fuente.get(params.id)
            fuenteInstance.properties = params
            if (!fuenteInstance) {
                notFound_ajax()
                return
            }
        }else {

            fuenteInstance = new Fuente()
            fuenteInstance.properties = params
//            fuenteInstance.estado = '1'
//            fuenteInstance.empresa = session.empresa


        } //update


        if (!fuenteInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo de Pago."
            msg += renderErrors(bean: fuenteInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo de Pago exitosa."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def fuenteInstance = Fuente.get(params.id)
            if (fuenteInstance) {
                try {
                    fuenteInstance.delete(flush: true)
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
