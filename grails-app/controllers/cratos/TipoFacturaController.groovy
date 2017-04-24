package cratos


class TipoFacturaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoFacturaInstanceList = TipoFactura.list(params)
        def tipoFacturaInstanceCount = TipoFactura.count()
        if(tipoFacturaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoFacturaInstanceList = TipoFactura.list(params)
        return [tipoFacturaInstanceList: tipoFacturaInstanceList, tipoFacturaInstanceCount: tipoFacturaInstanceCount]
    } //list

    def show_ajax() {
        if(params.id) {
            def tipoFacturaInstance = TipoFactura.get(params.id)
            if(!tipoFacturaInstance) {
                notFound_ajax()
                return
            }
            return [tipoFacturaInstance: tipoFacturaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoFacturaInstance = new TipoFactura(params)
        if(params.id) {
            tipoFacturaInstance = TipoFactura.get(params.id)
            if(!tipoFacturaInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoFacturaInstance: tipoFacturaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        params.each { k, v ->
            if (v != "date.struct" && v instanceof java.lang.String) {
                params[k] = v.toUpperCase()
            }
        }

        def tipoFacturaInstance = new TipoFactura()
        if(params.id) {
            tipoFacturaInstance = TipoFactura.get(params.id)
            if(!tipoFacturaInstance) {
                notFound_ajax()
                return
            }
        } //update
        tipoFacturaInstance.properties = params
        if(!tipoFacturaInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} TipoFactura."
            msg += renderErrors(bean: tipoFacturaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de TipoFactura exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def tipoFacturaInstance = TipoFactura.get(params.id)
            if(tipoFacturaInstance) {
                try {
                    tipoFacturaInstance.delete(flush:true)
                    render "OK_Eliminación de TipoFactura exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar TipoFactura."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró TipoFactura."
    } //notFound para ajax

}
