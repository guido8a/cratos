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

        //sri.firmar(input_file_path, key_store_path, key_store_password, output_path, out_file_name)
        sri.firmar(pathxml + archivo, firma, "FcoPaliz1959", pathxml, "f${archivo}")
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
    def claveAccs(prcs) {
//        def prcs = Proceso.get(id) // debe usarse el id del proceso
        def fcha = new Date().format("ddMMyyyy")
        def tipoComprobante = "01"  // factura --> ver tabla 3
        def ruc = "1705310330001"  //obtener de la empresa
        def tipoAmbiente = 1  //Pruebas 1, Producción 2 --> poner esto en PAUX
        def serie = "001001"  // viene de prcsdcmt quitando los '-'
        def numero = prcs.documento.split("-")[2]
        def codigo = 99999999 - prcs.id // 99999999 - prcs__id
        def tipo = 1

//        def clave = "$fcha|$tipoComprobante|$ruc|$tipoAmbiente|$serie|$numero|$codigo|$tipo|$verificador"
        def clave = fcha + tipoComprobante + ruc + tipoAmbiente + serie + numero + codigo + tipo
//        def linea = "12345678|91|1234567892123|4|567893|123456789|41234567|8|9<br/>"
        def linea = "1234567890123456789012345678901234567890123456789"
        println "$linea"
        println "$clave"

        def verificador = verificador(clave)
        println "clave: ${clave}, verificador: ${verificador} "
        clave += verificador
        return clave
    }

    def verificador(nmro) {
        def dg = nmro.toList()
        def coef = [7,6,5,4,3,2,7,6,5,4,3,2,7,6,5,4,3,2,7,6,5,4,3,2,7,6,5,4,3,2,7,6,5,4,3,2,7,6,5,4,3,2,7,6,5,4,3,2]
        def suma = 0
        48.times{i ->
            suma += dg[i].toInteger() * coef[i]
        }
        def retorna = 11 - suma%11

        if(retorna > 9) {
            retorna = 11 - retorna
        }

        println "retorna: ${retorna}"
        retorna
    }

    def facturaElectronica(){
        println "facturaElectrónica: $params"   // debe enviarse prcs__id de la factura
        def prcs = Proceso.get(params.id)
        def archivo = facturaXml(prcs)
//        def archivo = "fc_667.xml"
        println "finaliza xml de facura en --> ${archivo}"
        firmaSri(archivo)
        println "finaliza firma..."
        //se envía al SRI y si todo va bien se pone TipoEmision = 1, caso contrario 2


        //        prcs.claveAcceso = clave
//        prcs.tipoEmision = '1'  // si contesta el SRI
//        prcs.save(flush: true)


        render "ok"
    }

    def facturaXml(prcs) {
        def cn = dbConnectionService.getConnection()
        def sql = " "
        def empresa_id = session.empresa.id
        def clave = claveAccs(prcs)
        def cddc = CodigoDocumento.findByDescripcionIlike('factura')

        def pathxml = servletContext.getRealPath("/") + "xml/" + empresa_id + "/"  //web-app/xml
        def fileName = "fc_${clave}.xml"
        def path = pathxml + fileName
        new File(pathxml).mkdirs()
        def file = new File(path)

        if (!file.exists()) {
            sql = "select tpidcdgo, emprnmbr, empr_ruc, emprtpem, emprdire, emprambt, emprrzsc, emprnmbr, " +
                    "emprctes, emprcont from empr, tpid " +
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
                    ambiente(empr.emprambt)   //pruebas 1, Producción: 2
                    tipoEmision(1) //aplica solo a empresas de emisión "E" si no contesta SRI se pone 2.--> Reenvío???
                    razonSocial(empr.emprrzsc)  //Razón Social en Empresa
                    nombreComercial(empr.emprnmbr)  //nombre comercial
                    ruc(empr.empr_ruc)
                    claveAcceso(clave)
                    codDoc(cddc.codigo)
                    estab(prcs.facturaEstablecimiento)
                    ptoEmi(prcs.facturaPuntoEmision)
                    secuencial(prcs.documento.split("-")[2])
                    dirMatriz(empr.emprdire)
                }  /* -- infoTributaria -- */

                infoFactura() {
                    fechaEmision(new Date().format('dd/MM/yyyy'))
                    dirEstablecimiento(prcs.establecimiento.direccion)   //+++ crear tabla establecimeintos ++dirección
                    contribuyenteEspecial(empr.emprctes?:'000')   //++ agregar en empresa
                    obligadoContabilidad(empr.emprcont)
                    tipoIdentificacionComprador(tipoId(prcs.id))   // Usar dato desde TITT
//                    tipoIdentificacionComprador(prcs.proveedor.tipoIdentificacion.codigoSri)   // desde PRVE
                    razonSocialComprador(prcs.proveedor.nombre)
                    identificacionComprador(prcs.proveedor.ruc.trim())
                    totalSinImpuestos(utilitarioService.numero(prcs.baseImponibleNoIva + prcs.baseImponibleIva0 +
                    prcs.baseImponibleIva))
//                    totalSinImpuestos(utilitarioService.numero(prcs.baseImponibleIva))
                    totalDescuento(utilitarioService.numero(0))   //+++ agregar total descuentos en prcs

                    /** total con impuestos IVA 0 y 12 **/
                    totalConImpuestos() {
                        totalImpuesto() {
                            codigo(TipoDeImpuesto.findByDescripcion('IVA').codigo)   // TPIM
                            codigoPorcentaje(0)   // TRIV
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
                    println "parcial: ${dt.dtfccntd}, ${dt.dtfcpcun}, ${dt.dtfcdsct}"
                    def parcial = Math.round(dt.dtfccntd * (dt.dtfcpcun - dt.dtfcdsct) *100)/100
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
        }

        return fileName
    }


    def enviar() {
        println "enviar: $params"
        def path = servletContext.getRealPath("/")
        def prcs = Proceso.get(params.id)
//        def arch_xml = new File(path + "xml/46/enviar.xml").text
        def arch_xml = new File(path + "xml/46/ffc_${prcs.claveAcceso}.xml").text.encodeAsBase64()

        def sobre_xml = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" " +
           "xmlns:ec=\"http://ec.gob.sri.ws.recepcion\"><soapenv:Header/><soapenv:Body>" +
           "<ec:validarComprobante><xml>${arch_xml}</xml>" +
           "</ec:validarComprobante></soapenv:Body></soapenv:Envelope>"


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

        def respuesta = connection.content.text
        def respuestaSri = new XmlSlurper().parseText(respuesta)
        println respuestaSri
/*
        el SRI responde: respuesta = """<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
        <soap:Body><ns2:validarComprobanteResponse xmlns:ns2="http://ec.gob.sri.ws.recepcion">
        <RespuestaRecepcionComprobante>
          <estado>RECIBIDA</estado>
        <comprobantes/>
        </RespuestaRecepcionComprobante></ns2:validarComprobanteResponse></soap:Body></soap:Envelope>"""
*/



        if(respuestaSri == "RECIBIDA") {
            def para_autorizacion = """<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ec="http://ec.gob.sri.ws.autorizacion">
                <soapenv:Header/>
                <soapenv:Body>
                <ec:autorizacionComprobante>
                <claveAccesoComprobante>${prcs.claveAcceso}</claveAccesoComprobante>
                </ec:autorizacionComprobante>
                </soapenv:Body>
                </soapenv:Envelope>"""

            println "----\n ${para_autorizacion}\n----"
            //https://celcer.sri.gob.ec/comprobantes-electronicos-ws/AutorizacionComprobantesOffline?wsdl
            soapUrl = new URL("https://celcer.sri.gob.ec/comprobantes-electronicos-ws/AutorizacionComprobantesOffline?wsdl")
            connection = soapUrl.openConnection()
            println "abre conexion --- atrz"
            connection.setRequestMethod("POST" )
            println "...post"
            connection.setRequestProperty("Content-Type" ,"application/xml" )
            println "...xml"
            connection.doOutput = true
            println "...do Output"

            writer = new OutputStreamWriter(connection.outputStream)

            writer.write(para_autorizacion)
            println "...write"
            writer.flush()
            writer.close()
            connection.connect()
            println "...connect atz... "

            respuesta = connection.content.text
            def guardar = new File(path + "xml/46/salida.xml")
            guardar.write(respuesta)
            respuestaSri = new XmlSlurper().parseText(respuesta)

            println respuestaSri

            render "Factura electrónica generada correctamente en el SRI"

        } else {
            render "ha ocurrido un error al solicitar la autorización al SRI"
        }
        //con esto se debe pedir el número de autorización
        // --> https://www.jybaro.com/blog/xades-bes-con-javascript-en-el-navegador/

        /*** se usa **/
    }

    def tipoId(id) {
        def cn = dbConnectionService.getConnection()
        def sql = "select tittcdgo from titt, tpid, prve, prcs " +
                "where prcs__id = ${id} and prve.prve__id = prcs.prve__id and " +
                "tpid.tpid__id = prve.tpid__id and titt.tpid__id = tpid.tpid__id and " +
                "titt.tptr__id = prcs.tptr__id"
        println sql
        def tipo = cn.rows(sql.toString())[0].tittcdgo
        println "---> $tipo"
        tipo
    }

    def codigoIva() {
        def cn = dbConnectionService.getConnection()
        def sql = "select tittcdgo from titt, tpid, prve, prcs " +
                "where prcs__id = ${id} and prve.prve__id = prcs.prve__id and " +
                "tpid.tpid__id = prve.tpid__id and titt.tpid__id = tpid.tpid__id and " +
                "titt.tptr__id = prcs.tptr__id"
        println sql
        def tipo = cn.rows(sql.toString())[0].tittcdgo
        println "---> $tipo"
        tipo
    }


}
