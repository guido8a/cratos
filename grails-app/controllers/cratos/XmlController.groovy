package cratos

import groovy.xml.MarkupBuilder
import java.text.DecimalFormat
import java.text.NumberFormat;

class XmlController extends cratos.seguridad.Shield {

    def utilitarioService
    def dbConnectionService

    def test1() {
        def writer = new StringWriter()
//        def xml = new MarkupBuilder(writer)

        def xml = new MarkupBuilder(writer)
        xml.mkp.xmlDeclaration(version: "1.0", encoding: "UTF-8", standalone: "no")

        xml.records() {
            car(name: 'HSV Maloo', make: 'Holden', year: 2006) {
                country('Australia')
                record(type: 'speed', 'Production Pickup Truck with speed of 271kph')
            }
            car(name: 'P50', make: 'Peel', year: 1962) {
                country('Isle of Man')
                record(type: 'size', 'Smallest Street-Legal Car at 99cm wide and 59 kg in weight')
            }
            car(name: 'Royale', make: 'Bugatti', year: 1931) {
                country('France')
                record(type: 'price', 'Most Valuable Car at $15 million')
            }
        }

        println writer.toString()
        render writer.toString()
    } //test1

    def xml() {
        def cont = Contabilidad.findAllByInstitucion(session.empresa)
        return [cont: cont, periodos: null]
    }

    def getPeriodos() {
//        println "getPeriodos " + params
        def periodos = getPeriodosByAnio(params.anio)
        render g.select(name: "mes", from: periodos, optionKey: "id", optionValue: "val", class: "form-control")
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

    def errores() {
        return [params: params]
    }


    def createXml() {
        println "createXml: $params"
        def cn = dbConnectionService.getConnection()
        def sql = " "
        def prdo = Periodo.get(params.mes)
        def empresa_id = session.empresa.id

        def pathxml = servletContext.getRealPath("/") + "xml/" + empresa_id + "/"  //web-app/xml
        def fileName = "AnexoTransaccional_" + fechaConFormato(prdo.fechaInicio, "MM_yyyy") + ".xml"
        def path = pathxml + fileName
        new File(pathxml).mkdirs()
        def file = new File(path)

        println "existe: ${file.exists()}, over: ${params.override}"

        if (file.exists() && (params.override != '1')) {
            render "NO_1"
        } else {
            sql = "select tpidcdgo, emprnmbr, empr_ruc from empr, tpid where tpid.tpid__id = empr.tpid__id " +
                    "and empr__id = ${empresa_id}"
            def empr = cn.rows(sql.toString()).first()

            println "...empresa: $sql  --> ${empr}"

            sql = "select distinct prcsnmes from prcs where prcsfcis between '${prdo.fechaInicio}' and " +
                        "'${prdo.fechaFin}' order by prcsnmes"

            def num_estb = cn.rows(sql.toString())

            println "...nmes: $sql  --> ${num_estb}"


            def writer = new StringWriter()
            def xml = new MarkupBuilder(writer)
//        xml.mkp.xmlDeclaration(version: "1.0", encoding: "UTF-8", standalone: "no")
            xml.mkp.xmlDeclaration(version: "1.0", encoding: "UTF-8", standalone: "yes")

            println "inicia generacion de ATS"
            xml.iva() {
                num_estb.each { nmes ->
                    TipoIDInformante(empr.tpidcdgo.trim())
                    IdInformante(empr.empr_ruc)
                    razonSocial(empr.emprnmbr)
                    Anio(prdo.fechaInicio.format("yyyy"))
                    Mes(prdo.fechaInicio.format("MM"))
                    numEstabRuc(nmes.prcsnmes)
                    totalVentas(0.00)
                    codigoOperativo("IVA")
                    println "inicia compras..."
                    compras() {
                        sql = "select prcs__id from prcs where prcsfcis between '${prdo.fechaInicio}' and " +
                                "'${prdo.fechaFin}' and prcsnmes = '${nmes.prcsnmes}' and tpps__id = 1 " +
                                "order by prcsfcis"
                        println "prcsCompras: $sql"
                        def prcsCompras = cn.rows(sql.toString())

                        prcsCompras.each { pr ->
                            def proceso = Proceso.get(pr.prcs__id)
                            println "procesando ... ${proceso.id}"
                            def retencion = Retencion.findByProceso(proceso)
                            def remb = Reembolso.findAllByProceso(proceso)
                            def local = proceso.pago ?: '01'

                            detalleCompras() {
                                codSustento(proceso.sustentoTributario?.codigo)
                                tpIdProv(proceso.proveedor?.tipoIdentificacion?.codigoSri)
                                idProv(proceso.proveedor?.ruc)
                                tipoComprobante(proceso?.tipoCmprSustento?.tipoComprobanteSri?.codigo?.trim())
                                parteRel(proceso?.proveedor?.relacionado)

                                fechaRegistro(fechaConFormato(proceso.fechaIngresoSistema))
                                establecimiento(proceso.procesoSerie01)
                                puntoEmision(proceso.procesoSerie02)
                                secuencial(proceso.secuencial)
                                fechaEmision(fechaConFormato(proceso.fechaEmision))

                                autorizacion(proceso?.autorizacion)
                                baseNoGraIva(numero(proceso.baseImponibleNoIva))
                                baseImponible(numero(proceso.baseImponibleIva0))
                                baseImpGrav(numero(proceso.baseImponibleIva))
                                baseImpExe('0.00')   /* ??? crear campo */

//                                println "base: ${numero(proceso.baseImponibleIva)}  -- ${proceso.baseImponibleIva}"

                                montoIce(numero(proceso?.iceGenerado))
                                montoIva(numero(proceso?.ivaGenerado))

                                valRetBien10(numero(vlorRtcnIVA(proceso.id, 10)))
                                valRetServ20(numero(vlorRtcnIVA(proceso.id, 20)))
                                valorRetBienes(numero(vlorRtcnIVA(proceso.id, 30)))
                                valRetServ50(numero(vlorRtcnIVA(proceso.id, 50)))
                                valorRetServicios(numero(vlorRtcnIVA(proceso.id, 70)))
                                valRetServ100(numero(vlorRtcnIVA(proceso.id, 100)))

                                if (remb) {
                                    totbasesImpReemb(numero(proceso?.baseImponibleIva))
                                } else {
                                    totbasesImpReemb(numero(0))
                                }

                                pagoExterior() {
                                    pagoLocExt(local)
                                    if (local == "01") {
                                        paisEfecPago("NA")
                                        aplicConvDobTrib("NA")
                                        pagExtSujRetNorLeg("NA")
                                    } else {
                                        paisEfecPago(proceso.pais?.codigo)
                                        aplicConvDobTrib(proceso?.convenio)
                                        pagExtSujRetNorLeg(proceso?.normaLegal)
                                    }
                                }

                                /* tabla prfp --> ProcesoFormaDePago   ** vaor >= 1000 */
                                if (proceso.valor >= 1000) {
                                    def fp = ProcesoFormaDePago.findAllByProceso(proceso)
                                    formasDePago() {
                                        fp.each { f ->
                                            formaPago(f?.tipoPago?.codigo)
                                        }
                                    }
                                }

                                if (retencion?.baseRenta || retencion?.baseRentaServicios) {
                                    air() {
                                        detalleAir() {
                                            if (retencion?.baseRenta) {
                                                codRetAir(retencion?.conceptoRIRBienes?.codigo)
                                                baseImpAir(numero(retencion?.baseRenta))
                                                porcentajeAir(numero(retencion?.conceptoRIRBienes?.porcentaje))
                                                valRetAir(numero(retencion?.renta))
                                            }
                                            if (retencion?.baseRentaServicios) {
                                                codRetAir(retencion?.conceptoRIRServicios?.codigo)
                                                baseImpAir(numero(retencion?.baseRentaServicios))
                                                porcentajeAir(numero(retencion?.conceptoRIRServicios?.porcentaje))
                                                valRetAir(numero(retencion?.rentaServicios))
                                            }
                                        }
                                    }
                                }

                                /* reembolsos */
                                if (remb) {
                                    reembolsos() {
                                        remb.each { r ->
                                            reembolso() {
                                                tipoComprobanteReemb(r?.tipoCmprSustento?.tipoComprobanteSri?.codigo.trim())
                                                tpIdProvReemb(r?.proveedor?.tipoIdentificacion?.codigoSri)
                                                idProvReemb(r?.proveedor?.ruc)
                                                establecimientoReemb(r?.reembolsoEstb)
                                                puntoEmisionReemb(r?.reembolsoEmsn)
                                                secuencialReemb(r?.reembolsoSecuencial)
                                                fechaEmisionReemb(fechaConFormato(r?.fecha))
                                                autorizacionReemb(r?.autorizacion)
                                                baseImponibleReemb(numero(r?.baseImponibleIva0))
                                                baseImpGravReemb(numero(r?.baseImponibleIva))
                                                baseNoGraIvaReemb(numero(r?.baseImponibleNoIva))
                                                baseImpExeReemb(numero(r?.excentoIva))
                                                montoIceRemb(numero(r?.iceGenerado))
                                                montoIvaRemb(numero(r?.ivaGenerado))
                                            }
                                        }
                                    }
                                }  /* fin reembolsos */
                            }  /* detalle de compras */
                        }    /* -- each de compras -- */
                    }  /* -- compras-- */
                    sql = "select prcs__id from prcs where prcsfcis between '${prdo.fechaInicio}' and " +
                            "'${prdo.fechaFin}' and prcsnmes = '${nmes.prcsnmes}' and tpps__id = 2 " +
                            "order by prcsfcis"
                    def prcsVentas = cn.rows(sql.toString())

                    prcsVentas.each { pr ->
                        def proceso = Proceso.get(pr.prcs__id)
                        println "procesando ventas ... ${proceso.id}"
                        detalleVentas(){
                            tpIdCliente(proceso.proveedor?.tipoIdentificacion?.codigoSri)
                            idCliente(proceso.proveedor?.ruc)
                            parteRelVtas(proceso?.proveedor?.relacionado)
                            tipoComprobante(proceso?.tipoCmprSustento?.tipoComprobanteSri?.codigo?.trim())
                            tipoEmision('F')
                            numeroComprobantes(1)

                            baseNoGraIva(numero(proceso.baseImponibleNoIva))
                            baseImponible(numero(proceso.baseImponibleIva0))
                            baseImpGrav(numero(proceso.baseImponibleIva))
                            montoIce(numero(proceso?.iceGenerado))
                            montoIva(numero(proceso?.ivaGenerado))
                            valorRetIva(numero(vlorRtcnIVA(proceso.id, 10)))
                            valorRetRenta(numero(vlorRtcnIVA(proceso.id, 10)))

                            /* tabla prfp --> ProcesoFormaDePago   ** vaor >= 1000 */
                            if (proceso.valor >= 1000) {
                                def fp = ProcesoFormaDePago.findAllByProceso(proceso)
                                formasDePago() {
                                    fp.each { f ->
                                        formaPago(f?.tipoPago?.codigo)
                                    }
                                }
                            }

                        }
                    }
                }  /* -- num_estb -- */
            }   /* -- iva-- */
            file.write(writer.toString())
            render "OK"
        }

//            def output = response.getOutputStream()
//            def header = "attachment; filename=" + fileName;
//            response.setContentType("application/xml")
//            response.setHeader("Content-Disposition", header);
//            output.write(file.getBytes());
//        }
    }

    def downloadFile() {
        println "DownloadFile: " + params
        def fileName = ""
        if(params.archivo){
            fileName = params.archivo
        } else {
            def prdo = Periodo.get(params.mes)
            fileName = "AnexoTransaccional_" + fechaConFormato(prdo.fechaInicio, "MM_yyyy") + ".xml"
        }

        def empresa = Empresa.get(session.empresa.id)
        def pathxml = servletContext.getRealPath("/") + "xml/" + empresa.id + "/"  //web-app/xml
        def path = pathxml + fileName

//        new File(pathxml).mkdirs()
        def file = new File(path)

        if (file.exists()) {
            def b = file.getBytes()
            response.setContentType("application/xml")
            response.setHeader("Content-disposition", "attachment; filename=" + fileName)
            response.setContentLength(b.length)
            response.getOutputStream().write(b)

        } else {
            redirect(action: "errores", params: [tipo: 2])
        }
    }

    def downloads() {
        def empresa = Empresa.get(session.empresa.id)
        def baseFolder = servletContext.getRealPath("/") + "xml/" + empresa.id + "/"  //web-app/xml
        def baseDir = new File(baseFolder)
        def list = []
        baseDir.eachFileMatch(~/.*.xml/) { file ->
            def m = [:]
            m.file = file.name
            def parts = m.file.split("\\.")
            parts = parts[0].split("_")
            def mes = parts[1]
            def anio = parts[2]
            m.mes = mes
            m.anio = anio
            m.fecha = new Date().parse("dd-MM-yyyy", "01-" + mes + "-" + anio)
            m.modified = new Date(file.lastModified()).format('dd-MM-yyyy hh:mm:ss')
            list << m
        }

        list = list.sort { it.fecha }
        return [list: list, empresa: empresa]
    }

    private String fechaConFormato(fecha, formato) {
        def meses = ["", "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
        def mesesLargo = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
        def strFecha = ""
//        println ">>" + fecha + "    " + formato
        if (fecha) {
            switch (formato) {
                case "dd/MM/yyyy":
                    strFecha = "" + fecha.format("dd/MM/yyyy")
                    break;
                case "MMM-yy":
                    strFecha = meses[fecha.format("MM").toInteger()] + "-" + fecha.format("yy")
                    break;
                case "dd-MM-yyyy":
                    strFecha = "" + fecha.format("dd-MM-yyyy")
                    break;
                case "dd-MMM-yyyy":
                    strFecha = "" + fecha.format("dd") + "-" + meses[fecha.format("MM").toInteger()] + "-" + fecha.format("yyyy")
                    break;
                case "dd-MMM-yy":
                    strFecha = "" + fecha.format("dd") + "-" + meses[fecha.format("MM").toInteger()] + "-" + fecha.format("yy")
                    break;
                case "dd MMMM yyyy":
                    strFecha = "" + fecha.format("dd") + " de " + mesesLargo[fecha.format("MM").toInteger()] + " de " + fecha.format("yyyy")
                    break;
                case "MMMM_yyyy":
                    strFecha = "" + mesesLargo[fecha.format("MM").toInteger()] + "_" + fecha.format("yyyy")
                    break;
                case "MM_yyyy":
                    strFecha = "" + fecha.format("MM") + "_" + fecha.format("yyyy")
                    break;
                case "MMMM yyyy":
                    strFecha = "" + mesesLargo[fecha.format("MM").toInteger()] + " " + fecha.format("yyyy")
                    break;
                default:
                    strFecha = "Formato " + formato + " no reconocido"
                    break;
            }
        }
//        println ">>>>>>" + strFecha
        return strFecha
    }

    private String fechaConFormato(fecha) {
        return fechaConFormato(fecha, "dd/MM/yyyy")
    }

    def numero(nmro) {
        NumberFormat nf = NumberFormat.getInstance(Locale.US);
        nf.setGroupingUsed(false)
        nf.setMinimumFractionDigits(2)
        nf.format(nmro)
    }

    def vlorRtcnIVA(prcs, pcnt) {
        def cn = dbConnectionService.getConnection()
        def sql = "select rtcn_iva from rtcn, pciv where prcs__id = ${prcs} and " +
                "pciv.pciv__id = rtcn.pciv__id and pcivvlor = ${pcnt}"
        def retencion = cn.rows(sql.toString())[0]?.rtcn_iva?:0.0
        retencion.toDouble()
    }

}