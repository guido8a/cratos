<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Gestores Contables</title>

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

    <div class="linea45"></div>

    <div>
        <div class="col-md-3">
            <g:link class="btn btn-primary" action="nuevoProceso">
                <i class="fa fa-file-o"></i> Nuevo Gestor
            </g:link>
        </div>

        <div class="col-md-7" style="margin-left: 20px;">
            Buscar por:
            <div class="btn-group">
                <input id="buscar" type="search" class="form-control" value="${session.buscar}">
                <span id="limpiaBuscar" class="glyphicon glyphicon-remove-circle"
                      title="Limpiar texto de búsqueda"></span>
            </div>
            <a href="#" name="busqueda" class="btn btn-azul btnBusqueda btn-ajax"><i
                    class="fa fa-check-square-o"></i> Buscar</a>
        </div>
    </div>
</div>

<div style="margin-top: 30px; min-height: 650px" class="vertical-container">
    <p class="css-vertical-text">Gestores encontrados</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 1070px">
        <thead>
        <tr>
            <th class="alinear" style="width: 130px">Proceso</th>
            <th class="alinear" style="width: 700px">Nombre</th>
            <th class="alinear" style="width: 120px">Estado</th>
            <th class="alinear" style="width: 120px">Tipo</th>
        </tr>
        </thead>
    </table>

    <div id="bandeja">
    </div>
</div>

<div><strong>Nota</strong>: Si existen muchos registros que coinciden con el criterio de búsqueda, se retorna
  como máximo 20 <span style="margin-left: 40px; color: #0b2c89">Se ordena por proceso y nombre del gestor</span>
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
            url: "${g.createLink(action: 'tablaBuscarGstr')}",
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
            label: " Editar",
            icon: "fa fa-file-text-o",
            action: function () {
                location.href = '${createLink(action: "formGestor")}?id=' + id;
            }
        };

        var ver = {
            label: " Ver gestor",
            icon: "fa fa-search-plus",
            action: function () {
                location.href = '${createLink(action: "formGestor")}?id=' + id;
            }
        };

        var copiar = {
            label: " Copiar gestor..",
            icon: "fa fa-copy",
            action: function () {
                location.href = '${createLink(action: "copiarGestor")}?id=' + id;
            }
        };


        if(etdo != 'R') {
            items.editar = editar;
        }
        items.ver = ver;
        items.copiar = copiar;

        return items
    }


</script>

</body>
</html>