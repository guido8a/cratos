package cratos

import org.springframework.dao.DataIntegrityViolationException

class BodegaController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

//def list() {
//    params.max = Math.min(params.max ? params.int('max') : 10, 100)
//    [bodegaInstanceList: Bodega.list(params), bodegaInstanceTotal: Bodega.count()]
//}

def create() {
    [bodegaInstance: new Bodega(params)]
}

def save() {
    def bodegaInstance
    if(params.id) {
        bodegaInstance = Bodega.get(params.id)
        if(!bodegaInstance) {
            flash.message = "No se encontr&oacute; Bodega a modificar"
            render "NO"
            return
        }
        bodegaInstance.properties = params
    } else {
        bodegaInstance = new Bodega(params)
    }
    if (!bodegaInstance.save(flush: true)) {
        render "NO"
        println bodegaInstance.errors
        flash.message = "Ha ocurrido un error al guardar Bodega"
        return
    }

    flash.message = "Bodega guardado exitosamente"
//    redirect(action: "show", id: bodegaInstance.id)
    render "OK"
}

def show() {
    def bodegaInstance = Bodega.get(params.id)
    if (!bodegaInstance) {
        flash.message = "No se encontr&oacute; Bodega a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [bodegaInstance: bodegaInstance]
}

def edit() {
    def bodegaInstance = Bodega.get(params.id)
    if (!bodegaInstance) {
        flash.message = "No se encontr&oacute; Bodega a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [bodegaInstance: bodegaInstance]
}

def delete() {
    def bodegaInstance = Bodega.get(params.id)
    if (!bodegaInstance) {
        flash.message = "No se encontr&oacute; Bodega a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        bodegaInstance.delete(flush: true)
        flash.message = "Bodega eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar Bodega"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}


    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def bodegaInstanceList = Bodega.list(params)
        def bodegaInstanceCount = Bodega.count()
        if (bodegaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        bodegaInstanceList = Bodega.list(params)
        return [bodegaInstanceList: bodegaInstanceList, bodegaInstanceCount: bodegaInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def bodegaInstance = Bodega.get(params.id)
            if (!bodegaInstance) {
                notFound_ajax()
                return
            }
            return [bodegaInstance: bodegaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def bodegaInstance = new Bodega(params)
        if (params.id) {
            bodegaInstance = Bodega.get(params.id)
            if (!bodegaInstance) {
                notFound_ajax()
                return
            }
        }
        return [bodegaInstance: bodegaInstance]
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
//        params.empresa = session.empresa


        //original
        def bodegaInstance = new Bodega()
        if (params.id) {
            bodegaInstance = Bodega.get(params.id)
            bodegaInstance.properties = params
            if (!bodegaInstance) {
                notFound_ajax()
                return
            }
        }else {

            bodegaInstance = new Bodega()
            bodegaInstance.properties = params
//            bodegaInstance.estado = '1'
//            bodegaInstance.empresa = session.empresa


        } //update


        if (!bodegaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Bodega."
            msg += renderErrors(bean: bodegaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Bodega."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def bodegaInstance = Bodega.get(params.id)
            if (bodegaInstance) {
                try {
                    bodegaInstance.delete(flush: true)
                    render "OK_Eliminación de Bodega."
                } catch (e) {
                    render "NO_No se pudo eliminar la Bodega"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Bodega."
    } //notFound para ajax
    
    
}
