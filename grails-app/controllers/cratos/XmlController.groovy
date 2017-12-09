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
            sql = "select tpidcdgo, emprnmbr, empr_ruc, emprtpem from empr, tpid " +
                    "where tpid.tpid__id = empr.tpid__id and empr__id = ${empresa_id}"
            def empr = cn.rows(sql.toString()).first()

            println "...empresa: $sql  --> ${empr}"

            sql = "select count(distinct prcsnmes) cnta from prcs " +
                    "where prcsfcis between '${prdo.fechaInicio}' and '${prdo.fechaFin}' and " +
                    "prcsetdo = 'R'"

            def num_estb = cn.rows(sql.toString())[0].cnta
            num_estb = '0' * (3 - num_estb.toString().size()) + num_estb

            println "...nmes: $sql  --> ${num_estb}"

            sql = "select sum(prcsvlor) totl from prcs where prcsfcis between '${prdo.fechaInicio}' and " +
                    "'${prdo.fechaFin}' and tpps__id = 2 and prcsetdo = 'R'"
            def sumaVentas = cn.rows(sql.toString())[0].totl

            def writer = new StringWriter()
            def xml = new MarkupBuilder(writer)
//        xml.mkp.xmlDeclaration(version: "1.0", encoding: "UTF-8", standalone: "no")
            xml.mkp.xmlDeclaration(version: "1.0", encoding: "UTF-8", standalone: "yes")

            println "inicia generacion de ATS"
            xml.iva() {
                TipoIDInformante(empr.tpidcdgo.trim())
                IdInformante(empr.empr_ruc)
                razonSocial(empr.emprnmbr)
                Anio(prdo.fechaInicio.format("yyyy"))
                Mes(prdo.fechaInicio.format("MM"))
                numEstabRuc(num_estb)  //count(distinct prcsnmes)
                totalVentas(utilitarioService.numero(sumaVentas ?: 0))  /**  todo: total ventas ***/
                codigoOperativo("IVA")
                println "inicia compras..."
                compras() {
                    sql = "select prcs__id from prcs where prcsfcis between '${prdo.fechaInicio}' and " +
                            "'${prdo.fechaFin}' and tpps__id = 1 and prcsetdo = 'R' order by prcsfcis"
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
                            baseNoGraIva(utilitarioService.numero(proceso.baseImponibleNoIva))
                            baseImponible(utilitarioService.numero(proceso.baseImponibleIva0))
                            baseImpGrav(utilitarioService.numero(proceso.baseImponibleIva))
                            baseImpExe(utilitarioService.numero(proceso.excentoIva))   /* ??? crear campo */

//                                println "base: ${numero(proceso.baseImponibleIva)}  -- ${proceso.baseImponibleIva}"

                            montoIce(utilitarioService.numero(proceso?.iceGenerado))
                            montoIva(utilitarioService.numero(proceso?.ivaGenerado))

                            valRetBien10(utilitarioService.numero(vlorRtcnIVA(proceso.id, 10)))
                            valRetServ20(utilitarioService.numero(vlorRtcnIVA(proceso.id, 20)))
                            valorRetBienes(utilitarioService.numero(vlorRtcnIVA(proceso.id, 30)))
                            valRetServ50(utilitarioService.numero(vlorRtcnIVA(proceso.id, 50)))
                            valorRetServicios(utilitarioService.numero(vlorRtcnIVA(proceso.id, 70)))
                            valRetServ100(utilitarioService.numero(vlorRtcnIVA(proceso.id, 100)))

                            if (remb) {
                                totbasesImpReemb(utilitarioService.numero(proceso?.baseImponibleIva))
                            } else {
                                totbasesImpReemb(utilitarioService.numero(0))
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

                            if(proceso?.tipoCmprSustento?.tipoComprobanteSri?.codigo?.trim() != '41') {
                                if (retencion?.baseRenta || retencion?.baseRentaServicios) {
                                    air() {
                                        detalleAir() {
                                            if (retencion?.baseRenta) {
                                                codRetAir(retencion?.conceptoRIRBienes?.codigo)
                                                baseImpAir(utilitarioService.numero(retencion?.baseRenta))
                                                porcentajeAir(utilitarioService.numero(retencion?.conceptoRIRBienes?.porcentaje))
                                                valRetAir(utilitarioService.numero(retencion?.renta))
                                            }
                                            if (retencion?.baseRentaServicios) {
                                                codRetAir(retencion?.conceptoRIRServicios?.codigo)
                                                baseImpAir(utilitarioService.numero(retencion?.baseRentaServicios))
                                                porcentajeAir(utilitarioService.numero(retencion?.conceptoRIRServicios?.porcentaje))
                                                valRetAir(utilitarioService.numero(retencion?.rentaServicios))
                                            }
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
                                            baseImponibleReemb(utilitarioService.numero(r?.baseImponibleIva0))
                                            baseImpGravReemb(utilitarioService.numero(r?.baseImponibleIva))
                                            baseNoGraIvaReemb(utilitarioService.numero(r?.baseImponibleNoIva))
                                            baseImpExeReemb(utilitarioService.numero(r?.excentoIva))
                                            montoIceRemb(utilitarioService.numero(r?.iceGenerado))
                                            montoIvaRemb(utilitarioService.numero(r?.ivaGenerado))
                                        }
                                    }
                                }
                            }  /* fin reembolsos */
                        }  /* detalle de compras */
                    }    /* -- each de compras -- */
                }  /* -- compras-- */

                /* totalizar para cada cliente :*/
                sql = "select prve__id, tcst__id, sum(prcsbsnz) base, sum(prcsbszr) cero, count(*) nmro, " +
                        "sum(prcsnoiv) no_iva, sum(prcsexiv) excento, sum(prcs_iva) iva, sum(prcs_ice) ice, " +
                        "sum(prcsrtiv) rt_iva, sum(prcsrtrn) rt_rnta from prcs " +
                        "where prcsfcis between '${prdo.fechaInicio}' and '${prdo.fechaFin}' and tpps__id = 2 and " +
                        "prcsetdo = 'R'" +
                        "group by prve__id, tcst__id"

                println "ventas: $sql"
                def prcsVentas = cn.rows(sql.toString())

                ventas() {
                    prcsVentas.each { vn ->
                        println "procesando ventas ... ${vn.prve__id}"
                        detalleVentas() {
                            def proveedor = Proveedor.get(vn.prve__id)
                            def tpcp = cratos.sri.TipoCmprSustento.get(vn.tcst__id)
                            def tpid = cdgoIdentificacion(vn.prve__id, 2)
                            tpIdCliente(tpid)
                            idCliente(proveedor?.ruc.trim())
                            parteRelVtas(proveedor?.relacionado)
                            /* si tpIdCliente == 06 imprime tipoCliente*/
                            if(tpid == '06'){
                                tipoCliente(proveedor.tipoPersona.codigoSri)
                            }
                            tipoComprobante(tpcp?.tipoComprobanteSri?.codigo?.trim())
                            tipoEmision(empr.emprtpem)
                            numeroComprobantes(vn.nmro)  /** numero de facturas **/

                            baseNoGraIva(utilitarioService.numero(vn.cero))
                            baseImponible(utilitarioService.numero(vn.no_iva))
                            baseImpGrav(utilitarioService.numero(vn.base))
                            montoIva(utilitarioService.numero(vn.iva))
                            montoIce(utilitarioService.numero(vn.ice))
                            valorRetIva(utilitarioService.numero(vn.rt_iva))
                            valorRetRenta(utilitarioService.numero(vn.rt_rnta))

                            /* tabla prfp --> ProcesoFormaDePago   ** vaor >= 1000 */
                            sql = "select distinct tppgcdgo from prcs, prfp, tppg " +
                                    "where tppg.tppg__id = prfp.tppg__id and prfp.prcs__id = prcs.prcs__id and " +
                                    "prcsfcis between '${prdo.fechaInicio}' and '${prdo.fechaFin}' and " +
                                    "tpps__id = 2 and prcsetdo = 'R' and prve__id = ${vn.prve__id}"
                            println "prfp: $sql"
                            def fp = cn.rows(sql.toString())
                            formasDePago() {
                                fp.each { f ->
                                    formaPago(f.tppgcdgo)
                                }
                            }

                        }
                    }
                }
                sql = "select prcsnmes, sum(prcsvlor) totl from prcs where prcsfcis between '${prdo.fechaInicio}' and " +
                        "'${prdo.fechaFin}' and tpps__id = 2 and prcsetdo = 'R' group by prcsnmes"
                println "ventasTotl: $sql"
                def totlVentas = cn.rows(sql.toString())

                /* falta sección de ventasEstablecimiento*/
                ventasEstablecimiento() {
                    totlVentas.each { tv ->
                        ventaEst() {
                            codEstab(tv.prcsnmes)
                            ventasEstab(tv.totl)
                            ivaComp(utilitarioService.numero(0.0))
                        }
                    }
                }

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
        if (params.archivo) {
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



    def vlorRtcnIVA(prcs, pcnt) {
        def cn = dbConnectionService.getConnection()
        def sql = "select rtcn_iva from rtcn, pciv where prcs__id = ${prcs} and " +
                "pciv.pciv__id = rtcn.pciv__id and pcivvlor = ${pcnt}"
        def retencion = cn.rows(sql.toString())[0]?.rtcn_iva ?: 0.0
        retencion.toDouble()
    }

    def cdgoIdentificacion(prve, tptr) {
        def cn = dbConnectionService.getConnection()
        def sql = "select tittcdgo from titt, prve where tptr__id =  ${tptr} and prve.prve__id =  ${prve} and " +
                "titt.tpid__id = prve.tpid__id"
        def codigo = cn.rows(sql.toString())[0]?.tittcdgo
        codigo
    }

}