package cratos.inventario

class TipoIVA implements Serializable {
    String descripcion

    static auditable = true
    static mapping = {
        table 'tpiv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpiv__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpiv__id'
            descripcion column: 'tpivdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..63, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }

    String toString() {
        "${this.descripcion}"
    }
}