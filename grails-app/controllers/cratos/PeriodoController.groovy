package cratos

import org.springframework.dao.DataIntegrityViolationException

class PeriodoController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def contabilidad = Contabilidad.get(session.contabilidad.id)
        def periodos = Periodo.findAllByContabilidad(contabilidad)
        [periodoInstanceList: periodos, periodoInstanceTotal:periodos.size()]
    }

    def form_ajax() {
        def contabilidad = Contabilidad.get(session.contabilidad.id)
        def periodo

        if(params.id){
            periodo = Periodo.get(params.id)
        }else{
            periodo = new Periodo()
        }

        return [periodoInstance: periodo]
    }

    def create() {
        [periodoInstance: new Periodo(params)]
    }

    def save_ajax() {
        println "save periodo " + params

        def periodoInstance

        def contabilidad = Contabilidad.get(session.contabilidad.id)

        if (params.fechaCierre_input) {
            params.fechaFin = new Date().parse("dd-MM-yyyy", params.fechaCierre_input)
        }

        if (params.fechaInicio_input) {
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio_input)
        }


        if(params.fechaInicio_input && params.fechaCierre_input){

            if(params.fechaInicio < contabilidad.fechaInicio){
                render "er_La fecha de inicio ingresada es menor a la fecha de inicio de la contabilidad actual"
            }else{

                if(params.fechaFin > contabilidad.fechaCierre){
                    render "er_la fecha de fin ingresada es mayor a la fecha de cierre de la contabilidad actual"
                }else{

                    if(params.fechaInicio > params.fechaFin){
                        render "er_La fecha ingresada de inicio es mayor a la fecha de finalización"
                    }else{

                        if (params.id) {
                            periodoInstance = Periodo.get(params.id)
                        }else{
                            periodoInstance = new Periodo(params)
                            periodoInstance.contabilidad = contabilidad
                        }

                        periodoInstance.properties = params


                        if (!periodoInstance.save(flush: true)) {
                            render "no_Error al guardar el período"
                        }else{
                            render "ok_Período guardado correctamente"
                        }
                    }
                }
            }
        }else{
            render "no_Ingrese las fechas"
        }
    }


    def delete_ajax() {
        def periodoInstance = Periodo.get(params.id)

        if (!periodoInstance) {
            return true
        }

        try {
            periodoInstance.delete(flush: true)
            render "ok_Período borrado correctamente"
        }
        catch (e) {
            println("error al borrar el periodo " + e)
            render "no_Error al borrar el período "
        }
    }

    def revisarFecha_ajax() {
        println("params revisar fecha " + params)
        if(params.inicio && params.fin){
            def desde = new Date().parse("dd-MM-yyyy", params.inicio)
            def hasta = new Date().parse("dd-MM-yyyy", params.fin)

            if(desde > hasta){
                render "no"
            }else{
                render "ok"
            }
        }else{
            render "ok"
        }
    }
}
