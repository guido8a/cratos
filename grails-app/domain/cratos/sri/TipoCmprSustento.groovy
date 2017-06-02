package cratos.sri

class TipoCmprSustento implements Serializable {

    SustentoTributario sustentoTributario
    TipoComprobanteSri tipoComprobanteSri

    static mapping = {
        table 'tcst'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tcst__id'
        id generator: 'identity'
        version false
        columns {
            sustentoTributario column: 'sstr__id'
            tipoComprobanteSri column: 'tcsr__id'
        }
    }
    static constraints = {

    }

}
