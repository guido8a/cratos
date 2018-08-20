package cratos

import org.springframework.dao.DataIntegrityViolationException

class RolPagosController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        def empresa = Empresa.get(session.empresa.id)

        if(session.perfil.nombre == 'Administrador General'){
            [rolPagosInstanceList: RolPagos.list(params), params: params, rolPagosInstanceCount: RolPagos.count()]
        }else{
            if(session.perfil.nombre == 'Administrador'){
                [rolPagosInstanceList: RolPagos.findAllByEmpresa(empresa), params: params, rolPagosInstanceCount: RolPagos.findAllByEmpresa(empresa).size()]
            }
        }

    } //list

    def form_ajax() {
        def rolPagosInstance = new RolPagos(params)
        if(params.id) {
            rolPagosInstance = RolPagos.get(params.id)
            if(!rolPagosInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Rol Pagos con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [rolPagosInstance: rolPagosInstance]
    } //form_ajax

    def save() {

        def rol
        def errores = ''
        def texto = ''

        if(params.id){
            rol = RolPagos.get(params.id)
            texto = 'Rol de Pagos actualizado correctamente'

        }else{
            rol = new RolPagos()
            texto = 'Rol de Pagos creado correctamente'
        }

        rol.anio = Anio.get(params."anio.id")
        rol.mess = Mes.get(params."mess.id")
        rol.fecha = new Date().parse("dd-MM-yyyy", params."fecha_input")
        rol.pagado = params.pagado.toDouble()
        rol.estado = params.estado

        if(session.perfil.nombre == 'Administrador General'){
            rol.empresa = Empresa.get(params."empresa.id")
        }else{
            rol.empresa = Empresa.get(session.empresa.id)
        }

        try{
            rol.save(flush: true)
        }catch (e){
            errores += e
        }

        if(errores == ''){
            render "OK_" + texto
        }else{
            render "NO"
        }

    } //save

    def show_ajax() {
        def rolPagosInstance = RolPagos.get(params.id)
        if (!rolPagosInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Rol Pagos con id " + params.id
            redirect(action: "list")
            return
        }
        [rolPagosInstance: rolPagosInstance]
    } //show

    def delete() {
        def rolPagosInstance = RolPagos.get(params.id)
        def texto = ''

        try{
            rolPagosInstance.delete(flush: true)
            texto = "OK"
        }catch (e){
            texto = "NO"
        }

        render texto

    } //delete


    def cambiarEstado_ajax() {
        def rolPagos = RolPagos.get(params.id)

        if(rolPagos.estado == 'N'){
            rolPagos.estado = 'A'
        }else{
            rolPagos.estado = 'N'
        }

        try{
            rolPagos.save(flush: true)
            render "ok"
        }catch (e){
            println("error al cambiar el estado del rolPagos " + e)
            render "no"
        }
    }

    def rubros_ajax () {
        def empresa = Empresa.get(session.empresa.id)
        def rolPago = RolPagos.get(params.id)

        def detalles = DetallePago.findAllByRolPagos(rolPago)
        def rubros = detalles.rubroTipoContrato.rubro

        return[rubros: rubros]
    }

    def rubros () {
        println("params " + params)
    }

    def empleados () {
        println("params " + params)
        def rolPagos = RolPagos.get(params.id)
        return [rol: rolPagos.id]
    }

    def tablaEmpleados_ajax () {
        def rolPagos = RolPagos.get(params.id)
        def detallePagos = DetallePago.findAllByRolPagos(rolPagos)

        def personas = detallePagos.empleado

        return [detalles: detallePagos]
    }


} //fin controller
