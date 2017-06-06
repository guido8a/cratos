package cratos.sri

class TipoIdentificacionTransaccion implements Serializable {

    TipoIdentificacion tipoIdentificacion
    TipoTransaccion tipoTransaccion
    String codigo

    static mapping = {
        table 'titt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'titt__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tittcdgo'
            tipoIdentificacion column: 'tpid__id'
            tipoTransaccion column: 'tptr__id'
        }
    }
    static constraints = {
        codigo(blank: false, nullable: false, size: 1..2)
    }

}
