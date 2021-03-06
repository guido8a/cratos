package cratos

import cratos.seguridad.Persona
import groovy.json.JsonBuilder
import org.springframework.dao.DataIntegrityViolationException

class EmpleadoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//
//        def mes = Mes.list([sort:"id"])
//        def periodos = Periodo.findAllByContabilidad(session.contabilidad,[sort: "fechaInicio"])
//
//        [empleadoInstanceList: Empleado.list(params), empleadoInstanceTotal: Empleado.count(),mes:mes,periodos:periodos]
//    }

    def findPersona_ajax() {
        def ci = params.ci

        def persona = Persona.findAllByCedula(ci)
        if (persona.size() == 1) {
            persona = persona[0]
        } else if (persona.size() > 1) {
            persona = null
            println "Error: más de una persona con ci: " + ci
        } else {
            persona = null
            println "No se encontró persona con ci " + ci
        }
        def datos = [:]
        if (persona) {
            datos = [
                    cedula: persona.cedula,
                    nombre: persona.nombre,
                    apellido: persona.apellido,
                    direccion: persona.direccion,
                    telefono: persona.telefono,
                    email: persona.email,
                    fechaNacimiento: persona.fechaNacimiento.format("dd-MM-yyyy"),
                    personaId: persona.id
            ]
        }
        def json = new JsonBuilder(datos)
        render json
    }

    def form() {
        def empleadoInstance = new Empleado()
        def personaInstance = new Persona()
        if (params.id) {
            empleadoInstance = Empleado.get(params.id)
            personaInstance = empleadoInstance.persona
        }
        if (!empleadoInstance) {
            flash.message = "No se encontr&oacute; Empleado a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [empleadoInstance: empleadoInstance, personaInstance: personaInstance]
    }


    def create() {
        [empleadoInstance: new Empleado(params)]
    }

    def save() {
        println params
        if (params.persona.fechaNacimiento) {
            params.persona.fechaNacimiento = new Date().parse("dd-MM-yyyy", params.persona.fechaNacimiento)
        }
        if (params.empleado.fechaInicio) {
            params.empleado.fechaInicio = new Date().parse("dd-MM-yyyy", params.empleado.fechaInicio)
        }
        if (params.empleado.fechaFin) {
            params.empleado.fechaFin = new Date().parse("dd-MM-yyyy", params.empleado.fechaFin)
        }
        def empleadoInstance, personaInstance
        if (params.empleado.id) {
            empleadoInstance = Empleado.get(params.empleado.id)
            if (!empleadoInstance) {
                flash.message = "No se encontr&oacute; Empleado a modificar"
                render "NO"
                return
            }
            personaInstance = Persona.get(empleadoInstance.personaId)
            empleadoInstance.properties = params.empleado
            personaInstance.properties = params.persona
        } else {
            if (params.persona.id) {
                personaInstance = Persona.get(params.persona.id)
                if (!personaInstance) {
                    println "NO se encontro persona???"
                    personaInstance = new Persona(params.persona)
                    personaInstance.nacionalidad = Nacionalidad.get(1)
                }
            } else {
                personaInstance = new Persona(params.persona)
                personaInstance.empresa = session.empresa
                personaInstance.nacionalidad = Nacionalidad.get(1)
            }
            empleadoInstance = new Empleado(params.empleado)
        }
        if (!personaInstance.save(flush: true)) {
            render "NO"
            println personaInstance.errors
            flash.message = "Ha ocurrido un error al guardar Persona"
            return
        }
        empleadoInstance.persona = personaInstance
        if (!empleadoInstance.save(flush: true)) {
            render "NO"
            println empleadoInstance.errors
            flash.message = "Ha ocurrido un error al guardar Empleado"
            return
        }

        flash.message = "Empleado guardado exitosamente"
        redirect(action: "show", id: empleadoInstance.id)
        render "OK"
    }

    def show() {
        def empleadoInstance = Empleado.get(params.id)
        if (!empleadoInstance) {
            flash.message = "No se encontr&oacute; Empleado a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [empleadoInstance: empleadoInstance]
    }

    def edit() {
        def empleadoInstance = Empleado.get(params.id)
        if (!empleadoInstance) {
            flash.message = "No se encontr&oacute; Empleado a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [empleadoInstance: empleadoInstance]
    }

    def delete() {
        def empleadoInstance = Empleado.get(params.id)
        if (!empleadoInstance) {
            flash.message = "No se encontr&oacute; Empleado a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            empleadoInstance.delete(flush: true)
            flash.message = "Empleado eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar Empleado"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
//        def empleadoInstanceList = Empleado.list(params)
        def c = Empleado.createCriteria()
        def empleadoInstanceList = c.list(params) {
            persona {
                eq("empresa", session.empresa)
            }
        }
        def c2 = Empleado.createCriteria()
        def todos = c2.list() {
            persona {
                eq("empresa", session.empresa)
            }
        }
        def empleadoInstanceCount = todos.size()
        if (empleadoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        c = Empleado.createCriteria()
        empleadoInstanceList = c.list(params) {
            persona {
                eq("empresa", session.empresa)
            }
        }
        def mes = Mes.list([sort:"id"])
        def periodos = Periodo.findAllByContabilidad(session.contabilidad,[sort: "fechaInicio"])
        return [empleadoInstanceList: empleadoInstanceList, empleadoInstanceCount: empleadoInstanceCount,mes:mes,periodos:periodos]
    } //list

    def show_ajax() {
        if (params.id) {
            def empleadoInstance = Empleado.get(params.id)
            if (!empleadoInstance) {
                notFound_ajax()
                return
            }
            return [empleadoInstance: empleadoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def persona
        def empleadoInstance

        if(params.tipo == '1'){
            empleadoInstance = Empleado.get(params.id)
            persona = empleadoInstance.persona
        }else{
            persona = Persona.get(params.id)
            empleadoInstance = Empleado.findByPersona(persona)
        }

        return [empleadoInstance: empleadoInstance, persona: persona]
    } //form para cargar con ajax en un dialog

    def loadPersona() {
        println("entro loadPersona")

        def ci = params.ci
        def persona = Persona.findByCedulaAndEmpresa(ci, session.empresa)

        def datos = [:]
        if (persona) {
            datos = [
                    id: persona.id,
                    cedula: persona.cedula,
                    nombre: persona.nombre,
                    apellido: persona.apellido,
                    sigla: persona.sigla,
                    direccion: persona.direccion,
                    direccionReferencia: persona.direccionReferencia,
                    barrio: persona.barrio,
                    telefono: persona.telefono,
                    email: persona.email,
                    fechaNacimiento_input: persona.fechaNacimiento ? persona.fechaNacimiento.format("dd-MM-yyyy") : "",
                    fechaNacimiento_day: persona.fechaNacimiento ? persona.fechaNacimiento.format("dd") : "",
                    fechaNacimiento_month: persona.fechaNacimiento ? persona.fechaNacimiento.format("MM") : "",
                    fechaNacimiento_year: persona.fechaNacimiento ? persona.fechaNacimiento.format("yyyy") : "",
                    discapacitado: persona.discapacitado,
                    sexo: persona.sexo,
                    nacionalidad: persona.nacionalidadId,
                    profesion: persona.profesionId,
                    estadoCivil: persona.estadoCivilId
            ]
        }
        def json = new JsonBuilder(datos)
        render json
    }

    def validarCedula_ajax() {
//        println params
        params.cedula = params.persona.cedula.toString().trim()
        def pers = Persona.findByCedula(params.cedula)

        def empOk = true
        if (pers && pers.empresaId.toLong() != session.empresa.id.toLong()) {
            empOk = false
        }

        if (params.id) {
            def emp = Empleado.get(params.id)

            if (emp.persona.cedula == params.cedula) {
//                println "1"
                render true
                return
            } else {
                def emps = Empleado.withCriteria {
                    persona {
//                        eq("empresa", session.empresa)
                        eq("cedula", params.cedula)
                    }
                }
//                println "2: " + emps.size()
                render(emps.size() == 0) && empOk
//                render errors
                return
            }
        } else {
            def emps = Empleado.withCriteria {
                persona {
//                    eq("empresa", session.empresa)
                    eq("cedula", params.cedula)
                }
            }
//            println "3: " + emps.size()
            render emps.size() == 0 && empOk
//            render errors
            return
        }
    }

    def save_ajax() {

//        println("empl " + params)

        def empleadoInstance
        def errores = ''
        def texto = ''

        if(params."empleado.id"){
            println("entro 1")
            empleadoInstance = Empleado.get(params."empleado.id");
            texto = "Empleado actualizado correctamente"
        }else{
            println("entro 2")
            empleadoInstance = new Empleado ()
            texto = "Empleado creado correctamente"
        }

        empleadoInstance.persona = Persona.get(params."persona.id")
        empleadoInstance.departamento = Departamento.get(params."empleado.departamento.id")
        empleadoInstance.tipoContrato = TipoContrato.get(params."empleado.tipoContrato.id")
        empleadoInstance.estado = params."empleado.estado"

        if(params."empleado.fechaInicio_input"){
            empleadoInstance.fechaInicio = new Date().parse("dd-MM-yyyy", params."empleado.fechaInicio_input")
        }
        if(params."empleado.fechaFin_input"){
            empleadoInstance.fechaFin = new Date().parse("dd-MM-yyyy", params."empleado.fechaFin_input")
        }

        empleadoInstance.sueldo = params."empleado.sueldo".toDouble()
        empleadoInstance.porcentajeComision = params."empleado.porcentajeComision".toDouble()
        empleadoInstance.hijo = params."empleado.hijo".toInteger()
        empleadoInstance.cuenta = params."empleado.cuenta"
        empleadoInstance.iess = params."empleado.iess"
        empleadoInstance.numero = params."empleado.numero"
        empleadoInstance.cargo = params."empleado.cargo"
        empleadoInstance.telefono = params."empleado.telefono"
        empleadoInstance.mail = params."empleado.mail"
        empleadoInstance.observaciones = params."empleado.observaciones"

        try{
            empleadoInstance.save(flush: true)
        }catch (e){
            errores += e
        }


        if(errores == ''){
            render "OK_" + texto
        }else{
            render "NO"
        }

    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def empleadoInstance = Empleado.get(params.id)
            if (empleadoInstance) {
                try {
                    empleadoInstance.delete(flush: true)
                    render "OK_Eliminación de Empleado exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Empleado."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Empleado."
    } //notFound para ajax


    def cambiarEstado_ajax () {
        def empleado = Empleado.get(params.id)
        def texto = ''

        if(params.tipo == 'D'){
            empleado.estado = 'I'
            texto = "Empleado desactivado correctamente"
        }else{
            empleado.estado = 'A'
            texto = "Empleado activado correctamente"
        }

        try{
            empleado.save(flush: true)
            render "OK_" + texto
        }catch (e){
            println("error al cambiar de estado al empleado " + e)
            render "no"
        }
    }

    def empleado_ajax () {

        def personaInstance = new Persona(params)
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                notFound_ajax()
                return
            }
        }
        return [personaInstance: personaInstance]
    }


    def crearEmpleado_ajax () {

        def persona = Persona.get(params.id)
        def existe = Empleado.findByPersona(persona)

        if(!existe){
            def empleado = new Empleado()

            empleado.persona = persona
            empleado.sueldo = 0
            empleado.porcentajeComision = 0
            empleado.hijo = 0
            empleado.estado = 'A'

            if(!empleado.save(flush: true)){
                println("error al generar el empleado desde crear persona "  + empleado.errors)
                render "no"
            }else{
                render "ok"
            }
        }else{
            render "no"
        }


    }

}
