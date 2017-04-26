package cratos

class TipoContrato implements Serializable {

    String descripcion
    Empresa empresa

    static mapping = {
        table 'tpct'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpct__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpct__id'
            descripcion column: 'tpctdscr'
            empresa column: 'empr__id'
        }
    }
    static constraints = {
        descripcion(blank: true, nullable: true, size: 1..31, attributes: [title: 'descripcion'])
        empresa(blank:false,nullable: false, attributes: [title: 'Empresa'])
    }
}