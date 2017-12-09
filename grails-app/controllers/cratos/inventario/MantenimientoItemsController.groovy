package cratos.inventario

import cratos.Empresa
import cratos.seguridad.Shield
import org.springframework.dao.DataIntegrityViolationException
import org.w3c.dom.Document
import sri.XAdESBESSignature

//import javax.swing.JFileChooser

//import sun.plugin.javascript.navig.Document

/*
import javax.xml.crypto.*
import javax.xml.crypto.dsig.*
import javax.xml.crypto.dsig.dom.DOMSignContext
import javax.xml.crypto.dsig.keyinfo.KeyInfo
import javax.xml.crypto.dsig.keyinfo.KeyInfoFactory
import javax.xml.crypto.dsig.keyinfo.KeyValue
import javax.xml.crypto.dsig.keyinfo.X509Data
import javax.xml.crypto.dsig.spec.C14NMethodParameterSpec
import javax.xml.crypto.dsig.spec.TransformParameterSpec
import javax.xml.parsers.DocumentBuilder
import javax.xml.parsers.DocumentBuilderFactory
import javax.xml.transform.Transformer
import javax.xml.transform.TransformerFactory
import javax.xml.transform.dom.DOMSource
import javax.xml.transform.stream.StreamResult
import java.security.KeyPair
import java.security.KeyPairGenerator
import java.security.KeyStore
import java.security.cert.Certificate
import java.text.DecimalFormat
*/




//import java.io.FileInputStream;
//import java.io.FileOutputStream;
import java.security.Key;
import java.security.KeyPair;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.UnrecoverableKeyException;
import java.security.cert.Certificate;
//import java.util.ArrayList;
//import java.util.Collections;

import javax.xml.crypto.dsig.CanonicalizationMethod;
import javax.xml.crypto.dsig.DigestMethod;
import javax.xml.crypto.dsig.Reference;
import javax.xml.crypto.dsig.SignatureMethod;
import javax.xml.crypto.dsig.SignedInfo;
import javax.xml.crypto.dsig.Transform;
import javax.xml.crypto.dsig.XMLSignature;
import javax.xml.crypto.dsig.XMLSignatureFactory;
import javax.xml.crypto.dsig.dom.DOMSignContext;
import javax.xml.crypto.dsig.keyinfo.KeyInfo;
import javax.xml.crypto.dsig.keyinfo.KeyInfoFactory;
import javax.xml.crypto.dsig.keyinfo.X509Data;
import javax.xml.crypto.dsig.spec.C14NMethodParameterSpec;
import javax.xml.crypto.dsig.spec.TransformParameterSpec;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;


class MantenimientoItemsController extends Shield {

    def dbConnectionService

    def index() {
        redirect(action: "registro", params: params)
    } //index

    String makeBasicTree(params) {
        println "makeBasicTree: $params"
        def empr = Empresa.get(session.empresa.id)
        def ids = params.id
        def id
        def tp
        def tipo = params.tipo
        def precios = params.precios
        def all = params.all ? params.all.toBoolean() : false
        def ignore = params.ignore ? params.ignore.toBoolean() : false
        String tree = "", clase = ""

        def hijos = []

//        println "ids: $ids"
        if (ids == "#") {
            //root
            def gr = params.tipo.split('_')[1].toInteger()
            def grupo = ['Materiales', 'Mano de Obra', 'Equipos']
            clase = "hasChildren jstree-closed"
            tree = "<li id='root' class='root ${clase}' data-jstree='{\"type\":\"root\"}' level='0' ><a href='#' class='label_arbol'>${grupo[gr-1]}</a></li>"
        } else if (ids == "root") {
            id = params.tipo.split('_')[1]
            tipo = params.tipo.split('_')[0]
        } else {
            id = ids.split('_')[1]
            tp = ids.split('_')[0]
        }

        if (tree == "" && id) {
//            println "....1  id: $id"
            switch (tipo) {
                case "grupo_manoObra":
                    hijos = DepartamentoItem.findAllBySubgrupo(SubgrupoItems.get(id), [sort: 'codigo'])
                    break;
                case "grupo":
                    hijos = SubgrupoItems.findAllByGrupoAndEmpresa(Grupo.get(id), empr, [sort: 'codigo'])
                    break;
                case "subgrupo_manoObra":
                    hijos = Item.findAllByDepartamento(DepartamentoItem.get(id), [sort: 'codigo'])
                    break;
                case "subgrupo_material":
                case "subgrupo_equipo":
                    hijos = DepartamentoItem.findAllBySubgrupo(SubgrupoItems.get(id), [sort: 'codigo'])
                    break;
                case "departamento_manoObra":
                case "departamento_material":
                case "departamento_equipo":
                    hijos = Item.findAllByDepartamento(DepartamentoItem.get(id), [sort: 'codigo'])
                    break;
                case "item_manoObra":
                case "item_material":
                case "item_equipo":
                    def tipoLista = Item.get(id).tipoLista
                    if (precios) {
                        if (ignore) {
                            hijos = ["Todos"]
                        } else {
                            hijos = []
                            if (tipoLista) {
                                hijos = Lugar.findAllByTipoLista(tipoLista)
                            }
                        }
                    }
                    break;
            }

            String rel = "", extra = ""
//            println "hijos ... " + hijos
            tree += "<ul>"
            hijos.each { hijo ->
                def hijosH, desc, liId
//                println "hijo:---- $hijo, tipo: $tipo"
                switch (tipo) {
                    case "grupo_manoObra":
                        hijosH = Item.findAllByDepartamento(hijo, [sort: 'codigo'])
                        desc = hijo.codigo.toString().padLeft(3, '0') + " " + hijo.descripcion
                        def parts = tipo.split("_")
                        rel = "departamento_" + parts[1]
                        liId = "dp" + "_" + hijo.id
                        break;
                    case "grupo_material":
                    case "grupo":
                        hijosH = DepartamentoItem.findAllBySubgrupo(hijo, [sort: 'codigo'])
                        desc = hijo.codigo.toString().padLeft(3, '0') + " " + hijo.descripcion
                        def parts = tipo.split("_")
//                    rel = "subgrupo_" + parts[1]
                        liId = "sg" + "_" + hijo.id
                        break;
                    case "subgrupo_manoObra":
                        break;
                    case "subgrupo_material":
                    case "subgrupo_equipo":
//                        println "....2"
                        def item
                        try {
                            item = Item.list()
//                            println "items: $item"
                        } catch (e) {
                            println "error: $e"
                        }

                        hijosH = Item.findAllByDepartamento(hijo, [sort: 'codigo'])
//                        println "codigo: ${hijo.subgrupo.codigo.toString()}"
//                        println "${hijo.subgrupo.codigo.toString().padLeft(3, '0')}, ${hijo.codigo.toString().padLeft(3, '0')}, ${hijo.descripcion}"
                        desc = hijo.subgrupo.codigo.toString().padLeft(3, '0') + '.' + hijo.codigo.toString().padLeft(3, '0') + " " + hijo.descripcion
                        def parts = tipo.split("_")
                        rel = "departamento_" + parts[1]
                        liId = "dp" + "_" + hijo.id
                        break;
                    case "departamento_manoObra":
                        hijosH = []
                        def tipoLista = hijo.tipoLista
                        if (precios) {
                            if (ignore) {
                                hijosH = ["Todos"]
                            } else {
                                if (tipoLista) {
                                    hijosH = Lugar.findAllByTipoLista(tipoLista)
                                }
                            }
                        }
                        desc = hijo.codigo + " " + hijo.nombre
                        def parts = tipo.split("_")
                        rel = "item_" + parts[1]
                        liId = "it" + "_" + hijo.id
                        break;
                    case "departamento_material":
                    case "departamento_equipo":
                        hijosH = []
                        def tipoLista // no hay
                        if (precios) {
                            if (ignore) {
                                hijosH = ["Todos"]
                            } else {
                                if (tipoLista) {
                                    hijosH = Lugar.findAllByTipoLista(tipoLista)
                                }
                            }
                        }
                        desc = hijo.codigo + " " + hijo.nombre
                        def parts = tipo.split("_")
                        rel = "item_" + parts[1]
                        liId = "it" + "_" + hijo.id
                        break;
                    case "item_manoObra":
                        hijosH = []
                        if (precios) {
                            hijosH = []
                            if (ignore) {
                                desc = "mo4  " + "Todos los lugares"
                                rel = "lugar_all"
                                liId = "lg_" + id + "_all"
                            } else {
                                if (all) {
                                    desc = hijo.descripcion + " (" + hijo.tipo + ")"
                                } else {
                                    desc = hijo.descripcion
                                }
                                rel = "lugar"
                                liId = "lg_" + id + "_" + hijo.id

                                def obras = Obra.countByLugar(hijo)
                                extra = "data-obras='${obras}'"
                            }
                        }
                        break;
                }

                if (!hijosH) {
                    hijosH = []
                }
                clase = (hijosH?.size() > 0) ? "jstree-closed hasChildren" : ""

                tree += "<li id='" + liId + "' class='" + clase + "' rel='" + rel + "' " + extra + " data-jstree='{\"type\":\"${tipo}\"}' >"
                tree += "<a href='#' class='label_arbol'>" + desc + "</a>"
                tree += "</li>"
            }
        }
        tree += "</ul>"
        return tree
    }


    def loadMO() {
        def hijos = SubgrupoItems.findAllByGrupo(Grupo.get(2), [sort: 'codigo'])
        def html = ""
        def open = ""
        hijos.eachWithIndex { h, i ->
            def hijosH = DepartamentoItem.findAllBySubgrupo(h, [sort: 'codigo'])
            def cl = ""
            if (hijosH.size() > 0) {
                cl = "hasChildren jstree-closed"
                open = "manoObra_${h.id}"
            }
            html += "<li id='manoObra_${h.id}' class='root ${cl}' rel='grupo_manoObra'>"
            html += "<a href='#' class='label_arbol'>"
            html += h.descripcion
            html += "</a>"
            html += "</li>"
        }
        render html + "*" + open
    }

    def loadTreePart() {
//        println "loadTreePart...."
        render(makeBasicTree(params))
    }

    def searchTree_ajax() {
        println "searchTree_ajax: $params"
//        def parts = params.search_string.split("~")
        def search = params.search.trim()
        if (search != "") {
            def id = params.tipo
            def find = Item.withCriteria {
                departamento {
                    subgrupo {
                        grupo {
                            eq("id", id.toLong())
                        }
                    }
                }
                ilike("nombre", "%" + search + "%")
            }
            def departamentos = [], subgrupos = [], grupos = []
            find.each { item ->
                if (!departamentos.contains(item.departamento))
                    departamentos.add(item.departamento)
                if (!subgrupos.contains(item.departamento.subgrupo))
                    subgrupos.add(item.departamento.subgrupo)
                if (!grupos.contains(item.departamento.subgrupo.grupo))
                    grupos.add(item.departamento.subgrupo.grupo)
            }

            def ids = "[1,2"

            if (find.size() > 0) {
                ids += "\"#materiales_1\","

                grupos.each { gr ->
                    ids += "\"#gr_" + gr.id + "\","
                }
                subgrupos.each { sg ->
                    ids += "\"#sg_" + sg.id + "\","
                }
                departamentos.each { dp ->
                    ids += "\"#dp_" + dp.id + "\","
                }
                ids = ids[0..-2]
            }
            ids += "]"

            render ids
        } else {
            render ""
        }
    }

    def search_ajax() {
        def search = params.search.trim()
        def id = params.tipo
        def find = Item.withCriteria {
            departamento {
                subgrupo {
                    grupo {
                        eq("id", id.toLong())
                    }
                }
            }
            ilike("nombre", "%" + search + "%")
        }
        def json = "["
        find.each { item ->
            if (json != "[") {
                json += ","
            }
            json += "\"" + item.nombre + "\""
        }
        json += "]"
        render json
    }

    def registro() {
        //<!--grpo--><!--sbgr -> Grupo--><!--dprt -> Subgrupo--><!--item-->
        //materiales = 1
        //mano de obra = 2
        //equipo = 3
    }

    def arbol() {
        //<!--grpo--><!--sbgr -> Grupo--><!--dprt -> Subgrupo--><!--item-->
        //materiales = 1
        //mano de obra = 2
        //equipo = 3
        def hh = Grupo.count()
        return [hh: hh]
    }

    def moveNode_ajax() {
//        println params

        def node = params.node
        def newParent = params.newParent

        def parts = node.split("_")
        def tipoNode = parts[0]
        def idNode = parts[1]

        parts = newParent.split("_")
        def tipoParent = parts[0]
        def idParent = parts[1]

        switch (tipoNode) {
            case "it":
                def item = Item.get(idNode.toLong())
                def departamento = DepartamentoItem.get(idParent.toLong())
                item.departamento = departamento

                def cod = item.codigo
                def codItem = cod.split("\\.")[2]
//                println "codigo anterior: " + cod
                cod = "" + item.departamento.subgrupo.codigo.toString().padLeft(3, '0') + "." + item.departamento.codigo.toString().padLeft(3, '0') + "." + codItem.toString().padLeft(3, '0')
//                println "codigo nuevo: " + cod

                if (item.save(flush: true)) {
                    def tipo
                    def a
                    switch (item.departamento.subgrupo.grupoId) {
                        case 1:
                            tipo = "Material"
                            a = "o"
                            break;
                        case 2:
                            tipo = "Mano de obra"
                            a = "a"
                            break;
                        case 3:
                            tipo = "Equipo"
                            a = "o"
                            break;
                    }
                    render "OK_" + tipo + " movid" + a + " correctamente"
                } else {
                    render "NO_Ha ocurrid un error al mover"
                }
                break;
            case "dp":
                def departamento = DepartamentoItem.get(idNode.toLong())
                def subgrupo = SubgrupoItems.get(idParent.toLong())
                departamento.subgrupo = subgrupo
                if (departamento.save(flush: true)) {
                    render "OK_Subgrupo movido correctamente"
                } else {
                    render "NO_Ha ocurrid un error al mover"
                }
                break;
            default:
                render "NO"
                break;
        }
    }

    def loadLugarPorTipo() {
        params.tipo = params.tipo.toString().toUpperCase()
        def lugares = Lugar.findAllByTipo(params.tipo, [sort: 'descripcion'])
        def sel = g.select(name: "lugar", from: lugares, optionKey: "id", optionValue: {
            it.descripcion + ' (' + it.tipo + ')'
        })
        render sel
    }

    def reportePreciosUI() {
        def lugares = Lugar.list()
        def grupo = Grupo.get(params.grupo)
        return [lugares: lugares, grupo: grupo]
    }

    def precios() {
        //rubro precio
    }

    def showGr_ajax() {
        def grupoInstance = Grupo.get(params.id)
        return [grupoInstance: grupoInstance]
    }

    def showSg_ajax() {
        def subgrupoItemsInstance = SubgrupoItems.get(params.id)
        return [subgrupoItemsInstance: subgrupoItemsInstance]
    }

    def formSg_ajax() {
        println "formSg_ajax $params"
        def grpo__id = params.padre ?: params.id
        def grupo = Grupo.get(SubgrupoItems.get(grpo__id).grupo.id)
        def subgrupoItemsInstance = new SubgrupoItems()
        if (params.id) {
            subgrupoItemsInstance = SubgrupoItems.get(params.id)
        }
        println "retorna... $grupo"
        return [grupo: grupo, subgrupoItemsInstance: subgrupoItemsInstance]
    }

    def checkDsSg_ajax() {
        println "checkDsSg_ajax $params"
        if (params.id) {
            def subgrupo = SubgrupoItems.get(params.id)
            if (params.descripcion == subgrupo.descripcion) {
                render true
            } else {
                def subgrupos = SubgrupoItems.findAllByDescripcion(params.descripcion)
                if (subgrupos.size() == 0) {
                    render true
                } else {
                    render false
                }
            }
        } else {
            def subgrupos = SubgrupoItems.findAllByDescripcion(params.descripcion)
            if (subgrupos.size() == 0) {
                render true
            } else {
                render false
            }
        }
    }

    def saveSg_ajax() {
        def accion = "create"
        def subgrupo = new SubgrupoItems()
        if (params.codigo) {
            params.codigo = params.codigo.toString().toUpperCase()
        }
//        if (params.descripcion) {
//            params.descripcion = params.descripcion.toString().toUpperCase()
//        }
        if (params.id) {
            subgrupo = SubgrupoItems.get(params.id)
            accion = "edit"
        } else {
            params.empresa = session.empresa.id
        }
        subgrupo.properties = params
        if (subgrupo.save(flush: true)) {
            render "OK_" + accion + "_" + subgrupo.id + "_" + subgrupo.codigo + " " + subgrupo.descripcion
        } else {
            def errores = g.renderErrors(bean: subgrupo)
            render "NO_" + errores
        }
    }

    def deleteSg_ajax() {
        def subgrupo = SubgrupoItems.get(params.id)
        try {
            subgrupo.delete(flush: true)
            render "OK"
        }
        catch (DataIntegrityViolationException e) {
            println "mantenimiento items controller l 524: " + e
            render "NO"
        }
    }

    def showDp_ajax() {
        def departamentoItemInstance = DepartamentoItem.get(params.id)
        return [departamentoItemInstance: departamentoItemInstance]
    }

    def formDp_ajax() {
        println "formDp_ajax: $params"
        def mos = []

        def subgrupo = SubgrupoItems.get(params.padre)
        def departamentoItemInstance = new DepartamentoItem()
        if (params.id) {
            departamentoItemInstance = DepartamentoItem.get(params.id)
        }
        println "sbgr: $subgrupo, dprt: $departamentoItemInstance"
        return [subgrupo: subgrupo, departamentoItemInstance: departamentoItemInstance, mos: mos]
    }

    def checkCdDp_ajax() {
//        println params
        if (params.id) {
            def departamento = DepartamentoItem.get(params.id)
//            println params.codigo
//            println params.codigo.class
//            println departamento.codigo
//            println departamento.codigo.class
            if (params.codigo == departamento.codigo.toString()) {
                render true
            } else {
                def departamentos = DepartamentoItem.findAllByCodigoAndSubgrupo(params.codigo, SubgrupoItems.get(params.sg))
                if (departamentos.size() == 0) {
                    render true
                } else {
                    render false
                }
            }
        } else {
            def departamentos = DepartamentoItem.findAllByCodigoAndSubgrupo(params.codigo, SubgrupoItems.get(params.sg))
            if (departamentos.size() == 0) {
                render true
            } else {
                render false
            }
        }
    }

    def checkDsDp_ajax() {
        if (params.id) {
            def departamento = DepartamentoItem.get(params.id)
            if (params.descripcion == departamento.descripcion) {
                render true
            } else {
                def departamentos = DepartamentoItem.findAllByDescripcion(params.descripcion)
                if (departamentos.size() == 0) {
                    render true
                } else {
                    render false
                }
            }
        } else {
            def departamentos = DepartamentoItem.findAllByDescripcion(params.descripcion)
            if (departamentos.size() == 0) {
                render true
            } else {
                render false
            }
        }
    }

    def saveDp_ajax() {
        println "save $params"
        def accion = "create"
        def departamento = new DepartamentoItem()
        if (params.codigo) {
            params.codigo = params.codigo.toString().toUpperCase()
        }
/*
        if (params.descripcion) {
            params.descripcion = params.descripcion.toString().toUpperCase()
        }
*/
        if (params.id) {
            departamento = DepartamentoItem.get(params.id)
            accion = "edit"
        }
        departamento.properties = params
        if (departamento.save(flush: true)) {
            render "OK_" + accion + "_" + departamento.id + "_" + departamento.subgrupo.codigo + "." + departamento.codigo + " " + departamento.descripcion
        } else {
            println "mantenimiento items controller l 617: " + departamento.errors
            def errores = g.renderErrors(bean: departamento)
            render "NO_" + errores
        }
    }

    def deleteDp_ajax() {
        def departamento = DepartamentoItem.get(params.id)
        try {
            departamento.delete(flush: true)
            render "OK"
        }
        catch (DataIntegrityViolationException e) {
            println "mantenimiento items controller l 630: " + e
            render "NO"
        }
    }

    def showIt_ajax() {
        println "showIt_ajax" + params
        def itemInstance = Item.get(params.id)
        println "itemInstance: $itemInstance"
        return [itemInstance: itemInstance]
    }

    def formIt_ajax() {
        println "formIt_ajax $params"
        def departamento = DepartamentoItem.get(params.padre)
        def itemInstance = new Item()
        if (params.id) {
            itemInstance = Item.get(params.id)
        }

        def campos = ["numero": ["Código", "string"], "descripcion": ["Descripción", "string"]]

        return [departamento: departamento, itemInstance: itemInstance, grupo: params.grupo, campos: campos]
    }


    def checkCdIt_ajax() {
        println "checkCdIt_ajax: $params"
        def dep = DepartamentoItem.get(params.dep)
        if (dep.subgrupo.grupo.id != 2)
            params.codigo = dep.subgrupo.codigo.toString().padLeft(3, '0') + "." + dep.codigo.toString().padLeft(3, '0') + "." + params.codigo
        else
            params.codigo = dep.codigo.toString().padLeft(3, '0') + "." + params.codigo
        //println params
        println "a evaluar: ${params.codigo}"
        if (params.id) {
            def item = Item.get(params.id)
            if (params.codigo.toString().trim() == item.codigo.toString().trim()) {
                render true
            } else {
                def items = Item.findAllByCodigo(params.codigo)
                if (items.size() == 0) {
                    render true
                } else {
                    render false
                }
            }
        } else {
            def items = Item.findAllByCodigo(params.codigo)
            println ".... ${items.size()}"
            if (items.size() == 0) {
                render true
            } else {
                render false
            }
        }
    }

    def checkNmIt_ajax() {
        println "checkNmIt_ajax: $params"
        if (params.id) {
            def item = Item.get(params.id)
            if (params.nombre == item.nombre) {
                render true
            } else {
                def items = Item.findAllByNombre(params.nombre)
                if (items.size() == 0) {
                    render true
//                    return
                } else {
                    render false
                }
            }
        } else {
            def items = Item.findAllByNombre(params.nombre)
            if (items.size() == 0) {
                render true
            } else {
                render false
            }
        }
    }

    def checkCmIt_ajax() {
        if (params.id) {
            def item = Item.get(params.id)
            if (params.campo == item.campo) {
                render true
            } else {
                def items = Item.findAllByCampo(params.campo)
                if (items.size() == 0) {
                    render true
                } else {
                    render false
                }
            }
        } else {
            def items = Item.findAllByCampo(params.campo)
            if (items.size() == 0) {
                render true
            } else {
                render false
            }
        }
    }


    def infoItems() {
        def item = Item.get(params.id)
        def rubro = Rubro.findAllByItem(item)
        def precios = PrecioRubrosItems.findAllByItem(item)
        def fpItems = ItemsFormulaPolinomica.findAllByItem(item)
        return [item: item, rubro: rubro, precios: precios, fpItems: fpItems, delete: params.delete]
    }

    def copiarOferentes() {
        def item = Item.get(params.id)
        def res=null
        res = oferentesService.exportDominio(janus.Item, "itemjnid", item, null, "ofrt__id",null, "ofrt__id","select * from item where itemcdgo='${item.codigo}'")

//        render "NO_Ha ocurrido un error"
        if(res)
            render "OK"
        else
            render "NO_Ha ocurrido un error"
    }

    def saveIt_ajax() {
        println "saveIt_ajax: $params"
        println "p. venta: ${params.precioVenta.toDouble()}"
        def dep = DepartamentoItem.get(params.padre)
//        params.tipoItem = TipoItem.findByCodigo("I")
        params.fechaModificacion = new Date()
//        params.nombre = params.nombre.toString().toUpperCase()
//        params.observaciones = params.observaciones.toString().toUpperCase()
        params.codigo = params.codigo.toString().toUpperCase()
        params.precioVenta = params.precioVenta.toDouble()
        params.precioCosto = params.precioCosto.toDouble()
        params.peso = params.peso.toDouble()
        params.stockMaximo = params.stockMaximo.toDouble()
        params.stockMinimo = params.stockMinimo.toDouble()
        if (!params.id) {
            if (!params.codigo.contains(".")) {
                if (dep.subgrupo.grupoId == 2) {
                    params.codigo = dep.codigo.toString().padLeft(3, '0') + "." + params.codigo
                } else {
                    params.codigo = dep.subgrupo.codigo.toString().padLeft(3, '0') + "." + dep.codigo.toString().padLeft(3, '0') + "." + params.codigo
                }
            }
        } else {
            params.remove("codigo")
        }


        if (params.fecha) {
//            params.fecha = new Date().parse("dd-MM-yyyy", params.fecha)
            params.fecha = new Date().parse("dd-MM-yyyy", params.fecha_input)
        } else {
            params.fecha = new Date()

        }

        def accion = "create"
        def item = new Item()
        if (params.id) {
            item = Item.get(params.id)
            accion = "edit"
        }

        item.properties = params
        item.departamento = dep
        if (item.save(flush: true)) {
            render "OK_" + accion + "_" + item.id + "_" + item.codigo + " " + item.nombre
        } else {
            println "mantenimiento items controller l 784: " + item.errors
            def errores = g.renderErrors(bean: item)
            render "NO_" + errores
        }
    }

    def deleteIt_ajax() {
        def item = Item.get(params.id)
        try {
            item.delete(flush: true)
            render "OK"
        }
        catch (DataIntegrityViolationException e) {
            println "mantenimiento items controller l 797: " + e
            render "NO"
        }
    }

/*
    def formPrecio_ajax() {
        def item = Item.get(params.item)
        def lugar = null
        if (params.lugar != "all") {
            lugar = Lugar.get(params.lugar)
        }
        def precioRubrosItemsInstance = new PrecioRubrosItems()
        precioRubrosItemsInstance.item = item
        if (lugar) {
            precioRubrosItemsInstance.lugar = lugar
        }
        return [precioRubrosItemsInstance: precioRubrosItemsInstance, lugar: lugar, lugarNombre: params.nombreLugar, fecha: params.fecha, params: params]
    }
*/

    def checkFcPr_ajax() {
//        println params
        if (!params.lugar) {
            render true
        } else {
            def precios = PrecioRubrosItems.withCriteria {
                and {
                    eq("lugar", Lugar.get(params.lugar))
                    eq("fecha", new Date().parse("dd-MM-yyyy", params.fecha))
                    eq("item", Item.get(params.item))
                }
            }
            if (precios.size() == 0) {
                render true
            } else {
                render false
            }
        }
    }

/*
    def savePrecio_ajax() {
        def item = Item.get(params.item.id)
        params.fecha = new Date().parse("dd-MM-yyyy", params.fecha)
        if (params.lugar.id != "-1") {
            def precioRubrosItemsInstance = new PrecioRubrosItems(params)
            if (precioRubrosItemsInstance.save(flush: true)) {
                render "OK"
            } else {
                println "mantenimiento items controller l 846: " + precioRubrosItemsInstance.errors
                render "NO"
            }
        } else {
            if (params.ignore == "true") {
                def error = 0
                Lugar.findAllByTipoLista(item.tipoLista).each { lugar ->
                    def precios = PrecioRubrosItems.withCriteria {
                        and {
                            eq("lugar", lugar)
                            eq("fecha", params.fecha)
                            eq("item", item)
                        }
                    }
                    if (precios.size() == 0) {
                        def precioRubrosItemsInstance = new PrecioRubrosItems()
                        precioRubrosItemsInstance.precioUnitario = params.precioUnitario.toDouble()
                        precioRubrosItemsInstance.lugar = lugar
                        precioRubrosItemsInstance.item = Item.get(params.item.id)
                        precioRubrosItemsInstance.fecha = params.fecha
                        if (precioRubrosItemsInstance.save(flush: true)) {
                        } else {
                            println "mantenimiento items controller l 873: " + precioRubrosItemsInstance.errors
                            error++
                        }
                    }
                }
                if (error == 0) {
                    render "OK"
                } else {
                    render "NO"
                }
            }
        }
    }
*/

    def deletePrecio_ajax() {
        def rubroPrecioInstance = PrecioRubrosItems.get(params.id);
        def ok = true
        if (params.auto) {
            def usu = Persona.get(session.usuario.id)
            if (params.auto.toString().encodeAsMD5() != usu.autorizacion) {
                ok = false
                render "Ha ocurrido un error en la autorización."
            }
        }
        if (ok) {
            try {
                rubroPrecioInstance.delete(flush: true)
                render "OK"
            }
            catch (DataIntegrityViolationException e) {
                println "mantenimiento items controller l 903: " + e
                render "No se pudo eliminar el precio."
            }
        }
    }

    def actualizarPrecios_ajax() {
        if (params.item instanceof java.lang.String) {
            params.item = [params.item]
        }

        def oks = "", nos = ""

        params.item.each {
            def parts = it.split("_")

//            println parts

            def rubroId = parts[0]
            def nuevoPrecio = parts[1]

            def rubroPrecioInstance = PrecioRubrosItems.get(rubroId);
            rubroPrecioInstance.precioUnitario = nuevoPrecio.toDouble();
//            println rubroPrecioInstance.precioUnitario
            if (!rubroPrecioInstance.save(flush: true)) {
                println "mantenimiento items controller l 928: " + "error " + parts
                if (nos != "") {
                    nos += ","
                }
                nos += "#" + rubroId
            } else {
                if (oks != "") {
                    oks += ","
                }
                oks += "#" + rubroId
            }

        }
        render oks + "_" + nos
    }


    def clave2 () {
        def path = servletContext.getRealPath("/")

        //load the XML doc to sign
        DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();

//        FileInputStream fp = new FileInputStream("/home/gato/grails/cratos3/web-app/xml/42/AnexoTransaccional_01_2017.xml")
        FileInputStream fp = new FileInputStream(path + "xml/42/AnexoTransaccional_01_2017.xml")
        Document xmlDoc = docBuilder.parse(fp);

        //Load the keystore containing the keys
        KeyStore keystore = KeyStore.getInstance("PKCS12");
        char[] password = "FcoPaliz1959".toCharArray();
//        keystore.load(new FileInputStream("/home/gato/grails/cratos3/web-app/xml/fp.p12"), password);
        keystore.load(new FileInputStream(path + "xml/42/firma.p12"), password);
        KeyPair key = getKeyPair(keystore, "serialnumber=0000240522+cn=francisco fabian paliz osorio,l=quito," +
                "ou=entidad de certificacion de informacion-ecibce,o=banco central del ecuador,c=ec decryption key", password);

        //Create the signing context
        DOMSignContext dsc = new DOMSignContext(key.getPrivate(), xmlDoc.getDocumentElement());

        //Manufacture a signer object
        XMLSignatureFactory fac = XMLSignatureFactory.getInstance("DOM");

        //Specify the Reference attributes
        Reference ref = fac.newReference("", fac.newDigestMethod(DigestMethod.SHA1, null),
        Collections.singletonList
                (fac.newTransform(Transform.ENVELOPED,
                        (TransformParameterSpec) null)), null, null);

        //Specify the SignedInfo attributes
        SignedInfo si = fac.newSignedInfo(fac.newCanonicalizationMethod
                (CanonicalizationMethod.INCLUSIVE,
                        (C14NMethodParameterSpec) null),
        fac.newSignatureMethod(SignatureMethod.RSA_SHA1, null),
        Collections.singletonList(ref));

        //Setup the KeyInfo attributes
        KeyInfoFactory kif = fac.getKeyInfoFactory();
        ArrayList<Certificate> certificateList = new ArrayList<Certificate>();
        certificateList.add(keystore.getCertificate("serialnumber=0000240522+cn=francisco fabian paliz osorio,l=quito," +
                "ou=entidad de certificacion de informacion-ecibce,o=banco central del ecuador,c=ec decryption key"));
        X509Data kv = kif.newX509Data(certificateList);
        KeyInfo ki = kif.newKeyInfo(Collections.singletonList(kv));

        //Sign the document
        XMLSignature signature = fac.newXMLSignature(si, ki);
        signature.sign(dsc);

        //Save the new signed XML file
        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer trans = tf.newTransformer();
        trans.transform(new DOMSource(xmlDoc), new StreamResult(new FileOutputStream(path + "xml/42/terminado.xml")));
        render ("firmado<hr/>" + new File(path + "xml/42/terminado.xml").text)
    }

    public static KeyPair getKeyPair(KeyStore keystore, String alias, char[] password) {
        try {
            // Get private key
            Key key = keystore.getKey(alias, password);
            if (key instanceof PrivateKey) {
                // Get certificate of public key
                Certificate cert = keystore.getCertificate(alias);

                // Get public key
                PublicKey publicKey = cert.getPublicKey();

                // Return a key pair
                return new KeyPair(publicKey, (PrivateKey)key);
            }
        } catch (UnrecoverableKeyException e) {
        } catch (NoSuchAlgorithmException e) {
        } catch (KeyStoreException e) {
            System.err.println("key error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }


}

