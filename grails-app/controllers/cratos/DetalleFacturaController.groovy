package cratos

import cratos.inventario.Bodega
import cratos.inventario.CentroCosto
import cratos.inventario.DepartamentoItem
import cratos.inventario.DetalleFactura
import cratos.inventario.Item
import cratos.inventario.SubgrupoItems
import org.springframework.dao.DataIntegrityViolationException

class DetalleFacturaController extends cratos.seguridad.Shield  {

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
        return [proceso: proceso, bodegas: bodegas, centros: centros]
    }

    def buscarItems_ajax () {
        def proceso = Proceso.get(params.proceso)
        return [proceso: proceso]
    }

    def tablaItems_ajax () {
        def proceso = Proceso.get(params.proceso)
        def detalles = DetalleFactura.findAllByProceso(proceso)
        def subgrupos = SubgrupoItems.findAllByEmpresa(proceso.empresa)
        def departamento = DepartamentoItem.findAllBySubgrupoInList(subgrupos)
//        def todos = Item.findAllByDepartamentoInList(departamento)
        def todos = Item.withCriteria {
            'in'("departamento",departamento)
            and{
                ilike("nombre", '%' + params.nombre + '%')
                ilike("codigo", '%' + params.codigo + '%')
            }
            order ("codigo","asc")
        }

        return[ items: todos, proceso: proceso]
    }

    def guardarDetalle_ajax () {
        println("params " + params)
        def proceso = Proceso.get(params.proceso)
        def item = Item.get(params.item)
        def bodega = Bodega.get(params.bodega)
        def centroCostos = CentroCosto.get(params.centro)
        def especifico = DetalleFactura.findByProcesoAndItemAndBodegaAndCentroCosto(proceso,item,bodega,centroCostos)
        def detalle
        if(params.descuento == ''){
            params.descuento = 0
        }

        println("tipo " + proceso.tipoProceso.codigo)

        switch (proceso.tipoProceso.codigo.trim()){
            case 'C':
                if(params.id){
                    println("entro id")
                    detalle = DetalleFactura.get(params.id)
                    detalle.descuento = params.descuento.toDouble()
                    detalle.precioUnitario = params.precio.toDouble()
                    detalle.centroCosto = centroCostos
                    detalle.bodega = bodega
                    detalle.cantidad = params.cantidad.toDouble()
                }else{
                    if(especifico){
                        println("entro especifico")
                        detalle = DetalleFactura.get(especifico.id)
                        detalle.cantidad = detalle.cantidad.toDouble() + params.cantidad.toDouble()
                        detalle.descuento = params.descuento.toDouble()
                        detalle.precioUnitario = params.precio.toDouble()

                    }else{
                        println("entro nuevo")
                        detalle = new DetalleFactura()
                        detalle.proceso = proceso
                        detalle.item = item
                        detalle.descuento = params.descuento.toDouble()
                        detalle.precioUnitario = params.precio.toDouble()
                        detalle.centroCosto = centroCostos
                        detalle.bodega = bodega
                        detalle.cantidad = params.cantidad.toDouble()
                    }
                }
                break

            case 'V':
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
        def proceso = Proceso.get(params.proceso)
        def detalles = DetalleFactura.findAllByProceso(proceso).sort{it?.item?.codigo}

        return[detalles: detalles]
    }

    def cargarEdicion_ajax () {
        def detalle = DetalleFactura.get(params.detalle)

        render detalle.id + "_" + detalle.item.codigo + "_" + detalle.item.nombre + "_" + detalle.precioUnitario + "_" + detalle.cantidad + "_" + detalle.descuento + "_" + detalle.bodega.id + "_" + detalle.centroCosto.id + "_" + detalle.item.id
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
}
