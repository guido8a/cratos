package cratos

class Anio implements Serializable{

    String anio

    static mapping = {
        table 'anio'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'anio__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'anio__id'
            anio column: 'anioanio'
        }
    }
    static constraints = {
        anio(blank: false, nullable: false)
    }
}
