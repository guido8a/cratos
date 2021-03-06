package cratos

import cratos.sri.TipoIdentificacion
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
            flash.tipo = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Proveedor creado"
            flash.tipo = "success"
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
            flash.tipo = "error"
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
            flash.tipo = "error"
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
            flash.tipo = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            proveedorInstance.delete(flush: true)
            flash.message = "Proveedor  con id " + params.id + " eliminado"
            flash.tipo = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Proveedor con id " + params.id
            flash.tipo = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }


    def validarCedula_ajax() {
        println("params " + params)
        params.ruc = params.ruc.toString().trim()
        if (params.id) {
            def prov = Proveedor.get(params.id)
            if (prov.ruc.trim() == params.ruc.trim()) {
                render true
                return
            } else {
                render Proveedor.countByRuc(params.ruc) == 0
                return
            }
        } else {
            render Proveedor.countByEmpresaAndRuc(session.empresa, params.ruc) == 0
            return
        }
    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
//        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
//        def proveedorInstanceList = Proveedor.findAllByEmpresa(session.empresa, params).sort{it.nombre}
//        def proveedorInstanceCount = Proveedor.countByEmpresa(session.empresa)
//        if (proveedorInstanceList.size() == 0 && params.offset && params.max) {
//            params.offset = params.offset - params.max
//        }
//        proveedorInstanceList = Proveedor.findAllByEmpresa(session.empresa, params).sort{it.nombre}
//        return [proveedorInstanceList: proveedorInstanceList, proveedorInstanceCount: proveedorInstanceCount]

        def empresa = Empresa.get(session.empresa.id)
        def proveedores = Proveedor.withCriteria {
            eq("empresa",empresa)
            tipoRelacion{
                or{
                    eq("codigo","P")
                    eq("codigo","E")
                }
            }
            order("nombre","asc")
        }


        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def proveedorInstanceCount = proveedores.count {it.id}
        if (proveedores.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }

        return[proveedores: proveedores, proveedorInstanceCount: proveedorInstanceCount]
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
//        println("params " + params)
        def proveedorInstance = new Proveedor(params)
        if (params.id) {
            proveedorInstance = Proveedor.get(params.id)
            if (!proveedorInstance) {
                notFound_ajax()
                return
            }
        }


        def countries = [] as SortedSet

        Locale.availableLocales*.displayCountry.each {
            if (it) {
                countries << it
            }
        }

        def soloLectura = false

        if(params.edi){
            soloLectura = params.edi
        }

        def tipoIdentificacion = TipoIdentificacion.withCriteria {
            ne("codigo","T")

        }

        return [proveedorInstance: proveedorInstance, paises: countries, lectura: soloLectura, tipoIdentificacion: tipoIdentificacion]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
//        println "params:" + params
        def persona
        //original
        def proveedorInstance = new Proveedor()
        if (params.id) {
            proveedorInstance = Proveedor.get(params.id)
            proveedorInstance.properties = params
            proveedorInstance.pais = params."pais.id"
            if (!proveedorInstance) {
                notFound_ajax()
                return
            }
        } else {
            proveedorInstance = new Proveedor()
            proveedorInstance.properties = params
            proveedorInstance.empresa = session.empresa
            proveedorInstance.pais = params."pais.id"
        } //update

        try{
            proveedorInstance.save(flush: true)
//            def mnsj = "OK_${proveedorInstance.refresh().id}"
            def mnsj = "OK_Proveedor creador correctamente"
            render mnsj
        }catch (e){
            render "NO_Error al crear el proveedor"
            println "error al guardar proveedor $e, $proveedorInstance.errors"
        }
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


    def tipoPersona_ajax () {
        def lista
        def proveedorInstance
        if(params.id){
            proveedorInstance = Proveedor.get(params.id)
        }

        if(params.tipo == '2' || params.tipo == '3'){
            lista = TipoPersona.withCriteria {
                ne("codigo","J")
            }
        }else{
            lista = TipoPersona.list()
        }

        return[lista: lista, proveedorInstance: proveedorInstance]
    }

    def ruc_ajax () {
        def proveedorInstance
        def lectura
        def longitud
        if(params.id){
            lectura = true
            proveedorInstance = Proveedor.get(params.id)
        }else{
            lectura = false
        }

        if(params.tipo == '2'){
            longitud = 10
        }else{
            longitud = 13
        }

        return[proveedorInstance: proveedorInstance, lectura: lectura, longitud: longitud.toInteger()]
    }

    def clientesList () {
        def empresa = Empresa.get(session.empresa.id)
        def clientes = Proveedor.withCriteria {
            eq("empresa",empresa)
            tipoRelacion{
                or{
                    eq("codigo","C")
                    eq("codigo","E")
                }
            }
            order("nombre","asc")
        }

        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def clienteCount = clientes.count {it.id}
        if (clientes.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }


//        println("clientes " + clientes)
        return[clientes: clientes, clienteCount: clienteCount]
    }

    def proveedor (){

    }

    def tablaProveedor_ajax(){
//        println("params " + params)
        def empresa = Empresa.get(session.empresa.id)
        def tipoRel = null
        
        if(params.tipo != '0'){
           tipoRel = TipoRelacion.get(params.tipo) 
        }

        def proveedores = Proveedor.withCriteria {
            eq("empresa",empresa)

            if(params.tipo != '0'){
                eq("tipoRelacion",tipoRel)
            }

            and{
                ilike("ruc", "%" + params.ruc + "%")
                ilike("nombre", "%" + params.nombre + "%")
            }

            order("nombre", "asc")
        }

//        println("pro " + proveedores)

        return[proveedores: proveedores]

    }
}
