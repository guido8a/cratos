package cratos.inventario

import cratos.Empresa

class Marca implements Serializable {
    String descripcion
    Empresa empresa
    static mapping = {
        table 'mrca'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'mrca__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'mrca__id'
            descripcion column: 'mrcadsrc'
            empresa column: 'empr__id'
        }
    }
    static constraints = {
        descripcion(blank: true, nullable: true, size: 1..31, attributes: [title: 'descripción'])
    }
}