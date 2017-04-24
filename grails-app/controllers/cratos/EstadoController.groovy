package cratos


class EstadoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def estadoInstanceList = Estado.list(params)
        def estadoInstanceCount = Estado.count()
        if(estadoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        estadoInstanceList = Estado.list(params)
        return [estadoInstanceList: estadoInstanceList, estadoInstanceCount: estadoInstanceCount]
    } //list

    def show_ajax() {
        if(params.id) {
            def estadoInstance = Estado.get(params.id)
            if(!estadoInstance) {
                notFound_ajax()
                return
            }
            return [estadoInstance: estadoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def estadoInstance = new Estado(params)
        if(params.id) {
            estadoInstance = Estado.get(params.id)
            if(!estadoInstance) {
                notFound_ajax()
                return
            }
        }
        return [estadoInstance: estadoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        params.each { k, v ->
            if (v != "date.struct" && v instanceof java.lang.String) {
                params[k] = v.toUpperCase()
            }
        }

        def estadoInstance = new Estado()
        if(params.id) {
            estadoInstance = Estado.get(params.id)
            if(!estadoInstance) {
                notFound_ajax()
                return
            }
        } //update
        estadoInstance.properties = params
        if(!estadoInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Estado."
            msg += renderErrors(bean: estadoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Estado exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def estadoInstance = Estado.get(params.id)
            if(estadoInstance) {
                try {
                    estadoInstance.delete(flush:true)
                    render "OK_Eliminación de Estado exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Estado."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Estado."
    } //notFound para ajax

}
