package cratos.sri

import cratos.FormaDePago
import cratos.Periodo
import cratos.Proceso
import cratos.ProcesoFormaDePago
import cratos.Proveedor
import cratos.Reembolso
import cratos.Retencion
import groovy.xml.MarkupBuilder
import sri.XAdESBESSignature

class ServicioSriController {
    def dbConnectionService
    def utilitarioService

    def index() { }

    def firmaSri(archivo){
        def sri = new  XAdESBESSignature()
        def empresa_id = session.empresa.id
        def pathxml = servletContext.getRealPath("/") + "xml/" + empresa_id + "/"  //web-app/xml
        def firma = pathxml + "firma.p12"

//        def path = servletContext.getRealPath("/")

        //sri.firmar(input_file_path, key_store_path, key_store_password, output_path, out_file_name)
//        sri.firmar(path + "xml/42/factura.xml", path + "xml/42/firma.p12", "FcoPaliz1959",
//                path + "xml/42", "salida_sri.xml")

//        println "xml:${archivo}, firma en: ${firma}, salida en: f${archivo}"
        sri.firmar(pathxml + archivo, firma, "FcoPaliz1959", pathxml, "f${archivo}")

/*
        def arch = new File(pathxml + "f${archivo}")
        def html = "firmado<hr/>"
        arch.readLines().each {
            html += it.encodeAsHTML() + "<br/>"
        }
        render ("firmado<hr/>" + new File(path + "xml/42/salida_sri.xml").readLines().encodeAsHTML())
*/
        "archivo firmado"
    }

    /**
     * Crea la clave de acceso en base a la ficha técnica
     *  fecha de emisión: 8:(1..8) ddmmaaaaa
     *  tipo comprobante 2:(9..10) tabla 3
     *  RUC 13:(11..23)
     *  Tipo de ambiente 1:(24..24) tabla 4
     *  Serie 6:(25..30) 001001  (serie y establecimiento)
     *  Número 9:(31..39) secuencial de la factura
     *  Código numérico 8:(40..47) pueder ser el prcs__id
     *  Tipo de emisión 1:(48..48) tabla 2
     *  Dígito verificador: 1:(49..49) algoritmo módulo 11
     * **/
    def claveAcceso() {
        def prcs__id = 654  // debe usarse el id del proceso
        def fcha = new Date().format("ddMMyyyy")
        def tipoComprobante = "01"  // factura --> ver tabla 3
        def ruc = "1705310330001"  //obtener de la empresa
        def tipoAmbiente = 1  //Pruebas 1, Producción 2 --> poner esto en PAUX
        def serie = "001001"  // viene de prcsdcmt quitando los '-'
        def numero = "000002101"  // viene de prcsdcmt quitando los '-'
        def codigo = 99999999 - prcs__id // 99999999 - prcs__id
        def tipo = 1
        def verificador = verificador(codigo)
//        def clave = "$fcha|$tipoComprobante|$ruc|$tipoAmbiente|$serie|$numero|$codigo|$tipo|$verificador"
        def clave = fcha + tipoComprobante + ruc + tipoAmbiente + serie + numero + codigo + tipo + verificador
//        def linea = "12345678|91|1234567892123|4|567893|123456789|41234567|8|9<br/>"
//        render linea + clave
        return clave
    }

    def verificador(nmro) {
        def dg = nmro.toString().toList()
        def coef = [3,2,7,6,5,4,3,2]
        def suma = 0
        8.times{i ->
            suma += dg[i].toInteger() * coef[i]
        }
        println "retorna: ${11 - suma%11}"
        return 11 - suma%11
    }

    def facturaElectronica(){
        println "facturaElectrónica: $params"   // debe enviarse prcs__id de la factura
        def archivo = facturaXml(params.id)
//        def archivo = "fc_667.xml"
        println "finaliza xml de facura en --> ${archivo}"
        firmaSri(archivo)
        println "finaliza firma..."
        render "archivo firmado"
    }

    def facturaXml(id) {
        def prcs = Proceso.get(id)
        def cn = dbConnectionService.getConnection()
        def sql = " "
        def empresa_id = session.empresa.id
        def clave = claveAcceso()

        def pathxml = servletContext.getRealPath("/") + "xml/" + empresa_id + "/"  //web-app/xml
        def fileName = "fc_${prcs.id}.xml"
        def path = pathxml + fileName
        new File(pathxml).mkdirs()
        def file = new File(path)

        if (!file.exists()) {

            sql = "select tpidcdgo, emprnmbr, empr_ruc, emprtpem, emprdire from empr, tpid " +
                    "where tpid.tpid__id = empr.tpid__id and empr__id = ${empresa_id}"
            def empr = cn.rows(sql.toString()).first()

            println "...empresa: $sql  --> ${empr}"

            /** detalle de la facura **/
            sql = "select itemcdgo, itemnmbr, dtfccntd, dtfcpcun, dtfcdsct, tpiv__id " +
                    "from dtfc, item where prcs__id = ${prcs.id} and item.item__id = dtfc.item__id " +
                    "order by tpiv__id, itemcdgo"
            def dtfc = cn.rows(sql.toString())


            def writer = new StringWriter()
            def xml = new MarkupBuilder(writer)
//        xml.mkp.xmlDeclaration(version: "1.0", encoding: "UTF-8", standalone: "no")
            xml.mkp.xmlDeclaration(version: "1.0", encoding: "UTF-8", standalone: "yes")

            xml.factura(id: "comprobante", version: "1.1.0") {
                println "inicia factura..."
                infoTributaria() {
                    ambiente(1)   //pruebas 1, Producción: 2
                    tipoEmision(1)
//                    razonSocial(empr.emprnmbr)
                    razonSocial("FRANCISCO FABIAN PALIZ OSORIO")
//                    nombreComercial(empr.emprnmbr)  //++ crear campo nombre comercial y Razón Social en Empresa
                    nombreComercial("FRANCISCO FABIAN PALIZ OSORIO")  //++ crear campo nombre comercial y Razón Social en Empresa
//                    ruc(empr.empr_ruc)
                    ruc("1705310330001")
                    claveAcceso(clave)
                    codDoc("01")
                    estab(prcs.facturaEstablecimiento)
                    ptoEmi(prcs.facturaPuntoEmision)
                    secuencial(prcs.documento.split("-")[2])
//                    secuencial(prcs.documento)
                    dirMatriz(empr.emprdire)
                }  /* -- infoTributaria -- */
                infoFactura() {
//                    fechaEmision(prcs.fechaIngresoSistema.format('dd/MM/yyyy'))
                    fechaEmision(new Date().format('dd/MM/yyyy'))
                    dirEstablecimiento("Dirección establecimiento")   //+++ crear tabla establecimeintos ++dirección
                    contribuyenteEspecial("000")   //++ agregar en empresa
                    obligadoContabilidad("SI")  //++ registrar en Empresa
                    tipoIdentificacionComprador("05")   // desde PRVE
                    razonSocialComprador(prcs.proveedor.nombre)
                    identificacionComprador(prcs.proveedor.ruc.trim())
                    totalSinImpuestos(utilitarioService.numero(prcs.baseImponibleNoIva + prcs.baseImponibleIva0))
                    totalDescuento(utilitarioService.numero(0))   //+++ agregar total descuentos en prcs

                    /** total con impuestos IVA 0 y 12 **/
                    totalConImpuestos() {
                        totalImpuesto() {
                            codigo(2)   // +++ código del IVA
                            codigoPorcentaje(0)   // +++ código % del IVA
                            baseImponible(utilitarioService.numero(prcs.baseImponibleIva0))   // +++ código % del IVA
                            tarifa(utilitarioService.numero(0))   // +++ código % del IVA
                            valor(utilitarioService.numero(0))   // +++ código % del IVA
                        }
                        totalImpuesto() {
                            codigo(2)   // +++ código del IVA
                            codigoPorcentaje(2)   // +++ código % del IVA
                            baseImponible(utilitarioService.numero(prcs.baseImponibleIva))   // +++ código % del IVA
                            tarifa(12)   // +++ código % del IVA
                            valor(utilitarioService.numero(prcs.ivaGenerado))   // +++ código % del IVA
                        }
                    }
                    propina(utilitarioService.numero(0))  // +++ registrar propinas
                    importeTotal(utilitarioService.numero(prcs.valor))
                    moneda("DOLAR")

                    /** para cada forma de pago **/
                    pagos() {
                        pago() {
                            formaPago(19)
                            total(utilitarioService.numero(prcs.valor))
                            plazo(0)
                            unidadTiempo("DIAS")   // ++++ incluir forma de pago
                        }
                    }
                }  /* -- infoFactura -- */

                /** detalle **/
                dtfc.each {dt ->
                    def parcial = Math.round(dt.dtfccntd * (dt.dtfcpcun - dtfc.dtfcdsct) *100)/100
                    detalles() {
                        detalle() {
                            codigoPrincipal(dt.itemcdgo)
                            codigoAuxiliar(dt.itemcdgo)
                            descripcion(dt.itemnmbr)
                            cantidad(dt.dtfccntd)
                            precioUnitario(utilitarioService.numero4(dt.dtfcpcun))
                            descuento(utilitarioService.numero(dt.dtfcdsct))
                            precioTotalSinImpuesto(utilitarioService.numero(parcial))
                            impuestos(){
                                impuesto(){
                                    codigo(2)
                                    codigoPorcentaje(2)
                                    tarifa(12.00)
                                    baseImponible(utilitarioService.numero(parcial))
                                    valor(utilitarioService.numero(parcial*0.12))
                                }
                            }
                        }
                    }
                }

/*
                infoAdicional(){
                    campoAdicional(Dirección: "direccion","Direccion del Local")
                    campoAdicional(Email: "cliente@gmail.com")
                }
*/

            }   /* -- facura -- */

            file.write(writer.toString())
            return fileName
        }
    }


    def enviar() {
        def path = servletContext.getRealPath("/")
        def arch_xml = new File(path + "xml/46/ffc_667.xml").text.encodeAsBase64()
//        def arch_xml = new File(path + "xml/46/enviar.xml").text

        def sobre_xml = """
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ec="http://ec.gob.sri.ws.recepcion">
        <soapenv:Header/>
        <soapenv:Body>
        <ec:validarComprobante>
        <xml>${arch_xml}</xml>
        </ec:validarComprobante>
        </soapenv:Body>
        </soapenv:Envelope>"""


        //https://celcer.sri.gob.ec/comprobantes-electronicos-ws/RecepcionComprobantesOffline?wsdl
        def soapUrl = new URL("https://celcer.sri.gob.ec/comprobantes-electronicos-ws/RecepcionComprobantesOffline?wsdl")
//        def soapUrl = new URL("http://ec.gob.sri.ws.recepcion")
        def connection = soapUrl.openConnection()
        println "abre conexion"
        connection.setRequestMethod("POST" )
        println "...post"
        connection.setRequestProperty("Content-Type" ,"application/xml" )
        println "...xml"
        connection.doOutput = true
        println "...do Output"

        Writer writer = new OutputStreamWriter(connection.outputStream)

        writer.write(sobre_xml)
//        writer.write(arch_xml)
        println "...write"
        writer.flush()
        writer.close()
        connection.connect()
        println "...connect"

        def soapResponse = connection.content.text
        println soapResponse
        def repuesta = """<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
        <soap:Body><ns2:validarComprobanteResponse xmlns:ns2="http://ec.gob.sri.ws.recepcion">
        <RespuestaRecepcionComprobante>
          <estado>RECIBIDA</estado>
        <comprobantes/>
        </RespuestaRecepcionComprobante></ns2:validarComprobanteResponse></soap:Body></soap:Envelope>"""
        //co esto se debe pedir el número de autorización
        // --> https://www.jybaro.com/blog/xades-bes-con-javascript-en-el-navegador/

        /*** se usa **/
        def para_autrizacion = """
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ec="http://ec.gob.sri.ws.autorizacion">
        <soapenv:Header/>
        <soapenv:Body>
        <ec:autorizacionComprobante>
        <claveAccesoComprobante>AquiVaLaClaveDeAcceso</claveAccesoComprobante>
        </ec:autorizacionComprobante>
        </soapenv:Body>
        </soapenv:Envelope>"""
    }

}
