package cratos


class TipoComprobanteIdController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoComprobanteIdInstanceList = TipoComprobanteId.list(params)
        def tipoComprobanteIdInstanceCount = TipoComprobanteId.count()
        if(tipoComprobanteIdInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoComprobanteIdInstanceList = TipoComprobanteId.list(params)
        return [tipoComprobanteIdInstanceList: tipoComprobanteIdInstanceList, tipoComprobanteIdInstanceCount: tipoComprobanteIdInstanceCount]
    } //list

    def show_ajax() {
        if(params.id) {
            def tipoComprobanteIdInstance = TipoComprobanteId.get(params.id)
            if(!tipoComprobanteIdInstance) {
                notFound_ajax()
                return
            }
            return [tipoComprobanteIdInstance: tipoComprobanteIdInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoComprobanteIdInstance = new TipoComprobanteId(params)
        if(params.id) {
            tipoComprobanteIdInstance = TipoComprobanteId.get(params.id)
            if(!tipoComprobanteIdInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoComprobanteIdInstance: tipoComprobanteIdInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        params.each { k, v ->
            if (v != "date.struct" && v instanceof java.lang.String) {
                params[k] = v.toUpperCase()
            }
        }

        def tipoComprobanteIdInstance = new TipoComprobanteId()
        if(params.id) {
            tipoComprobanteIdInstance = TipoComprobanteId.get(params.id)
            if(!tipoComprobanteIdInstance) {
                notFound_ajax()
                return
            }
        } //update
        tipoComprobanteIdInstance.properties = params
        if(!tipoComprobanteIdInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} TipoComprobanteId."
            msg += renderErrors(bean: tipoComprobanteIdInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de TipoComprobanteId exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def tipoComprobanteIdInstance = TipoComprobanteId.get(params.id)
            if(tipoComprobanteIdInstance) {
                try {
                    tipoComprobanteIdInstance.delete(flush:true)
                    render "OK_Eliminación de TipoComprobanteId exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar TipoComprobanteId."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró TipoComprobanteId."
    } //notFound para ajax

}
