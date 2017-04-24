package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoIdentificacionController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

//def list() {
//    params.max = Math.min(params.max ? params.int('max') : 10, 100)
//    [tipoIdentificacionInstanceList: TipoIdentificacion.list(params), tipoIdentificacionInstanceTotal: TipoIdentificacion.count()]
//}

def create() {
    [tipoIdentificacionInstance: new TipoIdentificacion(params)]
}

def save() {
    def tipoIdentificacionInstance
    if(params.id) {
        tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
        if(!tipoIdentificacionInstance) {
            flash.message = "No se encontr&oacute; TipoIdentificacion a modificar"
            render "NO"
            return
        }
        tipoIdentificacionInstance.properties = params
    } else {
        tipoIdentificacionInstance = new TipoIdentificacion(params)
    }
    if (!tipoIdentificacionInstance.save(flush: true)) {
        render "NO"
        println tipoIdentificacionInstance.errors
        flash.message = "Ha ocurrido un error al guardar TipoIdentificacion"
        return
    }

    flash.message = "TipoIdentificacion guardado exitosamente"
//    redirect(action: "show", id: tipoIdentificacionInstance.id)
    render "OK"
}

def show() {
    def tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
    if (!tipoIdentificacionInstance) {
        flash.message = "No se encontr&oacute; TipoIdentificacion a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [tipoIdentificacionInstance: tipoIdentificacionInstance]
}

def edit() {
    def tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
    if (!tipoIdentificacionInstance) {
        flash.message = "No se encontr&oacute; TipoIdentificacion a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [tipoIdentificacionInstance: tipoIdentificacionInstance]
}

def delete() {
    def tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
    if (!tipoIdentificacionInstance) {
        flash.message = "No se encontr&oacute; TipoIdentificacion a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        tipoIdentificacionInstance.delete(flush: true)
        flash.message = "TipoIdentificacion eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar TipoIdentificacion"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoIdentificacionInstanceList = TipoIdentificacion.list(params)
        def tipoIdentificacionInstanceCount = TipoIdentificacion.count()
        if (tipoIdentificacionInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoIdentificacionInstanceList = TipoIdentificacion.list(params)
        return [tipoIdentificacionInstanceList: tipoIdentificacionInstanceList, tipoIdentificacionInstanceCount: tipoIdentificacionInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
            if (!tipoIdentificacionInstance) {
                notFound_ajax()
                return
            }
            return [tipoIdentificacionInstance: tipoIdentificacionInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoIdentificacionInstance = new TipoIdentificacion(params)
        if (params.id) {
            tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
            if (!tipoIdentificacionInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoIdentificacionInstance: tipoIdentificacionInstance]
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
        def tipoIdentificacionInstance = new TipoIdentificacion()
        if (params.id) {
            tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
            tipoIdentificacionInstance.properties = params
            if (!tipoIdentificacionInstance) {
                notFound_ajax()
                return
            }
        }else {

            tipoIdentificacionInstance = new TipoIdentificacion()
            tipoIdentificacionInstance.properties = params
//            tipoidentificacionInstance.estado = '1'
//            tipoIdentificacionInstance.empresa = session.empresa


        } //update


        if (!tipoIdentificacionInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo de Identificación."
            msg += renderErrors(bean: tipoIdentificacionInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo de Identificación."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
            if (tipoIdentificacionInstance) {
                try {
                    tipoIdentificacionInstance.delete(flush: true)
                    render "OK_Eliminación de Tipo de Identificación."
                } catch (e) {
                    render "NO_No se pudo eliminar el Tipo de Identificación"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Tipo de Identificación."
    } //notFound para ajax






}
