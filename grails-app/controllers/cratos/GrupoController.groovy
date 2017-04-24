package cratos


class GrupoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def grupoInstanceList = Grupo.list(params)
        def grupoInstanceCount = Grupo.count()
        if(grupoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        grupoInstanceList = Grupo.list(params)
        return [grupoInstanceList: grupoInstanceList, grupoInstanceCount: grupoInstanceCount]
    } //list

    def show_ajax() {
        if(params.id) {
            def grupoInstance = Grupo.get(params.id)
            if(!grupoInstance) {
                notFound_ajax()
                return
            }
            return [grupoInstance: grupoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def grupoInstance = new Grupo(params)
        if(params.id) {
            grupoInstance = Grupo.get(params.id)
            if(!grupoInstance) {
                notFound_ajax()
                return
            }
        }


        def cuentas = Cuenta.findAllByNumeroLike('1%',);



        return [grupoInstance: grupoInstance, cuentas: cuentas]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        params.each { k, v ->
            if (v != "date.struct" && v instanceof java.lang.String) {
                params[k] = v.toUpperCase()
            }
        }

        def grupoInstance = new Grupo()
        if(params.id) {
            grupoInstance = Grupo.get(params.id)
            if(!grupoInstance) {
                notFound_ajax()
                return
            }
        } //update
        grupoInstance.properties = params
        if(!grupoInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Grupo."
            msg += renderErrors(bean: grupoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Grupo exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def grupoInstance = Grupo.get(params.id)
            if(grupoInstance) {
                try {
                    grupoInstance.delete(flush:true)
                    render "OK_Eliminación de Grupo exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Grupo."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Grupo."
    } //notFound para ajax

}
