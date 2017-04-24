package cratos.seguridad


class PersonaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def modificar() {
        def yo = Persona.get(session.usuario.id)
        return [personaInstance: yo]
    }

    def cambiarPass() {
        def yo = Persona.get(session.usuario.id)
        return [personaInstance: yo, tipo: params.tipo]
    }

    def validarPass_ajax() {
        def yo = Persona.get(session.usuario.id)
        def pass = params.actu.toString().trim().encodeAsMD5()
        switch (params.tipo) {
            case "pass":
                render pass == yo.password
                return
                break;
            case "auto":
                render pass == yo.autorizacion
                return
                break;
        }
        render false
    }

    def savePass_ajax() {
        def yo = Persona.get(session.usuario.id)
        def pass = params.nuevo.toString().trim().encodeAsMD5()
        switch (params.tipo) {
            case "pass":
                yo.password = pass
                break;
            case "auto":
                yo.autorizacion = pass
                break;
        }
        if (yo.save(flush: true)) {
            render "OK_${params.tipo == 'pass' ? 'Password actualizado' : 'Clave de autorización actualizada'}"
        } else {
            render "NO_Ha ocurrido un error al atualizar ${params.tipo == 'pass' ? 'el password' : 'la clave de autorización'}"
        }
    }

    def index() {
        redirect(action: "list", params: params)
    } //index

    def accesos() {
        def usu = Persona.get(params.id)
        def accesos = Accs.findAllByUsuario(usu, [sort: 'accsFechaInicial'])
        return [accesos: accesos]
    }

    def perfiles() {
        def usu = Persona.get(params.id)
        def perfilesUsu = Sesn.findAllByUsuario(usu).perfil.id
        return [usuario: usu, perfilesUsu: perfilesUsu,]
    }

    def savePerfiles_ajax() {
        def usu = Persona.get(params.id)
        def perfilesUsu = Sesn.findAllByUsuario(usu).perfil.id*.toString()
//        println "**************"
//        println Sesn.findAllByUsuario(usu)
//        println Sesn.findAllByUsuario(usu).id
//        println Sesn.findAllByUsuario(usu).id*.toString()
//        println "**************"
        def arrRemove = perfilesUsu, arrAdd = []
        def errores = ""

        if (params.perfil instanceof java.lang.String) {
            params.perfil = [params.perfil]
        }

        params.perfil.each { pid ->
            if (perfilesUsu.contains(pid)) {
                //ya tiene este perfil: le quito de la lista de los de eliminar
                arrRemove.remove(pid)
            } else {
                //no tiene este perfil: le pongo en la lista de agregar
                arrAdd.add(pid)
            }
        }
//        println "params: " + params
//        println "perfilesUsu: " + perfilesUsu
//        println "add: " + arrAdd
//        println "remove: " + arrRemove
        arrRemove.each { pid ->
            def perf = Prfl.get(pid)
            def sesn = Sesn.findByUsuarioAndPerfil(usu, perf)
            try {
                sesn.delete(flush: true)
            } catch (e) {
                println "erorr al eliminar perfil: " + e
                errores += "<li>No se puedo remover el perfil ${perf.nombre}</li>"
            }
        }
        arrAdd.each { pid ->
            def perf = Prfl.get(pid)
            def sesn = new Sesn([usuario: usu, perfil: perf])
            if (!sesn.save(flush: true)) {
                println "error al asignar perfil: " + sesn.errors
                errores += "<li>No se puedo remover el perfil ${perf.nombre}</li>"
            }
        }

        if (errores == "") {
            render "OK_Cambios efectuados exitosamente"
        } else {
            render "<ul>" + errores + "</ul>"
        }
    }

    def validarCedula_ajax() {
        params.cedula = params.cedula.toString().trim()
        if (params.id) {
            def prsn = Persona.get(params.id)
            if (prsn.cedula == params.cedula) {
                render true
                return
            } else {
                render Persona.countByCedula(params.cedula) == 0
                return
            }
        } else {
            render Persona.countByCedula(params.cedula) == 0
            return
        }
    }

    def reset_pass_ajax() {
        def prsn = Persona.get(params.id)
        prsn.password = prsn.cedula.encodeAsMD5()
        if (!prsn.save(flush: true)) {
            render "NO_" + renderErrors(bean: prsn)
        } else {
            render "OK_Password reiniciado exitosamente."
        }
    }

    def listAdmin() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def personaInstanceList = Persona.list(params)
        def personaInstanceCount = Persona.count()
        if (personaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        personaInstanceList = Persona.list(params)
        return [personaInstanceList: personaInstanceList, personaInstanceCount: personaInstanceCount]
    } //list

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def personaInstanceList = Persona.findAllByEmpresa(session.empresa, params)
        def personaInstanceCount = Persona.count()
        if (personaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        personaInstanceList = Persona.findAllByEmpresa(session.empresa, params)
        return [personaInstanceList: personaInstanceList, personaInstanceCount: personaInstanceCount]
    } //list

    def formAdmin_ajax() {
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

    def createAdmin() {
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

    def show_ajax() {
        if (params.id) {
            def personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                notFound_ajax()
                return
            }
            return [personaInstance: personaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def personaInstance = new Persona(params)
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                notFound_ajax()
                return
            }
        }
        return [personaInstance: personaInstance]
    } //form para cargar con ajax en un dialog

    def save() {
        def personaInstance = new Persona()
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                notFound_ajax()
                return
            }
        } //update
        else {
            //create: pone la cedula en el pass y validacion y pone fecha de cambio de pass en ahora
            params.password = params.cedula.toString().encodeAsMD5()
            params.autorizacion = params.cedula.toString().encodeAsMD5()
            params.fechaPass = new Date()
        }

        personaInstance.properties = params

        if (!personaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Persona."
            msg += renderErrors(bean: personaInstance)
            render msg
            return
        }

        def perfilesUsu = Sesn.findAllByUsuario(personaInstance).perfil.id*.toString()
        def arrRemove = perfilesUsu, arrAdd = []
        def errores = ""

        if (params.perfil instanceof java.lang.String) {
            params.perfil = [params.perfil]
        }

        params.perfil.each { pid ->
            if (perfilesUsu.contains(pid)) {
                //ya tiene este perfil: le quito de la lista de los de eliminar
                arrRemove.remove(pid)
            } else {
                //no tiene este perfil: le pongo en la lista de agregar
                arrAdd.add(pid)
            }
        }
        arrRemove.each { pid ->
            def perf = Prfl.get(pid)
            def sesn = Sesn.findByUsuarioAndPerfil(personaInstance, perf)
            try {
                sesn.delete(flush: true)
            } catch (e) {
                println "erorr al eliminar perfil: " + e
                errores += "<li>No se puedo remover el perfil ${perf.nombre}</li>"
            }
        }
        arrAdd.each { pid ->
            def perf = Prfl.get(pid)
            def sesn = new Sesn([usuario: personaInstance, perfil: perf])
            if (!sesn.save(flush: true)) {
                println "error al asignar perfil: " + sesn.errors
                errores += "<li>No se puedo remover el perfil ${perf.nombre}</li>"
            }
        }

        def mensaje = "OK_${params.id ? 'Actualización' : 'Creación'} de Persona exitosa."

        if (errores == "") {
            mensaje += "<br/>Perfil(es) asignado(s) exitosamente"
        } else {
            mensaje += "<br/><ul>" + errores + "</ul>"
        }

        render mensaje
    } //save para grabar desde ajax

    def saveAdmin_ajax() {
        println params
        def personaInstance = new Persona()
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                notFound_ajax()
                return
            }
        } //update
        else {
            //create: pone la cedula en el pass y validacion y pone fecha de cambio de pass en ahora
            params.password = params.cedula.toString().encodeAsMD5()
            params.autorizacion = params.cedula.toString().encodeAsMD5()
            params.fechaPass = new Date()
        }

        personaInstance.properties = params

        if (!personaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Persona."
            msg += renderErrors(bean: personaInstance)
            render msg
            return
        }

        def perfilesUsu = Sesn.findAllByUsuario(personaInstance).perfil.id*.toString()
        def arrRemove = perfilesUsu, arrAdd = []
        def errores = ""

        if (params.perfil instanceof java.lang.String) {
            params.perfil = [params.perfil]
        }

        params.perfil.each { pid ->
            if (perfilesUsu.contains(pid)) {
                //ya tiene este perfil: le quito de la lista de los de eliminar
                arrRemove.remove(pid)
            } else {
                //no tiene este perfil: le pongo en la lista de agregar
                arrAdd.add(pid)
            }
        }
        arrRemove.each { pid ->
            def perf = Prfl.get(pid)
            def sesn = Sesn.findByUsuarioAndPerfil(personaInstance, perf)
            try {
                sesn.delete(flush: true)
            } catch (e) {
                println "erorr al eliminar perfil: " + e
                errores += "<li>No se puedo remover el perfil ${perf.nombre}</li>"
            }
        }
        arrAdd.each { pid ->
            def perf = Prfl.get(pid)
            def sesn = new Sesn([usuario: personaInstance, perfil: perf])
            if (!sesn.save(flush: true)) {
                println "error al asignar perfil: " + sesn.errors
                errores += "<li>No se puedo remover el perfil ${perf.nombre}</li>"
            }
        }

        def mensaje = "OK_${params.id ? 'Actualización' : 'Creación'} de Persona exitosa."

        if (errores == "") {
            mensaje += "<br/>Perfil(es) asignado(s) exitosamente"
        } else {
            mensaje += "<br/><ul>" + errores + "</ul>"
        }

        render mensaje
    } //save para grabar desde ajax

    def save_ajax() {

//        params.each { k, v ->
//            if (v != "date.struct" && v instanceof java.lang.String) {
//                params[k] = v.toUpperCase()
//            }
//        }


        def personaInstance = new Persona()
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                notFound_ajax()
                return
            }
            if (!personaInstance.empresa) {
                params.empresa = session.empresa
            }
        } //update
        else {
            //create: pone la cedula en el pass y validacion y pone fecha de cambio de pass en ahora
            params.password = params.cedula.toString().encodeAsMD5()
            params.autorizacion = params.cedula.toString().encodeAsMD5()
            params.fechaPass = new Date()
            params.empresa = session.empresa
        }

        personaInstance.properties = params

        if (!personaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Persona."
            msg += renderErrors(bean: personaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Persona exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def personaInstance = Persona.get(params.id)
            if (personaInstance) {
                try {
                    personaInstance.delete(flush: true)
                    render "OK_Eliminación de Persona exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Persona."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Persona."
    } //notFound para ajax

}
