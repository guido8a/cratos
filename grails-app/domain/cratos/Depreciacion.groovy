package cratos

class Depreciacion {

    Empresa empresa
    Periodo periodo
    Proceso proceso

    ActivoFijo activoFijo
    Double valor
    Date fecha

    static mapping = {
        table 'dprc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dprc__id'
        id generator: 'identity'
        version false
        columns {
            empresa column: 'empr__id'
            periodo column: 'prdo__id'
            proceso column: 'prcs__id'

            activoFijo column: 'acfj__id'
            valor column: 'dprcvalr'
            fecha column: 'dprcfcha'
        }
    }

    static constraints = {
        empresa(blank: false, nullable: false, attributes: [title: 'empresa'])
        periodo(blank: false, nullable: false, attributes: [title: 'periodo'])
        proceso(blank: false, nullable: false, attributes: [title: 'proceso'])
        activoFijo(blank: false, nullable: false, attributes: [title: 'activo fijo'])
        valor(blank: false, nullable: false, attributes: [title: 'valor'])
        fecha(blank: false, nullable: false, attributes: [title: 'fecha'])
    }
}
