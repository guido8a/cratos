package cratos.sri

class ModalidadPago implements Serializable {
    String codigo
    String descripcion

    static mapping = {
        table 'mdpg'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'mdpg__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'mdpgcdgo'
            descripcion column: 'mdpgdscr'
        }
    }
    static constraints = {
        codigo(blank:true,nullable: true,size: 1..2)
        descripcion(blank:true,nullable: true,size: 1..31)
    }

}
