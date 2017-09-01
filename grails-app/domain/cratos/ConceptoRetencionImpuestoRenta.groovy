package cratos

import cratos.sri.ModalidadPago

class ConceptoRetencionImpuestoRenta implements Serializable {
    String codigo
    String descripcion
    double porcentaje
    ModalidadPago modalidadPago
    String tipo

    static auditable = true
    static mapping = {
        table 'crir'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'crir__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'crircdgo'
            descripcion column: 'crirdscr'
            porcentaje column: 'crirpcnt'
            modalidadPago column: 'mdpg__id'
            tipo column: 'crirtipo'
        }
    }
    static constraints = {
        codigo(size: 1..5, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: false, maxSize: 255, attributes: [title: 'descripcion'])
        porcentaje(blank: false, nullable: false, attributes: [title: 'porcentaje'])
        modalidadPago(blank: false, nullable: false, attributes: [title: 'Modalidad de pago'])
        tipo(blank: true, nullable: true)
    }
}