package cratos.sri

class SustentoTributario implements Serializable {

    String codigo
    String descripcion
    String creditoTributario

    static mapping = {
        table 'sstr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'sstr__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'sstrcdgo'
            descripcion column: 'sstrdscr'
            creditoTributario column: 'sstrcrtr'
        }
    }

    static constraints = {
        descripcion(maxSize: 127)
    }
    String toString(){
        return "${this.codigo}: ${this.descripcion}"
    }
}