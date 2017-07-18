<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 06/07/17
  Time: 12:39
--%>

<div class="row" style="margin-bottom: 20px">
    <div class="col-md-1">
        <label>Código:</label>
    </div>
    <div class="col-md-2">
        <g:textField name="codigoItem_name" id="codigoBuscar" class="form-control"/>
    </div>
    <div class="col-md-1">
        <label>Nombre:</label>
    </div>
    <div class="col-md-4">
        <g:textField name="nombreItem_name" id="nombreBuscar" class="form-control"/>
    </div>
    <div class="col-md-2">
        <a href="#" class="btn btn-info" id="btnBuscarItem"><i class="fa fa-search"></i> Buscar item</a>
    </div>
</div>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr>
        <th style="width: 80px">Código</th>
        <th style="width: 240px">Nombre</th>
        <th style="width: 80px">Precio</th>
        <th style="width: 55px"><i class="fa fa-plus"></i> </th>
    </tr>
    </thead>
</table>

<div class="row-fluid"  style="width: 99.7%;height: 250px;overflow-y: auto;float: right;">
    <div class="span12">
        <div id="divTablaItems" style="width: 1030px; height: 250px;"></div>
    </div>
</div>

<script type="text/javascript">

    $("#btnBuscarItem").click(function () {
        cargarTablaItems();
    });

    function cargarTablaItems () {
        var codigo = $("#codigoBuscar").val();
        var nombre = $("#nombreBuscar").val();
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'detalleFactura', action: 'tablaItems_ajax')}',
            data:{
                proceso: '${proceso?.id}',
                codigo: codigo,
                nombre: nombre
            },
            success: function (msg) {
                $("#divTablaItems").html(msg)
            }
        })
    }

    $("#codigoBuscar").keyup(function (ev) {
        if (ev.keyCode == 13) {
            cargarTablaItems();
        }
    });

    $("#nombreBuscar").keyup(function (ev) {
        if (ev.keyCode == 13) {
            cargarTablaItems();
        }
    });


</script>