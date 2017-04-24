package cratos


class ActivoFijoController extends cratos.seguridad.Shield {

    def utilitarioService
    def procesoService

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def listGeneral() {
        if (params.id) {
            def proc = Proceso.get(params.id)
            if (!proc) {
                params.remove("id")
            }
        }

        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        if (!params.sort) {
            params.sort = 'fechaInicioDepreciacion'
        }
        if (!params.order) {
            params.order = "desc"
        }
        def activoFijoInstanceList, activoFijoInstanceCount
        activoFijoInstanceList = ActivoFijo.findAllByEmpresa(session.empresa, params)
        activoFijoInstanceCount = ActivoFijo.count()
        if (activoFijoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        activoFijoInstanceList = ActivoFijo.findAllByEmpresa(session.empresa, params)

        def depreciaciones = Depreciacion.findAllByEmpresa(session.empresa)
        depreciaciones = depreciaciones.sort({ it.periodo.fechaInicio })
        if (depreciaciones.size() > 0) {
            params.fechaUltimaDepreciacion = depreciaciones?.last()?.fecha
        }
        if (!params.fecha) {
            params.fecha = new Date()
        } else {
            params.fecha = new Date().parse("dd-MM-yyyy", params.fecha)
        }

        return [activoFijoInstanceList: activoFijoInstanceList, activoFijoInstanceCount: activoFijoInstanceCount, params: params]
    }

    def depreciarForm_ajax() {
        def finDeMes = utilitarioService.getLastDayOfMonth(new Date())

        def depreciaciones = Depreciacion.findAllByEmpresa(session.empresa)
        depreciaciones = depreciaciones.sort({ it.periodo.fechaInicio })
        def fechaUltimaDepreciacion = null
        if (depreciaciones.size() > 0) {
            fechaUltimaDepreciacion = depreciaciones.last().fecha
        }
        def contabilidad = Contabilidad.get(session.contabilidad.id)
        def periodos
        if (fechaUltimaDepreciacion) {
            periodos = Periodo.withCriteria {
                eq("contabilidad", contabilidad)
                gt("fechaFin", fechaUltimaDepreciacion)
                le("fechaFin", finDeMes)
                order("fechaInicio", "asc")
            }
        } else {
//            periodos = Periodo.findAllByContabilidad(contabilidad, [sort: "fechaInicio"])
            periodos = Periodo.withCriteria {
                eq("contabilidad", contabilidad)
                le("fechaFin", finDeMes)
                order("fechaInicio", "asc")
            }
        }
        return [periodos: periodos]
    }

    def errores() {
        [params: params]
    }

    def depreciar() {

        def error = ""

        def periodo = Periodo.get(params.per)
        def fin = periodo.fechaFin

        def espacio = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        def enter = "<br/>"

        espacio = "\t"
        enter = "\n"

        def str = periodo.toString() + enter + fin.format("dd-MM-yyyy") + enter

        def gestorDepreciacion = Gestor.findAllByEmpresaAndEsDepreciacion(session.empresa, "S")
        if (gestorDepreciacion.size() == 1) {
            gestorDepreciacion = gestorDepreciacion.first()
        } else if (gestorDepreciacion.size() > 1) {
            println "Existe mas de un gestor de depreciacion!!! ${gestorDepreciacion.id}"
            flash.message = "Se ha encontrado más de un gestor para la depreciación"
            flash.title = "Ha ocurrido un error grave"
            flash.tipo = "crit"
            return
        } else {
            //no existe
            println "NO existe el gestor: creando..."
            gestorDepreciacion = new Gestor([
                    estado: 'N',
                    fecha: new Date(),
                    descripcion: "Depreciación acumulada de activos fijos, generado automáticamente",
                    nombre: "Depreciación acumulada de activos fijos",
                    empresa: session.empresa,
                    fuente: Fuente.get(1),
                    observaciones: "",
                    esDepreciacion: 'S'
            ])
            if (gestorDepreciacion.save(flush: true)) {
                str += "Gestor creado"
                def genera1 = new Genera([
                        valor: 0,
                        porcentajeImpuestos: 0,
                        porcentaje: 100,
                        tipoComprobante: TipoComprobante.findByCodigo("D"),
                        cuenta: Cuenta.findByEmpresaAndResultado(session.empresa, "G"),
                        gestor: gestorDepreciacion,
                        debeHaber: "D"
                ])
                if (genera1.save(flush: true)) {
                    str += "genera 1 creado"
                    gestorDepreciacion.addToMovimientos(genera1)
                } else {
                    str += "error al crear genera 1: " + renderErrors(bean: genera1)
                    error += "<li>" + "error al crear genera 1: " + renderErrors(bean: genera1) + "</li>"
                }
                def genera2 = new Genera([
                        valor: 0,
                        porcentajeImpuestos: 0,
                        porcentaje: 100,
                        tipoComprobante: TipoComprobante.findByCodigo("D"),
                        cuenta: Cuenta.findByEmpresaAndResultado(session.empresa, "P"),
                        gestor: gestorDepreciacion,
                        debeHaber: "H"
                ])
                if (genera2.save(flush: true)) {
                    str += "genera 2 creado"
                    gestorDepreciacion.addToMovimientos(genera2)
                } else {
                    str += "error al crear genera 2: " + renderErrors(bean: genera2)
                    error += "<li>" + "error al crear genera 2: " + renderErrors(bean: genera2) + "</li>"
                }
            } else {
                str += "error al crear gestor: " + renderErrors(bean: gestorDepreciacion)
                error += "<li>error al crear gestor: " + renderErrors(bean: gestorDepreciacion) + "</li>"
            }
        }

//        def proceso = Proceso.get(341)
//        procesoService.registrar(proceso, session.perfil, session.usuario, session.contabilidad)

//        println "gestorDepreciacion"
//        println gestorDepreciacion
//        println "gestorDepreciacion movimientos"
//        println gestorDepreciacion.movimientos
//        println "gestorDepreciacion movimientos array"
//        println gestorDepreciacion.movimientos?.toArray()

        // lo de la contabilidad
        def procesoContable = new Proceso()
        procesoContable.gestor = gestorDepreciacion
        procesoContable.contabilidad = session.contabilidad
//        procesoContable.descripcion = "Depreciación activos fijos de ${periodo.toString()} , efectuada el " + new Date().format("dd-MM-yyyy hh:mm") + " Monto: " + depTotal
        procesoContable.estado = "R"
        procesoContable.fecha = new Date()
        procesoContable.usuario = session.usuario
//        proceso.valor = depTotalTotal
        procesoContable.impuesto = 0
        procesoContable.tipoProceso = "R"
        procesoContable.empresa = session.empresa
        if (procesoContable.save(flush: true)) {
//            procesoService.registrar(proceso, session.perfil, session.usuario, session.contabilidad)
            str += espacio + " proceso guardado...."
        } else {
            str += "error en el proceso " + renderErrors(bean: procesoContable)
            error += "<li>" + "error en el proceso " + renderErrors(bean: procesoContable) + "</li>"
        }

        def depTotalTotal = 0

        (ActivoFijo.findAllByEmpresa(session.empresa)).each { activoFijo ->
            if (activoFijo.estado == 'A') {
                def inicio = activoFijo.fechaInicioDepreciacion
                def anios = activoFijo.aniosVidaUtil
                def diferencia = (fin - inicio) + 1

                def depreciaciones = Depreciacion.findAllByActivoFijo(activoFijo)
                depreciaciones = depreciaciones.sort({ it.periodo.fechaInicio })

                str += enter + "+++++++++++++++++++++++++++++++++++++++++++" + enter
                str += "activo fijo: " + activoFijo.nombre + enter
                str += "precio: " + activoFijo.precio + enter
                str += "depreciaciones: " + depreciaciones + enter
                str += "inicio dep: " + inicio.format("dd-MM-yyyy") + enter
                str += "fin dep: " + fin.format("dd-MM-yyyy") + enter
                str += "diferencia: " + diferencia + enter

                if (diferencia <= 0) {
                    str += "NO SE DEPRECIA " + enter
                } else {
                    def diasVidaUtil
                    def depDiaria
                    def depTotal
                    def depreciar = true

                    if (depreciaciones.size() == 0) {
                        // es la primera vez que se deprecia: el inicio es la fecha de inicio de depreciacion
                        diasVidaUtil = (anios * 360)
                        depDiaria = activoFijo.precio / diasVidaUtil
                        depTotal = depDiaria * diferencia
                        str += "NO SE HA DEPRECIADO: " + enter
                    } else {
                        // ya se deprecio antes
                        inicio = depreciaciones.last().fecha + 1
                        //teoria: numero de dias desde el fin del anterior periodo
//                        diferencia = (fin - inicio) + 1
                        //practica: 30 dias
                        diferencia = 30
                        diasVidaUtil = (anios * 360)
                        depDiaria = activoFijo.precio / diasVidaUtil
                        depTotal = depDiaria * diferencia
                        str += "YA SE DEPRECIO: " + enter
                        if (diferencia <= 0) {
                            depreciar = false
                            str += espacio + "** Depreciacion desde: " + inicio.format("dd-MM-yyyy") + enter
                            str += espacio + "** Depreciacion hasta: " + fin.format("dd-MM-yyyy") + enter
                            str += espacio + "** diferencia: " + diferencia + enter
                        }
                    }
                    if (depreciar) {
                        str += espacio + "Depreciacion desde: " + inicio.format("dd-MM-yyyy") + enter
                        str += espacio + "Depreciacion hasta: " + fin.format("dd-MM-yyyy") + enter
                        str += espacio + "diferencia: " + diferencia + enter
                        str += espacio + "vida util (anios): " + anios + enter
                        str += espacio + "vida util (dias): " + diasVidaUtil + enter
                        str += espacio + "precio: " + activoFijo.precio + enter
                        str += espacio + "dep. diaria: " + depDiaria + enter
                        str += espacio + "dep. total: " + depTotal + enter

                        def valorSobrante = activoFijo.precio - activoFijo.depreciacionAcumulada - depTotal
                        if (valorSobrante < 0) {
                            valorSobrante = 0
                            depTotal = activoFijo.precio - activoFijo.depreciacionAcumulada
                        }

                        depTotalTotal += depTotal

                        def depreciacion = new Depreciacion([
                                empresa: session.empresa,
                                periodo: periodo,
                                proceso: procesoContable,
                                activoFijo: activoFijo,
                                valor: depTotal,
                                fecha: fin
                        ])
                        if (depreciacion.save(flush: true)) {
                            str += espacio + espacio + "DEPRECIACION REALIZADA" + enter
                            activoFijo.depreciacionAcumulada = activoFijo.depreciacionAcumulada + depTotal
                            if (valorSobrante == 0) {
                                activoFijo.estado = 'B'
                            }
                            if (activoFijo.save(flush: true)) {
                                str += espacio + espacio + "ACTIVO FIJO GUARDADO" + enter
                            } else {
                                str += espacio + espacio + "ERROR: " + renderErrors(bean: activoFijo) + enter
                                error += "<li>" + "error al guardar el activo fijo: " + renderErrors(bean: activoFijo) + "</li>"
                            }
                        } else {
                            str += espacio + espacio + "ERROR: " + renderErrors(bean: depreciacion) + enter
                            error += "<li>" + "error al guardar la depreciación: " + renderErrors(bean: depreciacion) + "<li>"
                        }
                    } else {
                        str += espacio + "ya se deprecio este periodo..." + enter
                        error += "<li>Ya se ha realizado una depreciación para este periodo</li>"
                    } // depreciar

//                    procesoContable.valor = depTotalTotal
//                    procesoContable.descripcion = "Depreciación activos fijos de ${periodo.toString()} , efectuada el " + new Date().format("dd-MM-yyyy hh:mm") + " Monto: " + (util.numero(number: depTotalTotal, decimales: 2))
//
//                    str += "DEP DESC: " + procesoContable.descripcion
                    str += espacio + espacio + espacio + "depTotalTotal: " + depTotalTotal + enter
//
//                    if (procesoContable.save(flush: true)) {
//                        procesoService.registrar(procesoContable, session.perfil, session.usuario, session.contabilidad)
//                        str += espacio + espacio + "Proceso guardado (2)"
//                    } else {
//                        str += espacio + espacio + "Error: " + renderErrors(bean: procesoContable)
//                        error += "<li>" + "error al guardar el proceso contable: " + renderErrors(bean: procesoContable) + "</li>"
//                    }

                } // si se deberia depreciar

            } // el activo fijo aun esta en estado A
        } // foreach activo fijo

        procesoContable.valor = depTotalTotal
        procesoContable.descripcion = "Depreciación activos fijos de ${periodo.toString()} , efectuada el " + new Date().format("dd-MM-yyyy hh:mm") + " Monto: " + (util.numero(number: depTotalTotal, decimales: 2))

        str += "DEP DESC: " + procesoContable.descripcion + enter
        str += "DEP TOTAL TOTAL: " + procesoContable.valor + enter

        if (procesoContable.save(flush: true)) {
            procesoService.registrar(procesoContable, session.perfil, session.usuario, session.contabilidad)
            str += espacio + espacio + "Proceso guardado (2)"
        } else {
            str += espacio + espacio + "Error: " + renderErrors(bean: procesoContable)
            error += "<li>" + "error al guardar el proceso contable: " + renderErrors(bean: procesoContable) + "</li>"
        }

        println str

        if (error == "") {
            render "OK_Depreciación realizada exitosamente._${procesoContable.id}"
        } else {
            render "NO_<ul>" + error + "</ul>"
        }
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def activoFijoInstanceList, activoFijoInstanceCount
        if (params.proceso && params.proceso.id) {
            def proceso = Proceso.get(params.proceso.id)
            def comprobante = Comprobante.findAllByProceso(proceso)
            params.proceso = proceso
            if (comprobante.size() > 1) {
                println "Hay más de 1 comprobante para el proceso: proceso->${proceso.id}, comprobantes->${comprobante.id}"
            }
            if (comprobante.size() > 0) {
                params.comprobante = comprobante[0]
            }
            params.comprobante
            activoFijoInstanceList = ActivoFijo.findAllByProceso(proceso, params)
            activoFijoInstanceCount = ActivoFijo.count()
            if (activoFijoInstanceList.size() == 0 && params.offset && params.max) {
                params.offset = params.offset - params.max
            }
            activoFijoInstanceList = ActivoFijo.findAllByProceso(proceso, params)
        } else {
            activoFijoInstanceList = ActivoFijo.list(params)
            activoFijoInstanceCount = ActivoFijo.count()
            if (activoFijoInstanceList.size() == 0 && params.offset && params.max) {
                params.offset = params.offset - params.max
            }
            activoFijoInstanceList = ActivoFijo.list(params)
        }
        return [activoFijoInstanceList: activoFijoInstanceList, activoFijoInstanceCount: activoFijoInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def activoFijoInstance = ActivoFijo.get(params.id)
            if (!activoFijoInstance) {
                notFound_ajax()
                return
            }
            return [activoFijoInstance: activoFijoInstance, params: params]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def activoFijoInstance = new ActivoFijo(params)
        if (params.id) {
            activoFijoInstance = ActivoFijo.get(params.id)
            if (!activoFijoInstance) {
                notFound_ajax()
                return
            }
        }

//        if (params.proceso.id) {
//            def activos = ActivoFijo.findAllByProceso(Proceso.get(params.proceso.id))
//            if (activos.size() == 1) {
//                activoFijoInstance = activos.first()
//            } else if (activos.size() > 0) {
//                println "Hay mas de un activo fijo para este proceso!!! ${activos.id}"
//                activoFijoInstance = activos.first()
//            }
//        }
        return [activoFijoInstance: activoFijoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        params.each { k, v ->
            if (v != "date.struct" && v instanceof java.lang.String) {
                params[k] = v.toUpperCase()
            }
        }

        params.empresa = session.empresa
        params.estado = 'A'

        def activoFijoInstance = new ActivoFijo()
        if (params.id) {
            activoFijoInstance = ActivoFijo.get(params.id)
            if (!activoFijoInstance) {
                notFound_ajax()
                return
            }
        } //update
        activoFijoInstance.properties = params
        if (!activoFijoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} ActivoFijo."
            msg += renderErrors(bean: activoFijoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de ActivoFijo exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def activoFijoInstance = ActivoFijo.get(params.id)
            if (activoFijoInstance) {
                try {
                    activoFijoInstance.delete(flush: true)
                    render "OK_Eliminación de ActivoFijo exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar ActivoFijo."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró ActivoFijo."
    } //notFound para ajax
}
