package cratos

import org.springframework.dao.DataIntegrityViolationException

class RolPagosController extends cratos.seguridad.Shield {

    def dbConnectionService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        def empresa =session.empresa.id
        def cn = dbConnectionService.getConnection()
        params.max = 15
//        [rubroTipoContratoInstanceList: RubroTipoContrato.list(params), params: params,
//         rubroTipoContratoInstanceCount: RubroTipoContrato.count() ]

        def sqlSelect = "select rlpg__id id, messdscr mess, anioanio anio, rlpg.mess__id mess__id, rlpg.anio__id anio__id, rlpgfcha fecha, " +
                "rlpgfcmd fechaModificacion, rlpgpgdo pagado, rlpgetdo estado "
        def sqlWhere = "from rlpg, mess, anio " +
                "where empr__id = ${empresa} and mess.mess__id = rlpg.mess__id and " +
                "anio.anio__id = rlpg.anio__id "
        def sqlOrder = "order by rlpg.anio__id, rlpg.mess__id "
        def sqlLimit = "offset ${params.offset} limit ${params.max}"
        def sqlCount = "select count(*) cnta "
//        println "--- ${sqlSelect + sqlWhere + sqlOrder + sqlLimit}"
        def data = cn.rows((sqlSelect + sqlWhere + sqlOrder + sqlLimit).toString())
//        println "--- ${sqlCount + sqlWhere}"
        def cnta = cn.rows((sqlCount + sqlWhere).toString())[0].cnta
//        println "${data.size()}, cnta: $cnta"

        /*MES*/

        def mesesAprobados = []

        data.each {
            if(it.estado == 'A'){
                mesesAprobados += it.mess__id
            }
        }

        def meses = Mes.findAllByIdNotInList(mesesAprobados)

        [rolPagosInstanceList: data, params: params, rolPagosInstanceCount: cnta, params: params, meses: meses]
//        [rolPagosInstanceList: RolPagos.findAllByEmpresa(empresa), params: params, rolPagosInstanceCount: RolPagos.findAllByEmpresa(empresa).size()]

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

        def detalles = DetallePago.withCriteria {

            eq("rolPagos", rolPago)

            rubroTipoContrato{

                tipoContrato{
                    eq("empresa",empresa)
                }
            }
        }


        def rubros = detalles.rubroTipoContrato.unique().sort{it.descripcion}
        return[rubros: rubros]
    }

    def rubros () {
        def rubroTipoContrato = RubroTipoContrato.get(params.rubro)
        def rolPago = RolPagos.get(params.id)
        return[rubro: rubroTipoContrato, rol: rolPago]
    }

    def empleados () {
        def rolPagos = RolPagos.get(params.id)
        return [rol: rolPagos.id]
    }

    def tablaEmpleados_ajax () {
        def rolPagos = RolPagos.get(params.id)
        def detallePagos = DetallePago.findAllByRolPagos(rolPagos).sort{it.empleado.persona.id}

        def ingresos = 0
        def descuentos = 0
        def arreglo = [:]
        def arregloDes = [:]


        def personas = detallePagos.empleado.unique().sort{it.persona.id}

        personas.each { p->

            ingresos = 0
            descuentos = 0

            detallePagos.each{ f->

                if(p.id == f.empleado.id){

                    if(f?.rubroTipoContrato?.rubro?.tipoRubro?.codigo == 'I'){
                        ingresos += f.valor
                    }

                    if(f?.rubroTipoContrato?.rubro?.tipoRubro?.codigo == 'D'){
                        descuentos += f.valor
                    }
                }
                arreglo.put(p,ingresos)
                arregloDes.put(p,descuentos)
            }
        }

//        println("arreglo " + arreglo)
//        println("des " + arregloDes)

        return [detalles: detallePagos, ingresos: arreglo, descuentos: arregloDes, rolPagos: rolPagos]
    }

    def tablaRubros_ajax () {
        def rubroTipoContrato = RubroTipoContrato.get(params.id)
        def rolPago = RolPagos.get(params.rol)
        def detallePagos = DetallePago.findAllByRubroTipoContratoAndRolPagos(rubroTipoContrato, rolPago)

        return[detalles: detallePagos]
    }

    def desglose () {

        def rol = RolPagos.get(params.rol)
        def empleado = Empleado.get(params.id)
        def detalles = DetallePago.findAllByRolPagosAndEmpleadoAndValorNotEqual(rol,empleado, 0.00,[sort: 'rubroTipoContrato.rubro.tipoRubro', order: 'asc'])

        return[detalles: detalles, rol: rol, empleado: empleado]
    }

    def tablaRolPagos_ajax() {

//        println("params trp" + params)

        def empresa = Empresa.get(session.empresa.id)

        if(params.tipo == '1'){

            def cn = dbConnectionService.getConnection()

            def sqlSelect = "select rlpg__id id, messdscr mess, anioanio anio, rlpg.mess__id mess__id, rlpg.anio__id anio__id, rlpgfcha fecha, " +
                    "rlpgfcmd fechaModificacion, rlpgpgdo pagado, rlpgetdo estado "
            def sqlWhere = "from rlpg, mess, anio " +
                    "where empr__id = ${empresa?.id} and mess.mess__id = rlpg.mess__id and " +
                    "anio.anio__id = rlpg.anio__id "
            def sqlOrder = "order by rlpg.anio__id, rlpg.mess__id "

            def data = cn.rows((sqlSelect + sqlWhere + sqlOrder).toString())

//            println("data " + data)

            [rolPagosInstanceList: data, tipo: params.tipo, parametros: params]

        }else{

            def roles = RolPagos.withCriteria {

                eq("empresa",empresa)

                and{

                    if(params.anio && params.anio != 'null'){
                        def anio = Anio.get(params.anio)
                            eq("anio", anio)
                    }

                    if(params.mes && params.mes != 'null'){
                        def mes = Mes.get(params.mes)
                            eq("mess",mes)
                    }

                    if(params.estado && params.estado != 'null'){
                            eq("estado",params.estado)
                    }

                    if (params.desde){
                        def d = new Date().parse("dd-MM-yyy", params.desde)
                            ge("fecha",d)
                    }

                    if(params.hasta){
                        def h = new Date().parse("dd-MM-yyy", params.hasta)
                            le("fecha", h)
                    }
                }

                order("mess","asc")

            }

//            println("roles " + roles)

            return [roles: roles, tipo: params.tipo, parametros: params]
        }
    }


    def meses_ajax () {

        def empresa =session.empresa.id
        def cn = dbConnectionService.getConnection()
        params.max = 15

        def sqlSelect = "select rlpg__id id, messdscr mess, anioanio anio, rlpg.mess__id mess__id, rlpg.anio__id anio__id, rlpgfcha fecha, " +
                "rlpgfcmd fechaModificacion, rlpgpgdo pagado, rlpgetdo estado "
        def sqlWhere = "from rlpg, mess, anio " +
                "where empr__id = ${empresa} and mess.mess__id = rlpg.mess__id and " +
                "anio.anio__id = rlpg.anio__id "
        def sqlOrder = "order by rlpg.anio__id, rlpg.mess__id "
        def sqlLimit = "offset ${params.offset} limit ${params.max}"
        def sqlCount = "select count(*) cnta "
        def data = cn.rows((sqlSelect + sqlWhere + sqlOrder + sqlLimit).toString())

        /*MES*/

        def mesesAprobados = []

        data.each {
            if(it.estado == 'A'){
                mesesAprobados += it.mess__id
            }
        }

        def meses = mesesAprobados ? Mes.findAllByIdNotInList(mesesAprobados) : Mes.list()

        return [meses: meses]

    }


} //fin controller
