package cratos

import cratos.inventario.Item
import cratos.seguridad.Persona
import cratos.sri.Pais
import cratos.sri.PorcentajeIva
import cratos.sri.SustentoTributario
import cratos.sri.TipoCmprSustento
import cratos.sri.TipoCmprTransaccion
import cratos.sri.TipoComprobanteSri
import cratos.sri.TipoTransaccion

import java.sql.Connection

import org.apache.poi.ss.usermodel.Row



class ProcesoController extends cratos.seguridad.Shield {

    def buscadorService
    def kerberosoldService
    def procesoService
    def loginService
    def utilitarioService
    def dbConnectionService


    def index = { redirect(action: "buscarPrcs") }

    def nuevoProceso = {
//        println "nuevo proceso "+params
//        def libreta = DocumentoEmpresa.findAllByEmpresaAndFechaInicioLessThanEqualsAndFechaFinGreaterThanEqualsAndTipo(empresa,
//                new Date(), new Date(),'F', [sort: 'fechaAutorizacion'])

        if (params.id) {
            def proceso = Proceso.get(params.id).refresh()
//            def registro = (Comprobante.findAllByProceso(proceso)?.size() == 0) ? false : true
            def fps = ProcesoFormaDePago.findAllByProceso(proceso)

            render(view: "procesoForm", model: [proceso: proceso, fps: fps])
        } else
            render(view: "procesoForm", model: [proceso: null])
    }

    def save = {
        println "save proceso: $params"
        def proceso
        def comprobante

        def sustento = SustentoTributario.get(params.tipoCmprSustento)  //????
        def comprobanteSri = TipoCmprSustento.get(params."tipoComprobanteSri.id")

        def proveedor = Proveedor.get(params."proveedor.id")
        def gestor = Gestor.get(params.gestor)
        def fechaRegistro = new Date().parse("dd-MM-yyyy", params.fecha_input)   //fecha del cmpr
        def fechaIngresoSistema = new Date().parse("dd-MM-yyyy",params.fechaingreso_input)   //registro

        if(params.id){
            proceso = Proceso.get(params.id)
        } else {
            proceso = new Proceso()
            proceso.estado = "N"
            proceso.contabilidad = Contabilidad.get(session.contabilidad.id)
            proceso.empresa = Empresa.get(session.empresa.id)
//            proceso.tipoTransaccion = tipoTran
        }

        proceso.gestor = gestor
        proceso.valor = (params.baseImponibleIva0?:0).toDouble() + (params.baseImponibleIva?:0).toDouble() +
                (params.baseImponibleNoIva?:0).toDouble()
        proceso.impuesto = (params.ivaGenerado?:0).toDouble() + (params.iceGenerado?:0).toDouble()
        proceso.baseImponibleIva = (params.baseImponibleIva?:0).toDouble()
        proceso.baseImponibleIva0 = (params.baseImponibleIva0?:0).toDouble()
        proceso.baseImponibleNoIva = (params.baseImponibleNoIva?:0).toDouble()
        proceso.ivaGenerado = (params.ivaGenerado?:0).toDouble()
        proceso.iceGenerado = (params.iceGenerado?:0).toDouble()
        proceso.flete = (params.flete?:0).toDouble()
        proceso.fechaEmision= fechaRegistro
        proceso.fechaIngresoSistema = fechaIngresoSistema
        proceso.descripcion = params.descripcion
        proceso.fecha = new Date()

        println "proceso: ${proceso.id}, tipoProceso: ${params.tipoProceso}, get: ${TipoProceso.get(params.tipoProceso)}"

        proceso.tipoProceso = TipoProceso.get(params.tipoProceso)
        proceso.usuario = session.usuario


        switch (params.tipoProceso) {
            case '1': //Compras
                proceso.tipoTransaccion = TipoTransaccion.get(1)
                proceso.procesoSerie01 = params.dcmtEstablecimiento
                proceso.procesoSerie02 = params.dcmtEmision
                proceso.secuencial = params.dcmtSecuencial?:0
                proceso.autorizacion = params.dcmtAutorizacion
                proceso.documento = params.dcmtEstablecimiento + "-" + params.dcmtEmision + "-" + '0' * (9-params.dcmtSecuencial.size()) + params.dcmtSecuencial
//                proceso.facturaAutorizacion = params.dcmtAutorizacion
                proceso.tipoCmprSustento = comprobanteSri
                proceso.sustentoTributario = sustento
                proceso.proveedor = proveedor

                proceso.pago = params.pago

                if (params.pago == '02') {
                    proceso.normaLegal = params.norma
                    proceso.convenio = params.convenio
                    proceso.pais = Pais.get(params.pais)
                } else {
                    proceso.normaLegal = null
                    proceso.convenio = null
                    proceso.pais = null
                }
                if (params?."mdfcComprobante.id"?.toInteger() > 0) {
                    println "---- ${TipoCmprSustento.get(params."mdfcComprobante.id".toInteger())}"
                    proceso.modificaCmpr = TipoCmprSustento.get(params."mdfcComprobante.id".toInteger())
                    proceso.modificaSerie01 = params.mdfcEstablecimiento
                    proceso.modificaSerie02 = params.mdfcEmision
                    proceso.modificaScnc = params.mdfcSecuencial
                    proceso.modificaAutorizacion = params.mdfcAutorizacion
                } else {
                    poneNulos(proceso)
                }
                break
            case '2':  //ventas
                proceso.tipoTransaccion = TipoTransaccion.get(2)
                proceso.documento = params.numEstablecimiento + "-" + params.numeroEmision + "-" + '0' * (9-params.serie.size()) + params.serie
                proceso.facturaEstablecimiento = params.numEstablecimiento
                proceso.facturaPuntoEmision = params.numeroEmision
                proceso.facturaSecuencial = params.serie.toInteger()?:0
                proceso.tipoCmprSustento = comprobanteSri
                proceso.proveedor = proveedor
                break

            case '6':  //ventas
                proceso.tipoTransaccion = null
                proceso.documento = params.numEstablecimiento + "-" + params.numeroEmision + "-" + '0' * (9-params.serie.size()) + params.serie
                proceso.facturaEstablecimiento = params.numEstablecimiento
                proceso.facturaPuntoEmision = params.numeroEmision
                proceso.facturaSecuencial = params.serie.toInteger()?:0
                proceso.comprobante = Comprobante.get(params.comprobanteSel_name)
//                proceso.tipoCmprSustento = comprobanteSri
                proceso.proveedor = proveedor
                break

            case '3':  //Ajustes
                poneNulos(proceso)
                proceso.proveedor = null
                proceso.baseImponibleIva = params.valorPago.toDouble()
                break

            case '4':  //Pagos
                poneNulos(proceso)
                proceso.proveedor = proveedor
                proceso.comprobante = Comprobante.get(params.comprobanteSel_name)
                proceso.baseImponibleIva = params.valorPago.toDouble()
                break

            case '5':  //Ingresos
                poneNulos(proceso)
                proceso.proveedor = proveedor
                proceso.comprobante = Comprobante.get(params.comprobanteSel_name)
                proceso.baseImponibleIva = params.valorPago.toDouble()
                break
        }

        println "...2"


//        println "<<<<< gestor: ${proceso.gestor?.id}, cont: ${proceso.contabilidad?.id}, empr: ${proceso.empresa?.id}, " +
//                "proveedor: ${proceso.proveedor?.id}, cmpr: ${proceso.comprobante?.id}, usro: ${proceso.usuario}"
//        println "tptr: ${proceso.tipoTransaccion}, tpss: ${proceso.tipoCmprSustento}, tpcp: ${proceso.sustentoTributario}"
//        println "tpps: ${proceso.tipoProceso}, fcha: ${proceso.fecha}, fcig: ${proceso.fechaIngresoSistema}"
//        println "fcrg: ${proceso.fechaRegistro}, fcem: ${proceso.fechaEmision}"
        try {
            println "...5: ${proceso.modificaCmpr}"
            proceso.save(flush: true)
            println "...6"
            proceso.refresh()
            println "...7: ${proceso.modificaCmpr}"
            if (proceso.errors.getErrorCount() == 0) {
                if (params.data != "") {
                    def data = params.data.split(";")
                    def fp
                    def tppgLista = []
                    // println "data "+data
                    data.each {
                        if (it != "") {
                            println "porcesando... $it"
                            def tppg = TipoPago.get(it)
                            fp = ProcesoFormaDePago.findByProcesoAndTipoPago(proceso, tppg)
                            if(!fp) {
                                def psfp = new ProcesoFormaDePago()
                                psfp.proceso = proceso
                                psfp.tipoPago = tppg
                                psfp.save(flush: true)
                            }
                            tppgLista.add(tppg)
                        }
                    }
                    println "existentes: $tppgLista"
                    if(tppgLista) {
                        fp = ProcesoFormaDePago.findAllByProcesoAndTipoPagoNotInList(proceso, tppgLista)
                    } else {
                        println "borrar todo........."
                    }

                    println "a borrar: $fp"
                    fp.each {
                        println "borrando: ${it}"
                        it.delete(flush: true)
                    }
                }
            } else {
                println "errores: ${proceso.errors}"
            }

            redirect(action: 'nuevoProceso', id: proceso.id)

        } catch (e) {
            println "...8"
            println "error al grabar el proceso $e"
        }

    }

    def poneNulos(proceso) {
        proceso.tipoTransaccion = null
        proceso.facturaEstablecimiento = null
        proceso.facturaPuntoEmision = null
        proceso.facturaSecuencial = 0
        proceso.tipoCmprSustento = null

        proceso.modificaCmpr = null
        proceso.modificaSerie01 = null
        proceso.modificaSerie02 = null
        proceso.modificaScnc = null
        proceso.modificaAutorizacion = null
    }

    def registrar = {
        if (request.method == 'POST') {
            println "registrar " + params
            def proceso = Proceso.get(params.id)
            if (proceso.estado == "R") {
                render("El proceso ya ha sido registrado previamente")
            } else {
                def lista = procesoService.registrar(proceso)
//                kerberosoldService.generarEntradaAuditoria(params, proceso, "registrado", "R", session.usuario)
                if (lista[0] != false) {
                    render("ok_Proceso registrado exitosamente")
                } else {
                    render("Error_No se ha podido registrar el proceso")
                }
            }
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }

    def cargaGestor = {
        println "cargar gestor $params "
        def gstr = Gestor.findAllByEmpresaAndTipoProceso(session.empresa, TipoProceso.get(params.tipo), [sort: 'nombre'])
        [gstr: gstr, gstr_id: params.gstr_id, rgst: params.rgst]
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

    def cargaTcsr() {
        println "cargatcsr $params"
        def cn = dbConnectionService.getConnection()
        def tipo = 0
        switch (params.tptr) {
            case '1':
                tipo = 1
                break
            case '2':
                tipo = 2
                break
            default:
                tipo = 0
        }
        def sql = "select cast(tittcdgo as integer) cdgo from titt, prve, tptr " +
                "where prve.tpid__id = titt.tpid__id and prve__id = ${params.prve} and " +
                "tptr.tptr__id = titt.tptr__id and tptrcdgo = '${tipo}'"
//        println "sql1: $sql"
        def titt = cn.rows(sql.toString())[0]?.cdgo
        println "identif: $titt"
        if(tipo == 2) {
            sql = "select tcst__id id, tcsrcdgo codigo, tcsrdscr descripcion from tcst, tcsr " +
                    "where tcsr.tcsr__id = tcst.tcsr__id and titt @> '{${titt}}' " +
                    "order by tcsrcdgo"
        } else {
            sql = "select tcst__id id, tcsrcdgo codigo, tcsrdscr descripcion from tcst, tcsr " +
                    "where tcsr.tcsr__id = tcst.tcsr__id and titt @> '{${titt}}' and " +
                    "sstr @> '{${params.sstr}}' order by tcsrcdgo"
        }
//        println "sql2: $sql"
        def data = cn.rows(sql.toString())
        cn.close()
        [data: data, tpcpSri: params.tpcp, estado: params.etdo?:'']
    }

    def cargaSstr() {
        println "cargaSstr $params"
        def cn = dbConnectionService.getConnection()
        def tipo = 0
        switch (params.tptr) {
            case '1':
                tipo = 1
                break
            case '2':
                tipo = 2
                break
            default:
                tipo = 0
        }

        def sql = "select cast(tittcdgo as integer) cdgo from titt, prve, tptr " +
                "where prve.tpid__id = titt.tpid__id and prve__id = ${params.prve} and " +
                "tptr.tptr__id = titt.tptr__id and tptrcdgo = '${tipo}'"
        println "sql: $sql"

        def titt = cn.rows(sql.toString())[0]?.cdgo
        println "identif: $titt"

        sql = "select sstr__id id, sstrcdgo codigo, sstrdscr descripcion from sstr " +
                "where sstr__id in (select distinct(unnest(sstr)) " +
                "from tcst where titt @> '{${titt}}') order by 1;"
//        println "sql2: $sql"
        def data = cn.rows(sql.toString())
        cn.close()
        [data: data, sstr: params.sstr, tpcpSri: params.tpcp, estado: params.etdo?:'']
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
        println "buscar proveedor "+params
        def prve = []
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
            sql = "select prve__id id, prve_ruc ruc, prvenmbr nombre, tppvdscr tipoProveedor, prveatrz from prve, tppv " +
                    "where tppv.tppv__id = prve.tppv__id and tprl__id in (${tipo}) and empr__id = ${session?.empresa?.id} order by prve_ruc;"
        }else{
            if(params.tipo == "1"){
                sql = "select prve__id id, prve_ruc ruc, prvenmbr nombre, tppvdscr tipoProveedor, prveatrz from prve, tppv " +
                        "where tppv.tppv__id = prve.tppv__id and tprl__id in (${tipo}) and empr__id = ${session?.empresa?.id} and prve_ruc like '%${params.par}%' order by prve_ruc;"
            }else{
                sql = "select prve__id id, prve_ruc ruc, prvenmbr nombre, tppvdscr tipoProveedor, prveatrz from prve, tppv " +
                        "where tppv.tppv__id = prve.tppv__id and tprl__id in (${tipo}) and empr__id = ${session?.empresa?.id} and prvenmbr ilike '%${params.par}%' order by prve_ruc;"
            }
        }

        prve = cn.rows(sql.toString())

        [prve: prve]
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
        println "detalleSri: $params"
        def empresa = Empresa.get(session.empresa.id)
        def proceso = Proceso.get(params.id)
        def retencion = Retencion.findByProceso(proceso)
        def libreta = DocumentoEmpresa.findAllByEmpresaAndFechaInicioLessThanEqualsAndFechaFinGreaterThanEqualsAndTipo(empresa,
                new Date(), new Date(),'R', [sort: 'fechaAutorizacion'])

        def baseImponible = (proceso?.baseImponibleIva ?: 0)
        def crirBienes = ConceptoRetencionImpuestoRenta.findAllByTipo("B")
        def crirServicios = ConceptoRetencionImpuestoRenta.findAllByTipo("S")

        def pcivBien = PorcentajeIva.list([sort: 'valor'])
        def pcivSrvc = PorcentajeIva.list([sort: 'valor'])

        return [proceso: proceso, libreta: libreta, retencion: retencion, base: baseImponible, crirBienes: crirBienes,
                crirServicios: crirServicios, pcivBien: pcivBien, pcivSrvc: pcivSrvc]
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

    def tablaBuscarComp_ajax () {
//        println "tablaBuscarComp_ajax: $params"
        def cn = dbConnectionService.getConnection()
        def proveedor = Proveedor.get(params.proveedor)
        def sql
        if(params.tipo == '4') {
            sql = "select * from porpagar(${proveedor?.id}) where sldo <> 0;"
        } else if(params.tipo in ['6', '7', '5']) {
            sql = "select cmpr__id, clntnmbr prvenmbr, dscr, dcmt, debe hber, ntcr pgdo, sldo from ventas(${proveedor?.id}) " +
                    "where sldo <> 0"
        }
        println "sql<<<<<: $sql"
        def res = cn.rows(sql.toString())
        return [res: res]
    }

    def filaComprobante_ajax () {
        println "filaComprobante_ajax: $params"
        def proceso = Proceso.get(params.proceso)
        def data
        def cn = dbConnectionService.getConnection()
        def sql
        if(params.proceso){
            println "tipo de proceso: ${proceso.tipoProceso.id}"
            if(proceso.tipoProceso.id == 4) {
                println "1---------"
                sql = "select sldo from porpagar(${proceso?.proveedor?.id}) where cmpr__id = ${proceso?.comprobante?.id}"
            } else
                println "2--------- ${proceso.tipoProceso.id}"
                if(proceso.tipoProceso.id.toInteger() in [5, 6, 7]) {
                    println "si se contiene-----"
                    sql = "select sldo from ventas(${proceso?.proveedor?.id}) where cmpr__id = ${proceso?.comprobante?.id}"
                }
            println "sql: $sql"
            data = cn.firstRow(sql.toString())
        }

        return[proceso: proceso, saldo: data?.sldo]
    }

    def valores_ajax () {
//        println "valores_ajax $params"
        def proceso = Proceso.get(params.proceso)
        def data = []
        def atrz
        def sql

        def cn = dbConnectionService.getConnection()
        def tipo = 0
        def tpcp = params?.tpcp?.toInteger()
        if(tpcp in [4, 5] && params.tpps == '1') {
            sql = "select cast(tittcdgo as integer) cdgo from titt, prve, tptr " +
                  "where prve.tpid__id = titt.tpid__id and prve__id = ${params.prve} and " +
                  "tptr.tptr__id = titt.tptr__id and tptrcdgo = '1'"
//        println "sql1: $sql"
            def titt = cn.rows(sql.toString())[0]?.cdgo
//            println "identif: $titt"
            sql = "select tcst__id id, tcsrcdgo codigo, tcsrdscr descripcion from tcst, tcsr " +
                  "where tcsr.tcsr__id = tcst.tcsr__id and titt @> '{${titt}}' " +
                  "order by tcsrcdgo"
//        println "sql2: $sql"
            data = cn.rows(sql.toString())
            cn.close()
        }
        sql = "select prveatrz from prve where prve__id = ${params.prve}"
        println "sql1: $sql"
        atrz = cn.rows(sql.toString())[0]?.prveatrz
        println "autorizacion: $atrz"

        [proceso: proceso, tipo: params.tipo, data: data, atrz: atrz]
    }

    def proveedor_ajax () {
//        println "proveedor_ajax: $params"
        def proceso = Proceso.get(params.proceso)
        def proveedores
        def tr
        def prve
        if(params.id) {
            prve = Proveedor.get(params.id.toInteger())
        }

        switch (params.tipo) {
            case ["1", "4"]:  //Pagos
                tr = TipoRelacion.findAllByCodigoInList(['C','P'])
                proveedores = Proveedor.findAllByTipoRelacionInList(tr)
                break
            case ["2", "6", "7"]:  //ventas, NC y ND
                tr = TipoRelacion.findAllByCodigoInList(['C','E'])
                proveedores = Proveedor.findAllByTipoRelacionInList(tr)
                break
        }
//        println "proveedores: $proveedores"
        return [proveedores : proveedores, proceso: proceso, tipo: params.tipo, proveedor: prve]
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
//        println("params " + params)
        def comprobante = Comprobante.get(params.id)
        def res = procesoService.mayorizar(comprobante)
//        println("res " + res)
        render res
    }

    def desmayorizar_ajax () {
//        println("params " + params)
        def comprobante = Comprobante.get(params.id)
        def res = procesoService.desmayorizar(comprobante)
//        println("res " + res)
        render res
    }


    def numeracion_ajax () {
//        println "numeracion_ajax: $params"
        def cn = dbConnectionService.getConnection()
        def proceso
        if(params.proceso) {
            proceso = Proceso.get(params.proceso)
        }

        def tpdc = ""
        def tipo = "Facturas"
        def fcdt
        def sql
        def nmro = 0
        switch (params.tpps){
            case '2':
                tpdc = 'F'
                tipo = 'Facturas'
                break
            case '6':
                tpdc = 'NC'
                tipo = 'Notas de Crédito'
                break
            case '7':
                tpdc = 'ND'
                tipo = 'Notas de Débito'
                break
        }

        if(params.libretin){
            fcdt = DocumentoEmpresa.get(params.libretin)
            sql = "select coalesce(max(prcsfcsc), 0) mxmo from prcs, fcdt " +
                    "where tpps__id = ${params.tpps} and fcdt.fcdt__id = prcs.fcdt__id and " +
                    "prcs.fcdt__id = ${params.libretin} and prcsfcsc between fcdtdsde and fcdthsta"
            nmro = cn.rows(sql.toString())[0]?.mxmo + 1
            render "${fcdt.numeroEstablecimiento}_${fcdt.numeroEmision}_${nmro}"
        } else {
            sql = "select fcdt__id id, fcdtdsde numeroDesde, fcdthsta numeroHasta, fcdtfcat fechaAutorizacion, " +
                    "fcdtnmes numeroEstablecimiento, fcdtnmpe numeroEmision " +
                    "from fcdt where cast(now() as date) - 365 < fcdtfcfn and fcdttipo = '${tpdc}'order by fcdtfcin"
//            println "sql: $sql"
            def libretin = cn.rows(sql.toString())
            sql = "select coalesce(max(prcsfcsc), 0) mxmo from prcs, fcdt " +
                    "where tpps__id = ${params.tpps} and fcdt.fcdt__id = prcs.fcdt__id and " +
                    "prcs.fcdt__id = ${libretin[0]?.id} and prcsfcsc between fcdtdsde and fcdthsta "
//            println "sql nmro: $sql"
            nmro = cn.rows(sql.toString())[0]?.mxmo
            nmro = nmro == 0 ? libretin[0]?.numeroDesde : nmro + 1
//            println "valor de nmro: $nmro, ${libretin[0]?.numeroDesde}"

            if(libretin?.size() > 0) {
                [libretin: libretin, estb: libretin[0].numeroEstablecimiento, emsn: libretin[0].numeroEmision, nmro: nmro,
                tipo: tipo, proceso: proceso]
            } else {
                [libretin: libretin, estb: 0, emsn: 0, nmro: 0, tipo: tipo, proceso: proceso]
            }

        }
    }

    def buscarPrcs() {
//        println "busqueda "
    }

    def tablaBuscarPrcs() {
        println "buscar .... $params"
        def data = []
        def cn = dbConnectionService.getConnection()
        def cont = session.contabilidad.id
        def buscar = params.buscar.trim()?:'%'

        def sql = "select * from procesos(${session.empresa.id}, ${cont}, '${buscar}') "

        println "buscar .. ${sql}"

        data = cn.rows(sql.toString())

        def msg = ""
        if(data?.size() > 20){
            data.pop()   //descarta el último puesto que son 21
            msg = "<div class='alert-danger' style='margin-top:-20px; diplay:block; height:25px;margin-bottom: 20px;'>" +
                    " <i class='fa fa-warning fa-2x pull-left'></i> Su búsqueda ha generado más de 20 resultados. " +
                    "Use más letras para especificar mejor la búsqueda.</div>"
        }
        cn.close()

        return [data: data, msg: msg]
    }

    def validarSerie_ajax () {
        println "validarSerie_ajax: $params"
        def cn = dbConnectionService.getConnection()
        def fcdt = DocumentoEmpresa.get(params.fcdt)
        def nmro = params.serie.toInteger()
        def sql = ""
        println "nmro:; $nmro"

        if(nmro) {
            if(nmro >= fcdt.numeroDesde && nmro <= fcdt.numeroHasta) {
                println "esta en el rango"
                sql = "select count(*) cnta from rtcn where empr__id = ${session.empresa.id} and rtcnnmro = ${nmro}"
                if(params.id) {
                    sql += " and rtcn__id <> ${params.id}"
                }
                println "sql: $sql"
                def existe = cn.rows(sql.toString())[0].cnta
                cn.close()

//                render existe > 0 ? true : false
                println "existe: $existe"
                if(existe > 0) {
                    render false
                } else {
                    println "no existe... $existe"
                    render true
                }
            } else {
                println "fuera del rango..."
                render false
            }
        } else {
            render true
        }
    }

    def validaSerie_ajax () {
        println "validaSerie_ajax: $params"
        def cn = dbConnectionService.getConnection()
        def fcdt = DocumentoEmpresa.get(params.fcdt)
        def nmro = params.serie.toInteger()
        def sql = ""
        println "nmro:; $nmro"

        if(nmro != 0) {
            if(nmro >= fcdt.numeroDesde && nmro <= fcdt.numeroHasta) {
                println "esta en el rango"
                sql = "select count(*) cnta from prcs where empr__id = ${session.empresa.id} and prcsfcsc = ${nmro}"
                if(params.id) {
                    sql += " and prcs__id <> ${params.id}"
                }
                println "sql: $sql"
                def existe = cn.rows(sql.toString())[0].cnta
                cn.close()

                println "existe: $existe"
                if(existe > 0) {
                    render "no_"
                } else {
                    println "no existe... $existe"
                    render "ok"
                }
            } else {
                println "fuera del rango..."
                render "no_Fuera del rango de valores"
            }
        } else {
            println "no hay valor..."
            render "no_No hay valor"
        }
    }

    def cargaCrir_ajax () {
        def concepto = ConceptoRetencionImpuestoRenta.get(params.id)
        println "porcentaje: ${concepto?.porcentaje}"
        render concepto?.porcentaje?:0
    }

    def carga_pciv () {
        def pciv = PorcentajeIva.get(params.id)
        println "porcentajeIva: ${pciv?.valor}"
        render pciv?.valor?:0
    }

    def validarBase_ajax () {
        println("params " + params)
        def sumatoria = params.baseBienes.toDouble() + params.baseServicios.toDouble()
        if(params.baseBienes.toDouble() > params.baseImponible.toDouble() || params.baseBienes.toDouble() > sumatoria ){
            render false
        }else{
            render true
        }
    }

    def calcularValorICE_ajax () {
//        def porcentaje = PorcentajeIva.get(params.porcentaje)
//        def valor = params.base.toDouble() * (porcentaje.valor / 100)
        def valor = (params.base ? params.base.toDouble() : 0) * (params.porcentaje ? (params.porcentaje.toDouble()  / 100) : 0)
        return [valor: valor]
    }

    def calcularValorBI_ajax () {
       def porcentaje = PorcentajeIva.get(params.porcentaje)
//       def valor = params.base.toDouble() * (porcentaje.valor / 100)
        def valor = (params.base ? params.base.toDouble() : 0) * (porcentaje ? (porcentaje?.valor?.toDouble()  / 100) : 0) * 0.12
        return [valor: valor]
    }

    def totalesRenta_ajax () {
        def total = (params.bienes ? params.bienes.toDouble() : 0) + (params.servicios ? params.servicios.toDouble() : 0)
        def base = params.base.toDouble()
        return [total: total.toDouble(), base: base]
    }

    def saveRetencion_ajax () {
        println("params save " + params)
        def proceso = Proceso.get(params.proceso)
        def retencion
        def mnsj

        def proveedor = Proveedor.get(proceso.proveedor.id)
        def libretin  = DocumentoEmpresa.get(params.documentoEmpresa)

        if(params.retencion){  /** update **/
            retencion = Retencion.get(params.retencion)
        }else{
            retencion = new Retencion()
            retencion.proceso = proceso
            retencion.proveedor = proveedor
        }
        retencion.empresa = proceso.empresa
        retencion.persona = proveedor.nombre
        retencion.telefono = proveedor.telefono
        retencion.ruc = proveedor.ruc
        retencion.direccion = proveedor.direccion
        retencion.fecha = new Date()
        retencion.fechaEmision = new Date().parse("dd-MM-yyyy",params.fechaEmision)

        println "${retencion.fechaEmision} >=  ${proceso.fechaRegistro}"
        if(retencion.fechaEmision < proceso.fechaRegistro) {
            mnsj = "La fecha de la retención es anterior a la emisión del comprobante: ${proceso.fechaRegistro.format('dd-MM-yyyy')}"
            render mnsj
            return
        }

        retencion.conceptoRIRBienes = ConceptoRetencionImpuestoRenta.get(params.conceptoRIRBienes)

        if(params.conceptoRIRBienes != '23') {
            retencion.numero = params.numero.toInteger()
            retencion.numeroComprobante = (libretin.numeroEstablecimiento + "-" + libretin.numeroEmision + "-" + params.numero)
            /*todo: poner el numero en 9 (fcdtdgto) cifras*/

            retencion.baseRenta = params.baseRenta.toDouble()
            retencion.renta = params.renta.toDouble()
            retencion.conceptoRIRServicios = ConceptoRetencionImpuestoRenta.get(params.conceptoRIRServicios)
            retencion.baseRentaServicios = params.baseRentaServicios.toDouble()
            retencion.rentaServicios = params.rentaServicios.toDouble()
            retencion.pcntIvaBienes = PorcentajeIva.get(params.pcntIvaBienes)
            retencion.baseIvaBienes = params.baseIvaBienes.toDouble()
            retencion.ivaBienes = params.ivaBienes.toDouble()
            retencion.pcntIvaServicios = PorcentajeIva.get(params.pcntIvaServicios)
            retencion.baseIvaServicios = params.baseIvaServicios.toDouble()
            retencion.ivaServicios = params.ivaServicios.toDouble()

            retencion.documentoEmpresa = DocumentoEmpresa.get(params.documentoEmpresa)
        } else {
            retencion.numero = 0
            retencion.numeroComprobante = null

            retencion.baseRenta = 0
            retencion.renta = 0
            retencion.baseRentaServicios = 0
            retencion.rentaServicios = 0
            retencion.baseIvaBienes = 0
            retencion.ivaBienes = 0
            retencion.baseIvaServicios = 0
            retencion.ivaServicios = 0
        }

        try {
            retencion.save(flush: true)
//            println("retencion id " + retencion.errors)
            render "ok"
        }catch (e){
            println("errores " + e)
            render "no"
        }
    }

    def numeracionFactura_ajax () {
        println "numeracionFactura_ajax: $params"
        def documentoEmpresa = DocumentoEmpresa.get(params.libretin)
        return [libreta : documentoEmpresa]
    }

    def comprobarSerieFactura_ajax () {
        def documentoEmpresa = DocumentoEmpresa.get(params.libretin)
        def desde = documentoEmpresa.numeroDesde
        def hasta = documentoEmpresa.numeroHasta

        if((params.serie.toInteger() >= desde.toInteger()) && (params.serie.toInteger() <= hasta.toInteger())){
            render 'ok'
        }else{
            render 'no'
        }
    }

    def validarSerieFactura_ajax () {
        def proceso
        def todas
        def empresaF = Empresa.get(session.empresa.id)

        if(params.proceso){
            proceso = Proceso.get(params.retencion)
            todas = Proceso.findAllByEmpresa(proceso.empresa) - proceso
            if(todas.facturaSecuencial.contains(params.serie.toInteger())){
                render 'no'
            }else{
                render 'ok'
            }
        }else{
            todas = Proceso.findAllByEmpresa(empresaF)
            if(todas.facturaSecuencial.contains(params.serie.toInteger())){
                render 'no'
            }else{
                render 'ok'
            }
        }
    }

    def valoresBienes_ajax (){
        def porcentajeIva = PorcentajeIva.get(params.porcentaje)
        return [porcentajeIva: porcentajeIva]
    }

    def valoresServicio_ajax () {
        def porcentajeIva = PorcentajeIva.get(params.porcentaje)
        return [porcentajeIva: porcentajeIva]
    }

}

