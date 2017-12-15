package cratos

class Establecimiento implements Serializable {

    Empresa empresa
    String numero
    String nombre
    String direccion

    static mapping = {
        table 'estb'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'estb__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'estb__id'
            empresa column: 'empr__id'
            numero column: 'estbnmro'
            nombre column: 'estbnmbr'
            direccion column: 'estbdire'
        }
    }

    static constraints = {
        numero(blank: true, nullable: true)
        nombre(blank: false, nullable: false)
        direccion(blank: false, nullable: false)
    }
}
