package cratos.sri

class TipoCmprSustento implements Serializable {

    TipoComprobanteSri tipoComprobanteSri
    static mapping = {
        table 'tcst'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tcst__id'
        id generator: 'identity'
        version false
        columns {
            tipoComprobanteSri column: 'tcsr__id'
        }
    }
    static constraints = {

    }

    String toString(){
        "${this.tipoComprobanteSri.codigo} ${this.tipoComprobanteSri.descripcion}"
    }

}
