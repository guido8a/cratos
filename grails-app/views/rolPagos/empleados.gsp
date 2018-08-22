<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 20/08/18
  Time: 14:47
--%>


<%@ page import="cratos.RolPagos" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Detalle de Pagos por Empleado</title>

    <style>

    .centrado{
        text-align: center;
    }

    .izquierda{
        text-align: left;
    }

    </style>
</head>
<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="rolPagos" action="list" class="btn btn-warning btnRegresar">
            <i class="fa fa-chevron-left"></i> Regresar
        </g:link>
    </div>
</div>

<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <th style="width: 55%">Empleado</th>
        <th style="width: 15%">Ingresos</th>
        <th style="width: 15%">Descuentos</th>
        <th style="width: 15%">Total</th>
    </tr>
    </thead>
</table>

<div class="row-fluid"  style="width: 99.7%;height: 450px;overflow-y: auto;float: right;">
    <div class="span12">
        <div id="divTabla" style="width: 100%; height: 250px;"></div>
    </div>
</div>

<script type="text/javascript">

    cargarTablaEmpleados('${rol}');

    function cargarTablaEmpleados (rol) {

        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'rolPagos', action: 'tablaEmpleados_ajax')}',
            data:{
                id: rol
            },
            success: function (msg) {
                $("#divTabla").html(msg)
            }
        });

    }


    function createContextMenu(node) {
        var $tr = $(node);
//        var $tr = $(e.target).parent();
        $tr.addClass("success");
        var id = $tr.data("id");
        var rol = $tr.data("rol");

        var items = {
            header: {
                label: "Acciones",
                header: true
            }
        };

        var ver = {
            label  : 'Ver',
            icon   : "fa fa-pencil",
            action : function (e) {
                location.href="${createLink(controller: 'rolPagos', action: 'desglose')}/?id=" + id + "&rol=" + rol
            }
        };

        var imprimir = {
            label  : 'Imprimir',
            icon   : "fa fa-print",
            action : function (e) {

            }
        };

        items.ver = ver;
        items.imprimir = imprimir;


        return items
    }


</script>

</body>
</html>
