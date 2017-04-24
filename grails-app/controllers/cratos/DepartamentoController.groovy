package cratos

import org.springframework.dao.DataIntegrityViolationException

class DepartamentoController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [departamentoInstanceList: Departamento.list(params), departamentoInstanceTotal: Departamento.count()]
//    }

    def create() {
        [departamentoInstance: new Departamento(params)]
    }

    def save() {
        def departamentoInstance = new Departamento(params)


        println("departamento" + params)


        departamentoInstance.properties = params
        departamentoInstance.empresa = session.empresa


        if (params.id) {
            departamentoInstance = Departamento.get(params.id)
            departamentoInstance.properties = params
        }

        if (!departamentoInstance.save(flush: true)) {

            println(departamentoInstance.errors)

            if (params.id) {
                render(view: "edit", model: [departamentoInstance: departamentoInstance])
            } else {
                render(view: "create", model: [departamentoInstance: departamentoInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Departamento actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Departamento creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: departamentoInstance.id)
    }

    def show() {
        def departamentoInstance = Departamento.get(params.id)
        if (!departamentoInstance) {
            flash.message = "No se encontró Departamento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [departamentoInstance: departamentoInstance]
    }

    def edit() {
        def departamentoInstance = Departamento.get(params.id)
        if (!departamentoInstance) {
            flash.message = "No se encontró Departamento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [departamentoInstance: departamentoInstance]
    }

    def delete() {
        def departamentoInstance = Departamento.get(params.id)
        if (!departamentoInstance) {
            flash.message = "No se encontró Departamento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            departamentoInstance.delete(flush: true)
            flash.message = "Departamento  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Departamento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def departamentoInstanceList = Departamento.list(params)
        def departamentoInstanceCount = Departamento.count()
        if (departamentoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        departamentoInstanceList = Departamento.list(params)
        return [departamentoInstanceList: departamentoInstanceList, departamentoInstanceCount: departamentoInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def departamentoInstance = Departamento.get(params.id)
            if (!departamentoInstance) {
                notFound_ajax()
                return
            }
            return [departamentoInstance: departamentoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def departamentoInstance = new Departamento(params)
        if (params.id) {
            departamentoInstance = Departamento.get(params.id)
            if (!departamentoInstance) {
                notFound_ajax()
                return
            }
        }
        return [departamentoInstance: departamentoInstance]
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
        params.empresa = session.empresa


        //original
        def departamentoInstance = new Departamento()
        if (params.id) {
            departamentoInstance = Departamento.get(params.id)
            departamentoInstance.properties = params
            if (!departamentoInstance) {
                notFound_ajax()
                return
            }
        }else {

            departamentoInstance = new Departamento()
            departamentoInstance.properties = params
//            departamentoInstance.estado = '1'
//            departamentoInstance.empresa = session.empresa


        } //update


        if (!departamentoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Departamento."
            msg += renderErrors(bean: departamentoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Departamento."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def departamentoInstance = Departamento.get(params.id)
            if (departamentoInstance) {
                try {
                    departamentoInstance.delete(flush: true)
                    render "OK_Eliminación de Departamento."
                } catch (e) {
                    render "NO_No se pudo eliminar el Departamento"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Departamento."
    } //notFound para ajax

}
