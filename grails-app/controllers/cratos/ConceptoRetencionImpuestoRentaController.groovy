package cratos

import cratos.sri.ModalidadPago
import org.springframework.dao.DataIntegrityViolationException

class ConceptoRetencionImpuestoRentaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
//        def conceptoRetencionImpuestoRentaInstanceCount = ConceptoRetencionImpuestoRenta.list([sort: 'codigo', order: 'asc']).size()
        def conceptoRetencionImpuestoRentaInstanceCount
        def conceptoRetencionImpuestoRentaInstanceList
        conceptoRetencionImpuestoRentaInstanceList = ConceptoRetencionImpuestoRenta.list(params)
        conceptoRetencionImpuestoRentaInstanceCount = ConceptoRetencionImpuestoRenta.count()
        if (conceptoRetencionImpuestoRentaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        [conceptoRetencionImpuestoRentaInstanceList: ConceptoRetencionImpuestoRenta.list([sort: 'codigo', order: 'asc']), params: params, conceptoRetencionImpuestoRentaInstanceCount: conceptoRetencionImpuestoRentaInstanceCount]
    } //list

    def form_ajax() {
        def conceptoRetencionImpuestoRentaInstance = new ConceptoRetencionImpuestoRenta(params)
        if(params.id) {
            conceptoRetencionImpuestoRentaInstance = ConceptoRetencionImpuestoRenta.get(params.id)
            if(!conceptoRetencionImpuestoRentaInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Concepto Retencion Impuesto Renta con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [conceptoRetencionImpuestoRentaInstance: conceptoRetencionImpuestoRentaInstance]
    } //form_ajax

    def save() {
//        println("params " + params)
        def concepto
        def modalidadPago = ModalidadPago.get(params."modalidadPago.id")
        if(params.id){
            concepto = ConceptoRetencionImpuestoRenta.get(params.id)
        }else{
            concepto = new ConceptoRetencionImpuestoRenta()
        }

        concepto.descripcion = params.descripcion
        concepto.codigo = params.codigo.toUpperCase()
        concepto.porcentaje = params.porcentaje.toDouble()
        concepto.tipo = params.tipo.toUpperCase()
        concepto.modalidadPago = modalidadPago

        try{
            concepto.save(flush: true)
            render "OK"
        }catch (e){
            render "no"
            println("error al guardar el concepto IR " + e)
        }


    } //save

    def show_ajax() {
        def conceptoRetencionImpuestoRentaInstance = ConceptoRetencionImpuestoRenta.get(params.id)
        if (!conceptoRetencionImpuestoRentaInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Concepto Retencion Impuesto Renta con id " + params.id
            redirect(action: "list")
            return
        }
        [conceptoRetencionImpuestoRentaInstance: conceptoRetencionImpuestoRentaInstance]
    } //show

    def delete() {
        def concepto = ConceptoRetencionImpuestoRenta.get(params.id)

        try {
            concepto.delete(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("Error al borrar el concepto IR")
        }


    } //delete
} //fin controller
