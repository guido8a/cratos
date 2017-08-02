package cratos

import cratos.inventario.CentroCosto

class AsientoCentro implements Serializable {

    Asiento asiento
    CentroCosto centroCosto
    double debe=0
    double haber=0

    static auditable = true
    static mapping = {
        table 'ascc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'ascc__id'
        id generator: 'identity'
        version false
        columns {
            asiento column: 'asnt__id'
            centroCosto column: 'cncs__id'
            debe column: 'asccdebe'
            haber column: 'ascchber'

        }
    }
    static constraints = {
    }

}
