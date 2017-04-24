package cratos

import org.springframework.dao.DataIntegrityViolationException

class ProfesionController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

//def list() {
//    params.max = Math.min(params.max ? params.int('max') : 10, 100)
//    [profesionInstanceList: Profesion.list(params), profesionInstanceTotal: Profesion.count()]
//}

def create() {
    [profesionInstance: new Profesion(params)]
}

def save() {
    def profesionInstance
    if(params.id) {
        profesionInstance = Profesion.get(params.id)
        if(!profesionInstance) {
            flash.message = "No se encontr&oacute; Profesion a modificar"
            render "NO"
            return
        }
        profesionInstance.properties = params
    } else {
        profesionInstance = new Profesion(params)
    }
    if (!profesionInstance.save(flush: true)) {
        render "NO"
        println profesionInstance.errors
        flash.message = "Ha ocurrido un error al guardar Profesion"
        return
    }

    flash.message = "Profesion guardado exitosamente"
//    redirect(action: "show", id: profesionInstance.id)
    render "OK"
}

def show() {
    def profesionInstance = Profesion.get(params.id)
    if (!profesionInstance) {
        flash.message = "No se encontr&oacute; Profesion a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [profesionInstance: profesionInstance]
}

def edit() {
    def profesionInstance = Profesion.get(params.id)
    if (!profesionInstance) {
        flash.message = "No se encontr&oacute; Profesion a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [profesionInstance: profesionInstance]
}

def delete() {
    def profesionInstance = Profesion.get(params.id)
    if (!profesionInstance) {
        flash.message = "No se encontr&oacute; Profesion a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        profesionInstance.delete(flush: true)
        flash.message = "Profesion eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar Profesion"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def profesionInstanceList = Profesion.list(params)
        def profesionInstanceCount = Profesion.count()
        if (profesionInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        profesionInstanceList = Profesion.list(params)
        return [profesionInstanceList: profesionInstanceList, profesionInstanceCount: profesionInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def profesionInstance = Profesion.get(params.id)
            if (!profesionInstance) {
                notFound_ajax()
                return
            }
            return [profesionInstance: profesionInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def profesionInstance = new Profesion(params)
        if (params.id) {
            profesionInstance = Profesion.get(params.id)
            if (!profesionInstance) {
                notFound_ajax()
                return
            }
        }
        return [profesionInstance: profesionInstance]
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
        params.sigla = params.sigla.toUpperCase()
//        params.codigo = params.codigo.toUpperCase()


        //original
        def profesionInstance = new Profesion()
        if (params.id) {
            profesionInstance = Profesion.get(params.id)
            profesionInstance.properties = params
            if (!profesionInstance) {
                notFound_ajax()
                return
            }
        }else {

            profesionInstance = new Profesion()
            profesionInstance.properties = params
//            profesionInstance.estado = '1'
//            profesionInstance.empresa = session.empresa


        } //update


        if (!profesionInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Profesión."
            msg += renderErrors(bean: profesionInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Profesión."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def profesionInstance = Profesion.get(params.id)
            if (profesionInstance) {
                try {
                    profesionInstance.delete(flush: true)
                    render "OK_Eliminación de Profesión."
                } catch (e) {
                    render "NO_No se pudo eliminar Profesión"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Profesión."
    } //notFound para ajax




}
