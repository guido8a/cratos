package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoProveedorController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [tipoProveedorInstanceList: TipoProveedor.list(params), tipoProveedorInstanceTotal: TipoProveedor.count()]
//    }

    def create() {
        [tipoProveedorInstance: new TipoProveedor(params)]
    }

    def save() {
        def tipoProveedorInstance = new TipoProveedor(params)

        if (params.id) {
            tipoProveedorInstance = TipoProveedor.get(params.id)
            tipoProveedorInstance.properties = params
        }

        if (!tipoProveedorInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [tipoProveedorInstance: tipoProveedorInstance])
            } else {
                render(view: "create", model: [tipoProveedorInstance: tipoProveedorInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "TipoProveedor actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "TipoProveedor creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: tipoProveedorInstance.id)
    }

    def show() {
        def tipoProveedorInstance = TipoProveedor.get(params.id)
        if (!tipoProveedorInstance) {
            flash.message = "No se encontró TipoProveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoProveedorInstance: tipoProveedorInstance]
    }

    def edit() {
        def tipoProveedorInstance = TipoProveedor.get(params.id)
        if (!tipoProveedorInstance) {
            flash.message = "No se encontró TipoProveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoProveedorInstance: tipoProveedorInstance]
    }

    def delete() {
        def tipoProveedorInstance = TipoProveedor.get(params.id)
        if (!tipoProveedorInstance) {
            flash.message = "No se encontró TipoProveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoProveedorInstance.delete(flush: true)
            flash.message = "TipoProveedor  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar TipoProveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoProveedorInstanceList = TipoProveedor.list(params)
        def tipoProveedorInstanceCount = TipoProveedor.count()
        if (tipoProveedorInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoProveedorInstanceList = TipoProveedor.list(params)
        return [tipoProveedorInstanceList: tipoProveedorInstanceList, tipoProveedorInstanceCount: tipoProveedorInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def tipoProveedorInstance = TipoProveedor.get(params.id)
            if (!tipoProveedorInstance) {
                notFound_ajax()
                return
            }
            return [tipoProveedorInstance: tipoProveedorInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoProveedorInstance = new TipoProveedor(params)
        if (params.id) {
            tipoProveedorInstance = TipoProveedor.get(params.id)
            if (!tipoProveedorInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoProveedorInstance: tipoProveedorInstance]
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
        def tipoProveedorInstance = new TipoProveedor()
        if (params.id) {
            tipoProveedorInstance = TipoProveedor.get(params.id)
            tipoProveedorInstance.properties = params
            if (!tipoProveedorInstance) {
                notFound_ajax()
                return
            }
        }else {

            tipoProveedorInstance = new TipoProveedor()
            tipoProveedorInstance.properties = params
//            tipoproveedorInstance.estado = '1'
//            tipoProveedorInstance.empresa = session.empresa


        } //update


        if (!tipoProveedorInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo de Proveedor."
            msg += renderErrors(bean: tipoProveedorInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo de Proveedor."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def tipoProveedorInstance = TipoProveedor.get(params.id)
            if (tipoProveedorInstance) {
                try {
                    tipoProveedorInstance.delete(flush: true)
                    render "OK_Eliminación de Tipo de Proveedor."
                } catch (e) {
                    render "NO_No se pudo eliminar el Tipo de Proveedor"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Tipo de Proveedor."
    } //notFound para ajax
}
