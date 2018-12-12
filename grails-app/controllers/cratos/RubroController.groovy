package cratos

import org.springframework.dao.DataIntegrityViolationException

class RubroController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def dbConnectionService
    def utilitarioService

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [rubroInstanceList: Rubro.list(params), rubroInstanceTotal: Rubro.count()]
//    }


    def rubros() {
        def tipos = TipoRubro.list([sort: "descripcion"])

        def rubroInstance = new Rubro(params)
        if (params.id) {
            rubroInstance = Rubro.get(params.id)
            if (!rubroInstance) {
                notFound_ajax()
//                return
            }
        }
        return [rubroInstance: rubroInstance, tipos: tipos]
    }

    def cargaRubros() {
        def rubros = Rubro.findAllByTipoRubroAndEmpresa(TipoRubro.get(params.id), session?.empresa, [sort: "descripcion"])
        println("rubros" + rubros)
        [rubros: rubros]
    }


    def create() {
        [rubroInstance: new Rubro(params)]
    }

    def addRubro() {
        println "params " + params
        def tipo = TipoRubro.get(params.tipo)
        def rubro
        if (params.id != "") {
            rubro = Rubro.get(params.id)
        } else {
            rubro = new Rubro()
        }
        rubro.descripcion = params.descripcion
        rubro.decimo = params.decimo
        rubro.gravable = params.grav
        rubro.iess = params.iess
        rubro.porcentaje = params.porcentaje.toDouble()
        rubro.valor = params.valor.toDouble()
        rubro.tipoRubro = tipo
        rubro.editable = "1"
        rubro.empresa = session.empresa
        if (!rubro.save(flush: true)) {
            println "error rubro save " + rubro.errors
        }
        redirect(action: "cargaRubros", id: params.tipo)
    }


    def composicion() {
        def tipos = TipoContrato.list([sort: "descripcion"])
        def tiposRubro = TipoRubro.list([sort: "descripcion"])
        def rubros = Rubro.findAllByTipoRubroAndEmpresa(tiposRubro[0], session.empresa)

        [tipos: tipos, tiposRubro: tiposRubro, rubros: rubros]
    }

    def cargaRubrosCombo() {
        def rubros = Rubro.findAllByTipoRubroAndEmpresa(TipoRubro.get(params.id), session.empresa, [sort: "descripcion"])
        [rubros: rubros]
    }

    def getDatosRubro() {
        def rubro = Rubro.get(params.id)
        render "" + rubro.valor + ";" + rubro.porcentaje + ";" + rubro.iess + ";" + rubro.gravable + ";" + rubro.decimo + ";" + rubro.editable
    }

//
    def addRubroContrato() {
        println "add rubro contrato " + params
        def rubro


        if (params.id != "") {
            rubro = RubroTipoContrato.get(params.id)
        } else {
            rubro = new RubroTipoContrato()
        }
        rubro.rubro = Rubro.get(params.rubro)
        rubro.decimo = params.decimo
        rubro.gravable = params.grav
        rubro.iess = params.iess
        rubro.porcentaje = params.porcentaje.toDouble()
        rubro.valor = params.valor.toDouble()
        rubro.tipoContrato = TipoContrato.get(params.tipoContrato)
        rubro.editable = "1"
        rubro.empresa = session.empresa
        if (!rubro.save(flush: true)) {
            println "error rubro save " + rubro.errors
        }
        redirect(action: "cargaRubrosContrato", id: params.tipoContrato)
    }

//    def agregarRubro() {
//
//        println("params " + params)
//
//        def rubroTipoContrato
//
//        def rubro = Rubro.get(params.rubro)
//        def tipoContrato = TipoContrato.get(params.tipoContrato)
//
//        if(params.gravable == true){
//
//            params.gravable = '1'
//        }else {
//
//            params.gravable = '0'
//        }
//
//        if(params.decimo == true){
//
//            params.decimo = '1'
//        }else {
//            params.decimo = '0'
//        }
//
//        if(params.iess == true){
//            params.iess = '1'
//        }else {
//            params.iess = '0'
//
//        }
//
//        def comp = RubroTipoContrato.findByRubroAndTipoContrato(rubro, tipoContrato)
//
//        if(comp != null){
//
//            render "EL rubro elegido ya está asignado a dicho Tipo de Contrato"
//
//        }else {
//
//            rubroTipoContrato = new RubroTipoContrato()
//
//            rubroTipoContrato.rubro = rubro
//            rubroTipoContrato.tipoContrato = tipoContrato
//            rubroTipoContrato.porcentaje = params.porcentaje.toDouble()
//            rubroTipoContrato.valor = params.valor.toDouble()
//            rubroTipoContrato.gravable = params.gravable
//            rubroTipoContrato.iess = params.iess
//            rubroTipoContrato.decimo = params.decimo
//
//            render "Rubro asignado correctamente"
//
//        }
//
//
//    }


    def cargaRubrosContrato() {
        def rubros = RubroTipoContrato.findAllByTipoContratoAndEmpresa(TipoContrato.get(params.id), session.empresa)
        rubros.sort { it.rubro.tipoRubro.descripcion }
        [rubros: rubros]
    }


    def cargarValores() {

        def rubro = Rubro.get(params.id)

        return [rubro: rubro]
    }


    def generarRol() {
        println "generarRol $params"
        def mes = Mes.get(params.mes)
        def anio = Anio.get(params.anio)
        def empresa = Empresa.get(session.empresa.id)
        def fcin = new Date().parse("dd-MM-yyyy", "01-${mes.numero}-${anio.anio}")
        def finDeMes = utilitarioService.getLastDayOfMonth(fcin)
        def dias = finDeMes - fcin + 1
        def rol = RolPagos.findByMessAndAnioAndEmpresa(mes, anio, empresa)
        def total = 0
        def msg = ""

        println "existe rol " + rol
        if (!rol) {
            rol = new RolPagos()
            rol.estado = "N"
            rol.fecha = new Date()
            rol.mess = mes
            rol.pagado = 0
            rol.anio = anio
            rol.empresa = session.empresa
            flash.message = "Rol de pagos creado correctamente"
        } else {
            flash.message = "Rol de pagos actualizado correctamente"
            rol.fechaModificacion = new Date()
        }

        if (!rol.save(flush: true)) {
            println "error save rol " + rol.errors
        }

        flash.tipo = "success"
        println "empr: ${empresa.id}, fcin: ${fcin}, fm: ${finDeMes}"

        def empleados = Empleado.withCriteria {
            persona {
                eq("empresa", empresa)
                order("apellido", "asc")
            }
            eq("estado", "A")
            lt("fechaInicio", finDeMes)
            or {
                isNull("fechaFin")
                gt("fechaFin", fcin)
            }
            isNotNull("tipoContrato")
        }
        println "empleados ${empleados.persona.nombre}"



        /* TODO: Para el contrato por horas hacer una pantalla para el registro de las horas
        * por ahora se usa 10 horas */
        empleados.each { emp ->
            println "Empl: ${emp.persona.nombre} --> contrato: ${emp.tipoContrato.descripcion}"
            def sldo = Rubro.findByCodigo('SLDO')
            def dc14 = Rubro.findByCodigo('DC14')
            def dc13 = Rubro.findByCodigo('DC13')
            def rbrotpct = RubroTipoContrato.findByRubroAndTipoContrato(sldo, emp.tipoContrato)
            def dcmo13   = RubroTipoContrato.findByRubroAndTipoContrato(dc13, emp.tipoContrato)
            def dcmo14   = RubroTipoContrato.findByRubroAndTipoContrato(dc14, emp.tipoContrato)
            def sueldo = emp.sueldo

//            println "rubro: ${rbrotpct}, ${emp.tipoContrato.descripcion}"
            if (!rbrotpct) {
                flash.message = "Error: No se ha definido sueldo para el empleado ${emp.persona}"
                flash.tipo = "crit"
            }

            if (emp.tipoContrato.descripcion == 'Por Horas') {
//                print "...hhhh: ${rbrotpct.valor}"
                sueldo = 10 * rbrotpct.valor
            } else {
                if (emp.fechaInicio > fcin) dias = (finDeMes - emp.fechaInicio).toInteger()
//                print "...1"
                if (emp.fechaFin) {
                    if (emp.fechaFin < finDeMes) dias = dias - (finDeMes - emp.fechaFin).toInteger()
                }
                if ((emp.fechaInicio <= fcin) && (emp.fechaFin ?: new Date() > finDeMes))
                    dias = (finDeMes - fcin + 1).toInteger()

                print "...2 dias: $dias, total: ${(finDeMes - fcin + 1)}"
                sueldo = (emp.sueldo * dias / (finDeMes - fcin + 1).toInteger()).toDouble().round(2)
                sueldo = Math.round(sueldo * 100)/100
            }
            println "sueldo: $sueldo"

            def detalle = DetallePago.find("from DetallePago where rolPagos = ${rol.id} and " +
                    "rubroTipoContrato = ${rbrotpct.id} and empleado = ${emp.id}")
//            println "detalle: ${detalle?.id}"
            if (!detalle) {
//                println "crea dtpg"
                detalle = new DetallePago()
            }
            println "edita dtpg ---- "
            detalle.empleado = emp
            detalle.rolPagos = rol
            detalle.rubroTipoContrato = rbrotpct
            detalle.valor = sueldo
            if (!detalle.save(flush: true))
                println "error save detalle pago sueldo " + detalle.errors
            total += sueldo
//            println "total $total, sueldo $sueldo, dcmo14: $dcmo14"

            if(dcmo14) {
                if(dcmo14.porcentaje > 0) { /* se paga el 14° mensual */
                    println "calcula fracción de 14 --> ${dcmo14.porcentaje}"
                    def dt14 = DetallePago.findByRubroTipoContratoAndEmpleado(dcmo14, emp)
                    if (dt14) {
                        if (Math.abs(dt14.valor - anio.sueldoBasico / 12) > 0.01) {
                            dt14.valor = anio.sueldoBasico / 12
                            dt14.save(flush: true)
                        }
                    } else {
                        dt14 = new DetallePago()
                        dt14.empleado = emp
                        dt14.rolPagos = rol
                        dt14.rubroTipoContrato = dcmo14
                        dt14.valor = anio.sueldoBasico / 12
                        dt14.save(flush: true)
                    }
                }
            }

            /* otros rubros */
            def rubros = RubroTipoContrato.findAllByTipoContratoAndRubroNotInListAndActivo(emp.tipoContrato, [sldo, dc14, dc13], '1')
//            println "rubros ==> ${rubros.rubro.descripcion} valor: ${rubros.rubro.valor} pc: ${rubros.rubro.porcentaje}"
            rubros.each { r ->
                detalle = DetallePago.find("from DetallePago where rubroTipoContrato = ${r.id} and " +
                        "rolPagos = ${rol.id} and empleado = ${emp.id}")

                println "detalle rubros: $detalle"
                if (!detalle) {
                    detalle = new DetallePago()
                }
                detalle.empleado = emp
                detalle.rolPagos = rol
                detalle.rubroTipoContrato = r
                def valor = 0
                def signo = -1
                if (r.rubro.tipoRubro.codigo in ["I", "P", "G"])
                    signo = 1
                if (r.valor != 0) {
                    valor = r.valor * signo
                } else {
                    valor = sueldo * (r.porcentaje / 100) * signo
                }
                valor = Math.round(valor * 100)/100
                detalle.valor = valor
                if (!detalle.save(flush: true))
                    println "error save detalle pago " + detalle.errors
                total += valor
            }

            def rubrosNo = RubroTipoContrato.findAllByTipoContratoAndRubroNotInListAndActivo(emp.tipoContrato, [sldo, dc14, dc13], '0')
//            println "rubros ==> ${rubros.rubro.descripcion} valor: ${rubros.rubro.valor} pc: ${rubros.rubro.porcentaje}"
            rubrosNo.each { r ->
                detalle = DetallePago.find("from DetallePago where rubroTipoContrato = ${r.id} and " +
                        "rolPagos = ${rol.id} and empleado = ${emp.id}")
                if(detalle){
                    detalle.delete(flush: true)
                }
            }
        }

        rol.pagado = total
        rol.empresa = session.empresa
        rol.save(flush: true)
        println "total nómina: $total"
//        println "done"
        render "ok"
    }

    def verRol() {
        println "ver rol " + params
        def mes = null
        def periodo = null
        def anio = new Date().format("yyyy").toInteger()
        def anios = [:]
        def meses = Mes.list([sort: "id"])
        3.times {
            anios.put((anio - it).toString(), anio - it)
            anios.put((anio + it).toString(), anio + it)
        }
        anios.sort { it.key }
//        println "anios "+anios

        def roles
        if (params.mes) {
            mes = Mes.get(params.mes)
            if (params.periodo) {
                periodo = Periodo.get(params.periodo)
                roles = RolPagos.findAllByMessAndPeriodo(mes, periodo)
            }
            if (params.anio) {
                def fecha = new Date().parse("dd-MM-yyyy", "01-01-" + params.anio)
                def cont = Contabilidad.findAllByInstitucionAndFechaInicioGreaterThanEquals(session.empresa, fecha)
//                println "cont "+cont+" anio "+anio
                def periodos = []
                Periodo.findAllByContabilidadInList(cont).each { p ->
                    if (p.fechaInicio.format("yyyy") == params.anio)
                        periodos.add(p)
                }
//                println "periodos "+periodos
                roles = RolPagos.findAllByMessAndPeriodoInList(mes, periodos)
//                println "roles "+roles
            }
//            anio=periodo.fechaInicio.format("YYYY")
        } else {
            mes = meses[0]
            roles = RolPagos.findAllByMessAndEmpresa(mes, session.empresa, [sort: "id", order: "desc"])
        }

        def rol = null
        def cn

        roles.each {
            if (!rol)
                if (it.periodo.contabilidad.institucion.id.toInteger() == session.empresa.id.toInteger()) {
                    rol = it
                    anio = it.periodo.fechaInicio.format("YYYY")
                }
        }
        def datos = []
        if (rol) {
            def sql = "SELECT e.empl__id,p.prsnnmbr || ' ' || p.prsnapll ,c.crgodscr,t.tpctdscr ,sum(d.dtpgvlor) from rlpg r,dtpg d,empl e,prsn p,crgo c, tpct t where r.rlpg__id=${rol.id} and r.rlpg__id=d.rlpg__id and d.empl__id=e.empl__id and e.prsn__id=p.prsn__id and e.crgo__id=c.crgo__id and e.tpct__id=t.tpct__id  group by 1,2,3,4 order by 2;"
            cn = dbConnectionService.getConnection()
            cn.eachRow(sql.toString()) { r ->
                datos.add(r.toRowResult())
            }
        }
        [datos: datos, rol: rol, mes: mes, meses: meses, anio: anio, anios: anios]

    }


    def getDetalle() {
        println "detalle " + params
        def rol = RolPagos.get(params.rol)
        def emp = Empleado.get(params.emp)
        def detalle = DetallePago.findAllByEmpleadoAndRolPagos(emp, rol)
        detalle.sort { it.rubroTipoContrato?.rubro?.tipoRubro?.codigo }
        [detalle: detalle, emp: emp, rol: rol]
    }

    def registrarRol() {
        def rol = RolPagos.get(params.rol)
        rol.estado = "R"
        rol.save(flush: true)
        render "ok"
    }

    def saveDetalle() {
        println "save detalle " + params
        def detalle = DetallePago.get(params.detalle)
        def rol = detalle.rolPagos
        def total = rol.pagado
        total -= detalle.valor
        detalle.valor = params.valor.toDouble()
        total += detalle.valor
        if (detalle.save(flush: true)) {
            rol.pagado = total
            rol.save(flush: true)
            render "ok"
        }
    }

    def deleteDetalle() {
        def detalle = DetallePago.get(params.detalle)
        def valor = detalle.valor
        def rol = detalle.rolPagos
        try {
            detalle.delete(flush: true)
            rol.pagado -= valor
            rol.save(flush: true)
            render "ok"
        } catch (e) {
            println "error delete detalle " + e
            render "error"
        }
    }


    def addDetalle() {
        def emp = Empleado.get(params.emp)
        def valor = params.val
        try {
            valor = valor.toDouble()
        } catch (e) {
            render "error"
            return
        }
        def rol = RolPagos.get(params.rol)
        def detalle = new DetallePago()
        detalle.descripcion = params.desc
        detalle.empleado = emp
        detalle.rolPagos = rol
        detalle.valor = valor
        if (detalle.save(flush: true)) {
            rol.pagado += detalle.valor
            rol.save(flush: true)
            render "ok"
            return
        } else {
            println "error save detalle " + detalle.errors
            render "error"
            return
        }
    }
//
    def save() {
        println "aqu?"
        def rubroInstance
        if (params.id) {
            rubroInstance = Rubro.get(params.id)
            if (!rubroInstance) {
                flash.message = "No se encontr&oacute; Rubro a modificar"
                render "NO"
                return
            }
            rubroInstance.properties = params
        } else {
            rubroInstance = new Rubro(params)
        }
        if (!rubroInstance.save(flush: true)) {
            render "NO"
            println rubroInstance.errors
            flash.message = "Ha ocurrido un error al guardar Rubro"
            return
        }

        flash.message = "Rubro guardado exitosamente"
//    redirect(action: "show", id: rubroInstance.id)
        render "OK"
    }

    def show() {
        def rubroInstance = Rubro.get(params.id)
        if (!rubroInstance) {
            flash.message = "No se encontr&oacute; Rubro a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [rubroInstance: rubroInstance]
    }
//
//    def edit() {
//        def rubroInstance = Rubro.get(params.id)
//        if (!rubroInstance) {
//            flash.message = "No se encontr&oacute; Rubro a modificar"
////            redirect(action: "list")
//            render "NO"
//            return
//        }
//
//        [rubroInstance: rubroInstance]
//    }

    def delete() {
        def rubroInstance = Rubro.get(params.id)
        if (!rubroInstance) {
            flash.message = "No se encontr&oacute; Rubro a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            rubroInstance.delete(flush: true)
            flash.message = "Rubro eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar Rubro"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def rubroInstanceList = Rubro.list(params)
        def rubroInstanceCount = Rubro.count()
        if (rubroInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        params.sort = 'tipoRubro'
        rubroInstanceList = Rubro.list(params)
        return [rubroInstanceList: rubroInstanceList, rubroInstanceCount: rubroInstanceCount]
    } //list

    def show_ajax() {


        if (params.id) {
            def rubroInstance = Rubro.get(params.id)
            if (!rubroInstance) {
                notFound_ajax()
                return
            }
            return [rubroInstance: rubroInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def rubroInstance = new Rubro(params)
        if (params.id) {
            rubroInstance = Rubro.get(params.id)
            if (!rubroInstance) {
                notFound_ajax()
                return
            }
        }
        return [rubroInstance: rubroInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {

//        println("params:" + params)

        //original
        def rubroInstance
        if (params.id) {
            rubroInstance = Rubro.get(params.id)
        } else {
            rubroInstance = new Rubro()
        } //update

        rubroInstance.tipoRubro = TipoRubro.get(params."tipoRubro.id")
        rubroInstance.descripcion = params.descripcion
        rubroInstance.decimo = params.decimo
        rubroInstance.iess = params.iess
        rubroInstance.gravable = params.gravable
        rubroInstance.editable = params.editable
        rubroInstance.porcentaje = params.porcentaje.toDouble()
        rubroInstance.valor = params.valor.toDouble()
        rubroInstance.codigo = params.codigo

        if (!rubroInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Rubro."
            msg += renderErrors(bean: rubroInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Rubro."
    } //save para grabar desde ajax


    def delete_ajax() {
        if (params.id) {
            def rubroInstance = Rubro.get(params.id)
            if (rubroInstance) {
                try {
                    rubroInstance.delete(flush: true)
                    render "ok."
                } catch (e) {
                    render "NO_No se pudo eliminar el Rubro"
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró el Rubro."
    } //notFound para ajax


    def saveRubro() {

        println("params:" + params)


        if (params.decimo == 'true') {
            params.decimo = '1'
        } else {
            params.decimo = '0'
        }

        if (params.iess == 'true') {
            params.iess = '1'
        } else {
            params.iess = '0'
        }

        if (params.gravable == 'true') {
            params.gravable = '1'
        } else {
            params.gravable = '0'
        }

        params.editable = '1'

        try {
            params.valor = params.valor.toDouble()
        } catch (e) {
            params.valor = 0
        }
        try {
            params.porcentaje = params.porcentaje.toDouble()
        } catch (e) {
            params.porcentaje = 0
        }


        def mensaje = ''

        //original
        def rubroInstance = new Rubro()

        if (params.id) {
            rubroInstance = Rubro.get(params.id)
            rubroInstance.properties = params
            if (!rubroInstance) {
                notFound_ajax()

            }


        } else {

            rubroInstance = new Rubro()
            rubroInstance.properties = params

        } //update

        rubroInstance.empresa = session.empresa
        if (!rubroInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Rubro."
            println "errores " + rubroInstance.errors
            msg += renderErrors(bean: rubroInstance)
            render msg
            return
        } else {

            render "OK"
            return
        }
//
//        render "OK_${params.id ? 'Actualización' : 'Creación'} de Rubro."


    } //save para grabar desde ajax


}
