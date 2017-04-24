<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 1/16/14
  Time: 12:48 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Configurar usuario</title>

        <style type="text/css">
        .perfil .fa-li, .perfil span, .permiso .fa-li, .permiso span {
            cursor : pointer;
        }
        </style>

    </head>

    <body>

        <div class="well">
            Usuario ${usuario.nombre} ${usuario.apellido}
        </div>


        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    Perfiles <small>Asignar uno o más perfiles al usuario</small>
                </h4>
            </div>

            <div class="panel-body">
                <p>
                    <a href="#" class="btn btn-default" id="allPerf">Asignar todos los perfiles</a>
                    <a href="#" class="btn btn-default" id="nonePerf">Quitar todos los perfiles</a>
                </p>
                <g:form name="frmPerfiles" action="savePerfiles_ajax">
                    <ul class="fa-ul">
                        <g:each in="${cratos.seguridad.Prfl.list([sort: 'nombre'])}" var="perfil">
                            <li class="perfil">
                                %{--<input class="chkPerfil" type="checkbox" name="perfil" value="${perfil.id}" ${perfilesUsu.contains(perfil.id) ? "checked" : ""}/>--}%
                                <i data-id="${perfil.id}" class="fa-li fa ${perfilesUsu.contains(perfil.id) ? "fa-check-square" : "fa-square-o"}"></i>
                                <span>${perfil.nombre}</span>
                            </li>
                        </g:each>
                    </ul>
                </g:form>
                <a href="#" class="btn btn-success" id="btnPerfiles">
                    <i class="fa fa-save"></i> Guardar
                </a>
            </div>
        </div>

        <script type="text/javascript">

            $(function () {
                var $btnPerfiles = $("#btnPerfiles");

                function doSave(url, data) {
                    $btnPerfiles.hide().after(spinner);
                    openLoader("Grabando");
                    $.ajax({
                        type    : "POST",
                        url     : url,
                        data    : data,
                        success : function (msg) {
                            closeLoader();
                            var parts = msg.split("_");
                            log(parts[1], parts[0] == "OK" ? "success" : "error");
                            spinner.remove();
                            $btnPerfiles.show();
                        }
                    });
                }

                $("#allPerf").click(function () {
                    $(".perfil .fa-li").removeClass("fa-square-o").addClass("fa-check-square");
                    return false;
                });

                $("#nonePerf").click(function () {
                    $(".perfil .fa-li").removeClass("fa-check-square").addClass("fa-square-o");
                    return false;
                });

                $(".perfil .fa-li, .perfil span").click(function () {
                    var ico = $(this).parent(".perfil").find(".fa-li");
                    if (ico.hasClass("fa-check-square")) { //descheckear
                        ico.removeClass("fa-check-square").addClass("fa-square-o");
                    } else { //checkear
                        ico.removeClass("fa-square-o").addClass("fa-check-square");
                    }
                });

                $btnPerfiles.click(function () {
                    var $frm = $("#frmPerfiles");
                    var url = $frm.attr("action");
                    var data = "id=${usuario.id}";
                    var band = false;
                    $(".perfil .fa-li").each(function () {
                        var ico = $(this);
                        if (ico.hasClass("fa-check-square")) {
                            data += "&perfil=" + ico.data("id");
                            band = true;
                        }
                    });
                    if (!band) {
                        bootbox.confirm("<i class='fa fa-warning fa-3x pull-left text-warning text-shadow'></i><p>No ha seleccionado ningún perfil. El usuario no podrá ingresar al sistema. ¿Desea continuar?.</p>", function (result) {
                            if (result) {
                                doSave(url, data);
                            }
                        })
                    } else {
                        doSave(url, data);
                    }
                    return false;
                });
            });
        </script>

    </body>
</html>