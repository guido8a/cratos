package cratos.sri

import cratos.inventario.TipoIVA

class TarifaIVA implements Serializable {
    String codigo
    int valor = 12
    String descripcion
    TipoIVA tipoIVA

    static mapping = {
        table 'triv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'triv__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'trivcdgo'
            valor column: 'trivvlor'
            descripcion column: 'trivdscr'
            tipoIVA column: 'tpiv__id'
        }
    }
    static constraints = {
        codigo(blank:false, nullable: false, size: 1..1)
        valor(blank:false, nullable: false)
        descripcion(blank:false, nullable: false, size: 1..15)
        tipoIVA(blank:false, nullable: false, size: 1..15)
    }

    String toString() {

    }
}
