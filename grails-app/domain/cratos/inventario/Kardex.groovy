package cratos.inventario

import cratos.Proceso


class Kardex {

    Item item
    Proceso proceso
    Bodega bodega
    double cantidad
    double precioUnitario
    Date fecha
    double existencias

    static mapping = {
        table 'krdx'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'krdx__id'
        id generator: 'identity'
        version false

        columns {
            item column: 'item__id'
            proceso column: 'prcs__id'
            bodega column: 'bdga__id'
            cantidad column: 'krdxcntd'
            precioUnitario column: 'krdxpcun'
            fecha column: 'krdxfcha'
            existencias column: 'krdxexst'
        }
    }
    static constraints = {
        item(blank: false, nullable: false, attributes: [title: 'Item'])
        proceso(blank: false, nullable: false,attributes: [title: 'Proceso'])
        bodega(blank: false, nullable: false, attributes: [title: 'Bodega'])
        cantidad(blank: false, nullable: false)
        precioUnitario(blank: false, nullable: false)
        existencias(blank: false, nullable: false)
    }
}
