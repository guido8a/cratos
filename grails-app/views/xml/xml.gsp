<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/19/13
  Time: 12:56 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>SRI (XML)</title>

        <style type="text/css">
        .container {
            padding : 5px;
        }
        </style>
    </head>

    <body>
        <elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

        <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link action="downloads" class="btn btn-default btnCrear">
                    <i class="fa fa-files-o"></i> Archivos
                </g:link>
            </div>
        </div>

        <g:form class="form-horizontal" name="sriForm" role="form" action="save_ajax" method="POST">
            <div class="form-group">
                <label for="anio" class="col-md-1 control-label">Año</label>

                <div class="col-md-4">
                    <g:select name="contabilidad" from="${cont}" optionKey="id" optionValue="descripcion" class="form-control"/>
                </div>
            </div>

            <div class="form-group">
                <label for="mes" class="col-md-1 control-label">Mes</label>

                <div class="col-md-2">
                    <span id="spMes">
                        <g:select name="mes" class="form-control" from="${periodos}" optionKey="id" optionValue="val"/>
                    </span>
                </div>
            </div>

            <div class="row">
                <div class="col-md-3 text-center">
                    <a href="#" class="btn btn-success" id="btnPrint">Generar</a>
                </div>
            </div>
        </g:form>


        <script type="text/javascript">
            function getPeriodos() {
                var anio = $("#anio").val();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'getPeriodos')}",
                    data    : {
                        anio : anio
                    },
                    success : function (msg) {
                        $("#spMes").html(msg);
                    }
                });
            }
            $(function () {
                var $anio = $("#anio");
                $anio.val("${new Date().format('yyyy')}");
                getPeriodos();

                function crearXML(mes, anio, override) {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'createXml')}",
                        data    : {
                            mes      : mes,
                            anio     : anio,
                            override : override
                        },
                        success : function (msg) {
                            var parts = msg.split("_");
                            if (parts[0] == "NO") {
                                if (parts[1] == "1") {
                                    var msgs = "Ya existe un archivo XML para el periodo " + mes + "-" + anio + "." +
                                               "<ul><li>Si desea <strong>sobreescribir el archivo existente</strong>, haga click en el botón <strong>'Sobreescribir'</strong></li>" +
                                               "<li>Si desea <strong>descargar el archivo previamente generado</strong>, haga click en el botón <strong>'Descargar'</strong></li>" +
                                               "<li>Si desea <strong>ver la lista de archivos generados</strong>, haga cilck en el botón <strong>'Archivos'</strong></li></ul>";
                                    bootbox.dialog({
                                        title   : "Alerta",
                                        message : msgs,
                                        buttons : {
                                            sobreescribir : {
                                                label     : "<i class='fa fa-pencil'></i> Sobreescribir",
                                                className : "btn-primary",
                                                callback  : function () {
                                                    crearXML(mes, anio, 1);
                                                }
                                            },
                                            descargar     : {
                                                label     : "<i class='fa fa-download'></i> Descargar",
                                                className : "btn-success",
                                                callback  : function () {
                                                    location.href = "${createLink(action:'downloadFile')}?mes=" + mes + "&anio=" + anio;
                                                }
                                            },
                                            archivos      : {
                                                label     : "<i class='fa fa-files-o'></i> Archivos",
                                                className : "btn-default",
                                                callback  : function () {
                                                    location.href = "${createLink(action:'downloads')}";
                                                }
                                            },
                                            cancelar      : {
                                                label     : "Cancelar",
                                                className : "btn-default",
                                                callback  : function () {
                                                }
                                            }
                                        }
                                    });
                                }
                            } else if (parts[0] == "OK") {
                                bootbox.dialog({
                                    title   : "Descargar archivo",
                                    message : "Archivo generado exitosamente",
                                    buttons : {
                                        descargar : {
                                            label     : "<i class='fa fa-download'> Descargar",
                                            className : "btn-success",
                                            callback  : function () {
                                                location.href = "${createLink(action:'downloadFile')}?mes=" + mes + "&anio=" + anio;
                                            }
                                        }
                                    }
                                });
                            }
                        }
                    });
                }

                $("#btnPrint").click(function () {
                    var mes = $("#mes").val();
                    var anio = $("#anio").val();
                    crearXML(mes, anio, 0);
                });

                $anio.change(function () {
                    getPeriodos();
                });
            });
        </script>

    </body>
</html>