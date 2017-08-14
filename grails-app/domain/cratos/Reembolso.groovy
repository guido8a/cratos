package cratos

class Reembolso {

    Gestor gestor
    Proveedor proveedor
    cratos.sri.TipoCmprSustento tipoCmprSustento

    double baseImponibleIva = 0
    double baseImponibleIva0 = 0
    double baseImponibleNoIva = 0
    double excentoIva = 0
    double ivaGenerado = 0
    double iceGenerado = 0
    double valor

    String reembolsoEstb
    String reembolsoEmsn
    String reembolsoSecuencial
    String autorizacion

    static auditable = true

    static mapping = {
        table 'remb'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'remb__id'
        id generator: 'identity'
        version false
        columns {
            gestor column: 'gstr__id'
            proveedor column: 'prve__id'
            tipoCmprSustento column: 'tcst__id'

            baseImponibleIva column: 'rembbsnz'
            baseImponibleIva0 column: 'rembbszr'
            baseImponibleNoIva column: 'rembnoiv'
            excentoIva column: 'rembexiv'
            ivaGenerado column: 'remb_iva'
            iceGenerado column: 'remb_ice'
            valor column: 'rembvlor'

            reembolsoEstb column: 'rembnmes'
            reembolsoEmsn column: 'rembnmem'
            reembolsoSecuencial column: 'rembscnc'
            autorizacion column: 'prcsatrz'
        }
    }
    static constraints = {
        gestor(blank: true, nullable: true, attributes: [title: 'gestor'])
        proveedor(blank: true, nullable: true, attributes: [title: 'proveedor'])
        tipoCmprSustento(nullable: true, blank: true)

        baseImponibleIva(blank: true, nullable: true, attributes: [title: 'baseImponibleIva'])
        baseImponibleIva0(blank: true, nullable: true, attributes: [title: 'baseImponibleIva0'])
        baseImponibleNoIva(blank: true, nullable: true, attributes: [title: 'baseImponibleNoIva'])
        excentoIva(blank: true, nullable: true, attributes: [title: 'excentoIva'])
        ivaGenerado(blank: true, nullable: true, attributes: [title: 'ivaGenerado'])
        iceGenerado(blank: true, nullable: true, attributes: [title: 'iceGenerado'])
        valor(blank: true, nullable: true, attributes: [title: 'valor'])

        reembolsoEstb(blank: true, nullable: true, maxSize: 10, attributes: [title: 'reembolso documento'])
        reembolsoEmsn(blank: true, nullable: true, maxSize: 10, attributes: [title: 'reembolso documento'])
        reembolsoSecuencial(blank: true, nullable: true, maxSize: 10, attributes: [title: 'reembolso secuencial'])
        autorizacion(blank: true, nullable: true, maxSize: 10, attributes: [title: 'reembolso autorizacion'])
     }
}
