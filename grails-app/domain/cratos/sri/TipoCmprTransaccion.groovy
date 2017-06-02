package cratos.sri

class TipoCmprTransaccion implements Serializable {

    TipoTransaccion tipoTransaccion
    TipoComprobanteSri tipoComprobanteSri

    static mapping = {
        table 'tctt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tctt__id'
        id generator: 'identity'
        version false
        columns {
            tipoTransaccion column: 'tptr__id'
            tipoComprobanteSri column: 'tcsr__id'
        }
    }
    static constraints = {

    }

}
