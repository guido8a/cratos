package cratos.sri

class TarifaIVA implements Serializable {
    String codigo
    int valor = 12
    String descripcion

    static mapping = {
        table 'triv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cddc__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'trivcdgo'
            valor column: 'trivvlor'
            descripcion column: 'trivdscr'
        }
    }
    static constraints = {
        codigo(blank:true, nullable: true, size: 1..1)
        valor(blank:false, nullable: false)
        descripcion(blank:true, nullable: true, size: 1..15)
    }

    String toString() {

    }
}
