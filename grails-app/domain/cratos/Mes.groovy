package cratos

class Mes implements Serializable {

    String descripcion
    String numero

    static mapping = {
        table 'mess'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'mess__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'mess__id'
            descripcion column: 'messdscr'
            numero column: 'messnmro'
        }
    }
    static constraints = {
        descripcion(blank: false, nullable: false, size: 1..15, attributes: [title: 'descripción'])
        numero(blank: false, nullable: false, size: 2..2, attributes: [title: 'número'])
    }
}