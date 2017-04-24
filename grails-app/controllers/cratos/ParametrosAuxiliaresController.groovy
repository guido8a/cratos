package cratos


class ParametrosAuxiliaresController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def parametrosAuxiliaresInstanceList = ParametrosAuxiliares.list(params)
        def parametrosAuxiliaresInstanceCount = ParametrosAuxiliares.count()
        if (parametrosAuxiliaresInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        parametrosAuxiliaresInstanceList = ParametrosAuxiliares.list(params)
        return [parametrosAuxiliaresInstanceList: parametrosAuxiliaresInstanceList, parametrosAuxiliaresInstanceCount: parametrosAuxiliaresInstanceCount]
    } //list

    def show_ajax() {
        if (params.id) {
            def parametrosAuxiliaresInstance = ParametrosAuxiliares.get(params.id)
            if (!parametrosAuxiliaresInstance) {
                notFound_ajax()
                return
            }
            return [parametrosAuxiliaresInstance: parametrosAuxiliaresInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def parametrosAuxiliaresInstance = new ParametrosAuxiliares(params)
        if (params.id) {
            parametrosAuxiliaresInstance = ParametrosAuxiliares.get(params.id)
            if (!parametrosAuxiliaresInstance) {
                notFound_ajax()
                return
            }
        }
        return [parametrosAuxiliaresInstance: parametrosAuxiliaresInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        params.each { k, v ->
            if (v != "date.struct" && v instanceof java.lang.String) {
                params[k] = v.toUpperCase()
            }
        }

        def parametrosAuxiliaresInstance = new ParametrosAuxiliares()
        if (params.id) {
            parametrosAuxiliaresInstance = ParametrosAuxiliares.get(params.id)
            if (!parametrosAuxiliaresInstance) {
                notFound_ajax()
                return
            }
        } //update
        parametrosAuxiliaresInstance.properties = params
        if (!parametrosAuxiliaresInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} ParametrosAuxiliares."
            msg += renderErrors(bean: parametrosAuxiliaresInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de ParametrosAuxiliares exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def parametrosAuxiliaresInstance = ParametrosAuxiliares.get(params.id)
            if (parametrosAuxiliaresInstance) {
                try {
                    parametrosAuxiliaresInstance.delete(flush: true)
                    render "OK_Eliminación de ParametrosAuxiliares exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar ParametrosAuxiliares."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró ParametrosAuxiliares."
    } //notFound para ajax

}
