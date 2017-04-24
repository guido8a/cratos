package cratos

class PagoAux implements Serializable {

    Auxiliar auxiliar
    double monto
    double impuesto = 0
    Date fecha
    String referencia
    String estado //V validado
    String tipo="P" /*Pago o nota de debito-credito... P-->pago D-->debito  C-->credito*/
    ProcesoFormaDePago formaDePago
    /*Solo para notas de debito/credito*/
    Date fechaEmision
    String establecimiento
    String emision
    String secuencial
    String autorizacionSri

    static mapping = {
        table 'pgax'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'pgax__id'
        id generator: 'identity'
        version false
        columns {
            auxiliar column: 'axlr__id'
            monto column: 'pgaxmnto'
            impuesto column: 'pgaxintr'
            referencia column: 'pgaxrefe'
            estado column: 'pgaxetdo'
            tipo column: 'pgaxtipo'
            formaDePago column: 'prfp__id'
            fechaEmision column: 'praxfcem'
            establecimiento column: 'praxstbl'
            emision column: 'praxemsn'
            secuencial column: 'pgaxsecu'
            autorizacionSri column: 'pgazatrz'

        }
    }
    static constraints = {
        auxiliar(blank: false, nullable: false)
        fecha(nullable: true, blank: true)
        referencia(blank: true, nullable: true, attributes: [title: 'documento de referencia'],size:1..30)
        estado(blank: true, nullable: true)
        tipo(blank: true, nullable: true,size: 1..1)
        formaDePago(nullable: true,blank:true)
        fechaEmision(nullable: true,blank:true)
        establecimiento(nullable: true,blank:true,size: 1..3)
        emision(nullable: true,blank:true,size: 1..3)
        secuencial(nullable: true,blank:true,size: 1..10)
        autorizacionSri(nullable: true,blank:true,size: 1..30)

    }
}