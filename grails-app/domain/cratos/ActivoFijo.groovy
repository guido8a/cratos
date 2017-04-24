package cratos

import cratos.seguridad.Persona
import groovy.time.TimeCategory

class ActivoFijo implements Serializable {
    Proceso proceso
    Empresa empresa

    String codigo
    Grupo grupo
    String estado = 'A'   //A-->activo B-->dado de baja
    String nombre
    Marca marca
    Persona custodio
    Proveedor proveedor
    Double precio
    Date fechaRegistro = new Date()
    Integer aniosVidaUtil
    String numeroSerie
    String modelo
    Color color
    Date fechaInicioDepreciacion
    String observaciones

    Double depreciacionAcumulada = 0

    static mapping = {
        table 'acfj'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'acfj__id'
        id generator: 'identity'
        version false
        columns {
            proceso column: 'prcs__id'
            empresa column: 'empr__id'

            codigo column: 'acfjcdgo'
            grupo column: 'grpo__id'
            estado column: 'acfjetdo'
            nombre column: 'acfjnmbr'
            marca column: 'mrca__id'
            custodio column: 'prsn__id'
            proveedor column: 'prve__id'
            precio column: 'acfjprco'
            fechaRegistro column: 'acfjfcrg'
            aniosVidaUtil column: 'acfjavut'
            numeroSerie column: 'acfjnmsr'
            modelo column: 'acfjmodl'
            color column: 'clor__id'
            fechaInicioDepreciacion column: 'acfjfcid'
            observaciones column: 'acfjobsv'

            depreciacionAcumulada column: 'acfjdpac'
        }
    }
    static constraints = {

        proceso(blank: false, nullable: false, attributes: [title: 'proceso'])
        empresa(blank: false, nullable: false, attributes: [title: 'proceso'])

        codigo(blank: false, nullable: false, attributes: [title: 'código'])
        grupo(blank: false, nullable: false, attributes: [title: 'grupo'])
        estado(blank: false, nullable: false, maxSize: 1, attributes: [title: 'estado'])
        nombre(blank: false, nullable: false, maxSize: 63, attributes: [title: 'nombre'])
        marca(blank: false, nullable: false, attributes: [title: 'marca'])
        custodio(blank: true, nullable: true, attributes: [title: 'custodio'])
        proveedor(blank: false, nullable: false, attributes: [title: 'proveedor'])
        precio(blank: false, nullable: false, attributes: [title: 'precio'])
        fechaRegistro(blank: false, nullable: false, attributes: [title: 'fecha registro'])
        aniosVidaUtil(blank: false, nullable: false, attributes: [title: 'años de vida útil'])
        numeroSerie(blank: true, nullable: true, maxSize: 20, attributes: [title: 'número de serie'])
        modelo(blank: true, nullable: true, maxSize: 20, attributes: [title: 'modelo'])
        color(blank: true, nullable: true, attributes: [title: 'color'])
        fechaInicioDepreciacion(blank: true, nullable: true, attributes: [title: 'fecha inicio de depreciación'])
        observaciones(blank: true, nullable: true, maxSize: 63, attributes: [title: 'observaciones'])

        depreciacionAcumulada(blank: true, nullable: true, attributes: [title: 'depreciación acumulada'])
    }

    def getFinVidaUtil() {
        def finVidaUtil = this.fechaInicioDepreciacion
        use(TimeCategory) {
            finVidaUtil = this.fechaInicioDepreciacion + (this.aniosVidaUtil).years
        }
        return finVidaUtil
    }

    def getDepreciacionFecha(fecha) {
        def ini = this.fechaInicioDepreciacion ?: this.fechaInicioDepreciacion
        def diasUtil = this.aniosVidaUtil * 360
        def dias = fecha - ini
        def depDiaria = this.precio / diasUtil
        return dias * depDiaria
    }

}