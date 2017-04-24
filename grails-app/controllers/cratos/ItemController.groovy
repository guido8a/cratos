package cratos

import org.springframework.dao.DataIntegrityViolationException

class ItemController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def updatePrecio() {
        println params
        def item = Item.get(params.id)
        def precio = (params.precio).toDouble()

        item.precioCosto = precio

        if (item.save(flush: true)) {
            render "Precio actualizado exitosamente_info_Mensaje"
        } else {
            render "Ha ocurrido un error al actualizar el precio_alert_Error"
        }
    }

    def index() {
        redirect(action: "create", params: params)
    }


    def create() {
        [itemInstance: new Item(params)]
    }

    def buscarItem() {
        def search = params.search

        def iva = ParametrosAuxiliares.get(1).iva
//        println "from Item where upper(nombre) like '%${search.toUpperCase()}%' and upper(codigo) like '%${search.toUpperCase()}%' "
//        def results = Item.findAll("from Item where upper(nombre) like '%${search.toUpperCase()}%' or upper(codigo) like '%${search.toUpperCase()}%' ", [max: 20])

        def results = Item.withCriteria {
            eq("empresa", Empresa.get(session.empresa.id))
            or {
                ilike("nombre", "%" + search + "%")
                ilike("codigo", "%" + search + "%")
            }
            order("nombre", "asc")
            maxResults(20)
        }

        return [results: results, iva: iva]
    }

    def buscarItemOrdenCompra() {
        def search = params.search

        def iva = ParametrosAuxiliares.get(1).iva
//        println "from Item where upper(nombre) like '%${search.toUpperCase()}%' and upper(codigo) like '%${search.toUpperCase()}%' "
//        def results = Item.findAll("from Item where upper(nombre) like '%${search.toUpperCase()}%' or upper(codigo) like '%${search.toUpperCase()}%' ", [max: 20])

        def results = Item.withCriteria {
            eq("empresa", Empresa.get(session.empresa.id))
            or {
                ilike("nombre", "%" + search + "%")
                ilike("codigo", "%" + search + "%")
            }
            order("nombre", "asc")
            maxResults(20)
        }


        return [results: results, iva: iva]
    }

    def save() {

        params.empresa = Empresa.get(session.empresa.id)

        println("Items:" + params)


        def itemInstance = new Item()

        if (params.fecha) {

            itemInstance.fecha = new Date().parse("yyy-MM-dd", params.fecha)
            params.remove("fecha")


        }

        itemInstance.properties = params



        if (params.id) {

            itemInstance = Item.get(params.id)


            if (params.fecha) {

                itemInstance.fecha = new Date().parse("yyyy-MM-dd", params.fecha)
                params.remove("fecha")

            }

            itemInstance.properties = params
        }


        itemInstance.estado = params.estado

        if (!itemInstance.save(flush: true)) {
            println(itemInstance.errors)
            if (params.id) {
                render(view: "edit", model: [itemInstance: itemInstance])
            } else {
                render(view: "create", model: [itemInstance: itemInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Item actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Item creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: itemInstance.id)
    }

    def show() {
        def itemInstance = Item.get(params.id)
        if (!itemInstance) {
            flash.message = "No se encontró Item con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [itemInstance: itemInstance]
    }

    def edit() {
        def itemInstance = Item.get(params.id)
        if (!itemInstance) {
            flash.message = "No se encontró Item con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [itemInstance: itemInstance]
    }

    def delete() {
        def itemInstance = Item.get(params.id)
        if (!itemInstance) {
            flash.message = "No se encontró Item con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            itemInstance.delete(flush: true)
            flash.message = "Item  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Item con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }




    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def itemInstanceList = Item.list(params)
        def itemInstanceCount = Item.count()
        if (itemInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        itemInstanceList = Item.list(params)
        return [itemInstanceList: itemInstanceList, itemInstanceCount: itemInstanceCount]
    } //list

    def show_ajax() {
        if (params.id) {
            def itemInstance = Item.get(params.id)
            if (!itemInstance) {
                notFound_ajax()
                return
            }
            return [itemInstance: itemInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def itemInstance = new Item(params)
        if (params.id) {
            itemInstance = Item.get(params.id)
            if (!itemInstance) {
                notFound_ajax()
                return
            }
        }
        return [itemInstance: itemInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {

//        params.each { k, v ->
//            if (v != "date.struct" && v instanceof java.lang.String) {
//                params[k] = v.toUpperCase()
//            }
//        }

        def itemInstance = new Item()
        if (params.id) {
            itemInstance = Item.get(params.id)
            if (!itemInstance) {
                notFound_ajax()
                return
            }
        } //update

        itemInstance.properties = params

        if (!itemInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Item."
            msg += renderErrors(bean: itemInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Item exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def itemInstance = Item.get(params.id)
            if (itemInstance) {
                try {
                    itemInstance.delete(flush: true)
                    render "OK_Eliminación de Item exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Item."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Item."
    } //notFound para ajax
    
    
}
