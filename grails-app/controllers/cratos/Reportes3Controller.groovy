package cratos

import com.lowagie.text.Document
import com.lowagie.text.Element
import com.lowagie.text.Font
import com.lowagie.text.PageSize
import com.lowagie.text.Paragraph
import com.lowagie.text.pdf.BaseFont
import com.lowagie.text.pdf.PdfContentByte
import com.lowagie.text.pdf.PdfImportedPage
import com.lowagie.text.pdf.PdfPTable
import com.lowagie.text.pdf.PdfReader
import com.lowagie.text.pdf.PdfWriter
import cratos.inventario.Bodega
import cratos.inventario.DetalleFactura
import cratos.inventario.Item
import cratos.pdf.PdfService
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.krysalis.barcode4j.impl.code128.Code128Bean
import org.krysalis.barcode4j.impl.code128.EAN128Bean
import org.krysalis.barcode4j.impl.code39.Code39Bean

import org.krysalis.barcode4j.*

import java.awt.Color

class Reportes3Controller {

    def dbConnectionService
    def cuentasService
    def buscadorService
    def barcode4jService
    def mailService
    PdfService pdfService
    def reportesPdfService
//    def kerberosoldService

    def reporteComprobante() {
        def contabilidad = Contabilidad.get(params.cont)
        def tipoComprobante = TipoComprobante.get(params.tipo)

        def numComp = params.num.toInteger()
        def tipoComp = params.tipo

        def comp = Comprobante.withCriteria {
            proceso {
                eq("contabilidad", contabilidad)
            }
            eq("numero", numComp)
            eq("tipo", tipoComprobante)
        }

        if (comp) {
            if (comp.size() == 1) {
                render comp[0].id
            } else {
                render "NO_Se encontró más de un comprobante"
            }
        } else {
            render "NO_No se encontró el comprobante"
        }
    }

    /*Reporte de cuentas por pagar
    * Sale de la tabla de axlr (plan de pagos)
    * Las pagas en teoria crean un registro en la tabla pagos
    * */

    def reporteCxP() {
//        println "reporte cxp "+params
//        params.empresa=1
//        params.fechaInicio="01/03/2013"
//        params.fechaFin="31/04/2013"
        def fechaInicio = new Date().parse("yyyy-MM-dd", params.fechaInicio)
        def fechaFin = new Date().parse("yyyy-MM-dd", params.fechaFin)
        def empresa = Empresa.get(params.empresa)
        def axl = Auxiliar.findAllByFechaPagoBetweenAndDebeGreaterThan(fechaInicio, fechaFin, 0, [sort: "fechaPago"])
        def cxp = []
        def valores = [:]
        axl.each { a ->
            if (a.asiento.cuenta.empresa.id.toInteger() == params.empresa.toInteger()) {
                def pagos = PagoAux.findAllByAuxiliar(a)
                def pagado = 0
                pagos.each { p ->
                    pagado += p.monto
                }
                if (pagado < a.debe) {
                    cxp.add(a)
                    valores.put(a.id, a.debe - pagado)
                }
            }
        }
        [cxp: cxp, empresa: empresa, fechaInicio: fechaInicio, fechaFin: fechaFin, valores: valores]

    }

    def auxiliarPorCliente() {
//        println "\n\n\n\n"
        println("params:-->" + params)

        if (!params.cli) {
            params.cli = "-1"
        }

//        params.cont = 1
//        params.per = 10
//        params.cli = -1
//        params.emp = 1
//
//        println params
//        println "\n\n\n\n"
        def html = "", header = ""
        if (!params.per || !params.cli || !params.emp || params.per == "undefined") {
            html += "<div class='errorReporte'>"
            html += "Faltan datos para generar el reporte: <ul>"
            if (!params.per || params.per == "undefined") {
                html += "<li>Seleccione un periodo</li>"
            }
            if (!params.cli) {
                html += "<li>Seleccione un cliente</li>"
            }
            if (!params.emp) {
                html += "<li>Verifique su sesión</li>"
            }
            html += "</ul>"
            html += "</div>"
        } else {
//            println("entro!!!!!")

            def empresa = Empresa.get(params.emp)
            def periodo = Periodo.get(params.per)
            def cliente = Proveedor.get(params.cli)
            if (params.cli == "-1" || params.cli == -1) {
                cliente = Proveedor.list()
            }
            if (!empresa || !periodo || !cliente) {
                html += "<div class='errorReporte'>"
                html += "Error de datos al generar el reporte: <ul>"
                if (!periodo) {
                    html += "<li>No se encontró el periodo " + params.per + "</li>"
                }
                if (!cliente) {
                    html += "<li>No se encontró el cliente " + params.cli + "</li>"
                }
                if (!empresa) {
                    html += "<li>No se econtró la empresa " + params.emp + "</li>"
                }
                html += "</ul>"
                html += "</div>"
            } else {

                header += "<h1>" + empresa.nombre + "</h1>"
                header += "<h2>AUXILIAR POR CLIENTES</h2>"
                header += "<h3>Movimiento desde " + periodo.fechaInicio.format("dd-MM-yyyy") + "    hasta " + periodo.fechaFin.format("dd-MM-yyyy") + "</h3>"

                def cn = dbConnectionService.getConnection()
                def cn2 = dbConnectionService.getConnection()

                def sql = "select\n" +
                        "        u.cnta__id              cuenta_id,\n" +
                        "        u.cntanmro              cuenta_num,\n" +
                        "        u.cntadscr              cuenta_desc,\n" +
                        "        r.prve__id              cli_id,\n" +
                        "        r.prve_ruc              cli_ruc,\n" +
                        "        r.prvenmbr              cli_nombre,\n" +
                        "        r.prvenbct              cli_nombrecontacto,\n" +
                        "        r.prveapct              cli_apellidocontacto,\n" +
                        "        x.axlrfcrg              fecha,\n" +
                        "        p.prcs__id              trans,\n" +
                        "        c.cmpr__id              comp,\n" +
                        "        t.tpcpdscr              tipocomp,\n" +
                        "        x.axlrdscr              descripcion,\n" +
                        "        x.axlrdebe              debe,\n" +
                        "        x.axlrhber              haber,\n" +
                        "        x.axlrdebe-x.axlrhber   saldo\n" +
                        "  from axlr x,\n" +
                        "          asnt s,\n" +
                        "          cmpr c,\n" +
                        "          prcs p,\n" +
                        "          tpcp t,\n" +
                        "          cnta u,\n" +
                        "          prve r\n" +
                        "  where x.asnt__id = s.asnt__id\n" +
                        "          and s.cmpr__id = c.cmpr__id\n" +
                        "          and c.prcs__id = p.prcs__id\n" +
                        "          and c.tpcp__id = t.tpcp__id\n" +
                        "          and s.cnta__id = u.cnta__id\n" +
                        "          and x.prve__id = r.prve__id\n" +
                        "          and u.empr__id = ${params.emp}\n" +
                        "          and c.cmprrgst = 'S'"
                "          and\n" +
                        "          c.cmprfcha >=\n" +
                        "                  (select prdofcin from prdo where prdo__id = ${params.per})\n" +
                        "          and\n" +
                        "          c.cmprfcha <=\n" +
                        "                  (select prdofcfn from prdo where prdo__id = ${params.per})"

//                println sql

                if (params.cli != -1 && params.cli != "-1") {
                    sql += "          and r.prve__id = ${params.cli}\n"
                }
                sql += " order by cuenta_id asc, cli_nombre asc, fecha asc"


                def cuentaId = null, cliId = null
                cn.eachRow(sql) { rs ->

//            println rs
                    def b = false
                    if (rs["cuenta_id"] != cuentaId) {
                        if (html != "") {
                            html += "</table>"
                        }
                        html += "<h1 class='cuenta'>Cuenta contable: " + rs["cuenta_num"] + " " + rs["cuenta_desc"] + "</h1>"
                        html += "<table border='1'>"
                        cuentaId = rs["cuenta_id"]
                        b = true
                    }
                    if (rs["cli_id"] != cliId || b) {

                        if (b) {
                            html += "<tr>"
                            html += "<th>Fecha</th>"
                            html += "<th>Trans.</th>"
                            html += "<th>Comp.</th>"
                            html += "<th>Tipo</th>"
                            html += "<th>Descripción</th>"
                            html += "<th>Debe</th>"
                            html += "<th>Haber</th>"
                            html += "<th>Saldo</th>"
                            html += "</tr>"
                        }

                        def sql2 = "select\n" +
                                "        u.cnta__id                    cuenta_id,\n" +
                                "        x.prve__id                    cli_id,\n" +
                                "        sum(x.axlrdebe-x.axlrhber)    saldo\n" +
                                "  from axlr x,\n" +
                                "          asnt s,\n" +
                                "          cmpr c,\n" +
                                "          prcs p,\n" +
                                "          cnta u\n" +
                                "  where x.asnt__id = s.asnt__id\n" +
                                "          and s.cmpr__id = c.cmpr__id\n" +
                                "          and c.prcs__id = p.prcs__id\n" +
                                "          and s.cnta__id = u.cnta__id\n" +
                                "          and u.empr__id = ${params.emp}\n" +
                                "          and x.prve__id = ${rs['cli_id']}\n" +
                                "          and u.cnta__id = ${rs['cuenta_id']}\n" +
                                "          and\n" +
                                "          c.cmprfcha <\n" +
                                "                  (select prdofcin from prdo where prdo__id=10)\n" +
                                "  group by cuenta_id, cli_id\n" +
                                "  order by cuenta_id asc;"

                        html += "<tr class='cliente'>"
                        html += "<th colspan='5'>"
                        html += "<b>Persona:</b> " + rs["cli_ruc"]
                        if (rs["cli_nombre"]) {
                            html += " " + rs["cli_nombre"]
                        }
                        html += " (" + rs["cli_nombrecontacto"] + " " + rs["cli_apellidocontacto"] + ")"
                        html += "</th>"

                        html += "<th colspan='2' class='right'>Saldo inicial:</th>"

                        html += "<th class='right'>"
                        def b2 = false
                        cn2.eachRow(sql2) { r ->
                            html += r["saldo"]
                            b2 = true
                        }
                        if (!b2) {
                            html += "0.00"
                        }
                        html += "</th>"

                        html += "</tr>"
                        cliId = rs["cli_id"]
                    }

                    html += "<tr>"
                    html += "<td width='80'>" + rs["fecha"].format("dd-MM-yyyy") + "</td>"
                    html += "<td width='80'>" + rs["trans"] + "</td>"
                    html += "<td width='80'>" + rs["comp"] + "</td>"
                    html += "<td width='80'>" + rs["tipocomp"] + "</td>"
                    html += "<td width='180'>" + rs["descripcion"] + "</td>"
                    html += "<td width='80' class='right'>" + rs["debe"] + "</td>"
                    html += "<td width='80' class='right'>" + rs["haber"] + "</td>"
                    html += "<td width='80' class='right'>" + rs["saldo"] + "</td>"
                    html += "</tr>"
                }
                if (html != "") {
                    println ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + html.contains("<table")
                    if (html.contains("<table")) {
                        html += "</table>"
                    }
                } else {
                    html += "<div class='errorReporte'>"
                    html += "No se encontraron datos para el reporte"
                    html += "</div>"
                }
                cn.close()
                cn2.close()
            }
        }

        html = header + html
        println html
        return [html: html]
    }

    def getCuentas(html, cuenta, per) {
//        println cuenta
        html += "<tr class='cuenta'>"
        html += "<td class='numero'>" + cuenta.numero + "</td>"
//        html += "<td class='nombre'>" + cuenta.descripcion + "</td>"
        //  <util:clean str="${cuenta.descripcion}"></util:clean>
        html += "<td class='nombre'>" + util.clean(str: cuenta.descripcion) + "</td>"


        html += "<td class='valor ${cuenta.nivel.descripcion.trim().toLowerCase()}'>"
        def saldos = SaldoMensual.findAllByCuentaAndPeriodo(cuenta, per)
        def saldoInit = 0
        saldos.each {
            it.refresh()
            saldoInit += (it.saldoInicial + it.debe - it.haber)
        }
        html += g.formatNumber(number: saldoInit, maxFractionDigits: 2, minFractionDigits: 2)
        html += "</td>"
        html += "</tr>"

//        println "\t" + cuenta.movimiento
        if (cuenta.movimiento == "0") {
//            println "\t "+Cuenta.countByPadre(cuenta)
            Cuenta.findAllByPadre(cuenta).each { cuentaHija ->
                html = getCuentas(html, cuentaHija, per)
            }
        } else {
//            println "\t"+Asiento.countByCuenta(cuenta)
            Asiento.findAllByCuenta(cuenta).each { asiento ->
                html += "<tr class='asiento'>"
                html += "<td class='numero'> </td>"
                html += "<td class='nombre'>"
                if (asiento.comprobante.proceso?.proveedor) {
                    if (asiento.comprobante.proceso?.proveedor?.nombre) {
//                        html += asiento.comprobante.proceso?.proveedor?.nombre
                        html += util.clean(str: asiento.comprobante.proceso?.proveedor?.nombre)
                    } else if (asiento.comprobante.proceso?.proveedor?.nombreContacto) {
//                        html += asiento.comprobante.proceso?.proveedor?.nombreContacto + " " + asiento.comprobante.proceso?.proveedor?.apellidoContacto
                        html += util.clean(str: asiento.comprobante.proceso?.proveedor?.nombreContacto) + " " + util.clean(str: asiento.comprobante.proceso?.proveedor?.apellidoContacto)
                    } else {
                        html += ""
                    }
                } else {
                    html += ""
                }

                html += "</td>"
                html += "<td class='valor asiento'>"
                html += g.formatNumber(number: asiento.debe - asiento.haber, minFractionDigits: 2, maxFractionDigits: 2)
                html += "</td>"
                html += "</tr>"
            }
        }

        return html
    }


    def balanceGeneralAuxiliares() {
//        params.emp = 1
//        params.per = 10

        def html = "", header = ""

        if (!params.per || !params.emp || params.per == "undefined") {
            html += "<div class='errorReporte'>"
            html += "Faltan datos para generar el reporte: <ul>"
            if (!params.per || params.per == "undefined") {
                html += "<li>Seleccione un periodo</li>"
            }
            if (!params.emp) {
                html += "<li>Verifique su sesión</li>"
            }
            html += "</ul>"
            html += "</div>"
        } else {
            def empresa = Empresa.get(params.emp)
            def periodo = Periodo.get(params.per)

            if (!empresa || !periodo) {
                html += "<div class='errorReporte'>"
                html += "Error de datos al generar el reporte: <ul>"
                if (!periodo) {
                    html += util.clean(str: "<li>No se encontró el periodo " + params.per + "</li>")
                }
                if (!empresa) {
//                    html += "<li>No se econtró la empresa " + params.emp + "</li>"
                    html += util.clean(str: "<li>No se encontró la empresa " + util.clean(str: empresa.nombre) + "</li>")
                }
                html += "</ul>"
                html += "</div>"
            } else {

//                def sp = kerberosoldService.ejecutarProcedure("saldos", periodo.contabilidadId)

                header += "<h1>" + util.clean(str: empresa.nombre) + "</h1>"
                header += "<h2>ESTADO DE SITUACION FINANCIERA (BALANCE GENERAL CON AUXILIARES)</h2>"
                header += "<h3>Movimiento desde " + periodo.fechaInicio.format("dd-MM-yyyy") + "    hasta " + periodo.fechaFin.format("dd-MM-yyyy") + "</h3>"

                def tabla = ""

                Cuenta.findAllByEmpresaAndNivel(empresa, Nivel.get(1)).each { cuenta ->
                    tabla = getCuentas(tabla, cuenta, periodo)
                }

                if (tabla == "") {
                    html += "<div class='errorReporte'>"
                    html += "No se encontraron datos para generar el reporte"
                    html += "</div>"
                } else {
                    html = "<table border='1'>"
                    html += tabla

                    def dos = valores(empresa, "2", periodo)
                    def tres = valores(empresa, "3", periodo)
                    def cuatro = valores(empresa, "4", periodo)
                    def cinco = valores(empresa, "5", periodo)
                    def seis = valores(empresa, "6", periodo)
                    def siete = valores(empresa, "7", periodo)

                    html += "<tr class='resultado'>"
                    html += "<td class='numero'> </td>"
                    html += "<td class='nombre'>RESULTADO DEL EJERCICIO</td>"
                    html += "<td class='valor'>"
                    html += g.formatNumber(number: ((cuatro + seis) - (cinco + siete)), maxFractionDigits: 2, minFractionDigits: 2)
                    html += "</td>"
                    html += "</tr>"

                    html += "<tr class='total'>"
                    html += "<td class='numero'> </td>"
                    html += "<td class='nombre'>TOTAL PASIVO + PATRIMONIO</td>"
                    html += "<td class='valor'>"
                    html += g.formatNumber(number: (dos + tres), maxFractionDigits: 2, minFractionDigits: 2)
                    html += "</td>"
                    html += "</tr>"

                    html += "</table>"

                }
            }
        }

        html = header + html

        html = "<div>TEST</div>"

//        println html
        return [html: html]
    }

    def valores(empresa, nivel, periodo) {
        def valor = SaldoMensual.withCriteria {
            eq("cuenta", Cuenta.findByEmpresaAndNumero(empresa, nivel))
            eq("periodo", periodo)
        }
        if (valor.size() == 1) {
            valor = valor[0]
            valor.refresh()
            valor = valor.saldoInicial + valor.debe - valor.haber
            return valor
        } else if (valor.size() == 0) {
            return 0
        } else {
            println "HAY MAS DE 1 SALDO INICIAL PARA " + nivel
            return 0
        }
    }

    def imprimirRetencion() {
//        println("params " + params)
        def empresa = Empresa.get(params.empresa)
        def proceso = Proceso.get(params.id)
        def retencion = Retencion.findByProceso(proceso)
        def meses = ["", "enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"]

        return [empresa: empresa, retencion: retencion, meses: meses, proceso: proceso]
    }


    def reporteExcel() {

        def comprobantes = cuentasService.getComprobante(582)
        def tipoComprobante = []
        comprobantes.each { i ->
            tipoComprobante += i.tipo.codigo
        }

        def asiento = []
        def comprobante = null
        def numero = null
        if (comprobantes) {
            numero = "" + comprobantes[0].prefijo + "" + comprobantes[0].numero
            comprobante = comprobantes[0]
            asiento = cuentasService.getAsiento(comprobantes?.pop()?.id)
        }
        def comp = [:]

        asiento.each { asientos ->
            def fecha = asientos.comprobante.fecha
            def descripcion = asientos.comprobante.descripcion
            if (!comp.containsKey(numero)) {
                comp[numero] = [:]
                comp[numero].fecha = fecha
                comp[numero].descripcion = descripcion
                comp[numero].tipo = asientos.comprobante.tipo.descripcion
                comp[numero].items = []
            }
            def c = [:]
            c.debe = asientos.debe
            c.haber = asientos.haber
            c.cuenta = asientos.cuenta.numero
            c.descripcion = asientos.cuenta.descripcion
            def cont = comp[numero].items.add(c)
        }

        comp[numero]?.items?.sort { it?.cuenta }


        XSSFWorkbook wb = new XSSFWorkbook()
        org.apache.poi.ss.usermodel.Sheet sheet = wb.createSheet("PAC")

        Row row = sheet.createRow(0)
        row.createCell(0).setCellValue("")

        Row row0 = sheet.createRow(1)
        row0.createCell(1).setCellValue("COMPROBANTE")

        Row row1 = sheet.createRow(2)
        row1.createCell(1).setCellValue("NÚMERO")
        row1.createCell(2).setCellValue("CUENTA")
        row1.createCell(3).setCellValue("DEBE")
        row1.createCell(4).setCellValue("HABER")

        comp.each { item ->
            def val = item.value
            val.items.eachWithIndex { i, j ->
                if (i.debe + i.haber > 0) {
                 Row row2 = sheet.createRow(j+3)
                    row2.createCell(1).setCellValue(i.cuenta)
                    row2.createCell(2).setCellValue(i.descripcion)
                    row2.createCell(3).setCellValue(i.debe)
                    row2.createCell(4).setCellValue(i.haber)
                }
            }
        }


        def output = response.getOutputStream()
        def header = "attachment; filename=" + "Excel.xlsx";
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", header);
        wb.write(output)

    }

    def imprimirCompraGasto () {
//        println("params comprobante " + params)
        def comprobante = Comprobante.get(params.id)
        def proceso = comprobante.proceso
        return [empresa: params.empresa,proceso: proceso, comprobante: comprobante]
    }

    def imprimirCompDiario () {
//        def comprobante = Comprobante.get(params.id)
//        def proceso = comprobante.proceso

        def proceso = Proceso.get(params.id)
        def comprobante = Comprobante.findByProceso(proceso)

        def asientos = Asiento.findAllByComprobante(comprobante).sort{it.numero}
        return [empresa: params.empresa,proceso: proceso, comprobante: comprobante, asientos: asientos]
    }

    def imprimirLibroDiario () {
        def contabilidad = Contabilidad.get(params.cont)
        def periodo = Periodo.get(params.periodo)
        def empresa = Empresa.get(params.empresa)

        def comprobantes = Comprobante.withCriteria {

            proceso{
                eq("empresa",empresa)
                eq("estado",'R')
            }

            and{
                le("fecha", periodo.fechaFin)
                ge("fecha", periodo.fechaInicio)
            }

        }
        return[comprobantes: comprobantes, empresa: params.empresa]

    }

    def reporteSituacion () {


//        println("params " + params)
        def periodoFinal = Periodo.get(params.periodo).fechaFin.format("yyyy-MM-dd")
        def empresa = Empresa.get(params.empresa)

        def cn = dbConnectionService.getConnection()
        def sql = "select * from estado_st(${params.periodo},${params.nivel})"
//        def sql = "select * from estado_st(${params.periodo},${params.nivel}) where slin + debe + hber > 0"
        println("sql " + sql)
        def data = cn.rows(sql.toString())
        cn.close()

//        println("data " + data)

        return[periodo: periodoFinal, empresa: empresa.id, cuentas: data]
    }


    def facturaElectronica () {
        def proceso = Proceso.get(params.id)
        def empresa = Empresa.get(params.emp)
        def detalles = DetalleFactura.findAllByProceso(proceso).sort{it?.item?.codigo}


        return[proceso: proceso, empresa: empresa, detalles: detalles]
    }

    def showBarcode(String barcode) {
//        println("params " + barcode)
//        def generator = new
//        def generator = new Code39Bean()
        def generator = new Code128Bean()
//        def generator = new EAN128Bean()
        generator.height = 6
        generator.fontSize = 2
//        def imageMimeType = "image/png"
//        barcode4jService.png(generator, barcode)
//       barcode4jService.render(generator, barcode, imageMimeType)

//        new File("barcode.png").withOutputStream { out ->
//         barcode4jService.png(generator, barcode, out)
//            render out
//        }

        renderBarcodePng(generator, barcode)
    }

    def notaCreditoElectronica () {

        def proceso = Proceso.get(params.id)
        def empresa = Empresa.get(params.emp)
        def detalles = DetalleFactura.findAllByProceso(proceso).sort{it?.item?.codigo}

        return[proceso: proceso, empresa: empresa, detalles: detalles]
    }

    def notaDebitoElectronica () {

        def proceso = Proceso.get(params.id)
        def empresa = Empresa.get(params.emp)
        def detalles = DetalleFactura.findAllByProceso(proceso).sort{it?.item?.codigo}

        return[proceso: proceso, empresa: empresa, detalles: detalles]
    }

    def modalKardex4_ajax () {

    }

    def kardex4 (){
        println("params " + params)
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



    def _correo () {

    }

    def pdfLink2 (urlOriginal) {
        try{
            byte[] b
            def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort
            // def baseUri = g.createLink(uri:"/", absolute:"true").toString()
            // TODO: get this working...
            //if(params.template){
            //println "Template: $params.template"
            //def content = g.render(template:params.template, model:[pdf:params])
            //b = pdfService.buildPdfFromString(content.readAsString(), baseUri)
            //}
            urlOriginal=urlOriginal.replaceAll("W","&")
            if(params.pdfController){
                def content = g.include(controller:params.pdfController, action:params.pdfAction, id:params.pdfId)
                b = pdfService.buildPdfFromString(content.readAsString(), baseUri)
            }
            else{
                println "sin plugin --> params url "+urlOriginal
                def url = baseUri + urlOriginal
                println "url pdf "+url
                b = pdfService.buildPdf(url)
            }
//            response.setContentType("application/pdf")
//            response.setHeader("Content-disposition", "attachment; filename=" + (params.filename ?: "document.pdf"))
//            response.setContentLength(b.length)
//            response.getOutputStream().write(b)
        }
        catch (Throwable e) {
            println "there was a problem with PDF generation 2 ${e}"
            //if(params.template) render(template:params.template)
            if(params.pdfController){
                println "no"
                redirect(controller:params.pdfController, action:params.pdfAction, params:params)
            }else{
                redirect(action: "index",controller: "reportes",params: [msn:"Hubo un error en la genración del reporte. Si este error vuelve a ocurrir comuniquelo al administrador del sistema."])
            }
        }
    }

    def enviarMail () {

        def para = "correo@hotmail.com"
        def xml = servletContext.getRealPath("/") + "xml/46/"
        def completo = xml + 'fc_667.xml'

//        def x = pdfPrueba()

//        try {
//            def mail = para
//            if (mail) {
//                mailService.sendMail {
//                    multipart true
//                    to mail
//                    subject "Correo de prueba"
//                    html g.render(template:'/reportes3/correo', model:[name:'TEDEIN'])
//                    body "Prueba body "
//                    attachBytes "documentoSri.xml", " application/xml", new File(completo).bytes
//                    attachBytes "facturaElectronica.pdf", "application/pdf", facturaE()
//                }
//            } else {
//                println "El usuario no tiene email"
//            }
//        } catch (e) {
//            println "error email " + e.printStackTrace()
//        }
    }

    def enviarMail2 () {

//        println("params " + params)

        def para = "fegrijalva2501@hotmail.com"
        def xml = servletContext.getRealPath("/") + "xml/46/"
        def completo = xml + 'fc_667.xml'

        //        def x = pdfPrueba()

        try {
            def mail = para
            if (mail) {
                mailService.sendMail {
                    multipart true
                    to mail
                    subject "Factura Electrónica"
                    html g.render(template:'/reportes3/correo', model:[name:'TEDEIN'])
                    body "Prueba body "
                    attachBytes "documentoSri.xml", " application/xml", new File(completo).bytes
                    attachBytes "facturaElectronica.pdf", "application/pdf", pdfLink2(params.url)
                }

                redirect(controller:'proceso', action:'buscarPrcs')

            } else {
                println "El usuario no tiene email"
            }
        } catch (e) {
            println "error email " + e.printStackTrace()
        }
    }


    def excelPlan() {

        def empresa = Empresa.get(params.empresa)

        XSSFWorkbook wb = new XSSFWorkbook()
        org.apache.poi.ss.usermodel.Sheet sheet = wb.createSheet("PLAN")

        Row row = sheet.createRow(0)
        row.createCell(0).setCellValue("")

        Row row0 = sheet.createRow(1)
        row0.createCell(1).setCellValue(empresa.nombre)

        Row rowT = sheet.createRow(2)
        rowT.createCell(1).setCellValue("PLAN DE CUENTAS")

        Row row1 = sheet.createRow(3)
        row1.createCell(1).setCellValue("NÚMERO")
        row1.createCell(2).setCellValue("PADRE")
        row1.createCell(3).setCellValue("NIVEL")
        row1.createCell(4).setCellValue("DESCRIPCIÓN")

        def contabilidad = Contabilidad.get(params.cont.toDouble())
        def cuentas = Cuenta.findAllByEmpresa(empresa, [sort: "numero"])

        CuentaContable.findAllByContabilidad(contabilidad).each { cc ->
            if (cuentas.contains(cc.antiguo)) {
                cuentas.remove(cc.antiguo)
            }
        }

        cuentas.eachWithIndex{cuenta, j->
                    Row row2 = sheet.createRow(j+4)
                    row2.createCell(1).setCellValue(cuenta.numero)
                    row2.createCell(2).setCellValue(cuenta?.padre?.numero)
                    row2.createCell(3).setCellValue(cuenta.nivel.id)
                    row2.createCell(4).setCellValue(cuenta.descripcion)
        }

        def output = response.getOutputStream()
        def header = "attachment; filename=" + "PlanCuentas.xlsx";
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", header);
        wb.write(output)
    }



    def encabezadoYnumeracion (f, tituloReporte, subtitulo, nombreReporte) {

        def titulo = new Color(30, 140, 160)
        Font fontTitulo = new Font(Font.TIMES_ROMAN, 12, Font.BOLD, titulo);
        Font fontTitulo16 = new Font(Font.TIMES_ROMAN, 16, Font.BOLD, titulo);

        def baos = new ByteArrayOutputStream()
        Document document
        document = new Document(PageSize.A4);

        def pdfw = PdfWriter.getInstance(document, baos);
        document.open();

        PdfContentByte cb = pdfw.getDirectContent();

        PdfReader reader = new PdfReader(f);
        for (int i = 1; i <= reader.getNumberOfPages(); i++) {
            document.newPage();
            PdfImportedPage page = pdfw.getImportedPage(reader, i);
            cb.addTemplate(page, 0, 0);
            def en = reportesPdfService.encabezado(tituloReporte, subtitulo, fontTitulo16, fontTitulo)
            reportesPdfService.numeracion(i,reader.getNumberOfPages()).writeSelectedRows(0, -1, -1, 25, cb)

            document.add(en)
        }

        document.close();
        byte[] b = baos.toByteArray();

        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombreReporte)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def reporteResultadoIntegral () {

        println("params " + params)

        def periodo = Periodo.get(params.per);
        def empresa = Empresa.get(params.empresa)

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

        println("cuenta 4 " + cuenta4)


        return [periodo: periodo, empresa: empresa, cuenta4: cuenta4, cuenta5: cuenta5, cuenta6: cuenta6, saldo4: saldo4,
                saldo5: saldo5, saldo6: saldo6, total4: total4, total5: total5, total6: total6, maxLvl: maxLvl]


    }

}