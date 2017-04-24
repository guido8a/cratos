package cratos

import org.springframework.dao.DataIntegrityViolationException

class BaseController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

//def list() {
//    params.max = Math.min(params.max ? params.int('max') : 10, 100)
//    [baseInstanceList: Base.list(params), baseInstanceTotal: Base.count()]
//}

def create() {
    [baseInstance: new Base(params)]
}

def save() {
    def baseInstance
    if(params.id) {
        baseInstance = Base.get(params.id)
        if(!baseInstance) {
            flash.message = "No se encontr&oacute; Base a modificar"
            render "NO"
            return
        }
        baseInstance.properties = params
    } else {
        baseInstance = new Base(params)
    }
    if (!baseInstance.save(flush: true)) {
        render "NO"
        println baseInstance.errors
        flash.message = "Ha ocurrido un error al guardar Base"
        return
    }

    flash.message = "Base guardado exitosamente"
//    redirect(action: "show", id: baseInstance.id)
    render "OK"
}

def show() {
    def baseInstance = Base.get(params.id)
    if (!baseInstance) {
        flash.message = "No se encontr&oacute; Base a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [baseInstance: baseInstance]
}

def edit() {
    def baseInstance = Base.get(params.id)
    if (!baseInstance) {
        flash.message = "No se encontr&oacute; Base a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [baseInstance: baseInstance]
}

def delete() {
    def baseInstance = Base.get(params.id)
    if (!baseInstance) {
        flash.message = "No se encontr&oacute; Base a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        baseInstance.delete(flush: true)
        flash.message = "Base eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar Base"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def baseInstanceList = Base.list(params)
        def baseInstanceCount = Base.count()
        if (baseInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        baseInstanceList = Base.list(params)
        return [baseInstanceList: baseInstanceList, baseInstanceCount: baseInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def baseInstance = Base.get(params.id)
            if (!baseInstance) {
                notFound_ajax()
                return
            }
            return [baseInstance: baseInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def baseInstance = new Base(params)
        if (params.id) {
            baseInstance = Base.get(params.id)
            if (!baseInstance) {
                notFound_ajax()
                return
            }
        }
        return [baseInstance: baseInstance]
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
        def baseInstance = new Base()
        if (params.id) {
            baseInstance = Base.get(params.id)
            baseInstance.properties = params
            if (!baseInstance) {
                notFound_ajax()
                return
            }
        }else {

            baseInstance = new Base()
            baseInstance.properties = params
//            baseInstance.estado = '1'
//            baseInstance.empresa = session.empresa


        } //update


        if (!baseInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Base."
            msg += renderErrors(bean: baseInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Base."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def baseInstance = Base.get(params.id)
            if (baseInstance) {
                try {
                    baseInstance.delete(flush: true)
                    render "OK_Eliminación de Base."
                } catch (e) {
                    render "NO_No se pudo eliminar Base"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Base."
    } //notFound para ajax
}
