package cratos

import cratos.sri.Pais
import cratos.sri.PorcentajeIva

class Retencion implements Serializable {

    Proceso proceso
    ConceptoRetencionImpuestoRenta conceptoRIRBienes
    ConceptoRetencionImpuestoRenta conceptoRIRServicios
    DocumentoEmpresa documentoEmpresa
    PorcentajeIva porcentajeIva
    Pais pais
    Empresa empresa
    Proveedor proveedor

    String direccion
    Date fecha
    String numero
    String numeroComprobante
    String persona
    String telefono
    String ruc
    Date fechaEmision
    String convenio
    String normaLegal
    String creditoTributario
    double baseIva = 0
    double iva = 0
    double baseRenta = 0
    double renta = 0
    double baseRentaServicios = 0
    double rentaServicios = 0
    double baseIce = 0
    double porcentajeIce = 0
    double ice = 0
    double baseBienes = 0
    double porcentajeBienes = 0
    double bienes = 0
    double baseServicios = 0
    double porcentajeServicios = 0
    double servicios = 0
    String pago



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
            porcentajeIva column: 'pciv__id'
            pais column: 'pais__id'
            empresa column: 'empr__id'
            proveedor column: 'prve__id'

            direccion column: 'rtcndrcn'
            fecha column: 'rtcnfcha'
            numero column: 'rtcnnmro'
            numeroComprobante column: 'rtcnnmcp'
            persona column: 'rtcnprsn'
            telefono column: 'rtcntlef'
            fechaEmision column: 'rtcnfcem'
            ruc column: 'rtcn_ruc'
            convenio column: 'rtcncnvn'
            normaLegal column: 'rtcnnmlg'
            baseIva column: 'rtcnbsiv'
            iva column: 'rtcn_iva'
            baseRenta column: 'rtcnbsrt'
            renta column: 'rtcnrnta'
            baseRentaServicios column: 'rtcnbrsr'
            rentaServicios column: 'rtcnrnsr'
            baseIce column: 'rtcnbsic'
            porcentajeIce column: 'rtcnpcic'
            ice column: 'rtcn_ice'
            baseBienes column: 'rtcnbsbn'
            porcentajeBienes column: 'rtcnpcbn'
            bienes column: 'rtcnbien'
            baseServicios column: 'rtcnbssr'
            porcentajeServicios column: 'rtcnpcsr'
            servicios column: 'rtcnsrvc'
            creditoTributario column: 'rtcncrtr'
            pago column: 'rtcnpago'

        }
    }
    static constraints = {
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        ruc(blank: false, nullable: false, size: 10..13)
        direccion(size: 1..127, blank: true, nullable: true, attributes: [title: 'direccion'])
        telefono(size: 1..15, blank: true, nullable: true, attributes: [title: 'telefono'])
        persona(size: 1..63, blank: true, nullable: true, attributes: [title: 'persona'])
        numero(blank: true, nullable: true, attributes: [title: 'numero'])
        fechaEmision (blank: true, nullable: true)
        convenio (blank: true, nullable: true)
        normaLegal(blank: true, nullable: true)
        pais(blank: true, nullable: true)
        documentoEmpresa (blank: true, nullable: true)
        baseIva(blank: true, nullable: true)
        iva(blank: true, nullable: true)
        baseRenta(blank: true, nullable: true)
        renta(blank: true, nullable: true)
        baseIce(blank: true, nullable: true)
        porcentajeIce(blank: true, nullable: true)
        ice(blank: true, nullable: true)
        baseBienes(blank: true, nullable: true)
        porcentajeBienes(blank: true, nullable: true)
        bienes(blank: true, nullable: true)
        baseServicios(blank: true, nullable: true)
        porcentajeServicios(blank: true, nullable: true)
        servicios(blank: true, nullable: true)
        conceptoRIRServicios(blank: true, nullable: true)
        conceptoRIRBienes(blank: true, nullable: true)
        creditoTributario(blank: true, nullable: true)
        numeroComprobante(blank: true, nullable: true)
        pago(blank: true, nullable: true)
    }
}