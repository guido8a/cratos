package cratos

import cratos.seguridad.Persona
import org.springframework.dao.DataIntegrityViolationException

class ContabilidadController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def utilitarioService

    def cambiar() {
        def yo = Persona.get(session.usuario.id)
        def cont = Contabilidad.get(session.contabilidad.id)
        def empresa = Empresa.get(session.empresa.id)

        def contabilidades = Contabilidad.findAllByInstitucion(empresa, [sort: "fechaInicio"])
        contabilidades.remove(cont)

        return [yo: yo, cont: cont, contabilidades: contabilidades]
    }

    def cambiarContabilidad() {
        def contabilidad = Contabilidad.get(params.contabilidad)
        session.contabilidad = contabilidad
        redirect(action: 'cambiar')
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def contabilidadInstanceList = Contabilidad.findAllByInstitucion(session.empresa, params)
        def contabilidadInstanceCount = Contabilidad.count()
        if (contabilidadInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        contabilidadInstanceList = Contabilidad.findAllByInstitucion(session.empresa, params)
        return [contabilidadInstanceList: contabilidadInstanceList, contabilidadInstanceCount: contabilidadInstanceCount]
    } //list

    def show_ajax() {
        if (params.id) {
            def contabilidadInstance = Contabilidad.get(params.id)
            if (!contabilidadInstance) {
                notFound_ajax()
                return
            }
            return [contabilidadInstance: contabilidadInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def contabilidadInstance = new Contabilidad(params)
        if (params.id) {
            contabilidadInstance = Contabilidad.get(params.id)
            if (!contabilidadInstance) {
                notFound_ajax()
                return
            }
        }
        return [contabilidadInstance: contabilidadInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {

        params.each { k, v ->
            if (v != "date.struct" && v instanceof java.lang.String) {
                params[k] = v.toUpperCase()
            }
        }

        params.institucion = session.empresa

        def contabilidadInstance = new Contabilidad()
        if (params.id) {
            contabilidadInstance = Contabilidad.get(params.id)
            if (!contabilidadInstance) {
                notFound_ajax()
                return
            }
        } //update

        if (params.anio) {
            params.fechaInicio = new Date().parse("dd-MM-yyyy", '01-01-' + params.anio)
            params.fechaCierre = new Date().parse("dd-MM-yyyy", '31-12-' + params.anio)
        }
        contabilidadInstance.properties = params
        contabilidadInstance.presupuesto = contabilidadInstance.fechaInicio

        if (!contabilidadInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Contabilidad."
            msg += renderErrors(bean: contabilidadInstance)
            render msg
            return
        }

        if (Periodo.countByContabilidad(contabilidadInstance) == 0) {
            12.times {
                def ini = new Date().parse("dd-MM-yyyy", "01-" + ((it + 1).toString().padLeft(2, '0')) + "-" + contabilidadInstance.fechaInicio.format("yyyy"))
                def fin = utilitarioService.getLastDayOfMonth(ini)
                def periodoInstance = new Periodo()

                if (periodoInstance.save(flush: true)) {

                    periodoInstance.contabilidad = contabilidadInstance
                    periodoInstance.fechaInicio = ini
                    periodoInstance.fechaFin = fin
                    periodoInstance.numero = it + 1
                } else {

                    render "Error al grabar períodos"
                }
            }
        }

        render "OK_${params.id ? 'Actualización' : 'Creación'} de Contabilidad exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def contabilidadInstance = Contabilidad.get(params.id)
            if (contabilidadInstance) {
                try {
                    contabilidadInstance.delete(flush: true)
                    render "OK_Eliminación de Contabilidad exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Contabilidad."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Contabilidad."
    } //notFound para ajax

    /* ******************** COPIADO HASTA AQUI ********************************************* */


    def index() {
        redirect(action: "list", params: params)
    }

//    def list() {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        [contabilidadInstanceList: Contabilidad.list(params), contabilidadInstanceTotal: Contabilidad.count()]
//    }

    def create() {
        [contabilidadInstance: new Contabilidad(params)]
    }

    def save() {

        if (params.fechaInicio) {
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        }
        if (params.fechaCierre) {
            params.fechaCierre = new Date().parse("dd-MM-yyyy", params.fechaCierre)
        }
        if (params.presupuesto) {
            params.presupuesto = new Date().parse("dd-MM-yyyy", params.presupuesto)
        }

        def contabilidadInstance = new Contabilidad(params)

        if (params.id) {
            contabilidadInstance = Contabilidad.get(params.id)
            contabilidadInstance.properties = params
        }

        if (!contabilidadInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [contabilidadInstance: contabilidadInstance])
            } else {
                render(view: "create", model: [contabilidadInstance: contabilidadInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Contabilidad actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Contabilidad creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }

        12.times {
            def ini = new Date().parse("dd-MM-yyyy", "01-" + ((it + 1).toString().padLeft(2, '0')) + "-" + contabilidadInstance.fechaInicio.format("yyyy"))
            def fin = utilitarioService.getLastDayOfMonth(ini)
            def periodoInstance = new Periodo()

            if (periodoInstance.save(flush: true)) {

                periodoInstance.contabilidad = contabilidadInstance
                periodoInstance.fechaInicio = ini
                periodoInstance.fechaFin = fin
                periodoInstance.numero = it + 1
            } else {

                render "Error al grabar períodos"
            }
        }

        redirect(action: "show", id: contabilidadInstance.id)
    }

    def show() {
        def contabilidadInstance = Contabilidad.get(params.id)
        if (!contabilidadInstance) {
            flash.message = "No se encontró Contabilidad con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [contabilidadInstance: contabilidadInstance]
    }

    def edit() {
        def contabilidadInstance = Contabilidad.get(params.id)
        if (!contabilidadInstance) {
            flash.message = "No se encontró Contabilidad con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [contabilidadInstance: contabilidadInstance]
    }

    def delete() {
        def contabilidadInstance = Contabilidad.get(params.id)
        if (!contabilidadInstance) {
            flash.message = "No se encontró Contabilidad con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            contabilidadInstance.delete(flush: true)
            flash.message = "Contabilidad  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Contabilidad con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


}
