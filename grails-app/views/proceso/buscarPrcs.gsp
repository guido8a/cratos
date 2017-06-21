<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Procesos Contables</title>

    <style type="text/css">

    .alinear {
        text-align: center !important;
    }

    #buscar {
        width: 240px;
        border-color: #0c6cc2;
    }

    #limpiaBuscar {
        position: absolute;
        right: 5px;
        top: 0;
        bottom: 0;
        height: 14px;
        margin: auto;
        font-size: 14px;
        cursor: pointer;
        color: #ccc;
    }
    </style>

</head>

<body>
<div style="margin-top: 0px; min-height: 50px" class="vertical-container">
    <p class="css-icono" style="margin-bottom: -15px"><i class="fa fa-folder-open-o"></i></p>
    %{--<p class="css-icono" style="margin-bottom: -15px"><i class="fa fa-search"></i></p>--}%

    <div class="linea45"></div>

    <div>
        <div class="col-md-3">
            <g:link class="btn btn-primary" action="nuevoProceso">
                <i class="fa fa-file-o"></i> Nueva Transacción
            </g:link>
        </div>

        <div class="col-md-6">
            Buscar procesos por:
            <div class="btn-group">
                <input id="buscar" type="search" class="form-control" value="${session.buscar}">
                <span id="limpiaBuscar" class="glyphicon glyphicon-remove-circle"
                      title="Limpiar texto de búsqueda"></span>
            </div>
            <a href="#" name="busqueda" class="btn btn-azul btnBusqueda btn-ajax"><i
                    class="fa fa-check-square-o"></i> Buscar</a>
        </div>

        <div class="col-md-2" style="margin-right: 0px; font-size: large; padding: 0 ">
            <span class="text-info"><strong>${session.contabilidad.descripcion}</strong></span>
        </div>
        <div class="col-md-1" >
        <a href="#" class="btn btn-azul" id="btnCambiarConta" style="margin-left: 0">
            <i class="fa fa-refresh"></i> Cambiar

        </a>
        </div>
    </div>
    %{----------}%
    %{--<div class="btn-toolbar toolbar">--}%
        %{--<div class="btn-group">--}%
                %{--<g:link class="btn btn-azul" action="cambiar" controller="contabilidad" style="margin-left:10px">--}%
                %{--<i class="fa fa-refresh"></i> Cambiar--}%
                %{--</g:link>--}%




            </span>
        %{--</div>--}%
    %{--</div>--}%


    %{--------}%
</div>

<div style="margin-top: 30px; min-height: 650px" class="vertical-container">
    <p class="css-vertical-text">Procesos encontrados</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 1070px">
        <thead>
        <tr>
            <th class="alinear" style="width: 70px">Fecha</th>
            <th class="alinear" style="width: 240px">Descripción</th>
            <th class="alinear" style="width: 80px">Estado</th>
            <th class="alinear" style="width: 60px">Comprobante</th>
            <th class="alinear" style="width: 80px">Tipo</th>
            <th class="alinear" style="width: 180px">Proveedor</th>
        </tr>
        </thead>
    </table>

    <div id="bandeja">
    </div>
</div>

<div><strong>Nota</strong>: Si existen muchos registros que coinciden con el criterio de búsqueda, se retorna
  como máximo 20 <span style="margin-left: 40px; color: #0b2c89">Se ordena por fecha de proceso</span>
</div>

<div class="modal fade " id="dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                %{--<h4 class="modal-title">Problema y Solución</h4>--}%
                Problema y Solución..
            </div>

            <div class="modal-body" id="dialog-body" style="padding: 15px">

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>


<script>
    $(function () {

        $("#limpiaBuscar").click(function () {
            $("#buscar").val('');
        });

    });
</script>

<script type="text/javascript">

    $(".btnBusqueda").click(function () {
        $("#bandeja").html("").append($("<div style='width:100%; text-align: center;'/>").append(spinnerSquare64));
        var buscar = $("#buscar").val();
        var datos = "buscar=" + buscar;

        $.ajax({
            type: "POST",
            url: "${g.createLink(controller: 'proceso', action: 'tablaBuscarPrcs')}",
            data: datos,
            success: function (msg) {
                $("#bandeja").html(msg);
            },
            error: function (msg) {
                $("#bandeja").html("Ha ocurrido un error");
            }
        });

    });

    $("input").keyup(function (ev) {
        if (ev.keyCode == 13) {
            $(".btnBusqueda").click();
        }
    });


    function createContextMenu(node) {
        var $tr = $(node);

        var items = {
            header: {
                label: "Acciones",
                header: true
            }
        };

        var etdo = $tr.data("ed");
        var id = $tr.data("id");

        var editar = {
            label: " Ir al proceso",
            icon: "fa fa-file-text-o",
            action: function () {
                location.href = '${createLink(controller: "proceso", action: "nuevoProceso")}?id=' + id;
            }
        };

        var retencion = {
            label: " Retenciones",
            icon: "fa fa-money",
            action: function () {
                location.href = '${createLink(controller: "proceso", action: "detalleSri")}?id=' + id;
            }
        };

        var imprimir = {
            label: " Imprimir Comprobante",
            icon: "fa fa-file",
            action: function () {
                location.href = '${createLink(controller: "proceso", action: "detalleSri")}?id=' + id;
            }
        };

        var auxiliar = {
            label: " Auxiliar",
            icon: "fa fa-table",
            action: function () {
                location.href = '${createLink(controller: "axlr", action: "show")}?id=' + id;
            }
        };

        items.editar = editar;
        items.auxiliar = auxiliar;

        if(etdo == 'R') {
            items.retencion = retencion;
            items.imprimir = imprimir;
        }

        return items
    }

    $(".btnBorrar").click(function () {
        $("#memorando").val("");
        $("#asunto").val("");
        $("#fechaRecepcion_input").val('');
        $("#fechaBusqueda_input").val('')
    });

    $("#btnCambiarConta").click(function () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'cambiarContabilidad_ajax')}",
            data:{

            },
            success: function(msg){
                bootbox.dialog({
                    title   : "",
                    message : msg,
                    class    : "long",
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    }
                });
            }
        })
    });


</script>

</body>
</html>