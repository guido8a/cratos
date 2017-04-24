package cratos


class CargoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def cargoInstanceList = Cargo.findAllByEmpresa(session.empresa, params)
        def cargoInstanceCount = Cargo.countByEmpresa(session.empresa)
        if (cargoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        cargoInstanceList = Cargo.findAllByEmpresa(session.empresa, params)
        return [cargoInstanceList: cargoInstanceList, cargoInstanceCount: cargoInstanceCount]
    } //list

    def show_ajax() {
        if (params.id) {
            def cargoInstance = Cargo.get(params.id)
            if (!cargoInstance) {
                notFound_ajax()
                return
            }
            return [cargoInstance: cargoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def cargoInstance = new Cargo(params)
        if (params.id) {
            cargoInstance = Cargo.get(params.id)
            if (!cargoInstance) {
                notFound_ajax()
                return
            }
        }
        return [cargoInstance: cargoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        params.each { k, v ->
            if (v != "date.struct" && v instanceof java.lang.String) {
                params[k] = v.toUpperCase()
            }
        }

        params.empresa = session.empresa

        def cargoInstance = new Cargo()
        if (params.id) {
            cargoInstance = Cargo.get(params.id)
            if (!cargoInstance) {
                notFound_ajax()
                return
            }
        } //update
        cargoInstance.properties = params
        if (!cargoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Cargo."
            msg += renderErrors(bean: cargoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Cargo exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def cargoInstance = Cargo.get(params.id)
            if (cargoInstance) {
                try {
                    cargoInstance.delete(flush: true)
                    render "OK_Eliminación de Cargo exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Cargo."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Cargo."
    } //notFound para ajax

}
