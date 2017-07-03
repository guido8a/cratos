package cratos

import cratos.sri.Pais
import cratos.sri.PorcentajeIva

class Retencion implements Serializable {

    Proceso proceso
    ConceptoRetencionImpuestoRenta conceptoRIRBienes
    ConceptoRetencionImpuestoRenta conceptoRIRServicios
    DocumentoEmpresa documentoEmpresa
    PorcentajeIva pcntIvaBienes
    PorcentajeIva pcntIvaServicios

    Empresa empresa
    Proveedor proveedor
    String direccion
    Date fecha

    int numero
    String numeroComprobante
    String persona
    String telefono
    String ruc
    Date fechaEmision

    double baseIvaBienes = 0
    double ivaBienes = 0
    double baseIvaServicios = 0
    double ivaServicios = 0
    double baseRenta = 0
    double renta = 0
    double baseRentaServicios = 0
    double rentaServicios = 0


    static mapping = {
        table 'rtcn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rtcn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'rtcn__id'
            proceso column: 'prcs__id'
            conceptoRIRBienes column: 'crir__id'
            conceptoRIRServicios column: 'crirsrvc'
            documentoEmpresa column: 'fcdt__id'
            empresa column: 'empr__id'
            proveedor column: 'prve__id'

            direccion column: 'rtcndrcn'
            fecha column: 'rtcnfcha'
            numero column: 'rtcnnmro'
            numeroComprobante column: 'rtcnnmcp'
            persona column: 'rtcnprsn'
            telefono column: 'rtcntlef'
            ruc column: 'rtcn_ruc'
            fechaEmision column: 'rtcnfcem'

            pcntIvaBienes column: 'pciv__id'
            baseIvaBienes column: 'rtcnbsiv'
            ivaBienes column: 'rtcn_iva'
            pcntIvaServicios column: 'pcivsrvc'
            baseIvaServicios column: 'rtcnbisr'
            ivaServicios column: 'rtcnivsr'

            baseRenta column: 'rtcnbsrt'
            renta column: 'rtcnrnta'
            baseRentaServicios column: 'rtcnbrsr'
            rentaServicios column: 'rtcnrnsr'
        }
    }

    static constraints = {
        conceptoRIRBienes(blank: true, nullable: true)
        conceptoRIRServicios(blank: true, nullable: true)
        documentoEmpresa (blank: true, nullable: true)

        direccion(size: 1..127, blank: true, nullable: true, attributes: [title: 'direccion'])
        fecha(blank: false, nullable: false, attributes: [title: 'fecha'])
        numero(blank: true, nullable: true, attributes: [title: 'numero'])
        numeroComprobante(blank: true, nullable: true)
        persona(size: 1..63, blank: true, nullable: true, attributes: [title: 'persona'])
        telefono(size: 1..15, blank: true, nullable: true, attributes: [title: 'telefono'])
        ruc(blank: false, nullable: false, size: 10..13)
        fechaEmision (blank: false, nullable: false)

        pcntIvaBienes(blank: true, nullable: true)
        baseIvaBienes(blank: true, nullable: true)
        ivaBienes(blank: true, nullable: true)
        pcntIvaServicios(blank: true, nullable: true)
        baseIvaServicios(blank: true, nullable: true)
        ivaServicios(blank: true, nullable: true)

        baseRenta(blank: true, nullable: true)
        renta(blank: true, nullable: true)
        baseRentaServicios(blank: true, nullable: true)
        rentaServicios(blank: true, nullable: true)

    }
}