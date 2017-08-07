package cratos.inventario

import cratos.Empresa

class CentroCosto implements Serializable {

    Empresa empresa
    String nombre
    String codigo
    static auditable = true
    static mapping = {
        table 'cncs'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cncs__id'
        id generator: 'identity'
        version false
        columns {
            empresa column: 'empr__id'
            nombre column: 'cncsnmbr'
            codigo column: 'cncscdgo'
        }
    }
    static constraints = {
        empresa(blank: false, attributes: [title: 'empresa'])
        nombre(blank: false, maxSize: 127, attributes: [title: 'nombre'])
        codigo(blank: false, nullable: false, maxSize: 3)
    }
}