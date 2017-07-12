package cratos.inventario

import cratos.Proceso

class DetalleFactura implements Serializable {

    Item item
    Proceso proceso
    CentroCosto centroCosto
    Bodega bodega

    double cantidad
    double precioUnitario
    double descuento
    String observaciones

    static auditable = true

    static mapping = {
        table 'dtfc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtfc__id'
        id generator: 'identity'
        version false
        columns {
            item column: 'item__id'
            proceso column: 'prcs__id'
            centroCosto column: 'cncs__id'
            bodega column: 'bdga__id'

            cantidad column: 'dtfccntd'
            precioUnitario column: 'dtfcpcun'
            descuento column: 'dtfcdsct'
            observaciones column: 'dtfcobsr'
        }
    }
    static constraints = {
        item(blank: false, nullable: false, attributes: [title: 'item'])
        proceso(blank: false, nullable: false, attributes: [title: 'proceso'])
        centroCosto(blank: false, nullable: false, attributes: [title: 'centro de costo'])
        bodega(blank: false, nullable: false, attributes: [title: 'bodega'])

        cantidad(blank: false, attributes: [title: 'cantidad'])
        precioUnitario(blank: false, nullable: false, attributes: [title: 'precioUnitario'])
        descuento(blank: false, nullable: false, attributes: [title: 'descuento'])
        observaciones(blank: true, nullable: true, size: 1..127, attributes: [title: 'observaciones'])
    }
}