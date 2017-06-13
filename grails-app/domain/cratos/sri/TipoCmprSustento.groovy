package cratos.sri

class TipoCmprSustento implements Serializable {

    SustentoTributario sustentoTributario
    static mapping = {
        table 'tcst'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tcst__id'
        id generator: 'identity'
        version false
        columns {
            sustentoTributario column: 'sstr__id'
//            tipoComprobanteSri column: 'tcsr__id'
        }
    }
    static constraints = {

    }

    String toString(){
        "${this.sustentoTributario.codigo} ${this.sustentoTributario.descripcion}"
    }

}
