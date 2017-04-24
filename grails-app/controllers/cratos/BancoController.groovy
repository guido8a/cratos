package cratos

import org.springframework.dao.DataIntegrityViolationException

class BancoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [bancoInstanceList: Banco.list(params), bancoInstanceTotal: Banco.count()]
//    }

    def create() {
        [bancoInstance: new Banco(params)]
    }

    def save() {
        def bancoInstance = new Banco(params)

        if (params.id) {
            bancoInstance = Banco.get(params.id)
            if (!bancoInstance) {
                flash.message = "No se encontr&oacute; Banco a modificar"
                render "NO"
                return
            }
            bancoInstance.properties = params
        } else {
            bancoInstance = new Banco(params)
        }
        bancoInstance.empresa = Empresa.get(session.empresa.id)
        if (!bancoInstance.save(flush: true)) {
            render "NO"
            println bancoInstance.errors
            flash.message = "Ha ocurrido un error al guardar Banco"
            return
        }

        flash.message = "Banco guardado exitosamente"
//    redirect(action: "show", id: bancoInstance.id)
        render "OK"
    }

    def show() {
        def bancoInstance = Banco.get(params.id)
        if (!bancoInstance) {
            flash.message = "No se encontr&oacute; Banco a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [bancoInstance: bancoInstance]
    }

    def edit() {
        def bancoInstance = Banco.get(params.id)
        if (!bancoInstance) {
            flash.message = "No se encontr&oacute; Banco a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [bancoInstance: bancoInstance]
    }

    def delete() {
        def bancoInstance = Banco.get(params.id)
        if (!bancoInstance) {
            flash.message = "No se encontr&oacute; Banco a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            bancoInstance.delete(flush: true)
            flash.message = "Banco eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar Banco"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def bancoInstanceList = Banco.list(params)
        def bancoInstanceCount = Banco.count()
        if (bancoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        bancoInstanceList = Banco.list(params)
        return [bancoInstanceList: bancoInstanceList, bancoInstanceCount: bancoInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def bancoInstance = Banco.get(params.id)
            if (!bancoInstance) {
                notFound_ajax()
                return
            }
            return [bancoInstance: bancoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def bancoInstance = new Banco(params)
        if (params.id) {
            bancoInstance = Banco.get(params.id)
            if (!bancoInstance) {
                notFound_ajax()
                return
            }
        }
        return [bancoInstance: bancoInstance]
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
        params.empresa = session.empresa


        //original
        def bancoInstance = new Banco()
        if (params.id) {
            bancoInstance = Banco.get(params.id)
            bancoInstance.properties = params
            if (!bancoInstance) {
                notFound_ajax()
                return
            }
        }else {

            bancoInstance = new Banco()
            bancoInstance.properties = params
//            bancoInstance.estado = '1'
//            bancoInstance.empresa = session.empresa


        } //update


        if (!bancoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Banco."
            msg += renderErrors(bean: bancoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Banco."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def bancoInstance = Banco.get(params.id)
            if (bancoInstance) {
                try {
                    bancoInstance.delete(flush: true)
                    render "OK_Eliminación de Banco."
                } catch (e) {
                    render "NO_No se pudo eliminar el Banco"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Banco."
    } //notFound para ajax

}
