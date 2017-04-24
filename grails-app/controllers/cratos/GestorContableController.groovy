package cratos

class GestorContableController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def buscadorService
    def index = {
        session.movimientos=[]
    }

    def buscarGestor() {
        session.movimientos=[]
//        println "params " + params
        def lista = buscadorService.buscar(Gestor, "Gestor", "incluyente", [campos: ["nombre", "descripcion"], criterios: [params.nombre, params.nombre], operadores: ["like", "like"], ordenado: "nombre", orden: "asc"], true," and empresa=${session.empresa.id}")
        def numRegistros = lista.get(lista.size() - 1)
        lista.pop()
        return [lista: lista]
    }

    def nuevoGestor() {
        //println "nuevo gestor " + params
        session.movimientos=[]
        def gestorInstance
        def nuevo = true
        def tipoCom
        if (params.id) {
            nuevo = false
            gestorInstance = Gestor.get(params.id.toLong())
//            println "gestor " + gestorInstance
            def movs = Genera.findAll("from Genera where gestor=${gestorInstance.id} order by debeHaber,cuenta")
            if (movs.size() > 0) {
                movs.each {
                    println "add " + it
                    tipoCom = it.tipoComprobante
                    session.movimientos.add(it)
                }
                session.tipoComp = movs[0]?.tipoComprobante?.id
            }
        } else {

            gestorInstance = new Gestor()
        }
        //println "nuevo gestor "+gestorInstance
        render(view: 'gestorForm', model: [gestorInstance: gestorInstance, nuevo: nuevo, tipoCom: tipoCom])
    }

    def buscarCuentas() {
        println "buscar cuentas!!! " + params

        def descripcion = (params.nombre) ?: null
        def numero = (params.codigo) ?: null
        def res = buscadorService.buscar(Cuenta, "Cuenta", "excluyente", [campos: ["descripcion", "numero", "movimiento"], criterios: [descripcion, numero, "1"], operadores: ["like", "like der", "="], ordenado: "numero", orden: "asc"], true," and empresa=${session.empresa.id}")
        def numRegistros = res.get(res.size() - 1)
        res.pop()
        return [planCuentas: res]
    }

    def cargarCuentas() {
        println "cuentas !!!!! " + session.movimientos
//        def cuentas=[]
        render(view: 'agregarCuenta', model: [cuentas: session.movimientos])
    }

    def cambiarComprobante() {
        def tipo = TipoComprobante.get(params.tc)
        session.tipoComp=tipo
        render(view: 'agregarCuenta', model: [cuentas: session.movmientos])
    }

    def agregarCuenta() {
        // println "agregar cuenta !! " + params
        if (params.posicion) {
            if (!params.eliminar) {
                session.movimientos[params.posicion.toInteger()].porcentaje = params.por.toDouble()
                session.movimientos[params.posicion.toInteger()].porcentajeImpuestos = params.imp.toDouble()
                session.movimientos[params.posicion.toInteger()].valor = params.val.toDouble()
            } else {
                println "tam " + session.movimientos.size() + " pos " + params.posicion
                session.movimientos.remove(params.posicion.toInteger())
            }

        } else {
            def genera = new Genera()
            def cuenta = Cuenta.get(params.id)
            def tipo = TipoComprobante.get(params.tc)
            genera.cuenta = cuenta
            genera.tipoComprobante = tipo
            genera.debeHaber = (params.razon == "Debe") ? "D" : "H"
            session.tipoComp=tipo
            session.movimientos.add(genera)
        }
        session.movimientos=ordernarLista(session.movimientos)
        return [cuentas: session.movimientos]
    }

    def save() {
        params.movimientos = null
        println "params save gestor !!! " + params + " id " + params.id
        def p
        if (params.id == null || params.id == "") {
            // println "save "
            try {
                params.controllerName = controllerName
                params.actionName = actionName
                params.estado = "A"
//        p=kerberosService.save(params,Gestor,session.perfil,session.usuario)
                p = new Gestor(params)
                p.fecha = new Date()
                p.empresa = session.empresa
                p.save(flush: true)
                println "errores gestor  " + p.errors
                // println "empeiza genera"
                if (session.movimientos.size() > 0) {
                    session.movimientos.each {
                        // println "  size!!!!!!  " + session.movimientos.size()
                        it.gestor = p
                        println " save genera " + it + " " + it.save()
                        p.addToMovimientos(it)
                    }

                    session.movimientos = []
                }
                flash.message = "Gestor contable guardado exitosamente"
                redirect(action: 'index')
            } catch (Exception e) {
                println "catch " + e
                render(view: 'gestorForm', model: ['GestorInstance': p], error: true)
            }
        } else {
            //  println "edit "
            try {
                params.controllerName = controllerName
                params.actionName = actionName
                params.estado = "A"
                p = Gestor.get(params.id)
                p.properties = params
                p.save(flush: true)
                println "errores " + p.properties.errors
                def lista = []
                def generaAntiguos = Genera.findAllByGestor(p)
                if (session.movimientos.size() > 0) {
                    println "  size!!!!!!  " + session.movimientos.size() + " \n\n\n\n\n"
                    def genera
                    session.movimientos.each {
                        println "cuentas  ==> " + it.id
                        if (it.id == null) {
                            //  println "save cuenta"
                            it.gestor = p
                            println " save new " + it + " " + it.save()
                            p.addToMovimientos(it)
                        } else {
                            // println "edit cuenta"
                            genera = Genera.get(it.id)
                            genera.porcentaje = it.porcentaje
                            genera.porcentajeImpuestos = it.porcentajeImpuestos
                            genera.valor = it.valor
                            println "tipo  !! " + session.tipoComp
                            if (session.tipoComp)
                                genera.tipoComprobante = session.tipoComp
                            //println " datos " + it.porcentajeImpuestos + " " + it.porcentaje + " " + it.valor
                            //println "paso genera " + genera
                            genera.save(flush: true)
                            lista.add(it.id)
                            println " save edit " + genera + " " + genera.save()
                            genera = null
                        }

                    }
                    generaAntiguos.each {
                        if (!lista.contains(it.id)) {
                            it.delete()
                        }
                    }

                    p.save()
                    session.movimientos = []
                }
                flash.message = "Gestor contable guardado exitosamente"
                redirect(action: 'index')
            } catch (Exception e) {
                println "catch " + e
                render(view: 'gestorForm', model: ['GestorInstance': p], error: true)
            }
        }
    }

    def verGestor() {

        def gestor = Gestor.get(params.id)
        def c = Genera.findAllByGestor(gestor)
        println "ver gestor "
        session.movimientos = Genera.findAll("from Genera where gestor=${gestor.id} order by debeHaber,cuenta")
        if(session.movimientos.size()>0)
            session.tipoComp=session.movimientos[0].tipoComprobante
        if (!gestor) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'Gestor.label', default: 'Gestor'), params.id])}"
            redirect(action: "index")
        } else {
            [gestor: gestor, cuentas: session.movimientos]
        }
    }

    def editarGestor() {
        def gestor = Gestor.get(params.id)
        if (!gestor) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'Gestor.label', default: 'Gestor'), params.id])}"
            redirect(action: "index")
        } else {
            render(view: 'gestorForm', model: [GestorInstance: gestor])
        }
    }

    def deleteGestor() {
        def gestor = Gestor.get(params.id)
        if (!gestor) {
            flash.message = "No se ha encontrado el gestor a eliminar"
            return
        }

        def adquisiciones = Adquisiciones.findAllByGestor(gestor)
        def facturas = Factura.findAllByGestor(gestor)
        def procesos = Proceso.findAllByGestor(gestor)

        if (adquisiciones.size() == 0 && facturas.size() == 0 && procesos.size() == 0) {
            def generas = Genera.findAllByGestor(gestor)
            generas.each { gen ->
                try {
                    gen.delete(flush: true)
                } catch (e) {
                    println e.stackTrace
                }
            }
            try {
                gestor.delete(flush: true)
            } catch (e) {
                println e.stackTrace
            }
            redirect(action: "index")
        } else {
            def msn = "El gestor se utiliza en "
            if (adquisiciones.size() > 0) {
                msn += adquisiciones.size() + " adquisici" + (adquisiciones.size() == 1 ? "ón, " : "ones, ")
            }
            if (facturas.size() > 0) {
                msn += facturas.size() + " factura" + (facturas.size() == 1 ? ", " : "s, ")
            }
            if (procesos.size() > 0) {
                msn += procesos.size() + " proceso" + (procesos.size() == 1 ? ", " : "s, ")
            }
            msn += " por lo que no puede ser eliminado."
            return [msn: msn, gestor: gestor]
        }
    }


    def ordernarLista(lista){
        println "original "+lista
        def res
        if(lista.size()>1)
            res = lista.sort{it?.debeHaber}
        else
            res=lista
        //res = res.sort{it.cuenta}
        println "despues "+res
        return res
    }


}
