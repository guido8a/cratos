package cratos.sri

class TipoDeImpuesto implements Serializable {
    String codigo
    String descripcion

    static mapping = {
        table 'tpim'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cddc__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tpimcdgo'
            descripcion column: 'tpimdscr'
        }
    }
    static constraints = {
        codigo(blank:true,nullable: true,size: 1..1)
        descripcion(blank:true,nullable: true,size: 1..15)
    }

    String toString() {

    }
}
