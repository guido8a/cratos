<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Estructura del Menú y Procesos</title>
    </head>


    <body>

        <div class="btn-toolbar" role="toolbar">
            <div class="btn-group">
                <p class="text-primary"> Tipo de Acción:</p>
            </div>
            <div class="btn-group" data-toggle="buttons">
                <g:each var="tp" in="${cratos.seguridad.Tpac.list([sort: id])}" status="i">
                    <label class="btn btn-primary tipo ${(tp.id == 1) ? 'active' : ''}">
                        <input type="radio" name="options" id="tpac${i}" value="${tp.id}"> ${tp.tipo}
                    </label>
                </g:each>
            </div>

            <div class="btn-group">
                <g:link controller="prfl" action="modulos" id="1" class="aPrfl btn btn-primary">
                    Gestionar Permisos y M&oacute;dulos
                </g:link>
            </div>

            <div class="btn-group">
                <a href="#" id="cargaCtrl" class="btn btn-primary">Cargar Controladores</a>

                <a href="#" id="cargaAccn" class="btn btn-primary">Cargar Acciones</a>
            </div>
        </div>

    <p class="text-primary"><strong>Seleccione el módulo para fijar permisos o editar acciones y procesos</strong></p>

        <div class="" id="parm">
            <div class="btn-group" data-toggle="buttons">
                <g:each in="${modulos}" status="i" var="d">
                    <label class="btn btn-primary modulo">
                        <input type="radio" id="check${i}" name="modulo" value="${d.id}"> ${d.nombre}
                    </label>
                </g:each>
            </div>

            <div id="ajx" style="width:900px; height: 520px; margin-top: 15px;"></div>

        </div>

        <div id="datosPerfil" class="container entero  ui-corner-bottom">
        </div>


        <script type="text/javascript">

            $(function () {
                $("#cargaCtrl").click(function () {
                    bootbox.confirm("Cargar controladores desde Grails?", function (result) {
                        if (result) {
                            openLoader();
                            $.ajax({
                                type    : "POST", url : "${createLink(controller:'acciones', action:'cargarControladores')}",
                                success : function (msg) {
                                    closeLoader();
                                    bootbox.alert(msg);
                                }
                            });
                        }
                    });
                });
                $("#cargaAccn").click(function () {
                    //alert("crear un perfil");
                    bootbox.confirm("Cargar acciones desde Grails?", function (result) {
                        if (result) {
                            openLoader();
                            $.ajax({
                                type    : "POST", url : "${createLink(controller:'acciones', action:'cargarAcciones')}",
                                data    : "",
                                success : function (msg) {
                                    closeLoader();
                                    bootbox.alert(msg);
                                }
                            });
                        }
                    });
                });
                $(".modulo").click(function () {
                    setTimeout(function () {
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(controller:'acciones', action:'ajaxAcciones')}",
                            data    : {
                                mdlo : $(".modulo.active").find("input").val(),
                                tipo : $(".tipo.active").find("input").val()
                            },
                            success : function (msg) {
                                $("#ajx").html(msg)
                            }
                        });
                    }, 1);
                });

            });

        </script>

    </body>
</html>