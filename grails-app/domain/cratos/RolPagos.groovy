package cratos

class RolPagos {

    Mes mess
    Anio anio
    Date fecha
    Date fechaModificacion
    double pagado
    String estado
    Empresa empresa

    static mapping = {
        table 'rlpg'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rlpg__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'rlpg__id'
            mess column: 'mess__id'
            anio column: 'anio__id'
            fecha column: 'rlpgfcha'
            fechaModificacion column: 'rlpgfcmd'
            pagado column: 'rlpgpgdo'
            estado column: 'rlpgetdo'
            empresa column: 'empr__id'
        }
    }

    static constraints = {

        mess(blank: true, nullable: true, attributes: [title: 'mess'])
        anio(blank: true, nullable: true, attributes: [title: 'período'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        fechaModificacion(blank: true, nullable: true, attributes: [title: 'fecha de modificación'])
        pagado(blank: true, nullable: true, attributes: [title: 'pagado'])
        estado(blank: true, nullable: true, size: 1..1, attributes: [title: 'estado'])
        empresa(blank:false,nullable: false)

    }
}
