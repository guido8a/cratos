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
        <th style="width: 150px">Código</th>
        <th style="width: 250px">Nombre</th>
        <th style="width: 70px">Precio</th>
        <th style="width: 50px"><i class="fa fa-plus"></i> </th>
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
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'detalle', action: 'tablaItems_ajax')}',
            data:{

            },
            success: function (msg) {
                $("#divTablaItems").html(msg)
            }
        })
    }

</script>