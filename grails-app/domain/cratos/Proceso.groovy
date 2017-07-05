package cratos

import cratos.sri.Pais
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
    cratos.sri.TipoCmprSustento modificaCmpr
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
    String autorizacion
    String documento

    String facturaEstablecimiento
    String facturaPuntoEmision
    int facturaSecuencial
    String facturaAutorizacion
    String pago
    Pais pais
    String normaLegal
    String convenio

    String modificaSerie01
    String modificaSerie02
    String modificaScnc = 0
    String modificaAutorizacion


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
            autorizacion column: 'prcsatrz'
            documento column: 'prcsdcmt'

            facturaEstablecimiento column: 'prcsfces'
            facturaPuntoEmision column: 'prcsfcpe'
            facturaSecuencial column: 'prcsfcsc'
            facturaAutorizacion column: 'prcsfcat'
            pago column: 'prcspago'
            pais column: 'pais__id'
            convenio column: 'prcscnvn'
            normaLegal column: 'prcsnmlg'

            modificaSerie01 column: 'prcsmds1'
            modificaSerie02 column: 'prcsmds2'
            modificaScnc column: 'prcsmdsc'
            modificaAutorizacion column: 'prcsmdat'
            modificaCmpr column: 'tcstmdfc'

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

        procesoSerie01(blank: true, nullable: true, maxSize: 3, attributes: [title: 'establecimeinto documento'])
        procesoSerie02(blank: true, nullable: true, maxSize: 3, attributes: [title: 'punto de emisión documento'])
        secuencial(blank: true, nullable: true, attributes: [title: 'secuencial'], size: 1..14)
        autorizacion(blank: true, nullable: true, maxSize: 10, attributes: [title: 'autorizacion documento'])
        documento(blank: true, nullable: true, size: 1..40)

        facturaEstablecimiento(blank: true, nullable: true)
        facturaPuntoEmision(blank: true, nullable: true)
        facturaSecuencial(blank: true, nullable: true)
        facturaAutorizacion(nullable: true,blank: true,size: 1..20)
        pago(nullable: true,blank: true)
        pais(nullable: true,blank: true)
        convenio(nullable: true,blank: true)
        normaLegal(nullable: true,blank: true)

        modificaSerie01(nullable: true,blank: true)
        modificaSerie02(nullable: true,blank: true)
        modificaScnc(nullable: true,blank: true)
        modificaAutorizacion(nullable: true,blank: true)
        modificaCmpr(nullable: true,blank: true)

    }
}