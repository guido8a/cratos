package cratos

class MenuTagLib {
    static namespace = "mn"

    def menu = { attrs ->
        def items = [:]
        def usuario = session.usuario
        def perfil = session.perfil
        def strItems = ""
        if (!attrs.title) {
            attrs.title = "cratos"
        }
//        attrs.title = attrs.title.toUpperCase()
        if (usuario) {
            def acciones = cratos.seguridad.Prms.findAllByPerfil(perfil).accion.sort { it.modulo.orden }

            acciones.each { ac ->
                if (ac.moduloId != 0) {
                    if (!items[ac.modulo.nombre]) {
                        items.put(ac.modulo.nombre, [ac.accnDescripcion, g.createLink(controller: ac.control.ctrlNombre, action: ac.accnNombre)])
                    } else {
                        items[ac.modulo.nombre].add(ac.accnDescripcion)
                        items[ac.modulo.nombre].add(g.createLink(controller: ac.control.ctrlNombre, action: ac.accnNombre))
                    }
                }
            }
            items.each { item ->
                for (int i = 0; i < item.value.size(); i += 2) {
                    for (int j = 2; j < item.value.size() - 1; j += 2) {
                        def val = item.value[i].trim().compareTo(item.value[j].trim())
                        if (val > 0 && i < j) {
                            def tmp = [item.value[j], item.value[j + 1]]
                            item.value[j] = item.value[i]
                            item.value[j + 1] = item.value[i + 1]
                            item.value[i] = tmp[0]
                            item.value[i + 1] = tmp[1]
                        }

                    }
                }
            }
        } else {
            items = ["Inicio": ["Prueba", "linkPrueba", "Test", "linkTest"]]
        }

        items.each { item ->
            strItems += '<li class="dropdown">'
            strItems += '<a href="#" class="dropdown-toggle" data-toggle="dropdown">' + item.key + '<b class="caret"></b></a>'
            strItems += '<ul class="dropdown-menu">'

            (item.value.size() / 2).toInteger().times {
                strItems += '<li><a href="' + item.value[it * 2 + 1] + '">' + item.value[it * 2] + '</a></li>'
            }
            strItems += '</ul>'
            strItems += '</li>'
        }

        def html = ""
        html += '<nav class="navbar navbar-fixed-top navbar-default hidden-print">'
        html += '<div class="container" style="min-width: 1000px !important;">'
        //<!-- Brand and toggle get grouped for better mobile display -->
        html += '<div class="navbar-header">'
        html += '<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#cratos-navbar-collapse">'
        html += '<span class="sr-only">Toggle navigation</span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '</button>'
        html += '<a class="navbar-brand" href="#" style="color:#0042B3">' + attrs.title + '</a>'
        html += '</div>'
        //<!-- Collect the nav links, forms, and other content for toggling -->
        html += '<div class="collapse navbar-collapse" id="cratos-navbar-collapse">'
        html += '<ul class="nav navbar-nav">'
        html += strItems
        html += '</ul>'

//        html += '<p  class="navbar-text navbar-right" id="countdown">20</p>'
        html += '<p  class="navbar-text navbar-right" id="countdown"></p>'
        html += '<ul class="nav navbar-nav navbar-right">'
//        html += '<p  class="navbar-text">' + (session.empresa?.nombre.size() > 10 ? session.empresa?.nombre[0..8]+ '..' : session.empresa?.nombre) + '</p>'
        html += '<p  class="navbar-text" style="color:#0042B3">' + (session.usuario?.login.size() > 10 ? session.usuario?.login[0..8]+ '..' : session.usuario?.login) + '</p>'
        html += '<li><a href="' + g.createLink(controller: 'login', action: 'logout') + '"><i class="fa fa-power-off"></i> Salir</a></li>'

//        html += '<li class="dropdown">'
//        html += '<a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>'
//        html += '<ul class="dropdown-menu">'
//        html += '<li><a href="#">Action</a></li>'
//        html += '<li><a href="#">Another action</a></li>'
//        html += '<li><a href="#">Something else here</a></li>'
//        html += '<li class="divider"></li>'
//        html += '<li><a href="#">Separated link</a></li>'
//        html += '</ul>'
//        html += '</li>'
        html += '</ul>'
        html += '</div><!-- navbar-collapse -->'
        html += '</div><!-- container -->'
        html += '</nav>'

//        html += '<li><a href="' + g.createLink(controller: 'tramites', action: 'list') + '">Alertas</a></li>'
//        html += ' <li class="divider-vertical"></li>'
//        html += '<li><a href="' + g.createLink(controller: 'login', action: 'logout') + '"><i class="icon-off icon-white"></i> Salir</a></li>'
//        html += ' <li class="divider-vertical"></li>'
//        html += '</ul>'
//        html += '<p class="nav navbar-nav navbar-right" id="countdown"></p>'
//        html += '</div><!--/.nav-collapse -->'
//        html += '</div>'
//        html += '</div>'

        out << html
    } //menu
}
