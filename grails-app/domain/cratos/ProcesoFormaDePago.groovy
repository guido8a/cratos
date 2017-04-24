package cratos

class ProcesoFormaDePago {

    Proceso proceso
    TipoPago tipoPago

    static mapping = {
        table 'prfp'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prfp__id'
        id generator: 'identity'
        version false
        columns {
            proceso column: 'prcs__id'
            tipoPago column: 'tppg__id'
        }
    }

    static constraints = {
        proceso(blank:false,nullable: false)
        tipoPago(blank:false,nullable: false)
    }
}
