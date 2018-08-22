package cratos

import org.springframework.dao.DataIntegrityViolationException

class DetallePagoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [detallePagoInstanceList: DetallePago.list(params), params: params]
    } //list

    def form_ajax() {

        def empresa = Empresa.get(session.empresa.id)

        def detallePagoInstance = new DetallePago(params)
        if(params.id) {
            detallePagoInstance = DetallePago.get(params.id)
            if(!detallePagoInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Detalle Pago con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit

        def rubroTipoContrato = RubroTipoContrato.withCriteria {
            tipoContrato{
                eq("empresa", empresa)
            }
        }

        def empleados = Empleado.withCriteria {
            eq("estado", "A")
            departamento{
                eq("empresa",empresa)
            }
        }

        def roles = RolPagos.findAllByEmpresa(empresa).sort{it.anio.anio}

        return [detallePagoInstance: detallePagoInstance, rubroTipoContrato: rubroTipoContrato, empleados: empleados.sort{it.persona.apellido}, roles: roles]
    } //form_ajax

    def save() {

        println("params " + params)

        def detallePagoInstance

        if(params.id){
            detallePagoInstance = DetallePago.get(params.id)
        }else{
            detallePagoInstance = new DetallePago()
        }

        detallePagoInstance.rubroTipoContrato = RubroTipoContrato.get(params."rubroTipoContrato.id")
        detallePagoInstance.empleado = Empleado.get(params."empleado.id")
        detallePagoInstance.rolPagos = RolPagos.get(params."rolPagos.id")
        detallePagoInstance.valor = params.valor.toDouble()
        detallePagoInstance.descripcion = params.descripcion

        try{
            detallePagoInstance.save(flush: true)
            render "ok"
        }catch (e){
            println("error a guardar el detalle de pago " + e)
            render "no"
        }

    } //save

    def show_ajax() {
        def detallePagoInstance = DetallePago.get(params.id)
        if (!detallePagoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Detalle Pago con id " + params.id
            redirect(action: "list")
            return
        }
        [detallePagoInstance: detallePagoInstance]
    } //show

    def delete() {
        def detallePagoInstance = DetallePago.get(params.id)
        if (!detallePagoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Detalle Pago con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            detallePagoInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message =  "Se ha eliminado correctamente Detalle Pago " + detallePagoInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message =  "No se pudo eliminar Detalle Pago " + (detallePagoInstance.id ? detallePagoInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
