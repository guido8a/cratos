package cratos.sri

class PorcentajeIva {

    String codigo
    String descripcion
    int valor

    static mapping = {
        table 'pciv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'pciv__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'pciv__id'
            codigo column: 'pcivcdgo'
            descripcion column: 'pcivdscr'
            valor column: 'pcivvlor'
        }
    }

    static constraints = {

        codigo(size: 1..2)
        descripcion(size: 1..31)
    }
}
