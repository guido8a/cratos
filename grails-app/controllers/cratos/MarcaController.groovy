package cratos

import org.springframework.dao.DataIntegrityViolationException

class MarcaController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [marcaInstanceList: Marca.list(params), marcaInstanceTotal: Marca.count()]
//    }

    def create() {
        [marcaInstance: new Marca(params)]
    }

    def save() {
        def marcaInstance = new Marca(params)

        if (params.id) {
            marcaInstance = Marca.get(params.id)
            marcaInstance.properties = params
        }

        if (!marcaInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [marcaInstance: marcaInstance])
            } else {
                render(view: "create", model: [marcaInstance: marcaInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Marca actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Marca creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: marcaInstance.id)
    }

    def show() {
        def marcaInstance = Marca.get(params.id)
        if (!marcaInstance) {
            flash.message = "No se encontró Marca con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [marcaInstance: marcaInstance]
    }

    def edit() {
        def marcaInstance = Marca.get(params.id)
        if (!marcaInstance) {
            flash.message = "No se encontró Marca con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [marcaInstance: marcaInstance]
    }

    def delete() {
        def marcaInstance = Marca.get(params.id)
        if (!marcaInstance) {
            flash.message = "No se encontró Marca con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            marcaInstance.delete(flush: true)
            flash.message = "Marca  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Marca con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def marcaInstanceList = Marca.list(params)
        def marcaInstanceCount = Marca.count()
        if (marcaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        marcaInstanceList = Marca.list(params)
        return [marcaInstanceList: marcaInstanceList, marcaInstanceCount: marcaInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def marcaInstance = Marca.get(params.id)
            if (!marcaInstance) {
                notFound_ajax()
                return
            }
            return [marcaInstance: marcaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def marcaInstance = new Marca(params)
        if (params.id) {
            marcaInstance = Marca.get(params.id)
            if (!marcaInstance) {
                notFound_ajax()
                return
            }
        }
        return [marcaInstance: marcaInstance]
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
//        params.empresa = session.empresa


        //original
        def marcaInstance = new Marca()
        if (params.id) {
            marcaInstance = Marca.get(params.id)
            marcaInstance.properties = params
            if (!marcaInstance) {
                notFound_ajax()
                return
            }
        }else {

            marcaInstance = new Marca()
            marcaInstance.properties = params
//            marcaInstance.estado = '1'
//            marcaInstance.empresa = session.empresa


        } //update


        if (!marcaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Marca."
            msg += renderErrors(bean: marcaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Marca."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def marcaInstance = Marca.get(params.id)
            if (marcaInstance) {
                try {
                    marcaInstance.delete(flush: true)
                    render "OK_Eliminación de Marca."
                } catch (e) {
                    render "NO_No se pudo eliminar la Marca"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Marca."
    } //notFound para ajax


}
