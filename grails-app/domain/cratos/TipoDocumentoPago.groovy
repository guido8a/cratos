package cratos

class TipoDocumentoPago {
    String descripcion

    static auditable = true

    static mapping = {
        table 'tpdp'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpdp__id'
        id generator: 'identity'
        version false
        columns {
            descripcion column: 'tpdpdscr'
        }
    }
    static constraints = {
        descripcion(blank: false, maxSize: 63, attributes: [title: 'descripción'])
    }
}