package cratos.seguridad

class Shield {
    def beforeInterceptor = [action: this.&auth, except: 'login']
    /**
     * Verifica si se ha iniciado una sesión
     * Verifica si el usuario actual tiene los permisos para ejecutar una acción
     */
    def auth() {
//        println "an " + actionName + " cn " + controllerName + "  "
//        println session
        session.an = actionName
        session.cn = controllerName
        session.pr = params
//        return true
        /** **************************************************************************/
        if (!session.usuario || !session.perfil) {
            if(controllerName != "inicio" && actionName != "index") {
                flash.message = "Usted ha superado el tiempo de inactividad máximo de la sesión"
            }
            render "<script type='text/javascript'> window.location.href = '${createLink(controller:'login', action:'login')}'; </script>"
            session.finalize()
            return false
        } else {
            return true
        }
        /*************************************************************************** */
    }

    boolean isAllowed() {
//        try {
//            if (session.permisos[actionName] == controllerName)
//                return true
//        } catch (e) {
//            println "Shield execption e: " + e
//            return true
//        }
//        return true
        return true
    }
}
 
