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

    </style>
</head>
<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <th style="width: 50%">Empleado</th>
        <th style="width: 25%">Rubro</th>
        <th style="width: 25%">Valor</th>
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


</script>

</body>
</html>
