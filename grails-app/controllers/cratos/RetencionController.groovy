package cratos

class RetencionController {
    def dbConnectionService

    def registrar() {
//        println "registrar: ${params}"
        def cn = dbConnectionService.getConnection()
        def cont = Contabilidad.get(session.contabilidad.id)
        def rtcn = Retencion.get(params.id)
        def compra = Comprobante.findByProceso(rtcn.proceso)
        def cmpr = new Comprobante()
        def sql = "select max(cmprnmro) mxmo from cmpr where cont__id = ${cont.id} and cmpr.tpcp__id = 3"
        def nmro = cn.rows(sql.toString())[0].mxmo

        sql = "select asnt.cnta__id from asnt, cnta where asnt.cnta__id = cnta.cnta__id and " +
                "cmpr__id = ${compra.id} and cntadscr ilike '%proveedo%'"
        def cuenta = cn.rows(sql.toString())[0].cnta__id
        def pxp = Cuenta.get(cuenta)
        def asiento = 1

//        println "nmro: $nmro hayRenta: ${rtcn.hayRenta}, hay iva: ${rtcn.hayIva}"

        cmpr.descripcion = "Retención en Compras"
        cmpr.tipo = TipoComprobante.findByCodigo('R')
        cmpr.proceso = rtcn.proceso
        cmpr.numero = nmro + 1
        cmpr.fecha = rtcn.proceso.fechaIngresoSistema
        cmpr.registrado = 'N'
        cmpr.factura = rtcn.numeroComprobante
        cmpr.prefijo = 'R'
        cmpr.fecha = new Date()
        cmpr.contabilidad = cont

        if (cmpr.save(flush: true)) {
            grabaAsiento(cmpr, pxp, asiento, rtcn.total, 0)
            asiento++
            if (rtcn.hayIva) {
                grabaAsiento(cmpr, cont.retencionCompraIva, asiento, 0, rtcn.ivaBienes + rtcn.ivaServicios)
                asiento++
            }
            if (rtcn.hayRenta) {
                grabaAsiento(cmpr, cont.retencionCompraRenta, asiento, 0, rtcn.renta + rtcn.rentaServicios)
            }
            rtcn.estado = 'S'
            rtcn.save(flush: true)
        }
        render "ok"
    }

    def grabaAsiento(cmpr, cnta, nmro, debe, hber) {
        def asnt = new Asiento()
        asnt.comprobante = cmpr
        asnt.cuenta = cnta
        asnt.debe = debe
        asnt.haber = hber
        asnt.numero = nmro
        asnt.save(flush: true)
    }

    def registrarRetVentas () {
        println "registrarVentas: ${params}"
        def cn = dbConnectionService.getConnection()
        def cont = Contabilidad.get(session.contabilidad.id)
        def prcs = Proceso.get(params.id)
        def venta = Comprobante.findByProceso(prcs)
        def cmpr = new Comprobante()
        def sql = "select max(cmprnmro) mxmo from cmpr where cont__id = ${cont.id} and cmpr.tpcp__id = 3"
        def nmro = cn.rows(sql.toString())[0].mxmo

        sql = "select asnt.cnta__id from asnt, cnta where asnt.cnta__id = cnta.cnta__id and " +
                "cmpr__id = ${venta.id} and cntadscr ilike '%cliente%'"
        def cuenta = cn.rows(sql.toString())[0].cnta__id
        def cxc = Cuenta.get(cuenta)
        def asiento = 1

//        println "nmro: $nmro hayRenta: ${rtcn.hayRenta}, hay iva: ${rtcn.hayIva}"

        cmpr.descripcion = "Retención en Ventas"
        cmpr.tipo = TipoComprobante.findByCodigo('R')
        cmpr.proceso = prcs
        cmpr.numero = nmro + 1
        cmpr.fecha = prcs.fechaIngresoSistema
        cmpr.registrado = 'N'
        cmpr.factura = prcs.documento
        cmpr.prefijo = 'R'
        cmpr.fecha = new Date()
        cmpr.contabilidad = cont

        if (cmpr.save(flush: true)) {
            grabaAsiento(cmpr, cxc, asiento, 0, prcs.retenidoIva + prcs.retenidoRenta)
            asiento++
            if (prcs.retenidoIva) {
                grabaAsiento(cmpr, cont.creditoTributarioIva, asiento, prcs.retenidoIva, 0)
                asiento++
            }
            if (prcs.retenidoRenta) {
                grabaAsiento(cmpr, cont.creditoTributarioRenta, asiento, prcs.retenidoRenta, 0)
            }
            prcs.retEstado = 'S'
            prcs.save(flush: true)
        }
        render "ok"
    }
}
