package cratos

class PagosController extends cratos.seguridad.Shield {

    def dbConnectionService

    def conciliacionBancaria() {
        def padreBancos = Cuenta.get(5018)
        def padrePagos = Cuenta.get(5026)
        def padreCobros = Cuenta.get(4984)
        def empresa = Empresa.get(session.empresa.id)
        def cuentasBancos = Cuenta.findAllByEmpresaAndPadre(empresa,padreBancos).sort{it.descripcion}
        def cuentasPagar = Cuenta.findAllByEmpresaAndPadre(empresa, padrePagos).sort{it.descripcion}
        def cuentasCobrar = Cuenta.findAllByEmpresaAndPadre(empresa, padreCobros).sort{it.descripcion}

        return [bancos: cuentasBancos, pagos: cuentasPagar, cobros: cuentasCobrar]
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

        return[res: res, pago: cp, transferencia: ct, credito: cnc, debito: cnd]
    }


}