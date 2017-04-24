package cratos.seguridad

import cratos.Contabilidad


class LoginController {

    def mail

    def index() {
        redirect(action: 'login')
    }

    def cambiarPass() {
        def usu = Persona.get(session.usuario.id)
        return [usu: usu]
    }

    def validarPass() {
        println params
        render "No puede ingresar este valor"
    }

    def guardarPass() {
        def usu = Persona.get(params.id)
        usu.password = params.pass.toString().trim().encodeAsMD5()
        usu.fechaPass = new Date() + 30
        if (usu.save(flush: true)) {
            redirect(controller: session.cn, action: session.an)
        }
        render params
    }

    def validarSesion() {
        if (session.usuario) {
            render "OK"
        } else {
            flash.message = "Su sesión ha caducado, por favor ingrese nuevamente."
            render "NO"
        }
    }

    def olvidoPass() {
        def mail = params.email
        def personas = Persona.findAllByEmail(mail)
        def msg
        if (personas.size() == 0) {
            msg = "NO*No se encontró un usuario con ese email"
        } else if (personas.size() > 1) {
            msg = "NO*Ha ocurrido un error grave"
        } else {
            def persona = personas[0]

            def random = new Random()
            def chars = []
            ['A'..'Z', 'a'..'z', '0'..'9', ('!@$%^&*' as String[]).toList()].each { chars += it }
            def newPass = (1..8).collect { chars[random.nextInt(chars.size())] }.join()

            persona.password = newPass.encodeAsMD5()
            if (persona.save(flush: true)) {
                sendMail {
                    to mail
                    subject "Recuperación de contraseña"
                    body 'Hola ' + persona.login + ", tu nueva contraseña es " + newPass + "."
                }
                msg = "OK*Se ha enviado un email a la dirección " + mail + " con una nueva contraseña."
            } else {
                msg = "NO*Ha ocurrido un error al crear la nueva contraseña. Por favor vuelva a intentar."
            }
        }
        render msg
    }

    def login() {
//        def usu = session.usuario
//        def cn = "inicio"
//        def an = "index"
//        if (usu) {
//            if (session.cn && session.an) {
//                cn = session.cn
//                an = session.an
//            }
//            println "cn: " + cn + "   an:" + an
//            redirect(controller: cn, action: an)
//        }
    }

    def validar() {
        //println "params "+params
        def user = Persona.withCriteria {
            eq("login", params.login, [ignoreCase: true])
            eq("password", params.pass.encodeAsMD5())
        }

        if (user.size() == 0) {
            flash.message = "No se ha encontrado el usuario"
            flash.tipo = "error"
            render "error_"+flash.message
            return
        } else if (user.size() > 1) {
            flash.message = "Ha ocurrido un error grave"
            flash.tipo = "error"
            render "error_"+flash.message
            return
        } else {
            def ahora = new Date().clearTime()
            user = user[0]
            session.usuario = user
            session.empresa = user.empresa
//            session.contabilidad = Contabilidad.findByFechaInicioLessThanEqualsAndFechaCierreGreaterThanEquals(ahora, ahora)

            def cont = Contabilidad.withCriteria {
                eq("institucion", user.empresa)
                le("fechaInicio", ahora)
                ge("fechaCierre", ahora)
                order("fechaCierre", "desc")
            }
            if (cont.size() == 0) {
                def conts = Contabilidad.findAllByInstitucion(user.empresa, [sort: "fechaCierre", order: "desc"])
                if (conts.size() > 0) {
                    cont = conts[0]
                }
            } else if (cont.size() == 1) {
                cont = cont[0]
            } else {
                cont = cont[0]
            }
            session.contabilidad = cont
//            if (!session.contabilidad) {
//                def conts = Contabilidad.list([sort: "fechaCierre", order: "desc"])
//                if (conts) {
//                    session.contabilidad = conts[0]
//                }
//            }
            def perfiles = Sesn.findAllByUsuario(user)
            if (perfiles.size() == 0) {
                flash.message = "No puede ingresar. Comuníquese con el administrador."
                flash.tipo = "error"
                flash.icon = "icon-splatter"
                render "error_"+flash.message
                return
            } else {
                return [perfiles:perfiles]

            }
        }
       // redirect(controller: 'login', action: "login")
    }

    def perfiles() {
        def usuarioLog = session.usuario
        def perfilesUsr = Sesn.findAllByUsuario(usuarioLog, [sort: 'perfil'])
        return [perfilesUsr: perfilesUsr]
    }

    def savePer() {
        def sesn = Sesn.get(params.prfl)
        def perf = sesn.perfil
        if (perf) {
            session.perfil = perf
            if (session.an && session.cn) {
                if (session.an.toString().contains("ajax")) {
                    redirect(controller: "inicio", action: "index")
                } else {
                    redirect(controller: session.cn, action: session.an, params: session.pr)
                }
            } else {
                redirect(controller: "inicio", action: "index")
            }
        } else {
            redirect(action: "login")
        }
    }

    def logout() {
        session.usuario = null
        session.perfil = null
        session.permisos = null
        session.menu = null
        session.an = null
        session.cn = null
        session.invalidate()
        redirect(controller: 'login', action: 'login')
    }
}
