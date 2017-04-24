package cratos


class TipoRubroController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoRubroInstanceList = TipoRubro.list(params)
        def tipoRubroInstanceCount = TipoRubro.count()
        if(tipoRubroInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoRubroInstanceList = TipoRubro.list(params)
        return [tipoRubroInstanceList: tipoRubroInstanceList, tipoRubroInstanceCount: tipoRubroInstanceCount]
    } //list

    def show_ajax() {
        if(params.id) {
            def tipoRubroInstance = TipoRubro.get(params.id)
            if(!tipoRubroInstance) {
                notFound_ajax()
                return
            }
            return [tipoRubroInstance: tipoRubroInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoRubroInstance = new TipoRubro(params)
        if(params.id) {
            tipoRubroInstance = TipoRubro.get(params.id)
            if(!tipoRubroInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoRubroInstance: tipoRubroInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        params.each { k, v ->
            if (v != "date.struct" && v instanceof java.lang.String) {
                params[k] = v.toUpperCase()
            }
        }

        def tipoRubroInstance = new TipoRubro()
        if(params.id) {
            tipoRubroInstance = TipoRubro.get(params.id)
            if(!tipoRubroInstance) {
                notFound_ajax()
                return
            }
        } //update
        tipoRubroInstance.properties = params
        if(!tipoRubroInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} TipoRubro."
            msg += renderErrors(bean: tipoRubroInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de TipoRubro exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def tipoRubroInstance = TipoRubro.get(params.id)
            if(tipoRubroInstance) {
                try {
                    tipoRubroInstance.delete(flush:true)
                    render "OK_Eliminación de TipoRubro exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar TipoRubro."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró TipoRubro."
    } //notFound para ajax

}
