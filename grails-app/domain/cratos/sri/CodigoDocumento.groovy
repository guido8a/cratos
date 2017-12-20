package cratos.sri

class CodigoDocumento implements Serializable {
    String codigo
    String descripcion

    static mapping = {
        table 'cddc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cddc__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'cddccdgo'
            descripcion column: 'cddcdscr'
        }
    }
    static constraints = {
        codigo(blank:true,nullable: true,size: 2..2)
        descripcion(blank:true,nullable: true,size: 1..31)
    }

    String toString() {

    }
}
