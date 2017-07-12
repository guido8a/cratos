package cratos

import cratos.inventario.Bodega
import cratos.inventario.CentroCosto
import cratos.inventario.DetalleFactura
import cratos.inventario.Item
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
        println("params " + params)
        def proceso = Proceso.get(params.id)
        def empresa = Empresa.get(session.empresa.id)
        def bodegas = Bodega.findAllByEmpresa(empresa).sort{it.descripcion}
        def centros = CentroCosto.findAllByEmpresa(empresa).sort{it.nombre}
        return [proceso: proceso, bodegas: bodegas, centros: centros]
    }

    def buscarItems_ajax () {

    }

    def tablaItems_ajax () {
        def empresa = Empresa.get(session.empresa.id)
        println("empresa " + empresa)
        def items = Item.list()

        return[ items: items]
    }

}
