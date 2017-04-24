package cratos

import org.springframework.dao.DataIntegrityViolationException

class ProveedorController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def buscarCedula() {
        def ci = params.ci
        def personas = Proveedor.findAllByRuc(ci)
        def str = ""
        println(personas)
        println(ci)

        if (personas.size() == 1) {

            def p = personas[0]
            str += (p.nombreContacto ?: "") + "&" + (p.apellidoContacto ?: "") + "&" + (p.direccion ?: "") + "&" + ""
            render("OK&" + str)
        } else if (personas.size() > 1) {
            render("NO&Existe más de un cliente con esa cédula o RUC")
        } else {
            render("NO&No existe un cliente con esa cédula o RUC")
        }


    }

    def index() {
        redirect(action: "list", params: params)
    }


    def create() {
        [proveedorInstance: new Proveedor(params)]
    }

    def save() {
        def proveedorInstance
        def ci = params.ruc

        def persona

        //save

        if (params.fecha) {

            params.fecha = new Date().parse("yyyy-MM-dd", params.fecha)

        }
        if (params.fechaCaducidad) {

            params.fechaCaducidad = new Date().parse("yyyy-MM-dd", params.fechaCaducidad)

        }


        if (params.id) {

            proveedorInstance = Proveedor.get(params.id)
            proveedorInstance.properties = params


        } else {
            proveedorInstance = new Proveedor()
            proveedorInstance.properties = params
            proveedorInstance.estado = '1'
            proveedorInstance.empresa = session.empresa
        }


        if (!proveedorInstance.save(flush: true)) {
            println proveedorInstance.errors

            return
        }

        if (params.id) {
            flash.message = "Proveedor actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Proveedor creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
//            redirect(action: "show", id: proveedorInstance.id)
        render "OK"



        println("per:" + persona)

    }

    def show() {
        def proveedorInstance = Proveedor.get(params.id)
        if (!proveedorInstance) {
            flash.message = "No se encontró Proveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [proveedorInstance: proveedorInstance]
    }

    def edit() {
        def proveedorInstance = Proveedor.get(params.id)
        if (!proveedorInstance) {
            flash.message = "No se encontró Proveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [proveedorInstance: proveedorInstance]
    }

    def delete() {
        def proveedorInstance = Proveedor.get(params.id)
        if (!proveedorInstance) {
            flash.message = "No se encontró Proveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            proveedorInstance.delete(flush: true)
            flash.message = "Proveedor  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Proveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


    def validarCedula_ajax() {
        params.ruc = params.ruc.toString().trim()
        if (params.id) {
            def prov = Proveedor.get(params.id)
            if (prov.ruc == params.ruc) {
                render true
                return
            } else {
                render Proveedor.countByRuc(params.ruc) == 0
                return
            }
        } else {
            render Proveedor.countByRuc(params.ruc) == 0
            return
        }
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def proveedorInstanceList = Proveedor.findAllByEmpresa(session.empresa, params)
        def proveedorInstanceCount = Proveedor.countByEmpresa(session.empresa)
        if (proveedorInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        proveedorInstanceList = Proveedor.findAllByEmpresa(session.empresa, params)
        return [proveedorInstanceList: proveedorInstanceList, proveedorInstanceCount: proveedorInstanceCount]
    } //list

    def show_ajax() {
        if (params.id) {
            def proveedorInstance = Proveedor.get(params.id)
            if (!proveedorInstance) {
                notFound_ajax()
                return
            }
            return [proveedorInstance: proveedorInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def proveedorInstance = new Proveedor(params)
        if (params.id) {
            proveedorInstance = Proveedor.get(params.id)
            if (!proveedorInstance) {
                notFound_ajax()
                return
            }
        }
        return [proveedorInstance: proveedorInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {

//        println("params:" + params)

//        params.each { k, v ->
//            if (v != "date.struct" && v instanceof java.lang.String) {
//                params[k] = v.toUpperCase()
//            }
//        }

        //nuevo

        def persona

//        if (params.fecha) {
//
//            params.fecha = new Date().parse("yyyy-MM-dd", params.fecha)
//
//        }
//        if (params.fechaCaducidad) {
//
//            params.fechaCaducidad = new Date().parse("yyyy-MM-dd", params.fechaCaducidad)
//
//        }

        //original
        def proveedorInstance = new Proveedor()
        if (params.id) {
            proveedorInstance = Proveedor.get(params.id)
            proveedorInstance.properties = params
            if (!proveedorInstance) {
                notFound_ajax()
                return
            }
        } else {

            proveedorInstance = new Proveedor()
            proveedorInstance.properties = params
//            proveedorInstance.estado = '1'
            proveedorInstance.empresa = session.empresa


        } //update


        if (!proveedorInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Proveedor."
            msg += renderErrors(bean: proveedorInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Proveedor exitosa."
    } //save para grabar desde ajax


    def delete_ajax() {
        if (params.id) {
            def proveedorInstance = Proveedor.get(params.id)
            if (proveedorInstance) {
                try {
                    proveedorInstance.delete(flush: true)
                    render "OK_Eliminación de Proveedor exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Proveedor."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Proveedor."
    } //notFound para ajax


}
