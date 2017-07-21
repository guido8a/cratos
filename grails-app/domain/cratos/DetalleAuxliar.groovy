package cratos

class DetalleAuxliar implements Serializable {
    Auxiliar auxiliar
    Proveedor proveedor
    double debe = 0
    double haber = 0
    String documento

    static auditable = true
    static mapping = {
        table 'dtax'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtax__id'
        id generator: 'identity'
        version false
        columns {
            auxiliar column: 'axlr__id'
            proveedor column: 'prve__id'
            debe column: 'dtaxdebe'
            haber column: 'dtaxhber'
            documento column: 'dtaxdcmt'
        }
    }
    static constraints = {
        auxiliar(blank: false, nullable: false)
        proveedor(blank: false, nullable: false)
        debe(blank: false, nullable: false)
        haber(blank: false, nullable: false)
        documento(blank: true, nullable: true)
    }
}