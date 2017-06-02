package cratos.sri

class TipoComprobanteSri implements Serializable {
    String codigo
    String descripcion

    static auditable = true
    static mapping = {
        table 'tcsr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tcsr__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tcsrcdgo'
            descripcion column: 'tcsrdscr'
        }
    }
    static constraints = {
        codigo(size: 1..4, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: false, maxSize: 127, attributes: [title: 'descripcion'])
    }
}