package cratos

import org.springframework.dao.DataIntegrityViolationException

class ReporteCuentaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [reporteCuentaInstanceList: ReporteCuenta.list(params), reporteCuentaInstanceTotal: ReporteCuenta.count()]
//    }

    def create() {
        [reporteCuentaInstance: new ReporteCuenta(params)]
    }

    def save() {
        def reporteCuentaInstance = new ReporteCuenta(params)

        reporteCuentaInstance.properties = params
        reporteCuentaInstance.empresa = session.empresa

        if (params.id) {
            reporteCuentaInstance = ReporteCuenta.get(params.id)
            if (!reporteCuentaInstance) {
                flash.message = "No se encontr&oacute; ReporteCuenta a modificar"
                render "NO"
                return
            }
            reporteCuentaInstance.properties = params
        } else {
            reporteCuentaInstance = new ReporteCuenta(params)
        }
        if (!reporteCuentaInstance.save(flush: true)) {
            render "NO"
            println reporteCuentaInstance.errors
            flash.message = "Ha ocurrido un error al guardar ReporteCuenta"
            return
        }

        flash.message = "ReporteCuenta guardado exitosamente"
//    redirect(action: "show", id: reporteCuentaInstance.id)
        render "OK"
    }

    def show() {
        def reporteCuentaInstance = ReporteCuenta.get(params.id)
        if (!reporteCuentaInstance) {
            flash.message = "No se encontr&oacute; ReporteCuenta a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [reporteCuentaInstance: reporteCuentaInstance]
    }

    def edit() {
        def reporteCuentaInstance = ReporteCuenta.get(params.id)
        if (!reporteCuentaInstance) {
            flash.message = "No se encontr&oacute; ReporteCuenta a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [reporteCuentaInstance: reporteCuentaInstance]
    }

    def delete() {
        def reporteCuentaInstance = ReporteCuenta.get(params.id)
        if (!reporteCuentaInstance) {
            flash.message = "No se encontr&oacute; ReporteCuenta a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            reporteCuentaInstance.delete(flush: true)
            flash.message = "ReporteCuenta eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar ReporteCuenta"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        def empresa = Empresa.get(session.empresa.id)
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def reporteCuentaInstanceList = ReporteCuenta.findAllByEmpresa(empresa)
        def reporteCuentaInstanceCount = ReporteCuenta.count()
        if (reporteCuentaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        reporteCuentaInstanceList = ReporteCuenta.findAllByEmpresa(empresa)
        return [reporteCuentaInstanceList: reporteCuentaInstanceList, reporteCuentaInstanceCount: reporteCuentaInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def reporteCuentaInstance = ReporteCuenta.get(params.id)
            if (!reporteCuentaInstance) {
                notFound_ajax()
                return
            }
            return [reporteCuentaInstance: reporteCuentaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def reporteCuentaInstance = new ReporteCuenta(params)
        if (params.id) {
            reporteCuentaInstance = ReporteCuenta.get(params.id)
            if (!reporteCuentaInstance) {
                notFound_ajax()
                return
            }
        }
        return [reporteCuentaInstance: reporteCuentaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {

//        println("params:" + params)

        //nuevo

        def persona

//        params.descripcion = params.descripcion.toUpperCase()
//        params.codigo = params.codigo.toUpperCase()
        params.empresa = session.empresa


        //original
        def reporteCuentaInstance = new ReporteCuenta()
        if (params.id) {
            reporteCuentaInstance = ReporteCuenta.get(params.id)
            reporteCuentaInstance.properties = params
            if (!reporteCuentaInstance) {
                notFound_ajax()
                return
            }
        }else {

            reporteCuentaInstance = new ReporteCuenta()
            reporteCuentaInstance.properties = params
//            reportecuentaInstance.estado = '1'
//            reportecuentaInstance.empresa = session.empresa


        } //update


        if (!reporteCuentaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Reporte de cuentas."
            msg += renderErrors(bean: reporteCuentaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Reporte de cuentas."
    } //save para grabar desde ajax



    def delete_ajax() {
        if (params.id) {
            def reporteCuentaInstance = ReporteCuenta.get(params.id)
            if (reporteCuentaInstance) {
                try {
                    reporteCuentaInstance.delete(flush: true)
                    render "OK_Eliminación de Reporte de cuentas."
                } catch (e) {
                    render "NO_No se pudo eliminar el Reporte de cuentas"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Reporte de cuentas."
    } //notFound para ajax


}
