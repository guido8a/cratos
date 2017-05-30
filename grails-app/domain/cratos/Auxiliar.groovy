package cratos

class Auxiliar implements Serializable {
    double haber = 0
    double debe = 0
    String descripcion
    Asiento asiento
    Date fechaRegistro = new Date()
    Date fechaPago
    Proveedor proveedor
    TipoPago tipoPago
    Comprobante comprobante
    String factura

    static mapping = {
        table 'axlr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'axlr__id'
        id generator: 'identity'
        version false
        columns {
            haber column: 'axlrhber'
            debe column: 'axlrdebe'
            descripcion column: 'axlrdscr'
            asiento column: 'asnt__id'
            fechaRegistro column: 'axlrfcrg'
            fechaPago column: 'axlrfcpg'
            proveedor column: 'prve__id'
            tipoPago column: 'tppg__id'
            comprobante column: 'cmpr__id'
            factura column: 'axlrfctr'
        }
    }
    static constraints = {
        haber(blank: false, nullable: false, attributes: [title: 'haber'])
        descripcion(size: 1..255, blank: true, nullable: true, attributes: [title: 'descripcion'])
        asiento(blank: true, nullable: true, attributes: [title: 'asiento'])
        fechaPago(blank: true, nullable: true)
        fechaRegistro(blank: true, nullable: true)
        proveedor(blank: true, nullable: true)
        tipoPago (blank: true, nullable: true)
        comprobante (blank: true, nullable: true)
        factura (blank: true, nullable: true)
    }


}