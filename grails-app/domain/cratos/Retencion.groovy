package cratos

import cratos.sri.Pais
import cratos.sri.PorcentajeIva

class Retencion implements Serializable {

    Proceso proceso
    ConceptoRetencionImpuestoRenta conceptoRetencionImpuestoRenta
    DocumentoEmpresa documentoEmpresa
    PorcentajeIva porcentajeIva
    Pais pais

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
    double baseIva
    double iva
    double baseRenta
    double renta
    double baseIce
    double porcentajeIce
    double ice
    double baseBienes
    double porcentajeBienes
    double bienes
    double baseServicios
    double porcentajeServicios
    double servicios


    static mapping = {
        table 'rtcn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rtcn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'rtcn__id'
            proceso column: 'prcs__id'
            conceptoRetencionImpuestoRenta column: 'crir__id'
            documentoEmpresa column: 'fcdt__id'
            porcentajeIva column: 'pciv__id'
            pais column: 'pais__id'

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
            baseIce column: 'rtcnbsic'
            porcentajeIce column: 'rtcnpcic'
            ice column: 'rtcn_ice'
            baseBienes column: 'rtcnbsbn'
            porcentajeBienes column: 'rtcnpcbn'
            bienes column: 'rtcnbien'
            baseServicios column: 'rtcnbssr'
            porcentajeServicios column: 'rtcnpcsr'
            servicios column: 'rtcnsrvc'

        }
    }
    static constraints = {
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        ruc(blank: false, nullable: false, size: 10..13)
        direccion(size: 1..127, blank: true, nullable: true, attributes: [title: 'direccion'])
        telefono(size: 1..15, blank: true, nullable: true, attributes: [title: 'telefono'])
        persona(size: 1..63, blank: true, nullable: true, attributes: [title: 'persona'])
        numero(size: 1..15, blank: true, nullable: true, attributes: [title: 'numero'])
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
    }
}