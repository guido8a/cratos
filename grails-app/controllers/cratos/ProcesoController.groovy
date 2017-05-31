package cratos

import cratos.seguridad.Persona
import cratos.sri.Pais

class ProcesoController extends cratos.seguridad.Shield {

    def buscadorService
    def kerberosoldService
    def procesoService
    def loginService
    def utilitarioService
    def dbConnectionService

    /* todo acabar los dominios */


    def index = { redirect(action: "lsta") }

    def lsta = {
        def campos = ["estado": ["Estado", "string"], "descripcion": ["Descripción", "string"], "fecha": ["Fecha", "date"], "comp": ["Comprobante", "string"]]
        [campos: campos]
    }

    def nuevoProceso = {
//        println "nuevo proceso "+params
        def tiposProceso = ["-1": "Seleccione...",
                            "C": "Compras (Compras Inventario, Compras Gasto)",
                            "V": "Ventas (Ventas, Reposición de Gasto)",
                            "A": "Ajustes (Diarios y Otros)",
                            "P": "Pagos a proveedores",
                            "N": "Nota de Crédito"]
        if (params.id) {
            def proceso = Proceso.get(params.id)
            def registro = (Comprobante.findAllByProceso(proceso)?.size() == 0) ? false : true
            //println "registro " + registro
            render(view: "procesoForm", model: [proceso: proceso, registro: registro, tiposProceso: tiposProceso])
        } else
            render(view: "procesoForm", model: [registro: false, tiposProceso: tiposProceso])
    }

    def save = {
//        if (request.method == 'POST') {
        println "save proceso "+params
        def proceso
        def comprobante

        if (params.sustentoTributario.id == "-1")
            params.sustentoTributario.id = null
        if (params.tipoComprobanteSri.id == "-1")
            params.tipoComprobanteSri.id = null

        def sustento = SustentoTributario.get(params."sustentoTributario.id")
        def proveedor = Proveedor.get(params."proveedor.id")
        def gestor = Gestor.get(params."gestor.id")
        def tipoPago
        def tipoComproSri = TipoComprobanteSri.get(params."tipoComprobanteSri.id")
        def fechaRegistro = new Date().parse("dd-MM-yyyy",params.fecha_input)

        if(params.id){
            proceso = Proceso.get(params.id)
            params.tipoProceso = proceso.tipoProceso
        }else{
            proceso = new Proceso()
            proceso.estado = "N"
            proceso.gestor = gestor
            proceso.contabilidad = session.contabilidad
            proceso.empresa = session.empresa
        }

        proceso.proveedor = proveedor
        proceso.tipoComprobanteSri = tipoComproSri
        proceso.sustentoTributario = sustento
        proceso.fechaRegistro = fechaRegistro
        proceso.descripcion = params.descripcion
        proceso.fecha = new Date()
        proceso.tipoProceso = params.tipoProceso

        if(params.tipoProceso == 'P'){
            comprobante = Comprobante.get(params.comprobanteSel_name)
            proceso.comprobante = comprobante
            tipoPago = TipoPago.get(params.tipoPago_name)
            proceso.tipoPago = tipoPago
            proceso.valor = params.valorPago_name.toDouble()

        }else
        {
            if(params.tipoProceso == 'NC'){
                comprobante = Comprobante.get(params.comprobanteSel_name)
                proceso.comprobante = comprobante
                proceso.valor = params.valorPago_name.toDouble()
                proceso.impuesto = params.ivaGenerado.toDouble()
                tipoPago = TipoPago.get(params.tipoPago_name)
                proceso.tipoPago = tipoPago
            }
            else{
                proceso.valor = params.baseImponibleIva0.toDouble() + params.baseImponibleIva.toDouble() + params.baseImponibleNoIva.toDouble()
                proceso.impuesto = params.ivaGenerado.toDouble() + params.iceGenerado.toDouble()
                proceso.baseImponibleIva = params.baseImponibleIva.toDouble()
                proceso.baseImponibleIva0 = params.baseImponibleIva0.toDouble()
                proceso.baseImponibleNoIva = params.baseImponibleNoIva.toDouble()
                proceso.ivaGenerado = params.ivaGenerado.toDouble()
                proceso.iceGenerado = params.iceGenerado.toDouble()
                proceso.documento = params.facturaEstablecimiento + "-" + params.facturaPuntoEmision + "-" + params.facturaSecuencial
                proceso.facturaEstablecimiento = params.facturaEstablecimiento
                proceso.facturaPuntoEmision = params.facturaPuntoEmision
                proceso.facturaSecuencial = params.facturaSecuencial
                proceso.facturaAutorizacion = params.facturaAutorizacion
            }
        }

        try{
            proceso.save(flush: true)
            redirect(action: 'show', id: proceso.id)
        }catch (e){
            println("error al grabar el proceso " + e)
        }

//            params.lang="en"
//            def key = "org.springframework.web.servlet.DispatcherServlet.LOCALE_RESOLVER"
//            def localeResolver = request.getAttribute(key)
//            localeResolver.setLocale(request, response, new Locale("en"))
//            def p
//            params.controllerName = controllerName
//            params.actionName = actionName
//            if (params.proveedor.id == "null")
//                params.proveedor.id = null
//            if (params.sustentoTributario.id == "-1")
//                params.sustentoTributario.id = null
//            if (params.tipoComprobanteSri.id == "-1")
//                params.tipoComprobanteSri.id = null
//            params.estado = "N"
//            params.valor = params.baseImponibleIva0.toDouble() + params.baseImponibleIva.toDouble() + params.baseImponibleNoIva.toDouble()
//            params.impuesto = params.ivaGenerado.toDouble() + params.iceGenerado.toDouble()
//            params.documento = params.facturaEstablecimiento + "-" + params.facturaPuntoEmision + "-" + params.facturaSecuencial
//            params.fechaIngresoSistema = new Date()
//            if (params.id) {
//                p = Proceso.get(params.id)
//            } else {
//                p = new Proceso()
//            }
//            p.properties = params
//            p.contabilidad = session.contabilidad
//            p.empresa = session.empresa
//            def comprobante = Comprobante.get(params.comprobanteSel_name)
//            p.comprobante = comprobante
//            p.save(flush: true)
//            println "errores proceso " + p.errors
//            if (p.errors.getErrorCount() == 0) {
//                if (params.data != "") {
//                    def data = params.data.split(";")
//                    // println "data "+data
//                    data.each {
//                        if (it != "") {
//                        }
//                    }
//                }
//
//                redirect(action: 'show', id: p.id)
//            } else
//                render(view: 'procesoForm', model: ['proceso': p], error: true)
//        } else {
//            redirect(controller: "shield", action: "ataques")
//        }
    }


    def registrar = {
        if (request.method == 'POST') {
            println "registrar " + params
            def pro = Proceso.get(params.id)
            if (pro.estado == "R") {
                render("El proceso ya ha sido registrado previamente")
            } else {
//                def lista = procesoService.registrar(pro, session.perfil, session.usuario, session.contabilidad)
                def lista = procesoService.registrar(pro)
                if (lista[0] != false) {
                    render(view: "detalleProceso", model: [comprobantes: lista[1], asientos: lista[2], proceso: pro])

                } else {
                    render("Error registrando el proceso")
                }

            }
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }

    def cargaComprobantes = {
//        println "cargar comprobantes " + params
        def proceso = Proceso.get(params.proceso)
        def comprobantes = Comprobante.findByProceso(proceso)
        def asientos = []
        if (comprobantes)
            asientos += Asiento.findAllByComprobante(comprobantes)
        if (asientos.size() > 0) {
            asientos.sort { it.cuenta.numero }
        }
        def aux = false
        asientos.each {
            if (Auxiliar.findAllByAsiento(it).size() > 1)
                aux = true
        }
        //println "comp "+comprobantes+" as "+asientos
        render(view: "detalleProceso", model: [comprobantes: comprobantes, asientos: asientos, proceso: proceso, aux: aux])
    }

    def valorAsiento = {
        if (request.method == 'POST') {
            params.lang="en"
            def key = "org.springframework.web.servlet.DispatcherServlet.LOCALE_RESOLVER"
            def localeResolver = request.getAttribute(key)
            localeResolver.setLocale(request, response, new Locale("en"))
            println "cambiar Valor Asiento " + params
            def vd = params.vd.toDouble()
            def vh = params.vh.toDouble()
            // println "vd "+vd +" vh  "+vh
            def proceso = Proceso.get(params.proceso)
            def comprobantes = Comprobante.findAllByProceso(proceso)
            def asiento = Asiento.get(params.id)
            def asientos = []
            comprobantes.each {
                asientos += Asiento.findAllByComprobante(it)
            }
            params.controllerName = controllerName
            params.actionName = actionName
            asiento.debe = vd
            asiento.haber = vh
            asiento.cuenta = Cuenta.get(params.cnta)
            if (asiento.save(flush: true))
                render "ok"
            else
                render "error"
//            render(view: "detalleProceso", model: [comprobantes: comprobantes, asientos: asientos])
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }

    /*TODO Crear periodos y probar el mayorizar y desmayorizar... move on*/
    def registrarComprobante = {
        if (request.method == 'POST') {
            println "registrar comprobante " + params
            def comprobante = Comprobante.get(params.id)
            def msn = kerberosoldService.ejecutarProcedure("mayorizar", [comprobante.id, 1])
            println "LOG: mayorizando por comprobante ${comprobante.id}" + msn["mayorizar"]
            try {
                def log = new LogMayorizacion()
                log.usuario = cratos.seguridad.Persona.get(session.usuario.id)
                log.comprobante = comprobante
                log.tipo = "M"
                log.resultado = msn["mayorizar"].toString()
                log.save(flush: true)
            } catch (e) {
                println "LOG: error del login de mayorizar " + msn["mayorizar"].toString()
            }
            if (msn["mayorizar"] =~ "Error") {
                render " " + msn["mayorizar"]
            } else {
                def proceso = comprobante.proceso
                params.controllerName = controllerName
                params.actionName = actionName
                comprobante.registrado = "S"
                comprobante.save(flush: true)
                proceso.estado = "R"
                proceso.save(flush: true)
                render "ok"
            }
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }

    def desmayorizar() {
        println "demayo " + params
        if (request.method == 'POST') {
            def comprobante = Comprobante.get(params.id)
            def msn = kerberosoldService.ejecutarProcedure("mayorizar", [comprobante.id, -1])
            println "LOG: desmayorizando  comprobante ${comprobante.id} " + msn["mayorizar"]
            try {
                def log = new LogMayorizacion()
                log.usuario = cratos.seguridad.Persona.get(session.usuario.id)
                log.comprobante = comprobante
                log.tipo = "D"
                log.resultado = msn["mayorizar"].toString()
                log.save(flush: true)
            } catch (e) {
                println "LOG: error del login de mayorizar " + msn["mayorizar"].toString()
            }
            if (msn["mayorizar"] =~ "Error") {

                render " " + msn["mayorizar"]
            } else {
                def proceso = comprobante.proceso
                params.controllerName = controllerName
                params.actionName = actionName
//                kerberosService.generarEntradaAuditoria(params,Comprobante,"registrado","R",comprobante.registrado,session.perfil,session.usuario)
                comprobante.registrado = "N"
                comprobante.save(flush: true)
                proceso.estado = "N"
                proceso.save(flush: true)
                render "ok"
            }
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }

    def listar = {
        //println "buscar proceso"
        def extraComp = ""
        if (params.campos instanceof java.lang.String) {
            if (params.campos == "comp") {
                def comps = Comprobante.findAll("from Comprobante where numero like '%${params.criterios.toUpperCase()}%' or prefijo like '%${params.criterios.toUpperCase()}%' ")
                params.criterios = ""
                comps.eachWithIndex { p, i ->
                    extraComp += "" + p.proceso.id
                    if (i < comps.size() - 1)
                        extraComp += ","
                }
                if (extraComp.size() < 1)
                    extraComp = "-1"
                params.campos = ""
                params.operadores = ""
            }
        } else {
            def remove = []
            params.campos.eachWithIndex { p, i ->
                if (p == "comp") {
                    def comps = Comprobante.findAll("from Comprobante where numero like '%${params.criterios[i].toUpperCase()}%' or prefijo like '%${params.criterios[i].toUpperCase()}%' ")

                    comps.eachWithIndex { c, j ->
                        extraComp += "" + c.proceso.id
                        if (j < comps.size() - 1)
                            extraComp += ","
                    }
                    if (extraComp.size() < 1)
                        extraComp = "-1"
                    remove.add(i)
                }
            }
            remove.each {
                params.criterios[it] = null
                params.campos[it] = null
                params.operadores[it] = null
            }
        }
        def extras = " and empresa=${session.empresa.id} and contabilidad=${session.contabilidad.id}"
        if (extraComp.size() > 1)
            extras += " and id in (${extraComp})"

        def closure = { estado ->
            if (estado == "R")
                return "Registrado"
            else
                return "No registrado"
        }
        def comp = { proceso ->
            def c = Comprobante.findByProceso(proceso)
            if (c)
                return c.prefijo + "" + c.numero
            else
                return ""
        }
        def tipo = { t ->
            switch (t) {
                case "P":
                    return "Pago"
                    break;
                case "C":
                    return "Compra"
                    break;
                case "V":
                    return "Venta"
                    break;
                case "A":
                    return "Ajuste"
                    break;
                case "O":
                    return "Otro"
                    break;
                default:
                    return "Otro"
                    break;
            }
        }
        def listaTitulos = ["Fecha", "Descripcion", "Estado", "Comprobante", "Tipo", "Proveedor"]
        /*Titulos de la tabla*/
        def listaCampos = ["fecha", "descripcion", "estado", "comprobante", "tipoProceso", "proveedor"]
        /*campos que van a mostrarse en la tabla, en el mismo orden que los titulos*/
        def funciones = [["format": ["dd-MM-yyyy "]], null, ["closure": [closure, "?"]], ["closure": [comp, "&"]], ["closure": [tipo, "?"]], null]
        /*funciones para cada campo en caso de ser necesari. Cada campo debe tener un mapa (con el nombre de la funcion como key y los parametros como arreglo) o un null si no tiene funciones... si un parametro es ? sera sustituido por el valor del campo, si es & sera sustituido por el objeto */
        def link = "descripcion"                                      /*nombre del campo que va a llevar el link*/
        def url = g.createLink(action: "listar", controller: "proceso")
        /*link de esta accion ...  sive para la opcion de reporte*/
//        params.ordenado="fecha"
//        params.orden="desc"
        def listaSinFiltro = buscadorService.buscar(Proceso, "Proceso", "excluyente", params, true, extras)
        /* Dominio, nombre del dominio , excluyente dejar asi,params tal cual llegan de la interfaz del buscador, ignore case */
        listaSinFiltro.pop()
        def lista = []
        listaSinFiltro.each {
            if (it.estado != "B")
                lista.add(it.refresh())
        }

        def numRegistros = 10
        if (!params.reporte) {
//            println "no reporte"
            render(view: '../lstaTbla', model: [listaTitulos: listaTitulos, listaCampos: listaCampos, lista: lista, link: link, funciones: funciones, url: url, numRegistros: numRegistros])
        } else {
            /*De esto solo cambiar el dominio, el parametro tabla, el paramtero titulo y el tamaño de las columnas (anchos)*/
//            println "si reporte"
            session.dominio = Proceso
            session.funciones = funciones
            def anchos = [16, 70, 14] /*el ancho de las columnas en porcentajes*/
            redirect(controller: "reportes2", action: "reporteBuscador", params: [listaCampos: listaCampos, listaTitulos: listaTitulos, tabla: "Proceso", orden: params.orden, ordenado: params.ordenado, criterios: params.criterios, operadores: params.operadores, campos: params.campos, titulo: "Transacciones contables", anchos: anchos])
        }

    }

    def show = {
//        println "session "+session.contabilidad
        def proceso = Proceso.get(params.id)
//        def tiposProceso = ["-1": "Seleccione...", "C": "Compras", "V": "Ventas", "O": "Otros", "A": "Ajustes"]
        def tiposProceso = ["-1": "Seleccione...", "C": "Compras", "V": "Ventas", "O": "Otros", "A": "Ajustes", "P": "Pagos", "NC": "Nota de Crédito"]
        def comprobante = Comprobante.findByProceso(proceso)
        def registro = (Comprobante.findAllByProceso(proceso)?.size() == 0) ? false : true
        def fps = ProcesoFormaDePago.findAllByProceso(proceso)
        def aux = false
        Asiento.findAllByComprobante(comprobante).each {
            if (Auxiliar.findAllByAsiento(it).size() > 1)
                aux = true
        }
//        println "registro "+registro

        render(view: "procesoForm", model: [proceso: proceso, registro: registro, comprobante: comprobante, tiposProceso: tiposProceso, fps: fps, registro: registro, aux: aux])
    }

    def comprobarPassword = {
        if (request.method == 'POST') {
            println "comprobar password " + params
            def resp = loginService.autorizaciones(session.usuario, params.atrz)

            render(resp)
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }

    def cargarAuxiliares = {
        //println "cargar auxiliares "+params
        def msn = null
        def asiento = Asiento.get(params.id);
        def auxiliares = Auxiliar.findAllByAsiento(asiento)
        def formas = [:]
        def fps = ProcesoFormaDePago.findAllByProceso(asiento.comprobante.proceso)
        fps.each {
            formas.put(it.id, it.tipoPago.descripcion)
        }
        formas.put("-1", "NOTA DE DEBITO")
        formas.put("-2", "NOTA DE CREDITO")
//        println "Formas "+formas
        if (auxiliares.size() == 0) {
            msn = "EL asiento no tiene registrado ningun plan de pagos"
        }
        def max = Math.abs(asiento.debe - asiento.haber)
        render(view: "detalleAuxiliares", model: [auxiliares: auxiliares, asiento: asiento, msn: msn, max: max, formas: formas])
    }

    def nuevoAuxiliar = {
        if (request.method == 'POST') {
            params.lang="en"
            def key = "org.springframework.web.servlet.DispatcherServlet.LOCALE_RESOLVER"
            def localeResolver = request.getAttribute(key)
            localeResolver.setLocale(request, response, new Locale("en"))
//            println "nuevo aux "+params
            def msn = null
            if (params.razon == "D")
                params["debe"] = params.valor
            else
                params["haber"] = params.valor
            if (params.proveedor.id == "-1") {
                def proceso = Proceso.get(params.proceso)
                if (proceso.proveedor != null)
                    params["proveedor.id"] = proceso.proveedor.id
            }
            def fecha = params.remove("fechaPago")
            def p = new Auxiliar(params)
            p.fechaPago = new Date().parse("dd-MM-yyyy", fecha)
            p.save(flush: true)
            println "nuevo auxiliar " + params + "  " + p.errors
            if (p.errors.getErrorCount() != 0)
                msn = "Error al insertar el auxiliar revise los datos ingresados"
            else
                redirect(action: "cargarAuxiliares", params: ["id": params.asiento.id])
//      def asiento=p.asientoContable
//      def auxiliares=Auxiliar.findAllByAsientoContable(asiento)

        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }
    def borrarAuxiliar = {

        if (request.method == 'POST') {
            println " borrar auxiliar " + params
            def aux = Auxiliar.get(params.id)
            def pagos = PagoAux.findAllByAuxiliar(aux)
            if (pagos.size() > 0) {
                render "error"
                return
            } else {
                aux.delete(flush: true)
                def asiento = Asiento.get(params.idAs)
                def auxiliares = Auxiliar.findAllByAsiento(asiento)
                render(view: "detalleAuxiliares", model: [auxiliares: auxiliares, asiento: asiento])
            }

        } else {
            redirect(controller: "shield", action: "ataques")
        }

    }

    def buscarProveedor = {
//         println "buscar proveedor "+params
        def provs = []
        def proceso = Proceso.get(params.proceso)
        def tr = TipoRelacion.list()
        def tipo =   " 1,2,3 "
        switch (params.tipoProceso) {
            case "P":
                tr = TipoRelacion.findAllByCodigoInList(['C','P'])
                tipo = " 1, 3 "
                break
            case "NC" :
                tr = TipoRelacion.findAllByCodigoInList(['C','E'])
                tipo = " 2,3 "
                break
            case "V"  :
                tr = TipoRelacion.findAllByCodigoInList(['C','E'])
                tipo = " 2, 3 "
                break
        }

        def cn = dbConnectionService.getConnection()
        def sql

        if(params?.par?.trim() == ""){
            sql = "select prve__id id, prve_ruc ruc, prvenmbr nombre, tppvdscr tipoProveedor from prve, tppv " +
                    "where tppv.tppv__id = prve.tppv__id and tprl__id in (${tipo}) and empr__id = ${session?.empresa?.id} order by prve_ruc;"
        }else{
            if(params.tipo == "1"){
                sql = "select prve__id id, prve_ruc ruc, prvenmbr nombre, tppvdscr tipoProveedor from prve, tppv " +
                        "where tppv.tppv__id = prve.tppv__id and tprl__id in (${tipo}) and empr__id = ${session?.empresa?.id} and prve_ruc like '%${params.par}%' order by prve_ruc;"
            }else{
                sql = "select prve__id id, prve_ruc ruc, prvenmbr nombre, tppvdscr tipoProveedor from prve, tppv " +
                        "where tppv.tppv__id = prve.tppv__id and tprl__id in (${tipo}) and empr__id = ${session?.empresa?.id} and prvenmbr ilike '%${params.par}%' order by prve_ruc;"
            }
        }

        provs = cn.rows(sql.toString())

        [provs: provs]
    }

    def detallePagos = {
        def aux = Auxiliar.get(params.id)
        def pagos = PagoAux.findAllByAuxiliar(aux)
        [pagos: pagos, aux: aux]
    }

    def savePagoNota = {
        println "save pago nota " + params
        params.lang="en"
        def key = "org.springframework.web.servlet.DispatcherServlet.LOCALE_RESOLVER"
        def localeResolver = request.getAttribute(key)
        localeResolver.setLocale(request, response, new Locale("en"))
        def fecha = params.remove("fecha")
        def fechaEmi = new Date().parse("dd-MM-yyyy", params.fechaEmision)
        params.remove("fechaEmision")
        def pago = new PagoAux(params)
        pago.fecha = new Date().parse("dd-MM-yyyy", fecha)
        pago.fechaEmision = fechaEmi
        if (params.tipo == "-1")
            pago.tipo = "D"
        else
            pago.tipo = "C"
        if (pago.save(flush: true)) {
            def proceso = new Proceso()
            proceso.gestor = Gestor.get(params.gestor)
            proceso.contabilidad = session.contabilidad
            proceso.descripcion = "Nota de ${(pago.tipo == 'C') ? 'Crédito' : 'Débito'} " + new Date().format("dd-MM-yyyy hh:mm") + " Monto: " + (pago.monto + pago.impuesto) + " Proveedor: " + pago.auxiliar?.asiento?.comprobante?.proceso?.proveedor
            proceso.estado = "R"
            proceso.fecha = new Date()
            proceso.proveedor = pago.auxiliar.asiento.comprobante.proceso.proveedor
            proceso.tipoPago = pago.auxiliar.asiento.comprobante.proceso.tipoPago
            proceso.usuario = session.usuario
            /*TODO preguntar que es esto?*/
            //proceso.tipoComprobanteId = TipoComprobanteId.get(3)
            proceso.valor = pago.monto
            proceso.impuesto = 0
            proceso.documento = pago.referencia
            proceso.pagoAux = pago
            proceso.tipoProceso = "P"
            proceso.empresa = session.empresa
            println "valor " + proceso.valor + " inp " + proceso.impuesto
            if (proceso.save(flush: true)) {
                procesoService.registrar_old(proceso, session.perfil, session.usuario, session.contabilidad)
                render "ok"
            } else {
                println "error en el proceso " + proceso.errors
                render "error"
            }

        } else {
            render "error"
            println "error save pago nota " + pago.errors
        }
    }

    def savePago = {
        println "save pago " + params
        params.lang="en"
        def key = "org.springframework.web.servlet.DispatcherServlet.LOCALE_RESOLVER"
        def localeResolver = request.getAttribute(key)
        localeResolver.setLocale(request, response, new Locale("en"))
        def fecha = params.remove("fecha")
        def pago = new PagoAux(params)
        pago.fecha = new Date().parse("dd-MM-yyyy", fecha)
        if (pago.save(flush: true)) {
            def proceso = new Proceso()
            proceso.gestor = Gestor.get(params.gestor)
            proceso.contabilidad = session.contabilidad
            proceso.descripcion = "Pago  " + new Date().format("dd-MM-yyyy hh:mm") + " Monto: " + pago.monto + " Proveedor: " + pago.auxiliar?.asiento?.comprobante?.proceso?.proveedor
            proceso.estado = "R"
            proceso.fecha = new Date()
            proceso.proveedor = pago.auxiliar.asiento.comprobante.proceso.proveedor
            proceso.tipoPago = pago.auxiliar.asiento.comprobante.proceso.tipoPago
            proceso.usuario = session.usuario
            /*TODO preguntar que es esto?*/
            //proceso.tipoComprobanteId = TipoComprobanteId.get(3)
            proceso.valor = pago.monto
            proceso.impuesto = 0
            proceso.documento = pago.referencia
            proceso.pagoAux = pago
            proceso.tipoProceso = "P"
            proceso.empresa = session.empresa
            println "valor " + proceso.valor + " inp " + proceso.impuesto
            if (proceso.save(flush: true)) {
                procesoService.registrar_old(proceso, session.perfil, session.usuario, session.contabilidad)
                render "ok"
            } else {
                println "error en el proceso " + proceso.errors
                render "error"
            }

        } else {
            render "error"
            println "error save pago " + pago.errors
        }
    }

    def prueba() {
        render "prueba"
    }


    def borrarProceso() {
        println("LOG: borrar proceso " + params)
        def proceso = Proceso.get(params.id)
        def comprobante = Comprobante.findByProceso(proceso)
        def asiento
        if (comprobante) {
            asiento = Asiento.findAllByComprobante(comprobante)
        }
        if (comprobante) {
            if (comprobante.registrado == 'N') {
                def msn = kerberosoldService.ejecutarProcedure("mayorizar", [comprobante.id, -1])
                println "LOG: desmayorizando  comprobante borrar proceso ${comprobante.id} " + msn["mayorizar"]
                try {
                    def log = new LogMayorizacion()
                    log.usuario = cratos.seguridad.Persona.get(session.usuario.id)
                    log.comprobante = comprobante
                    log.tipo = "B"
                    log.resultado = msn["mayorizar"].toString()
                    log.save(flush: true)
                } catch (e) {
                    println "LOG: error del login de mayorizar " + msn["mayorizar"].toString()
                }
                proceso.estado = "B"
                proceso.save(flush: true)
                comprobante.registrado = "B"
                comprobante.save(flush: true)
                flash.message = "Proceso Borrado!"
                redirect(action: 'lsta')
            } else {
                flash.message = "No se puede borrar el proceso!!"
                redirect(action: 'lsta')
            }

        } else {
            proceso.estado = "B"
            proceso.save(flush: true)
            flash.message = "Proceso Borrado!"
            redirect(action: 'lsta')
        }
    }


    def procesosAnulados() {
//        println "proc anulados "+params
        def contabilidad
        if (!params.contabilidad) {
            contabilidad = session.contabilidad
        } else {
            contabilidad = Contabilidad.get(params.contabilidad)
        }
//        println "contabilidad "+contabilidad
        def procesos = Proceso.findAllByEstadoAndContabilidad("B", contabilidad, [sort: "fecha"])
        [procesos: procesos, contabilidad: contabilidad]
    }

    def verComprobante() {
        def comp = Comprobante.get(params.id)
        def asientos = Asiento.findAllByComprobante(comp)
        [asientos: asientos, comp: comp]
    }


    def detalleSri() {

        def empresa = Empresa.get(session.empresa.id)

        println("params " + params)

        def proceso = Proceso.get(params.id)
        def libreta

//        libreta = DocumentoEmpresa.withCriteria {
//            eq("empresa", empresa)
//
//                lt("fechaFin", new Date().format("yyyy-MM-dd"))
//                gt("fechaInicio", new Date().format("yyyy-MM-dd"))
//
//        }
        
       libreta =  DocumentoEmpresa.findAllByEmpresaAndFechaInicioLessThanEqualsAndFechaFinGreaterThanEqualsAndTipo(empresa, new Date(), new Date(),'R')

        println("libreta " + libreta)


        return [proceso: proceso, libreta: libreta]





        //antiguo

//        def proceso = Proceso.get(params.id)
//
//        def retencion = Retencion.findByProceso(proceso)
//
//
//        def detalleRetencion = []
//        if (retencion) {
//            detalleRetencion = DetalleRetencion.findAllByRetencion(retencion)
//        } else {
//            detalleRetencion = []
//        }
//
//        def hoy = new Date()
//        def anioFin = hoy.format("yyyy").toInteger()
//        def anios = []
//        3.times {
//            def p = getPeriodosByAnio(anioFin - it)
//            if (p.size() > 0) {
//                anios.add(anioFin - it)
//            }
//        }
//        def per = Periodo.withCriteria {
//            ge("fechaInicio", new Date().parse("dd-MM-yyyy", "01-01-" + hoy.format("yyyy")))
//            le("fechaFin", utilitarioService.getLastDayOfMonth(hoy))
//            order("fechaInicio", "asc")
//        }
//        def periodos = []
//        per.each { p ->
//            def key = p.fechaInicio.format("MM")
//            def val = fechaConFormato(p.fechaInicio, "MMMM yyyy").toUpperCase()
//            def m = [:]
//            m.id = key
//            m.val = val
//            periodos.add(m)
//        }
//
//
//        def sustento = SustentoTributario.list()
//
//        def porIce = Impuesto.findAllBySri('ICE')
//        def porBns = Impuesto.findAllBySri('BNS')
//        def porSrv = Impuesto.findAllBySri('SRV')
//
//        def comprobante = Comprobante.findByProceso(proceso)
//        def asiento = Asiento.findAllByComprobante(comprobante)
//
////        println("-->>>" + asiento)
//
//
//        return [proceso: proceso, periodos: periodos, sustento: sustento, porIce: porIce, porBns: porBns, porSrv: porSrv, anios: anios, detalleRetencion: detalleRetencion, retencion: retencion]
    }

    def getPeriodosByAnio(anio) {
        def per = Periodo.withCriteria {
            ge("fechaInicio", new Date().parse("dd-MM-yyyy", "01-01-" + anio))
            le("fechaFin", new Date().parse("dd-MM-yyyy", "31-12-" + anio))
            order("fechaInicio", "asc")
        }
        def periodos = []
        per.each { p ->
            def key = p.fechaInicio.format("MM")
            def val = fechaConFormato(p.fechaInicio, "MMMM yyyy").toUpperCase()
            def m = [:]
            m.id = key
            m.val = val
            periodos.add(m)
        }
        return periodos
    }


    def getPeriodos() {
//        println "getPeriodos " + params
        def periodos = getPeriodosByAnio(params.anio)
        render g.select(name: "mes", from: periodos, optionKey: "id", optionValue: "val")
    }


    def getPorcentajes() {

        def concepto = ConceptoRetencionImpuestoRenta.get(params.id)
        render g.textField(name: "porcentajeIR", value: concepto?.porcentaje, style: "width: 50px")

    }

    private String fechaConFormato(fecha, formato) {
        def meses = ["", "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
        def meses2 = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
        def strFecha
        switch (formato) {
            case "MMM-yy":
                strFecha = meses[fecha.format("MM").toInteger()] + "-" + fecha.format("yy")
                break;
            case "MMMM-yy":
                strFecha = meses2[fecha.format("MM").toInteger()] + "-" + fecha.format("yy")
                break;
            case "MMMM yyyy":
                strFecha = meses2[fecha.format("MM").toInteger()] + " " + fecha.format("yyyy")
                break;
        }
        return strFecha
    }

    def guardarSri() {
//        println("guardarSri:" + params)
        params.lang="en"
        def key = "org.springframework.web.servlet.DispatcherServlet.LOCALE_RESOLVER"
        def localeResolver = request.getAttribute(key)
        localeResolver.setLocale(request, response, new Locale("en"))
        def fecha = params.remove("fechaEmision")
        def proceso = Proceso.get(params.id)
        def retencion = Retencion.findByProceso(proceso)
        def concepto = ConceptoRetencionImpuestoRenta.get(params.concepto)

        if (retencion.save(flush: true)) {
            retencion.numeroEstablecimiento = params.numeroEstablecimiento
            retencion.numeroPuntoEmision = params.numeroEmision
            retencion.numeroAutorizacionComprobante = params.numeroAutorizacion
            retencion.tipoPago = params.pago
            retencion.numeroSecuencial = params.numeroSecuencial
            retencion.creditoTributario = params.credito
            if (params.pago == '02') {
                retencion.normaLegal = params.normaLegal
                retencion.convenio = params.convenio
                retencion.pais = Pais.get(params.pais)
            } else {
                retencion.normaLegal = ''
                retencion.convenio = ''
            }
            if (fecha) {
                retencion.fechaEmision = new Date().parse("dd-MM-yyyy", fecha)
            }
            //detalle
            def detalle = DetalleRetencion.findAllByRetencion(retencion)
            detalle.each { det ->
                if (det.cuenta.impuesto.sri == 'RNT') {
//                   println("entro RNT!")
                    det.porcentaje = params.porcentaje
                    det.conceptoRetencionImpuestoRenta = params.concepto
                    det.base = params.base
                    det.total = params.valorRetenido
                }
                if (det.cuenta.impuesto.sri == 'ICE') {
//                   println("entro ICE!")
                    det.porcentaje = params.icePorcentaje.toDouble()
                    det.base = params.iceBase.toDouble()
                    det.total = params.valorRetenidoIce.toDouble()
                }
                if (det.cuenta.impuesto.sri == 'BNS') {
//                   println("entro BNS!")
                    det.porcentaje = params.bienesPorcentaje.toDouble()
                    det.base = params.bienesBase.toDouble()
                    det.total = params.valorRetenidoBienes.toDouble()
                }
                if (det.cuenta.impuesto.sri == 'SRV') {
//                   println("entro SRV!")
                    det.porcentaje = params.serviciosPorcentaje.toDouble()
                    det.base = params.serviciosBase.toDouble()
                    det.total = params.valorRetenidoServicios.toDouble()
                } else {
//                   println("NO entro!")
                }
            }
            render "ok"
//            println("ok")

        } else {
//            println("error al grabar la retencion" + retencion.errors)
            render "Error al grabar!"
        }
    }

    def pagos_ajax () {
        def proceso = Proceso.get(params.proceso)
        def formasPago = ProcesoFormaDePago.findAllByProceso(proceso).tipoPago
        def listaId = TipoPago.list().id - formasPago.id
        def listaFormasPago = TipoPago.findAllByIdInList(listaId)
        return [proceso: proceso, lista: listaFormasPago]
    }

    def tablaPagos_ajax () {
        def proceso = Proceso.get(params.proceso)
        def formasPago = ProcesoFormaDePago.findAllByProceso(proceso)
        return [formas: formasPago, proceso: proceso]
    }

    def borrarFormaPago_ajax () {
        def formaPago = ProcesoFormaDePago.get(params.id)

        try{
            formaPago.delete(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error borrar forma pago " + formaPago.errors)
        }
    }

    def listaFormas_ajax () {
        def proceso = Proceso.get(params.proceso)
        def formasPago = ProcesoFormaDePago.findAllByProceso(proceso).tipoPago
        def listaId = TipoPago.list().id - formasPago.id
        def listaFormasPago = TipoPago.findAllByIdInList(listaId)
        return [proceso: proceso, lista: listaFormasPago]
    }

    def agregarFormaPago_ajax () {
//        println("params " + params)
        def proceso = Proceso.get(params.proceso)
        def tipoPago = TipoPago.get(params.forma)
        def formaPago = new ProcesoFormaDePago()
        formaPago.proceso = proceso
        formaPago.tipoPago = tipoPago

        if(!formaPago.save(flush: true)){
            render "no"
        }else{
            render "ok"
        }
    }

    def cargarPagoMain_ajax () {
        def proceso = Proceso.get(params.proceso)
        def formasPago = ProcesoFormaDePago.findAllByProceso(proceso).tipoPago
        return [formasPago: formasPago]
    }

    def comprobante_ajax () {
        def proceso = Proceso.get(params.proceso)
        def comprobantes = Comprobante.findAllByProceso(proceso).sort{it.tipo.descripcion}
        return [comprobantes: comprobantes, proceso: proceso]
    }

    def asientos_ajax () {
        def proceso = Proceso.get(params.proceso)
        def comprobante = Comprobante.get(params.comprobante)
        def asientos = Asiento.findAllByComprobante(comprobante).sort{it.numero}
        def auxiliares = Auxiliar.findAllByAsientoInList(asientos)
        return [asientos: asientos, comprobante: comprobante, proceso: proceso, auxiliares: auxiliares]
    }

    def formAsiento_ajax () {
//        println("params asiento " + params)
        def comprobante = Comprobante.get(params.comprobante)
        if(params.asiento){
            def asiento = Asiento.get(params.asiento)
            return [asiento: asiento]
        }else{
            return [comprobante: comprobante]
        }
    }


    def buscarCuenta_ajax () {
        def empresa = Empresa.get(params.empresa)
        return [empresa: empresa]
    }

    def tablaBuscarCuenta_ajax () {
//        println("params " + params)
        def empresa = Empresa.get(params.empresa)
        def res

        if(params.nombre == "" && params.codigo == ""){
            res = Cuenta.findAllByEmpresa(empresa).sort{it.numero}
        }else{
            res = Cuenta.withCriteria {
                eq("empresa", empresa)

                and{
                    ilike("descripcion", '%' + params.nombre + '%')
                    ilike("numero", '%' + params.codigo + '%')
                }
                order ("numero","asc")
            }
        }

        return [cuentas: res]
    }

    def guardarAsiento_ajax () {
//        println("params guardar " + params)
        def asiento
        def cuenta = Cuenta.get(params.cuenta)
        def proceso = Proceso.get(params.proceso)
        def comprobante = Comprobante.get(params.comprobante)
        def asientos = Asiento.findAllByComprobante(comprobante).sort{it.numero}
        def siguiente = 0
        if(asientos){
            siguiente = asientos.numero.last() + 1
        }
//        println("asientos " + asientos.numero)

        if(params.asiento){
            asiento = Asiento.get(params.asiento)
            asiento.cuenta = cuenta
            asiento.debe = params.debe.toDouble()
            asiento.haber = params.haber.toDouble()
        }else{
            asiento = new Asiento()
            asiento.cuenta = cuenta
            asiento.debe = params.debe.toDouble()
            asiento.haber = params.haber.toDouble()
            asiento.comprobante = comprobante
            asiento.numero = siguiente
        }

        if(!asiento.save(flush: true)){
            render "no"
            println("error " + asiento.errors)
        }else{
            render "ok"
        }
    }

    def borrarAsiento_ajax () {
//        println("borrar asiento params " + params)
        def comprobante = Comprobante.get(params.comprobante)
        def asiento = Asiento.get(params.asiento)
        def auxiliar = Auxiliar.findByAsiento(asiento)

        if(comprobante.registrado == 'N'){
            if(!auxiliar){
                try{
                    asiento.delete(flush: true)
                    render "ok_Asiento borrado correctamente"
                }catch (e){
                    render "no_Error al borrar el asiento"
                }
            } else{
                render "no_No se puede borrar el asiento, debido a que posee un auxiliar"
            }
        }else{
            render "no_No se puede borrar el asiento, el comprobante ya se encuentra registrado"
        }
    }

    def borrarAuxiliar_ajax () {
        def comprobante = Comprobante.get(params.comprobante)
        def auxiliar = Auxiliar.get(params.auxiliar)

        if(comprobante.registrado == 'N'){
            try{
                auxiliar.delete(flush: true)
                render "ok_Auxiliar borrado correctamente"
            }catch (e){
                render "no_Error al borrar el auxiliar"
            }
        }else{
            render "no_No se puede borrar el auxiliar, el comprobante ya se encuentra registrado"
        }
    }

    def formAuxiliar_ajax() {
        def comprobante = Comprobante.get(params.comprobante)
        def asiento
        def auxiliar
        if(params.auxiliar){
            auxiliar = Auxiliar.get(params.auxiliar)
            asiento = auxiliar.asiento
            return [asiento: asiento, auxiliar: auxiliar, comprobante: comprobante]
        }else{
            asiento = Asiento.get(params.asiento)
            return [asiento: asiento, comprobante: comprobante]
        }
    }

    def guardarAuxiliar_ajax () {
//        println("params " + params)
        def asiento
        def comprobante = Comprobante.get(params.comprobante)
        def tipoPago = TipoPago.get(params.tipoPago)
        def proveedor = Proveedor.get(params.proveedor)
        def fechaPago =  new Date().parse("dd-MM-yyyy", params.fechaPago)
        def auxiliar

        if(params.auxiliar){
            auxiliar = Auxiliar.get(params.auxiliar)
        }else{
            asiento = Asiento.get(params.asiento)
            auxiliar = new Auxiliar()
            auxiliar.asiento = asiento
        }

        auxiliar.descripcion = params.descripcion
        auxiliar.fechaPago = fechaPago
        auxiliar.proveedor = proveedor
        auxiliar.tipoPago = tipoPago
        auxiliar.debe = params.debe.toDouble()
        auxiliar.haber = params.haber.toDouble()

        try{
            auxiliar.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
        }
    }

    def tablaBuscarComprobante_ajax () {
        println "tablaBuscarComprobante_ajax: $params"
        def cn = dbConnectionService.getConnection()
        def proveedor = Proveedor.get(params.proveedor)
        def sql
        if(params.tipo == 'P') {
            sql = "select * from porpagar(${proveedor?.id}) where sldo <> 0;"
        } else if(params.tipo == 'N') {
            sql = "select cmpr__id, clntnmbr prvenmbr, dscr, debe hber, ntcr pgdo, sldo from ventas(${proveedor?.id}) " +
                    "where sldo <> 0"
        }

        def res = cn.rows(sql.toString())
        return [res: res]
    }

    def filaComprobante_ajax () {
        println "filaComprobante_ajax: $params"
        def proceso = Proceso.get(params.proceso)
//        def comprobante = Comprobante.get(params.comprobante)
//        def proveedor =
        def res
        if(params.proceso){
            def cn = dbConnectionService.getConnection()
            def sql
            sql = "select sldo from porpagar(${proceso?.proveedor?.id}) where cmpr__id = ${proceso?.comprobante?.id} ;"
            res = cn.firstRow(sql.toString())
        }else{
//            def cn = dbConnectionService.getConnection()
//            def sql
//            sql = "select sldo from porpagar(${proceso?.proveedor?.id}) where cmpr__id = ${comprobante?.id} ;"
//            res = cn.firstRow(sql.toString())
        }
        return[proceso: proceso, saldo: res?.sldo]
    }

    def valores_ajax () {
        def proceso = Proceso.get(params.proceso)
        return[proceso: proceso, tipo: params.tipo]
    }

    def proveedor_ajax () {
        def proceso = Proceso.get(params.proceso)
        def proveedores = Proveedor.list()
        def tr
        switch (params.tipo) {
            case "P":
                tr = TipoRelacion.findAllByCodigoInList(['C','P'])
                proveedores = Proveedor.findAllByTipoRelacionInList(tr)
                break
            case "NC" :
                tr = TipoRelacion.findAllByCodigoInList(['C','E'])
                proveedores = Proveedor.findAllByTipoRelacionInList(tr)
                break
            case "V"  :
                tr = TipoRelacion.findAllByCodigoInList(['C','E'])
                proveedores = Proveedor.findAllByTipoRelacionInList(tr)
                break
        }

//        println("proveedores " + proveedores)
        return [proveedores : proveedores, proceso: proceso, tipo: params.tipo]
    }

    def cambiarContabilidad_ajax () {
        def usuario = Persona.get(session.usuario.id)
        def contabilidad = Contabilidad.get(session.contabilidad.id)
        def empresa = Empresa.get(session.empresa.id)
        def contabilidades = Contabilidad.findAllByInstitucion(empresa, [sort: "fechaInicio"])
        contabilidades.remove(contabilidad)
        return [usuario: usuario, contabilidad: contabilidad, contabilidades: contabilidades]
    }

    def botonesMayo_ajax () {
        def comprobante = Comprobante.get(params.comprobante).refresh()
        def auxiliares = Auxiliar.findAllByComprobante(comprobante)
        return[comprobante: comprobante, auxiliares: auxiliares]
    }
    def mayorizar_ajax () {
        println("params " + params)
        def comprobante = Comprobante.get(params.id)
        def res = procesoService.mayorizar(comprobante)
        println("res " + res)
        render res
    }

    def desmayorizar_ajax () {
        println("params " + params)
        def comprobante = Comprobante.get(params.id)
        def res = procesoService.desmayorizar(comprobante)
        println("res " + res)
        render res
    }

}

