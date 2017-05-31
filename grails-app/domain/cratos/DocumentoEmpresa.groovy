package cratos

class DocumentoEmpresa implements Serializable {
    Empresa empresa
    Date fechaIngreso
    String autorizacion
    int numeroDesde
    int numeroHasta
    Date fechaAutorizacion
    String tipo
    String numeroEstablecimiento
    String numeroEmision
    int digitosEnSecuencial = 9
    Date fechaInicio
    Date fechaFin

    static mapping = {
        table 'fcdt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'fcdt__id'
        id generator: 'identity'
        version false
        columns {
            empresa column: 'empr__id'
            fechaIngreso column: 'fcdtfcha'
            autorizacion column: 'fcdtatrz'
            numeroDesde column: 'fcdtdsde'
            numeroHasta column: 'fcdthsta'
            fechaAutorizacion column: 'fcdtfcat'
            tipo column: 'fcdttipo'
            numeroEstablecimiento column: 'fcdtnmes'
            numeroEmision column: 'fcdtnmpe'
            digitosEnSecuencial column: 'fcdtdgto'
            fechaInicio column: 'fcdtfcin'
            fechaFin column: 'fcdtfcfn'
        }
    }
    static constraints = {
        empresa(blank: false, nullable: false, attributes: [title: 'Empresa'])
        fechaIngreso(blank: false, nullable: false)
        autorizacion(blank: false, nullable: false)
        numeroDesde(blank: false, nullable: false)
        numeroHasta(blank: false, nullable: false)
        fechaAutorizacion(blank: false, nullable: false)
        tipo(blank: false, nullable: false)
        numeroEstablecimiento(blank: false, nullable: false)
        numeroEmision(blank: false, nullable: false)
        digitosEnSecuencial(blank: false, nullable: false)
        fechaInicio(blank: false, nullable: false)
        fechaFin(blank: false, nullable: false)
    }

    String toString() {
        return "${this.numeroDesde} - ${this.numeroHasta} ${this.fechaAutorizacion}"
    }

}