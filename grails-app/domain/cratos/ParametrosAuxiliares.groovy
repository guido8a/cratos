package cratos

class ParametrosAuxiliares {

    Double iva
    Date fechaInicio
    Date fechaFin


    static mapping = {
        table 'paux'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'paux__id'
        id generator: 'identity'
        version false
        columns {
            iva column: "paux_iva"
            fechaInicio column: "pauxfcin"
            fechaFin column: "pauxfcfn"
        }
    }

    static constraints = {
        iva(blank: false, nullable: false)
        fechaInicio(blank: false, nullable: false)
        fechaFin(blank: true, nullable: true)
    }

    String toString() {
        return "${this.iva} desde: ${this.fechaInicio} hasta: ${this?.fechaFin}"
    }
}
