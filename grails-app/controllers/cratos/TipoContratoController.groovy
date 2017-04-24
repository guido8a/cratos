package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoContratoController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

//def list() {
//    params.max = Math.min(params.max ? params.int('max') : 10, 100)
//    [tipoContratoInstanceList: TipoContrato.list(params), tipoContratoInstanceTotal: TipoContrato.count()]
//}

def create() {
    [tipoContratoInstance: new TipoContrato(params)]
}

def save() {
    def tipoContratoInstance
    if(params.id) {
        tipoContratoInstance = TipoContrato.get(params.id)
        if(!tipoContratoInstance) {
            flash.message = "No se encontr&oacute; TipoContrato a modificar"
            render "NO"
            return
        }
        tipoContratoInstance.properties = params
    } else {
        tipoContratoInstance = new TipoContrato(params)
    }
    if (!tipoContratoInstance.save(flush: true)) {
        render "NO"
        println tipoContratoInstance.errors
        flash.message = "Ha ocurrido un error al guardar TipoContrato"
        return
    }

    flash.message = "TipoContrato guardado exitosamente"
//    redirect(action: "show", id: tipoContratoInstance.id)
    render "OK"
}

def show() {
    def tipoContratoInstance = TipoContrato.get(params.id)
    if (!tipoContratoInstance) {
        flash.message = "No se encontr&oacute; TipoContrato a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [tipoContratoInstance: tipoContratoInstance]
}

def edit() {
    def tipoContratoInstance = TipoContrato.get(params.id)
    if (!tipoContratoInstance) {
        flash.message = "No se encontr&oacute; TipoContrato a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [tipoContratoInstance: tipoContratoInstance]
}

def delete() {
    def tipoContratoInstance = TipoContrato.get(params.id)
    if (!tipoContratoInstance) {
        flash.message = "No se encontr&oacute; TipoContrato a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        tipoContratoInstance.delete(flush: true)
        flash.message = "TipoContrato eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar TipoContrato"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoContratoInstanceList = TipoContrato.list(params)
        def tipoContratoInstanceCount = TipoContrato.count()
        if (tipoContratoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoContratoInstanceList = TipoContrato.list(params)
        return [tipoContratoInstanceList: tipoContratoInstanceList, tipoContratoInstanceCount: tipoContratoInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def tipoContratoInstance = TipoContrato.get(params.id)
            if (!tipoContratoInstance) {
                notFound_ajax()
                return
            }
            return [tipoContratoInstance: tipoContratoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoContratoInstance = new TipoContrato(params)
        if (params.id) {
            tipoContratoInstance = TipoContrato.get(params.id)
            if (!tipoContratoInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoContratoInstance: tipoContratoInstance]
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
        def tipoContratoInstance = new TipoContrato()
        if (params.id) {
            tipoContratoInstance = TipoContrato.get(params.id)
            tipoContratoInstance.properties = params
            if (!tipoContratoInstance) {
                notFound_ajax()
                return
            }
        }else {

            tipoContratoInstance = new TipoContrato()
            tipoContratoInstance.properties = params
//            tipocontratoInstance.estado = '1'
//            tipoContratoInstance.empresa = session.empresa


        } //update


        if (!tipoContratoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo de Contrato."
            msg += renderErrors(bean: tipoContratoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo de Contrato."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def tipoContratoInstance = TipoContrato.get(params.id)
            if (tipoContratoInstance) {
                try {
                    tipoContratoInstance.delete(flush: true)
                    render "OK_Eliminación de Tipo de Contrato."
                } catch (e) {
                    render "NO_No se pudo eliminar el Tipo de Contrato"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Tipo de Contrato."
    } //notFound para ajax

}
