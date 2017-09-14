package cratos

import cratos.inventario.Bodega
import cratos.inventario.CentroCosto
import cratos.inventario.DepartamentoItem
import cratos.inventario.DetalleFactura
import cratos.inventario.Item
import cratos.inventario.SubgrupoItems
import org.springframework.dao.DataIntegrityViolationException

class DetalleFacturaController extends cratos.seguridad.Shield  {

    def dbConnectionService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [detalleFacturaInstanceList: DetalleFactura.list(params), detalleFacturaInstanceTotal: DetalleFactura.count()]
    }

    def create() {
        [detalleFacturaInstance: new DetalleFactura(params)]
    }

    def save() {
        def detalleFacturaInstance = new DetalleFactura(params)

        if (params.id) {
            detalleFacturaInstance = DetalleFactura.get(params.id)
            detalleFacturaInstance.properties = params
        }

        if (!detalleFacturaInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [detalleFacturaInstance: detalleFacturaInstance])
            } else {
                render(view: "create", model: [detalleFacturaInstance: detalleFacturaInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "DetalleFactura actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "DetalleFactura creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: detalleFacturaInstance.id)
    }

    def show() {
        def detalleFacturaInstance = DetalleFactura.get(params.id)
        if (!detalleFacturaInstance) {
            flash.message = "No se encontró DetalleFactura con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [detalleFacturaInstance: detalleFacturaInstance]
    }

    def edit() {
        def detalleFacturaInstance = DetalleFactura.get(params.id)
        if (!detalleFacturaInstance) {
            flash.message = "No se encontró DetalleFactura con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [detalleFacturaInstance: detalleFacturaInstance]
    }

    def delete() {
        def detalleFacturaInstance = DetalleFactura.get(params.id)
        if (!detalleFacturaInstance) {
            flash.message = "No se encontró DetalleFactura con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            detalleFacturaInstance.delete(flush: true)
            flash.message = "DetalleFactura  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar DetalleFactura con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


    def  detalleGeneral (){
//        println("params " + params)
        def proceso = Proceso.get(params.id)
        def empresa = Empresa.get(session.empresa.id)
        def bodegas = Bodega.findAllByEmpresa(empresa).sort{it.descripcion}
        def centros = CentroCosto.findAllByEmpresa(empresa).sort{it.nombre}
        def detalles = DetalleFactura.findAllByProceso(proceso)
        def truncar

        if(proceso.estado == 'R'){
            truncar = true
        }else{
            truncar = false
        }

        return [proceso: proceso, bodegas: bodegas, centros: centros, truncar: truncar]
    }

    def buscarItems_ajax () {
        def proceso = Proceso.get(params.proceso)
        def bodega = Bodega.get(params.bodega)
        return [proceso: proceso, bodega: bodega]
    }

    def tablaItems_ajax () {
//        println("params " + params)
        def proceso = Proceso.get(params.proceso)
        def bodega = Bodega.get(params.bodega)

        def cn = dbConnectionService.getConnection()
        def sql
        if(params.nombre && params.codigo){
            sql = "select * from lsta_item('${proceso?.id}','${bodega?.id}') where itemcdgo ilike '${params.codigo}' and itemnmbr ilike '%${params.nombre}%' "
        }else if (params.nombre){
            sql = "select * from lsta_item('${proceso?.id}','${bodega?.id}') where itemnmbr ilike '%${params.nombre}%' "
        }else if(params.codigo){
            sql = "select * from lsta_item('${proceso?.id}','${bodega?.id}') where itemcdgo ilike '%${params.codigo}%' "
        }else{
            sql = "select * from lsta_item('${proceso?.id}','${bodega?.id}')"
        }
        def res = cn.rows(sql.toString())
//        println("res " + res)
//        println("sql " + sql)
        return[items: res, proceso: proceso]

    }

    def guardarDetalle_ajax () {
//        println("params " + params)
        def proceso = Proceso.get(params.proceso)
        def item = Item.get(params.item)
        def bodega = Bodega.get(params.bodega)
        def centroCostos = CentroCosto.get(params.centro)
        def especifico = DetalleFactura.findByProcesoAndItemAndBodegaAndCentroCosto(proceso,item,bodega,centroCostos)
        def detalle
        if(params.descuento == ''){
            params.descuento = 0
        }

        if(params.id){
            detalle = DetalleFactura.get(params.id)
//            detalle.descuento = params.descuento.toDouble()
            detalle.precioUnitario = params.precio.toDouble()
            detalle.centroCosto = centroCostos
            detalle.bodega = bodega
            detalle.cantidad = params.cantidad.toDouble()
        }else{
            if(especifico){
                detalle = DetalleFactura.get(especifico.id)
                detalle.cantidad = detalle.cantidad.toDouble() + params.cantidad.toDouble()
//                detalle.descuento = params.descuento.toDouble()
                detalle.precioUnitario = params.precio.toDouble()

            }else{
                detalle = new DetalleFactura()
                detalle.proceso = proceso
                detalle.item = item
//                detalle.descuento = params.descuento.toDouble()
                detalle.precioUnitario = params.precio.toDouble()
                detalle.centroCosto = centroCostos
                detalle.bodega = bodega
                detalle.cantidad = params.cantidad.toDouble()
            }
        }

//        println("tipo " + proceso.tipoProceso.codigo)

        switch (proceso.tipoProceso.codigo.trim()){
            case 'C':
                detalle.descuento = params.descuento.toDouble()
                break
            case 'V':
                detalle.descuento = params.descuento.toDouble()
                break
            case "T":
                detalle.descuento = 0
                break
            case 'NC':
                detalle.descuento = params.descuento.toDouble()
                break
        }

        try{
            detalle.save(flush: true)
            render "ok"
        }catch (e){
            println("error al grabar item " + e)
            render "no"
        }

    }

    def tablaDetalle_ajax() {
        def cn = dbConnectionService.getConnection()
        def proceso = Proceso.get(params.proceso)
        def detalles = DetalleFactura.findAllByProceso(proceso).sort{it?.item?.codigo}
        def totl = cn.rows("select * from total_detalle(${params.proceso},0,0)".toString())[0]
        def truncar
        if(detalles && proceso.estado == 'R'){
            truncar = true
        }else{
            truncar = false
        }
        return[detalles: detalles, totl: totl, truncar: truncar]
    }

    def cargarEdicion_ajax () {
        def detalle = DetalleFactura.get(params.detalle)

        render detalle.id + "_" + detalle.item.codigo + "_" + detalle.item.nombre + "_" + detalle.precioUnitario + "_" + detalle.cantidad.toInteger() + "_" + detalle.descuento + "_" + detalle.bodega.id + "_" + detalle.centroCosto.id + "_" + detalle.item.id
    }

    def borrarItemDetalle_ajax () {
        def detalle = DetalleFactura.get(params.detalle)

        try{
           detalle.delete(flush: true)
            render "ok"
        }catch (e){
           println("error al borrar el detalle " + e)
            render "no"
        }
    }

    def verificarDetalle_ajax () {
        println("params " + params)
        def proceso = Proceso.get(params.proceso)
        def detalles = DetalleFactura.findAllByProceso(proceso)
        def band

        if(detalles){
            band = true
        }else{
            band = false
        }

        render band
    }
}
