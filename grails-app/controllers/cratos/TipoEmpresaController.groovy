package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoEmpresaController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [tipoEmpresaInstanceList: TipoEmpresa.list(params), tipoEmpresaInstanceTotal: TipoEmpresa.count()]
//    }

    def create() {
        [tipoEmpresaInstance: new TipoEmpresa(params)]
    }

    def save() {
        def tipoEmpresaInstance = new TipoEmpresa(params)

        if(params.id) {
            tipoEmpresaInstance = TipoEmpresa.get(params.id)
            tipoEmpresaInstance.properties = params
        }

        if (!tipoEmpresaInstance.save(flush: true)) {
            if(params.id) {
                render(view: "edit", model: [tipoEmpresaInstance: tipoEmpresaInstance])
            } else {
                render(view: "create", model: [tipoEmpresaInstance: tipoEmpresaInstance])
            }
            return
        }

        if(params.id) {
            flash.message = "TipoEmpresa actualizado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        } else {
		    flash.message = "TipoEmpresa creado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        }
        redirect(action: "show", id: tipoEmpresaInstance.id)
    }

    def show() {
        def tipoEmpresaInstance = TipoEmpresa.get(params.id)
        if (!tipoEmpresaInstance) {
            flash.message = "No se encontró TipoEmpresa con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [tipoEmpresaInstance: tipoEmpresaInstance]
    }

    def edit() {
        def tipoEmpresaInstance = TipoEmpresa.get(params.id)
        if (!tipoEmpresaInstance) {
            flash.message = "No se encontró TipoEmpresa con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [tipoEmpresaInstance: tipoEmpresaInstance]
    }

    def delete() {
        def tipoEmpresaInstance = TipoEmpresa.get(params.id)
        if (!tipoEmpresaInstance) {
			flash.message = "No se encontró TipoEmpresa con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoEmpresaInstance.delete(flush: true)
			flash.message = "TipoEmpresa  con id "+params.id+" eliminado"
            flash.clase = "success"
            flash.ico ="ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = "No se pudo eliminar TipoEmpresa con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoEmpresaInstanceList = TipoEmpresa.list(params)
        def tipoEmpresaInstanceCount = TipoEmpresa.count()
        if (tipoEmpresaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoEmpresaInstanceList = TipoEmpresa.list(params)
        return [tipoEmpresaInstanceList: tipoEmpresaInstanceList, tipoEmpresaInstanceCount: tipoEmpresaInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def tipoEmpresaInstance = TipoEmpresa.get(params.id)
            if (!tipoEmpresaInstance) {
                notFound_ajax()
                return
            }
            return [tipoEmpresaInstance: tipoEmpresaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoEmpresaInstance = new TipoEmpresa(params)
        if (params.id) {
            tipoEmpresaInstance = TipoEmpresa.get(params.id)
            if (!tipoEmpresaInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoEmpresaInstance: tipoEmpresaInstance]
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
        def tipoEmpresaInstance = new TipoEmpresa()
        if (params.id) {
            tipoEmpresaInstance = TipoEmpresa.get(params.id)
            tipoEmpresaInstance.properties = params
            if (!tipoEmpresaInstance) {
                notFound_ajax()
                return
            }
        }else {

            tipoEmpresaInstance = new TipoEmpresa()
            tipoEmpresaInstance.properties = params
//            tipoempresaInstance.estado = '1'
//            tipoEmpresaInstance.empresa = session.empresa


        } //update


        if (!tipoEmpresaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo de Empresa."
            msg += renderErrors(bean: tipoEmpresaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo de Empresa."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def tipoEmpresaInstance = TipoEmpresa.get(params.id)
            if (tipoEmpresaInstance) {
                try {
                    tipoEmpresaInstance.delete(flush: true)
                    render "OK_Eliminación de Tipo de Empresa."
                } catch (e) {
                    render "NO_No se pudo eliminar el Tipo de Empresa"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Tipo de Empresa."
    } //notFound para ajax


}
