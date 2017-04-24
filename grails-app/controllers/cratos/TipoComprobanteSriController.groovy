package cratos


class TipoComprobanteSriController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoComprobanteSriInstanceList = TipoComprobanteSri.list(params)
        def tipoComprobanteSriInstanceCount = TipoComprobanteSri.count()
        if(tipoComprobanteSriInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoComprobanteSriInstanceList = TipoComprobanteSri.list(params)
        return [tipoComprobanteSriInstanceList: tipoComprobanteSriInstanceList, tipoComprobanteSriInstanceCount: tipoComprobanteSriInstanceCount]
    } //list

    def show_ajax() {
        if(params.id) {
            def tipoComprobanteSriInstance = TipoComprobanteSri.get(params.id)
            if(!tipoComprobanteSriInstance) {
                notFound_ajax()
                return
            }
            return [tipoComprobanteSriInstance: tipoComprobanteSriInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoComprobanteSriInstance = new TipoComprobanteSri(params)
        if(params.id) {
            tipoComprobanteSriInstance = TipoComprobanteSri.get(params.id)
            if(!tipoComprobanteSriInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoComprobanteSriInstance: tipoComprobanteSriInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        params.each { k, v ->
            if (v != "date.struct" && v instanceof java.lang.String) {
                params[k] = v.toUpperCase()
            }
        }

        def tipoComprobanteSriInstance = new TipoComprobanteSri()
        if(params.id) {
            tipoComprobanteSriInstance = TipoComprobanteSri.get(params.id)
            if(!tipoComprobanteSriInstance) {
                notFound_ajax()
                return
            }
        } //update
        tipoComprobanteSriInstance.properties = params
        if(!tipoComprobanteSriInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} TipoComprobanteSri."
            msg += renderErrors(bean: tipoComprobanteSriInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de TipoComprobanteSri exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def tipoComprobanteSriInstance = TipoComprobanteSri.get(params.id)
            if(tipoComprobanteSriInstance) {
                try {
                    tipoComprobanteSriInstance.delete(flush:true)
                    render "OK_Eliminación de TipoComprobanteSri exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar TipoComprobanteSri."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró TipoComprobanteSri."
    } //notFound para ajax

}
