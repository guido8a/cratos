package cratos


class FormaDePagoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def formaDePagoInstanceList = FormaDePago.list(params)
        def formaDePagoInstanceCount = FormaDePago.count()
        if(formaDePagoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        formaDePagoInstanceList = FormaDePago.list(params)
        return [formaDePagoInstanceList: formaDePagoInstanceList, formaDePagoInstanceCount: formaDePagoInstanceCount]
    } //list

    def show_ajax() {
        if(params.id) {
            def formaDePagoInstance = FormaDePago.get(params.id)
            if(!formaDePagoInstance) {
                notFound_ajax()
                return
            }
            return [formaDePagoInstance: formaDePagoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def formaDePagoInstance = new FormaDePago(params)
        if(params.id) {
            formaDePagoInstance = FormaDePago.get(params.id)
            if(!formaDePagoInstance) {
                notFound_ajax()
                return
            }
        }
        return [formaDePagoInstance: formaDePagoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        params.each { k, v ->
            if (v != "date.struct" && v instanceof java.lang.String) {
                params[k] = v.toUpperCase()
            }
        }

        def formaDePagoInstance = new FormaDePago()
        if(params.id) {
            formaDePagoInstance = FormaDePago.get(params.id)
            if(!formaDePagoInstance) {
                notFound_ajax()
                return
            }
        } //update
        formaDePagoInstance.properties = params
        if(!formaDePagoInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} FormaDePago."
            msg += renderErrors(bean: formaDePagoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de FormaDePago exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def formaDePagoInstance = FormaDePago.get(params.id)
            if(formaDePagoInstance) {
                try {
                    formaDePagoInstance.delete(flush:true)
                    render "OK_Eliminación de FormaDePago exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar FormaDePago."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró FormaDePago."
    } //notFound para ajax

}
