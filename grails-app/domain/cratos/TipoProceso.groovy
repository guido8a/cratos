package cratos

class TipoProceso {
    String codigo
    String descripcion

    static auditable = true
    static mapping = {
        table 'tpps'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpps__id'
        id generator: 'identity'
        version false

        columns {
            codigo column: 'tppscdgo'
            descripcion column: 'tppsdscr'
        }
    }
    static constraints = {
        codigo(size: 1..2, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: false, maxSize: 31, attributes: [title: 'descripción'])
    }
}
