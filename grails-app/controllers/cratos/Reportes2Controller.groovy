package cratos

import com.itextpdf.text.*
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPTable
import com.itextpdf.text.pdf.PdfWriter
import cratos.inventario.Bodega
import cratos.inventario.DepartamentoItem
import cratos.inventario.DetalleFactura
import cratos.inventario.Grupo
import cratos.inventario.Item
import cratos.inventario.Kardex
import cratos.inventario.SubgrupoItems


class Reportes2Controller {

    def buscadorService
    def dbConnectionService
//    def kerberosoldService

    def updateCuenta() {

        def per = Periodo.get(params.per.toLong())
        def cont = per.contabilidad
//        def cuentas = []
        def cuentas = Auxiliar.withCriteria {
            asiento {
                comprobante {
                    proceso {
                        eq("contabilidad", cont)
                        between("fecha", per.fechaInicio, per.fechaFin)
                    }
                }
                projections {
                    distinct "cuenta"
                }
            }
        }

        println cuentas

        def sel = g.select(name: "cuenta", from: cuentas, optionKey: "id", "class": "ui-widget-content ui-corner-all", style: "width:150px;")

        def html = "Cuenta: " + sel

        render html
    }

    def estadoSituacionFinanciera() {

        println ">> " + params

        params.cont = 1
        params.per = 10

        def empresa = Empresa.get(session.empresa.id)
        def contabilidad = Contabilidad.get(params.cont)
        def periodo = Periodo.get(params.per)

        println session.empresa.id

        def cuentas = Cuenta.findAllByEmpresa(session.empresa)

        return [empresa: empresa, cuentas: cuentas, contabilidad: contabilidad, periodo: periodo]
    }

    def auxiliarClientes() {
        params.cont = 1
        params.per = 10
        params.cli = -1

        def contabilidad = Contabilidad.get(params.cont)
        def periodo = Periodo.get(params.per)

        def clientes = Proveedor.findAllByEmpresa(session.empresa)

        if (params.cli != -1) {
            clientes = [Proveedor.get(params.cli)]
        }

        def cuentas = []

//        println "1"
        Cuenta.findAllByEmpresa(session.empresa).each { cuenta ->
            def mapCuenta = [:]
            def band = false
            if (clientes.size() > 0) {
                mapCuenta.cuenta = cuenta
                mapCuenta.clientes = []
                clientes.each { cliente ->
                    def mapCliente = [:]
                    def tieneAuxiliares = false
                    def procesos = Proceso.findAllByProveedorAndEstado(cliente, 'R', [sort: 'fecha'])
                    if (procesos.size() > 0) {
                        mapCliente.cliente = cliente
                        mapCliente.auxiliares = []
//                        mapCliente.procesos = []
                        procesos.each { proceso ->
//                            def mapProceso = [:]
                            def comprobantes = Comprobante.findAllByProcesoAndFechaBetween(proceso, periodo.fechaInicio, periodo.fechaFin)
                            if (comprobantes.size() > 0) {
//                                mapProceso.proceso = proceso
//                                mapProceso.comprobantes = []
                                comprobantes.each { comprobante ->
                                    if (comprobante.registrado == "S") {
//                                    def mapComprobante = [:]
                                        def asientos = Asiento.findAllByComprobanteAndCuenta(comprobante, cuenta)
                                        if (asientos.size() > 0) {
//                                        mapComprobante.comprobante = comprobante
//                                        mapComprobante.asientos = []
                                            asientos.each { asiento ->
//                                            def mapAsiento = [:]
//                                            mapAsiento.asiento = asiento
//                                            mapAsiento.auxiliares = Auxiliar.findAllByAsiento(asiento)
                                                mapCliente.auxiliares += Auxiliar.findAllByAsiento(asiento)
//                                            mapComprobante.asientos.add(mapAsiento)
                                            } //asientos.each
                                            if (mapCliente.auxiliares.size() > 0) {
                                                tieneAuxiliares = true
                                                band = true
                                            }
//                                        mapProceso.comprobantes.add(mapComprobante)
                                        } //if comprobante tiene asientos
                                    }
                                } //comprobantes.each
//                                mapCliente.procesos.add(mapProceso)
                            } //if procesos tiene comprobantes
                        } //procesos.each
                        if (tieneAuxiliares) {
                            mapCuenta.clientes.add(mapCliente)
                        }
                    } //if cliente tiene procesos
                }//clientes.each
            } //if cuenta tiene clientes
            if (band) {
                cuentas.add(mapCuenta)
            }
        }//cuentas.each
//        println "2"
//
//
//        arr.each { cuenta ->
//            println "cuenta: " + cuenta.cuenta.id
//            cuenta.clientes.each { cliente ->
//                println "\tcliente: " + cliente.cliente.id
//                cliente.auxiliares.each { auxiliar ->
//                    println "\t\tauxiliar: " + auxiliar.id
//                }
//            }
//        }
//
//
//        println "done"
//        render "OK"

        return [cuentas: cuentas]
    }

    def situacionFinanciera() {
        println ">>>" + params

        def empresa = Empresa.get(params.emp)
        def periodo = Periodo.get(params.per)

//        def cuenta1 = Cuenta.findByNumeroLikeAndEmpresa("1%", empresa)

        def numCuentas = [1, 2, 3, 4, 5]

        def datos = []

        numCuentas.each { num ->
//            println "**" + num
            def c = Cuenta.withCriteria {
                eq("empresa", empresa)
                ilike("numero", num + "%")
                eq("nivel", Nivel.get(1))
            }
//            println ">" + Cuenta.withCriteria {
//                eq("empresa", empresa)
////                ilike("numero", it.toString())
//                eq("nivel", Nivel.get(1))
//            }.numero
//            println "   >" + Cuenta.withCriteria {
//                eq("empresa", empresa)
////                ilike("numero", it.toString())
//                eq("nivel", Nivel.get(1))
//            }.find { it.numero.contains(num.toString()) }

            if (c.size() > 0) {
//                def s = SaldoMensual.findByPeriodoAndCuenta(periodo, c[0])
                def s = SaldoMensual.findByCuenta(c[0])
                datos.add(s)
            }
        }

        return [datos: datos, periodo: periodo]

    }

    def situacionFinanciera_old() {

        println "++++++++++++++++++++++++++++++++++" + params
        def empresa = Empresa.get(params.emp)
        def periodo = Periodo.get(params.per)
        def cuenta1 = Cuenta.findByNumeroAndEmpresa("1", empresa)
        def cuenta2 = Cuenta.findByNumeroAndEmpresa("2", empresa)
        def cuenta3 = Cuenta.findByNumeroAndEmpresa("3", empresa)
        def cuenta4 = Cuenta.findByNumeroAndEmpresa("4", empresa)
        def cuenta5 = Cuenta.findByNumeroAndEmpresa("5", empresa)
        def cuenta6 = Cuenta.findByNumeroAndEmpresa("6", empresa)
        def cuenta7 = Cuenta.findByNumeroAndEmpresa("7", empresa)
//        println "periodo " + periodo + " cuenta2 " + cuenta3.id
        def saldo1 = SaldoMensual.findByPeriodoAndCuenta(periodo, cuenta1)
        def saldo2 = SaldoMensual.findByPeriodoAndCuenta(periodo, cuenta2)
        def saldo3 = SaldoMensual.findByPeriodoAndCuenta(periodo, cuenta3)
        def saldo4 = SaldoMensual.findByPeriodoAndCuenta(periodo, cuenta4)
        def saldo5 = SaldoMensual.findByPeriodoAndCuenta(periodo, cuenta5)
        def saldo6 = SaldoMensual.findByPeriodoAndCuenta(periodo, cuenta6)
        def saldo7 = SaldoMensual.findByPeriodoAndCuenta(periodo, cuenta7)

        def tot1
        def tot2
        def tot3
        def tot4
        def tot5
        def tot6
        def tot7
        if (saldo1)
            tot1 = saldo1.saldoInicial + (saldo1.debe - saldo1.haber)
        else
            tot1 = 0
        if (saldo2)
            tot2 = saldo2.saldoInicial + (saldo2.debe - saldo2.haber)
        else
            tot2 = 0
        if (saldo3)
            tot3 = saldo3.saldoInicial + (saldo3.debe - saldo3.haber)
        else
            tot3 = 0
        if (saldo4)
            tot4 = saldo4.saldoInicial + (saldo4.debe - saldo4.haber)
        else
            tot4 = 0
        if (saldo5)
            tot5 = saldo5.saldoInicial + (saldo5.debe - saldo5.haber)
        else
            tot5 = 0
        if (saldo6)
            tot6 = saldo6.saldoInicial + (saldo6.debe - saldo6.haber)
        else
            tot6 = 0
        if (saldo7)
            tot7 = saldo7.saldoInicial + (saldo7.debe - saldo7.haber)
        else
            tot7 = 0

        def resultado = (tot4 + tot6) - (tot5 + tot7)
        def ppr = tot2 + tot3 + resultado


        def datos = SaldoMensual.withCriteria {
            eq("periodo", periodo)
            cuenta {
                and {
                    not {
                        like("numero", "4%")
                    }
                    not {
                        like("numero", "5%")
                    }
                }
                order("numero", "asc")
            }
            neProperty("debe", "haber")
        }

//        println datos

        return [periodo: periodo, contabilidad: session.contabilidad, tot2: tot2, tot3: tot3, tot4: tot4, tot5: tot5, datos: datos, resultado: resultado, ppr: ppr]

    }


    def reporteBuscador = {

        // println "reporte buscador params !! "+params
        if (!session.dominio)
            response.sendError(403)
        else {
            def listaTitulos = params.listaTitulos
            def listaCampos = params.listaCampos
            def lista = buscadorService.buscar(session.dominio, params.tabla, "excluyente", params, true)
            def funciones = session.funciones
            session.dominio = null
            session.funciones = null
            lista.pop()

            def baos = new ByteArrayOutputStream()
            def name = "reporte_de_" + params.titulo.replaceAll(" ", "_") + "_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
            println "name " + name
            Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
            Font info = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL)
            Document document = new Document();
            def pdfw = PdfWriter.getInstance(document, baos);

            document.open();
            document.addTitle("Reporte de " + params.titulo + " " + new Date().format("dd_MM_yyyy"));
            document.addSubject("Generado por el sistema Cratos");
            document.addKeywords("reporte, cratos," + params.titulo);
            document.addAuthor("Cratos");
            document.addCreator("Tedein SA");
            Paragraph preface = new Paragraph();
            addEmptyLine(preface, 1);
            preface.add(new Paragraph("Reporte de " + params.titulo, catFont));
            preface.add(new Paragraph("Generado por el usuario: " + session.usuario + "   el: " + new Date().format("dd/MM/yyyy hh:mm"), info))
            addEmptyLine(preface, 1);
            document.add(preface);
//        Start a new page
//        document.newPage();
            //System.getProperty("user.name")
            addContent(document, catFont, listaCampos.size(), listaTitulos, params.anchos, listaCampos, funciones, lista);
            // Los tamaños son porcentajes!!!!
            document.close();
            pdfw.close()
            byte[] b = baos.toByteArray();
            response.setContentType("application/pdf")
            response.setHeader("Content-disposition", "attachment; filename=" + name)
            response.setContentLength(b.length)
            response.getOutputStream().write(b)
        }
    }

    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }


    private
    static void addContent(Document document, catFont, columnas, headers, anchos, campos, funciones, datos) throws DocumentException {
        Font small = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL);
        def parrafo = new Paragraph("")
        createTable(parrafo, columnas, headers, anchos, campos, funciones, datos);
        document.add(parrafo);


    }


    private
    static void createTable(Paragraph subCatPart, columnas, headers, anchos, campos, funciones, datos) throws BadElementException {
        PdfPTable table = new PdfPTable(columnas);
        table.setWidthPercentage(100);
        table.setWidths(arregloEnteros(anchos))
        Font small = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL);
        headers.eachWithIndex { h, i ->
            PdfPCell c1 = new PdfPCell(new Phrase(h, small));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(c1);
        }
        table.setHeaderRows(1);
        def tagLib = new BuscadorTagLib()
        datos.each { d ->
            campos.eachWithIndex { c, j ->
                def campo
                if (funciones) {
                    if (funciones[j])
                        campo = tagLib.operacion([propiedad: c, funcion: funciones[j], registro: d]).toString()
                    else
                        campo = d.properties[c].toString()
                } else {
                    campo = d.properties[c].toString()
                }

                table.addCell(new Phrase(campo, small));

            }

        }

        subCatPart.add(table);

    }

    private static void createList(Section subCatPart) {
        List list = new List(true, false, 10);
        list.add(new ListItem("First point"));
        list.add(new ListItem("Second point"));
        list.add(new ListItem("Third point"));
        subCatPart.add(list);
    }


    static arregloEnteros(array) {
        int[] ia = new int[array.size()]
        array.eachWithIndex { it, i ->
            ia[i] = it.toInteger()
        }

        return ia
    }


    def estadoDeResultados = {
//        def contabilidad = Contabilidad.get(params.cont);

//        def sp = kerberosoldService.ejecutarProcedure("saldos", params.cont)
//        println "estado de resultados aaaaa " + params
        def periodo = Periodo.get(params.per);


        def empresa = Empresa.get(params.empresa)
//        println("empresa" + empresa)

        def cuenta4 = Cuenta.findAllByNumeroIlikeAndEmpresa("4%", empresa, [sort: "numero"])
        def cuenta5 = Cuenta.findAllByNumeroIlikeAndEmpresa("5%", empresa, [sort: "numero"])
        def cuenta6 = Cuenta.findAllByNumeroIlikeAndEmpresa("6%", empresa, [sort: "numero"])
        def saldo4 = [:]
        def saldo5 = [:]
        def saldo6 = [:]
        def total4 = 0
        def total5 = 0
        def total6 = 0
        def maxLvl = 1


        if (cuenta4) {
            cuenta4.eachWithIndex { i, j ->
                //println "each "+i+" j "+j

                def saldo = SaldoMensual.findByCuentaAndPeriodo(i, periodo)

                if (saldo) {
                    saldo = SaldoMensual.findByCuentaAndPeriodo(i, periodo).refresh()
                    saldo4.put(i.id.toString(), saldo.saldoInicial + saldo.debe - saldo.haber)
                } else
                    saldo4.put(i.id.toString(), 0)
                if (j == 0)
                    total4 = saldo4[i.id.toString()]
                if (i.nivel.id > maxLvl)
                    maxLvl = i.nivel.id
            }
        }
        if (cuenta5) {
            cuenta5.eachWithIndex { i, j ->
                def saldo = SaldoMensual.findByCuentaAndPeriodo(i, periodo)
                if (saldo) {
                    saldo = SaldoMensual.findByCuentaAndPeriodo(i, periodo).refresh()
                    saldo5.put(i.id.toString(), saldo.saldoInicial + saldo.debe - saldo.haber)
                } else
                    saldo5.put(i.id.toString(), 0)
                if (j == 0)
                    total5 = saldo5[i.id.toString()]
                if (i.nivel.id > maxLvl)
                    maxLvl = i.nivel.id
            }

        }

        if (cuenta6) {
            cuenta6.eachWithIndex { i, j ->
                def saldo = SaldoMensual.findByCuentaAndPeriodo(i, periodo)
                if (saldo) {
                    saldo = SaldoMensual.findByCuentaAndPeriodo(i, periodo).refresh()
                    saldo6.put(i.id.toString(), saldo.saldoInicial + saldo.debe - saldo.haber)
                } else
                    saldo6.put(i.id.toString(), 0)
                if (j == 0)
                    total6 = saldo6[i.id.toString()]
                if (i.nivel.id > maxLvl)
                    maxLvl = i.nivel.id
            }

        }
        //println "saldo4 "+cuenta4
        return [periodo: periodo, empresa: empresa, cuenta4: cuenta4, cuenta5: cuenta5, cuenta6: cuenta6, saldo4: saldo4,
                saldo5: saldo5, saldo6: saldo6, total4: total4, total5: total5, total6: total6, maxLvl: maxLvl]
    }


    def reportePagos() {

//       println("---->>" + params)

        def fechaInicio = new Date().parse("yyyy-MM-dd", params.fechaInicio)
        def fechaFin = new Date().parse("yyyy-MM-dd", params.fechaFin)
        def empresa = Empresa.get(params.empresa)
        def proveedor = Proveedor.get(params.prove)
        def auxiliar = Auxiliar.findAllByFechaPagoBetweenAndProveedor(fechaInicio, fechaFin, proveedor)
        def pago
        def pagos = []
        auxiliar.each { i ->
            pago = PagoAux.findAllByAuxiliar(i)
            pagos += pago

        }

        return [auxiliar: auxiliar, pagos: pagos, fechaInicio: fechaInicio, fechaFin: fechaFin, empresa: empresa]
   }

    def libroMayor () {
        println("params lm " + params)
        def desde = new Date().parse("dd-MM-yyyy", params.desde)
        def hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        def cuenta = Cuenta.get(params.cnta)

        def cn = dbConnectionService.getConnection()
        def sql = "select * from libro_mayor(${params.emp}, ${params.cont}, ${params.cnta}, '${params.desde}', '${params.hasta}');"
//        println("sql " + sql)
        def res =  cn.rows(sql.toString())

        return[res: res,empresa: params.emp, desde: desde, hasta: hasta, cuenta: cuenta]
    }

    def balanceComprobacion () {
//        println("params " + params)
        def periodo = Periodo.get(params.periodo);
        def cn = dbConnectionService.getConnection()
        def sql = "select cntanmro, cntadscr, slmsslin, slmsdebe, slmshber, cntamvmt from cnta, slms " +
                "where prdo__id = ${periodo?.id} and slms.cnta__id = cnta.cnta__id and cntamvmt = '1' " +
                "order by cntanmro"
        println("sql " + sql)
        def res =  cn.rows(sql.toString())

        return[cuentas: res, empresa: params.emp, periodo: periodo]
    }

    def retenciones () {
        def desde = new Date().parse("dd-MM-yyyy", params.desde)
        def hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        def contabilidad = Contabilidad.get(params.cont)

         def retenciones = Retencion.withCriteria {

                proceso{
                    eq("contabilidad", contabilidad)
                }

                and{
                    ge("fechaEmision", desde)
                    le("fechaEmision", hasta)
                    order("numero","asc")
                }
         }
        return[retenciones: retenciones, empresa: params.emp, desde: desde, hasta: hasta]
    }

    def kardexGeneral () {
//        println("---> " + params)
        def desde = new Date().parse("dd-MM-yyyy", params.desde)
        def hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        def contabilidad = Contabilidad.get(params.cont)
        def bodega = Bodega.get(params.bodega)

        def res = Kardex.withCriteria {

            proceso{
                eq("contabilidad", contabilidad)
            }

            and{
                eq("bodega", bodega)
                ge("fecha", desde)
                le("fecha", hasta)
            }

            and{
                order("item","desc")
                order("fecha","desc")
            }

        }

        return[res: res, empresa: params.emp, desde: desde, hasta: hasta]
    }

    def retencionesCodigo () {
        def desde = new Date().parse("dd-MM-yyyy", params.desde)
        def hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        def contabilidad = Contabilidad.get(params.cont)

        def listaIR = ConceptoRetencionImpuestoRenta.list().sort{it.codigo}

        def retenciones = Retencion.withCriteria {

            proceso{
                eq("contabilidad", contabilidad)
            }

            and{
                ge("fechaEmision", desde)
                le("fechaEmision", hasta)
            }


            conceptoRIRBienes{
                order("codigo", 'asc')
            }

        }
        return[retenciones: retenciones, empresa: params.emp, desde: desde, hasta: hasta, lista: listaIR]
    }

    def compras () {
//        println("println " + params)
        def desde = new Date().parse("dd-MM-yyyy", params.desde)
        def hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        def contabilidad = Contabilidad.get(params.cont)
        def tipoProceso = TipoProceso.findByCodigo('C')
        def gestorTipo
        def tipo

        if(params.tipo == '1'){
            gestorTipo = 'G'
            tipo = 'Gasto'
        }else{
            gestorTipo = "I"
            tipo = 'Inventario'
        }

        def procesos = Proceso.withCriteria {

            eq("contabilidad", contabilidad)
            eq("tipoProceso", tipoProceso)
            eq("estado", 'R')

            if(params.tipo == 'I'){
                'in'('tipo',['G','S'])
            }else{
                gestor{
                    eq('tipo', gestorTipo)
                }
            }

            and{
                ge("fechaEmision", desde)
                le("fechaEmision", hasta)
            }

        }

        return[empresa: params.emp, desde: desde, hasta: hasta, procesos : procesos, tipo: tipo]
    }

    def ventas () {
        def desde = new Date().parse("dd-MM-yyyy", params.desde)
        def hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        def contabilidad = Contabilidad.get(params.cont)
        def tipoProceso = TipoProceso.findByCodigo('V')

        def ventas = Proceso.withCriteria {

            eq("contabilidad", contabilidad)
            eq("tipoProceso", tipoProceso)

            and{
                ge("fechaEmision", desde)
                le("fechaEmision", hasta)
            }

        }

        return[ventas: ventas, empresa: params.emp, desde: desde, hasta: hasta]
    }

    def factura () {
        def proceso = Proceso.get(params.id)
        def detalles = DetalleFactura.findAllByProceso(proceso)
        def tipoPago = TipoPago.findByCodigo(proceso?.pago?.toString())
        def cn = dbConnectionService.getConnection()
        def totl = cn.rows("select * from total_detalle(${params.id},0,0)".toString())[0]
        return[proceso: proceso, detalles: detalles, empresa: params.emp, pago: tipoPago, totl: totl]
    }

    def factura_E2 () {
        def proceso = Proceso.get(params.id)
        def detalles = DetalleFactura.findAllByProceso(proceso)
        def tipoPago = TipoPago.findByCodigo(proceso?.pago?.toString())
        def cn = dbConnectionService.getConnection()
        def totl = cn.rows("select * from total_detalle(${params.id},0,0)".toString())[0]
        return[proceso: proceso, detalles: detalles, empresa: params.emp, pago: tipoPago, totl: totl]
    }

    def kardex2 () {
//        println("params " + params)
        def desde = new Date().parse("dd-MM-yyyy", params.desde)
        def hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        def contabilidad = Contabilidad.get(params.cont)
        def bodega = Bodega.get(params.bodega)
        def item = Item.get(params.item)
        def d = desde.format("dd-MM-yyyy")
        def h = hasta.format("dd-MM-yyyy")

        def cn = dbConnectionService.getConnection()
        def res = cn.rows("select * from rp_kardex('${contabilidad?.id}','${bodega?.id}','${item?.id}', '${d}', '${h}')")

        return[res: res, empresa: params.emp, desde: desde, hasta: hasta, item: item]
    }

    def modalKardex2_ajax () {

    }

    def subgrupoItems_ajax () {
        def empresa = Empresa.get(session.empresa.id)
        def grupo = Grupo.get(params.grupo)
        def subgrupo = SubgrupoItems.findAllByEmpresaAndGrupo(empresa, grupo, [sort: 'descripcion'])
        return[subgrupo: subgrupo]
    }

    def departamentoItems_ajax () {
//        println("params " + params)
        def subgrupo = SubgrupoItems.get(params.subgrupo)
        def departamento = DepartamentoItem.findAllBySubgrupo(subgrupo)
//        println("res " + departamento)
        return [departamento: departamento]
    }

    def tablaItems_ajax () {
        println("params " + params)
        def departamento = DepartamentoItem.get(params.departamento)
        def items = Item.withCriteria {
            if(params.departamento != '-1'){
                eq("departamento", departamento)
            }
            ilike("nombre", '%' + params.item + '%')
            ilike("codigo", '%' + params.codigo + '%')
        }

        return [items: items]
    }

    def modalKardex3_ajax () {

    }

    def kardex3 () {
//        println("params " + params)
        def bodega = Bodega.get(params.bodega)
        def departamento = DepartamentoItem.get(params.departamento)
//        def desde = new Date().parse("dd-MM-yyyy", params.desde)
//        def hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        def contabilidad = Contabilidad.get(params.cont)

        def cn = dbConnectionService.getConnection()
        def res = cn.rows("select * from rp_existencias('${contabilidad?.id}','${departamento?.id}','${bodega?.id}')")


//        println(" " + "select * from rp_existencias('${contabilidad?.id}','${departamento?.id}','${bodega?.id}')")

//        return[items: res, empresa: params.emp, desde: desde, hasta: hasta, valor: params.valor]
        return[items: res, empresa: params.emp,valor: params.valor]
    }

    def modalCostoVentas_ajax () {

    }

    def costoVentas () {
                println("params cv" + params)
        def bodega = Bodega.get(params.bodega)
        def departamento = DepartamentoItem.get(params.departamento)
        def desde = new Date().parse("dd-MM-yyyy", params.desde)
        def hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        def contabilidad = Contabilidad.get(params.cont)
        def d = desde.format("dd-MM-yyyy")
        def h = hasta.format("dd-MM-yyyy")
        def cn = dbConnectionService.getConnection()
        def res = cn.rows("select * from rp_ventas('${contabilidad?.id}','${departamento?.id}','${bodega?.id}','${d}', '${h}')")
//        println("res " + res)
        return[items: res, empresa: params.emp, desde: desde, hasta: hasta, valor: params.valor]
    }



}