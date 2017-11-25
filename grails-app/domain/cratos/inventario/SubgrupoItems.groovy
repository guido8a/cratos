package cratos.inventario

import cratos.Empresa

class SubgrupoItems implements Serializable {

    Grupo grupo
    String codigo
    String descripcion
    Empresa empresa
    static auditable = true
    static mapping = {
        table 'sbgr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'sbgr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'sbgr__id'
            grupo column: 'grpo__id'
            codigo column: 'sbgrcdgo'
            descripcion column: 'sbgrdscr'
            empresa column: 'empr__id'
        }
    }
    static constraints = {
        grupo(blank: false, attributes: [title: 'grupo'])
        codigo(size: 1..20, blank: false, attributes: [title: 'numero'])
        descripcion(size: 1..63, blank: false, attributes: [title: 'descripcion'])
        empresa(blank: false, attributes: [title: 'empresa'])
    }
}