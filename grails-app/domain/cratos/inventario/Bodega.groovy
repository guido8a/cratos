package cratos.inventario

import cratos.Empresa

class Bodega implements Serializable {
    Empresa empresa
    String codigo
    String descripcion

    static mapping = {
        table 'bdga'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'bdga__id'
        id generator: 'identity'
        version false

        columns {
            empresa column: 'empr__id'
            codigo column: 'bdgacdgo'
            descripcion column: 'bdgadscr'
        }
    }
    static constraints = {
        empresa(blank: false, nullable: false, attributes: [title: 'Empresa'])
        codigo(blank: false, nullable: false, size: 1..4, attributes: [title: 'código de la bodega'])
        descripcion(blank: false, nullable: false, size: 1..63, attributes: [title: 'Nombre de la bodega'])
    }
}