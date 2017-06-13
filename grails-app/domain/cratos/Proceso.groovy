package cratos

import cratos.sri.TipoDePagoSri

class Proceso implements Serializable {
    Gestor gestor
    Contabilidad contabilidad
    Empresa empresa
    Proveedor proveedor
    Comprobante comprobante  /* relacionado para NC */
    cratos.seguridad.Persona usuario

    RolPagos rolPagos
    Adquisiciones adquisicion
    Factura factura
    Transferencia transferencia

    cratos.sri.TipoTransaccion tipoTransaccion //incluir en controller
    cratos.sri.SustentoTributario sustentoTributario
    cratos.sri.TipoCmprSustento tipoCmprSustento
//    TipoPago tipoPago

    Date fecha
    Date fechaRegistro
    Date fechaEmision
    Date fechaIngresoSistema
    String descripcion
    String tipoProceso /*para saber si es compra, venta etc etc........... C--> compra, V---> venta, A--> Ajuste, O--> otros, R->Depreciacion*/
    String estado

    double baseImponibleIva = 0
    double baseImponibleIva0 = 0
    double baseImponibleNoIva = 0
    double ivaGenerado = 0
    double iceGenerado = 0
    double impuesto
    double valor

    String procesoSerie01
    String procesoSerie02
    String secuencial = 0
    String autorizacionSRI
    String documento

    String facturaEstablecimiento
    String facturaPuntoEmision
    String facturaSecuencial
    String facturaAutorizacion

//    double retencionIvaBienes = 0
//    double retencionIvaServicios = 0
//    double retencionIva = 0
//    String tipoRetencion
//    String retencionSerie1
//    String retencionSerie2
//    String retencionSecuencial
//    String retencionAutorizacion


    static auditable = true

    static mapping = {
        table 'prcs'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prcs__id'
        id generator: 'identity'
        version false
        columns {
            gestor column: 'gstr__id'
            contabilidad column: 'cont__id'
            empresa column: 'empr__id'
            proveedor column: 'prve__id'
            comprobante column: 'cmpr__id'
            usuario column: 'prsn__id'

            rolPagos column: 'rlpg__id'
            adquisicion column: 'adqc__id'
            factura column: 'fctr__id'
            transferencia column: 'trnf__id'

            tipoTransaccion column: 'tptr__id'
            sustentoTributario column: 'sstr__id'
            tipoCmprSustento column: 'tcst__id'
//            tipoPago column: 'tppg__id'

            fecha column: 'prcsfcha'
            fechaRegistro column: 'prcsfcrg'
            fechaEmision column: 'prcsfcem'
            fechaIngresoSistema column: 'prcsfcis'
            descripcion column: 'prcsdscr'
            tipoProceso column: 'prcstpps'
            estado column: 'prcsetdo'

            baseImponibleIva column: 'prcsbsnz'
            baseImponibleIva0 column: 'prcsbszr'
            baseImponibleNoIva column: 'prcsnoiv'
            ivaGenerado column: 'prcs_iva'
            iceGenerado column: 'prcs_ice'
            impuesto column: 'prcsimpt'
            valor column: 'prcsvlor'

            procesoSerie01 column: 'prcssr01'
            procesoSerie02 column: 'prcssr02'
            secuencial column: 'prcsscnc'
            autorizacionSRI column: 'prcsatrz'
            documento column: 'prcsdcmt'

            facturaEstablecimiento column: 'prcsfces'
            facturaPuntoEmision column: 'prcsfcpe'
            facturaSecuencial column: 'prcsfcsc'
            facturaAutorizacion column: 'prcsfcat'

//            retencionIvaBienes column: 'prcsrtbn'
//            retencionIvaServicios column: 'prcsrtsr'
//            retencionIva column: 'prcsrtiv'
//            tipoRetencion column: 'prcstprt'
//            retencionSerie1 column: 'prcsrts1'
//            retencionSerie2 column: 'prcsrts2'
//            retencionSecuencial column: 'prcsrtsc'
//            retencionAutorizacion column: 'prcsrtat'
//            ordenCompra column: 'odcp__id'
//            tipoComprobanteId column: 'tcti__id'
//            tipoSoporte column: 'tpst__id'
//            pagoAux column: 'pgax__id'
//            sustentoTributario column: 'sstr__id'
//            tipoComprobanteSri column: 'tpcp__id'

        }
    }
    static constraints = {
        gestor(blank: true, nullable: true, attributes: [title: 'gestor'])
        contabilidad(blank: true, nullable: true, attributes: [title: 'contabilidad'])
        empresa(nullable: false,blank:false)
        proveedor(blank: true, nullable: true, attributes: [title: 'proveedor'])
        comprobante(nullable: true, blank: true)
        usuario(blank: true, nullable: true, attributes: [title: 'usuario'])

        rolPagos(blank: true, nullable: true, attributes: [title: 'rolPagos'])
        adquisicion(blank: true, nullable: true, attributes: [title: 'adquisicion'])
        factura(blank: true, nullable: true, attributes: [title: 'factura'])
        transferencia(blank: true, nullable: true, attributes: [title: 'transferencia'])

        tipoTransaccion(nullable: true, blank: true)
        sustentoTributario(nullable: true, blank: true)
        tipoCmprSustento(nullable: true, blank: true)
//        tipoPago(blank: true, nullable: true, attributes: [title: 'tipoPago'])

        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        fechaRegistro(blank: true, nullable: true, attributes: [title: 'fechaRegistro'])
        fechaEmision(blank: true, nullable: true, attributes: [title: 'fechaEmision'])
        fechaIngresoSistema(blank: true, nullable: true)
        descripcion(size: 1..255, blank: true, nullable: true, attributes: [title: 'descripcion'])
        tipoProceso(nullable: true,blank: true,size: 1..1)
        estado(blank: true, maxSize: 1, attributes: [title: 'estado'])

        baseImponibleIva(blank: true, nullable: true, attributes: [title: 'baseImponibleIva'])
        baseImponibleIva0(blank: true, nullable: true, attributes: [title: 'baseImponibleIva0'])
        baseImponibleNoIva(blank: true, nullable: true, attributes: [title: 'baseImponibleNoIva'])
        ivaGenerado(blank: true, nullable: true, attributes: [title: 'ivaGenerado'])
        iceGenerado(blank: true, nullable: true, attributes: [title: 'iceGenerado'])
        impuesto(blank: true, nullable: true, attributes: [title: 'impuesto'])
        valor(blank: true, nullable: true, attributes: [title: 'valor'])

        procesoSerie01(blank: true, nullable: true, maxSize: 3, attributes: [title: 'procesoSerie01'])
        procesoSerie02(blank: true, nullable: true, maxSize: 3, attributes: [title: 'procesoSerie02'])
        secuencial(blank: true, nullable: true, attributes: [title: 'secuencial'], size: 1..14)
        autorizacionSRI(blank: true, nullable: true, maxSize: 10, attributes: [title: 'autorizacionSRI'])
        documento(blank: true, nullable: true, size: 1..40)

        facturaEstablecimiento(blank: true, nullable: true)
        facturaPuntoEmision(blank: true, nullable: true)
        facturaSecuencial(blank: true, nullable: true)
        facturaAutorizacion(nullable: true,blank: true,size: 1..20)


//        retencionIvaBienes(blank: true, nullable: true, attributes: [title: 'retencionIvaBienes'])
//        retencionIvaServicios(blank: true, nullable: true, attributes: [title: 'retencionIvaServicios'])
//        retencionIva(blank: true, nullable: true, attributes: [title: 'retencionIva'])
//        tipoRetencion(blank: true, nullable: true, attributes: [title: 'tipo de rentencion: bienes o servicios'])
//        retencionSerie1(blank: true, nullable: true)
//        retencionSerie2(blank: true, nullable: true)
//        retencionSecuencial(blank: true, nullable: true)
//        retencionAutorizacion(blank: true, nullable: true)
//        ordenCompra(blank: true, nullable: true, attributes: [title: 'ordenCompra'])
//        tipoComprobanteId(blank: true, nullable: true, attributes: [title: 'tipoComprobanteId'])
//        tipoSoporte(blank: true, nullable: true, attributes: [title: 'tipoSoporte'])
//        pagoAux(blank: true, nullable: true)
//        sustentoTributario(blank: true, nullable: true)
//        tipoComprobanteSri(blank: true, nullable: true)


    }
}