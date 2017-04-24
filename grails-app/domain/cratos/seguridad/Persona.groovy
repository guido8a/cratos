package cratos.seguridad

import cratos.Empresa
import cratos.EstadoCivil
import cratos.Nacionalidad
import cratos.Profesion

class Persona {
    Empresa empresa
    String email
    String telefono
    String direccionReferencia
    String barrio
    String direccion
    Date fechaNacimiento
    String discapacitado
    String sexo
    String apellido
    String nombre
    String cedula
    Nacionalidad nacionalidad
    Profesion profesion
    EstadoCivil estadoCivil
    String observaciones
    String login
    String password
    String autorizacion
    String sigla
    int activo
    Date fechaPass

    static mapping = {
        table 'prsn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prsn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'prsn__id'
            email column: 'prsnmail'
            telefono column: 'prsntelf'
            direccionReferencia column: 'prsndrrf'
            barrio column: 'prsnbarr'
            direccion column: 'prsndire'
            fechaNacimiento column: 'prsnfcna'
            discapacitado column: 'prsndscp'
            sexo column: 'prsnsexo'
            apellido column: 'prsnapll'
            nombre column: 'prsnnmbr'
            cedula column: 'prsncdla'
            empresa column: 'empr__id'
            nacionalidad column: 'ncnl__id'
            profesion column: 'prof__id'
            estadoCivil column: 'edcv__id'
            observaciones column: 'prsnobsr'
            login column: 'prsnlogn'
            password column: 'prsnpass'
            autorizacion column: 'prsnatrz'
            sigla column: 'prsnsgla'
            activo column: 'prsnactv'
            fechaPass column: 'prsnfcps'
            observaciones column: 'prsnobsr'
        }
    }
    static constraints = {
        email(size: 1..63, blank: true, nullable: true, attributes: [title: 'E-mail'])
        telefono(size: 1..63, blank: true, nullable: true, attributes: [title: 'Teléfono'])
        direccionReferencia(size: 1..127, blank: true, nullable: true, attributes: [title: 'Referencia de la dirección'])
        barrio(size: 1..127, blank: true, nullable: true, attributes: [title: 'Barrio'])
        direccion(size: 1..127, blank: true, nullable: true, attributes: [title: 'Dirección'])
        fechaNacimiento(blank: true, nullable: true, attributes: [title: 'Fecha de Nacimiento'])
        discapacitado(size: 1..1, inList: ['S', 'N'], blank: true, nullable: true, attributes: [title: 'Discapacitado'])
        sexo(size: 1..1, inList: ['M', 'F'], blank: false, attributes: [title: 'Sexo'])
        apellido(size: 1..31, blank: false, attributes: [title: 'Apellido'])
        nombre(size: 1..31, blank: false, attributes: [title: 'Nombre'])
        cedula(size: 1..10, blank: false, attributes: [title: 'Cédula'])
        empresa(blank: true, nullable: true, attributes: [title: 'Empresa'])
        nacionalidad(blank: false, attributes: [title: 'Nacionalidad'])
        profesion(blank: true, nullable: true, attributes: [title: 'Profesión'])
        estadoCivil(blank: true, nullable: true, attributes: [title: 'Estado Civil'])
        observaciones(size: 1..127, blank: true, nullable: true, attributes: [title: 'Observaciones'])
        login(size: 1..25, blank: false, nullable: false, unique: true, attributes: [title: 'Nombre de usuario'])
        password(size: 1..64, blank: false, nullable: false, password: true, attributes: [title: 'Contraseña para el ingreso al sistema'])
        autorizacion(size: 1..255, blank: false, nullable: false, password: true, attributes: [title: 'Contraseña para autorizaciones'])
        sigla(size: 1..8, blank: false, nullable: false, attributes: [title: 'Sigla del usuario'])
        activo(size: 1..1, blank: false, nullable: false, attributes: [title: 'Usuario activo o no'])
        fechaPass(blank: true, nullable: true, attributes: [title: 'Fecha de cambio de contraseña'])
    }



}