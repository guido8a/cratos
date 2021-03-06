package cratos

class PagosController extends cratos.seguridad.Shield {

    def dbConnectionService

    def conciliacionBancaria() {
        def empresa = Empresa.get(session.empresa.id)
        def contabilidad = Contabilidad.get(session.contabilidad.id)

        def padreBancos = Cuenta.get(contabilidad?.bancos?.id)
        def padrePagos = Cuenta.get(contabilidad?.porPagar?.id)
        def padreCobros = Cuenta.get(contabilidad?.porCobrar?.id)

        def cuentasBancos = Cuenta.findAllByEmpresaAndPadre(empresa,padreBancos).sort{it.descripcion}
        def cuentasPagar =  Cuenta.findAllByEmpresaAndPadre(empresa, padrePagos).sort{it.descripcion}
        def cuentasCobrar = Cuenta.findAllByEmpresaAndPadre(empresa, padreCobros).sort{it.descripcion}

        return [bancos: cuentasBancos, pagos: cuentasPagar, cobros: cuentasCobrar, pb: padreBancos, pp: padrePagos, pc: padreCobros]
    }

    def conciliacion_ajax () {

//        println("params " + params)

        def empresa = Empresa.get(session.empresa.id)
        def contabilidad = Contabilidad.get(session.contabilidad.id)

        def desde = new Date().parse("dd-MM-yyyy", params.desde)
        def hasta = new Date().parse("dd-MM-yyyy", params.hasta)

        def cn = dbConnectionService.getConnection()
        def sql = "select * from conciliacion(${empresa?.id},${contabilidad?.id}, ${params.bancaria}, ${params.pago}, ${params.cobro}, '${params.desde}', '${params.hasta}')"
//        println("sql " + sql)
        def res =  cn.rows(sql.toString())
        def cp = res.count{it.tpps == 'P'}
        def ct = res.count{it.tpps == 'T'}
        def cnc = res.count{it.tpps == 'NC'}
        def cnd = res.count{it.tpps == 'ND'}
//        println("cp " + cp)
//        println("ct " + ct)
//        println("cnc " + cnc)
//        println("cnd " + cnd)

        def girados = 0
        def estadoCuenta = 0
        def suma = 0

        res.each {
            girados += it.sldopndt
            estadoCuenta += it.sldobnco
        }

        suma = girados + estadoCuenta

        return[res: res, pago: cp, transferencia: ct, credito: cnc, debito: cnd, girados: girados, suma: suma]
    }

    def guardarConciliacion_ajax () {
//        println("params " + params)

        def auxiliar = Auxiliar.get(params.aux)
        def fechaRegistro = new Date();

        if(params.valor == 'true'){
            auxiliar.fechaRecepcionPago = fechaRegistro
            auxiliar.pagado = 'S'
        }else{
            auxiliar.fechaRecepcionPago = null
            auxiliar.pagado = 'N'
        }

        try{
            auxiliar.save(flush: true)
            render "ok"
        }catch (e){
            println("error al marcar el pago en conciliacion bancaria")
            render "no"
        }

    }


}