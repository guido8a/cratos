package cratos

import cratos.seguridad.Persona

class Empleado implements Serializable {
    Persona persona
    TipoContrato tipoContrato
    Departamento departamento
    String numero
    String iess
    int hijo
    String telefono
    String mail
    String cuenta
    double sueldo
    Date fechaFin
    Date fechaInicio
    String estado
    byte[] foto
    double porcentajeComision
    String cargo
    String observaciones

    static mapping = {
        table 'empl'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'empl__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'empl__id'
            persona column: 'prsn__id'
            tipoContrato column: 'tpct__id'
            departamento column: 'dpto__id'
            numero column: 'emplnmro'
            iess column: 'empliess'
            hijo column: 'emplhijo'
            telefono column: 'empltlfn'
            mail column: 'emplmail'
            cuenta column: 'emplcnta'
            sueldo column: 'emplsldo'
            fechaFin column: 'emplfcfn'
            fechaInicio column: 'emplfcin'
            estado column: 'empletdo'
            foto column: 'emplfoto'
            porcentajeComision column: 'emplpccm'
            cargo column: 'emplcrgo'
            observaciones column: 'emplobsr'
        }
    }
    static constraints = {
        porcentajeComision(blank: true, nullable: true, attributes: [title: 'porcentajeComision'])
        foto(blank: true, nullable: true, attributes: [title: 'foto'])
        estado(size: 1..1, blank: true, nullable: true, attributes: [title: 'estado'])
        fechaFin(blank: true, nullable: true, attributes: [title: 'fechaFin'])
        fechaInicio(blank: true, nullable: true, attributes: [title: 'fechaInicio'])
        sueldo(blank: true, nullable: true, attributes: [title: 'sueldo'])
        cuenta(size: 1..12, blank: true, nullable: true, attributes: [title: 'cuenta'])
        mail(size: 1..63, blank: true, nullable: true, attributes: [title: 'email'])
        telefono(size: 1..63, blank: true, nullable: true, attributes: [title: 'telefono'])
        hijo(blank: true, nullable: true, attributes: [title: 'hijo'])
        iess(size: 1..13, blank: true, nullable: true, attributes: [title: 'iess'])
        numero(size: 1..10, blank: true, nullable: true, attributes: [title: 'numero'])
        tipoContrato(blank: true, nullable: true, attributes: [title: 'tipoContrato'])
        cargo(blank: true, nullable: true, size: 1..127, attributes: [title: 'crgo'])
        observaciones(blank: true, nullable: true, size: 1..127, attributes: [title: 'observaciones'])
    }
}