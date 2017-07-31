package cratos

import cratos.inventario.Marca
import cratos.seguridad.Persona
import cratos.seguridad.Shield
import org.codehaus.groovy.grails.commons.DomainClassArtefactHandler
import org.codehaus.groovy.grails.orm.hibernate.cfg.GrailsDomainBinder

class InicioController extends Shield {
    def dbConnectionService

    def index() {
        def cn = dbConnectionService.getConnection()
        def prms = []
        def acciones = "'procesos', 'contabilidad', 'facturacion'"
        def usu = Persona.get(session.usuario?.id)
        if (usu) {
            def now = new Date().clearTime()
            if ((usu.password == usu.cedula.encodeAsMD5()) || usu.fechaPass <= now) {
                redirect(controller: "login", action: "cambiarPass")
                return
            }
        }
//        def tx = "select accnnmbr from prms, accn where prfl__id = " + Prfl.findByNombre(session.perfil.toString()).id +
        def tx = "select accnnmbr from prms, accn where prfl__id = " + '1' +
                " and accn.accn__id = prms.accn__id and accnnmbr in (${acciones})"
        cn.eachRow(tx) { d ->
            prms << d.accnnmbr
        }
        cn.close()

        println "permisos: $prms"

        return [prms: prms]
    }

    def saldosIniciales(){
        def gestor = Gestor.get(11)
        def cuentas = Cuenta.findAllByMovimiento("1")
        cuentas.sort{it.numero.toInteger()}
        def tipo = TipoComprobante.get(3)
        def random = new Random()
        cuentas.each {
            println "cuenta "+it.numero+"   id "+it.id
            def genera = new Genera()
            def num = random.nextInt(5487878)
            genera.gestor=gestor
            genera.cuenta=it
            genera.tipoComprobante=tipo
            genera.debeHaber="D"
            genera.valor=num.toDouble()
            genera.porcentaje=0
            genera.porcentajeImpuestos=0
            if (!genera.save(flush: true))
                println "error guardar genera  "+it.id
            def genera2 = new Genera()
            num = random.nextInt(5487878)
            genera2.gestor=gestor
            genera2.cuenta=it
            genera2.tipoComprobante=tipo
            genera2.debeHaber="H"
            genera2.valor=num.toDouble()
            genera2.porcentaje=0
            genera2.porcentajeImpuestos=0
            if (!genera2.save(flush: true))
                println "error guardar genera  "+it.id

        }
        println "acabo"
    }


    def arreglaMovimientos(){
        def cuentas = Cuenta.list()
        cuentas.each {
            def hijos = Cuenta.findAllByPadre(it)
            if (hijos.size()==0){
                it.movimiento="1"
                println "cuenta "+it.numero+"      si movimiento "
                it.save(flush: true)
            }
        }

    }






    def cargaCuentas(){
        def file = new File("/home/svt/Documents/cuentas.csv")
        file.eachLine {
            def parts = it.split("&&&&&&&&&&&&&&&&&")

            def cuenta = Cuenta.findByNumero(parts[1])
            if (!cuenta){
                cuenta=new Cuenta()
                cuenta.numero=parts[1]
                cuenta.descripcion=parts[0]
                cuenta.auxiliar="S"
                cuenta.empresa=Empresa.get(1)
                if (parts[1].trim().size()>1){
                    println "si padre   cuenta "+ parts[1]+"    padre "+parts[1].substring(0,parts[1].size()-2)
                    cuenta.padre=Cuenta.findByNumero(parts[1].substring(0,parts[1].size()-2))
                    if (!cuenta.padre)
                        println "no encontro padre "+parts[1]
                }
                cuenta.movimiento=0
                def nivel
                switch (parts[1].size()){
                    case 1:
                        nivel=Nivel.get(1)
                        break;
                    case 3:
                        nivel=Nivel.get(2)
                        break;
                    case 5:
                        nivel=Nivel.get(3)
                        break;
                    case 7:
                        nivel=Nivel.get(4)
                        break;
                    case 9:
                        nivel=Nivel.get(5)
                        break;
                    default:
                        println "wtf "+parts[1]
                }
                cuenta.nivel=nivel
                cuenta.estado="A"
                /*TODO verificar que ese estado sea el correcto*/
                if (!cuenta.save(flush: true))
                    println "error cuenta "+cuenta.errors+"   --> "+cuenta.numero

            } else{
                println "si hay cuenta "+cuenta.numero
            }

//            println "linea "+it+" parts "+parts


        }
    }


    def inicio() {
        redirect(action: "index")
    }

    def parametros = {

    }

    def cp = {

    }

    def parametrosEmpresa () {
        def empresa = session.empresa.id
        return[empresa: empresa]
    }

    def nuevo() {
        def pr = Proceso.get(607)
        def tableName = GrailsDomainBinder.superclass.getMapping(pr.class).table.name

        render "ok --$dt"
    }

}
