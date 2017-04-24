package cratos


class MesController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def mesInstanceList = Mes.list(params)
        def mesInstanceCount = Mes.count()
        if(mesInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        mesInstanceList = Mes.list(params)
        return [mesInstanceList: mesInstanceList, mesInstanceCount: mesInstanceCount]
    } //list

    def show_ajax() {
        if(params.id) {
            def mesInstance = Mes.get(params.id)
            if(!mesInstance) {
                notFound_ajax()
                return
            }
            return [mesInstance: mesInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def mesInstance = new Mes(params)
        if(params.id) {
            mesInstance = Mes.get(params.id)
            if(!mesInstance) {
                notFound_ajax()
                return
            }
        }
        return [mesInstance: mesInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        params.each { k, v ->
            if (v != "date.struct" && v instanceof java.lang.String) {
                params[k] = v.toUpperCase()
            }
        }

        def mesInstance = new Mes()
        if(params.id) {
            mesInstance = Mes.get(params.id)
            if(!mesInstance) {
                notFound_ajax()
                return
            }
        } //update
        mesInstance.properties = params
        if(!mesInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Mes."
            msg += renderErrors(bean: mesInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Mes exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def mesInstance = Mes.get(params.id)
            if(mesInstance) {
                try {
                    mesInstance.delete(flush:true)
                    render "OK_Eliminación de Mes exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Mes."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Mes."
    } //notFound para ajax

}
