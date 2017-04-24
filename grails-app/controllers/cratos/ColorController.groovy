package cratos

import org.springframework.dao.DataIntegrityViolationException

class ColorController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [colorInstanceList: Color.list(params), colorInstanceTotal: Color.count()]
//    }

    def create() {
        [colorInstance: new Color(params)]
    }

    def save() {
        def colorInstance
        if (params.id) {
            colorInstance = Color.get(params.id)
            if (!colorInstance) {
                flash.message = "No se encontr&oacute; Color a modificar"
                render "NO"
                return
            }
            colorInstance.properties = params
        } else {
            colorInstance = new Color(params)
        }
        if (!colorInstance.save(flush: true)) {
            render "NO"
            println colorInstance.errors
            flash.message = "Ha ocurrido un error al guardar Color"
            return
        }

        flash.message = "Color guardado exitosamente"
//    redirect(action: "show", id: colorInstance.id)
        render "OK"
    }

    def show() {
        def colorInstance = Color.get(params.id)
        if (!colorInstance) {
            flash.message = "No se encontr&oacute; Color a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [colorInstance: colorInstance]
    }

    def edit() {
        def colorInstance = Color.get(params.id)
        if (!colorInstance) {
            flash.message = "No se encontr&oacute; Color a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [colorInstance: colorInstance]
    }

    def delete() {
        def colorInstance = Color.get(params.id)
        if (!colorInstance) {
            flash.message = "No se encontr&oacute; Color a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            colorInstance.delete(flush: true)
            flash.message = "Color eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar Color"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def colorInstanceList = Color.list(params)
        def colorInstanceCount = Color.count()
        if (colorInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        colorInstanceList = Color.list(params)
        return [colorInstanceList: colorInstanceList, colorInstanceCount: colorInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def colorInstance = Color.get(params.id)
            if (!colorInstance) {
                notFound_ajax()
                return
            }
            return [colorInstance: colorInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def colorInstance = new Color(params)
        if (params.id) {
            colorInstance = Color.get(params.id)
            if (!colorInstance) {
                notFound_ajax()
                return
            }
        }
        return [colorInstance: colorInstance]
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
//        params.empresa = session.empresa


        //original
        def colorInstance = new Color()
        if (params.id) {
            colorInstance = Color.get(params.id)
            colorInstance.properties = params
            if (!colorInstance) {
                notFound_ajax()
                return
            }
        }else {

            colorInstance = new Color()
            colorInstance.properties = params
//            colorInstance.estado = '1'
//            colorInstance.empresa = session.empresa


        } //update


        if (!colorInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Color."
            msg += renderErrors(bean: colorInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Color."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def colorInstance = Color.get(params.id)
            if (colorInstance) {
                try {
                    colorInstance.delete(flush: true)
                    render "OK_Eliminación de Color."
                } catch (e) {
                    render "NO_No se pudo eliminar el Color"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Color."
    } //notFound para ajax


}
