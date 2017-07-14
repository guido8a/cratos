<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 05/07/17
  Time: 15:35
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Detalle de ${proceso?.tipoProceso?.id == 1 ? ' Compras' : (proceso?.tipoProceso?.id == 2 ? ' Ventas' : ' Transferencias')}</title>
    <style type="text/css">

    .camposTexto{
        text-align: center;
        margin-left: -25px;
    }

    </style>
</head>

<body>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link class="btn regresar btn-primary btn-ajax" id="${proceso?.id}" controller="proceso" action="nuevoProceso">
            <i class="fa fa-chevron-left"></i> Proceso</g:link>
    </div>
</div>



<div class="col-md-12" style="text-align: center; margin-bottom: 20px">
    <b style="font-size: 18px;">Detalle de ${proceso?.tipoProceso?.id == 1 ? ' Compras' : (proceso?.tipoProceso?.id == 2 ? ' Ventas' : ' Transferencias')} de ${proceso?.descripcion}</b>
</div>

<div class="vertical-container" style="position: relative;float: left;width: 95%;padding-left: 45px;">
    <p class="css-vertical-text">Item</p>
    <div class="linea" style="height: 98%;"></div>

    <div class="col-md-12" style="margin-bottom: 10px">
        <div class="col-md-5" style="text-align: center">
            <b>Bodega</b>
            <g:select from="${bodegas}" name="bodegasName" id="bodegas" class="form-control" optionValue="descripcion" optionKey="id"/>
        </div>

        <div class="col-md-5" style="text-align: center">
            <b>Centro de Costos</b>
            <g:select from="${centros}" name="centroName" id="centros" class="form-control" optionValue="nombre" optionKey="id"/>
        </div>

    </div>
    <g:hiddenField name="idItem_name" id="idItem" value=""/>
    <g:hiddenField name="idDetalle_name" id="idDetalle" value=""/>

    <div class="col-md-2" style="text-align: center">
        <b>Código</b>
        <g:textField name="codigo_name" id="codigoItem" class="form-control" value="" readonly="true"/>
    </div>
    <div class="col-md-4 camposTexto">
        <b>Nombre</b>
        <g:textField name="nombre_name" id="nombreItem" class="form-control" value="" readonly="true"/>
    </div>
    <div class="col-md-2 camposTexto">
        <b>Precio</b>
        <g:textField name="precio_name" id="precioItem" class="form-control number" value="" style="text-align: right"/>
    </div>
    <div class="col-md-1 camposTexto">
        <b>Cantidad</b>
        <g:textField name="cantidad_name" id="cantidadItem" class="form-control number canti" value="" style="text-align: center"/>
    </div>
    <g:if test="${proceso?.tipoProceso?.id != 8}" >
        <div class="col-md-2 camposTexto">
            <b>Descuento</b>
            <g:textField name="descuento_name" id="descuentoItem" class="form-control number desc" value="" style="text-align: right"/>
        </div>
    </g:if>

    <div class="col-md-2" style="margin-top: 20px; margin-bottom: 20px">
        <b></b>
        <a href="#" id="btnBuscar" class="btn btn-info" title="Buscar Item">
            <i class="fa fa-search"></i>
        </a>
        <a href="#" id="btnAgregar" class="btn btn-success" title="Agregar Item al detalle">
            <i class="fa fa-plus"></i>
        </a>

        <a href="#" id="btnGuardar" class="btn btn-success hidden" title="Guardar Item">
            <i class="fa fa-save"></i>
        </a>

        <a href="#" id="btnCancelar" class="btn btn-warning hidden" title="Cancelar Edición">
            <i class="fa fa-times-circle"></i>
        </a>
    </div>
</div>

<div class="vertical-container" style="position: relative;float: left;width: 95%;padding-left: 45px">
    <p class="css-vertical-text">Tabla de Items</p>
    <div class="linea" style="height: 98%;"></div>
    <table class="table table-bordered table-hover table-condensed" style="margin-top: 10px">
        <thead>
        <tr>
            <th style="width: 70px">Código</th>
            <th style="width: 250px">Descripción</th>
            <th style="width: 50px">Bodega</th>
            <th style="width: 50px">C. Cost.</th>
            <th style="width: 40px">Uni</th>
            <th style="width: 70px">Canti</th>
            <th style="width: 70px">P.U.</th>
            <g:if test="${proceso?.tipoProceso?.id != 8}">
                <th style="width: 50px">% Desc</th>
            </g:if>
            <th style="width: 70px">Total</th>
            <th style="width: 40px"><i class="fa fa-pencil"></i> </th>
        </tr>
        </thead>
    </table>
    <div style="width: 99.7%;height: 500px;overflow-y: auto;float: right;" id="divTablaDetalle"></div>
</div>

<script type="text/javascript">

    $("#codigoItem").click(function () {
        buscarItem();
    });

    $("#btnBuscar").click(function () {
        buscarItem();
    });

    function buscarItem () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'detalleFactura', action: 'buscarItems_ajax')}',
            data:{
                proceso: '${proceso?.id}'
            },
            success: function (msg){
                bootbox.dialog({
                    title: "Buscar Item",
                    class: 'long',
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    }
                });
            }
        });
    }


    $("#btnAgregar").click(function () {
       guardarDetalle()
    });

    $("#btnGuardar").click(function () {
        var idDet = $("#idDetalle").val();
       guardarDetalle(idDet)
    });


    function guardarDetalle (id) {
        var item = $("#idItem").val();
        var precio = $("#precioItem").val();
        var cantidad = $("#cantidadItem").val();
        var descuento = $("#descuentoItem").val();
        var bodega = $("#bodegas").val();
        var centro = $("#centros").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'detalleFactura', action: 'guardarDetalle_ajax')}',
            data:{
                item: item,
                precio: precio,
                cantidad: cantidad,
                descuento: descuento,
                bodega: bodega,
                centro: centro,
                proceso: '${proceso?.id}',
                id: id

            },
            success: function (msg){
                if(msg == 'ok'){
                    log("Item agregado correctamente!", "success");
                    cargarTablaDetalle();
                }else{
                    log("Error al agregar el item al detalle","error");
                }
            }
        });
    }


    cargarTablaDetalle();

    function cargarTablaDetalle () {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'detalleFactura', action: 'tablaDetalle_ajax')}',
            data:{
                proceso: '${proceso?.id}'
            },
            success: function (msg){
                $("#divTablaDetalle").html(msg)
            }

        });
    }

    $(".canti").blur(function () {
        if (isNaN($(this).val()))
            $(this).val("1")
        if ($(this).val() == "")
            $(this).val("1")
    });

    $(".desc").blur(function () {
        if (isNaN($(this).val()))
            $(this).val("0")
        if ($(this).val() == "")
            $(this).val("0")
    });


    $("#btnCancelar").click(function () {
        $("#idDetalle").val('');
        $("#codigoItem").val('');
        $("#nombreItem").val('');
        $("#precioItem").val('');
        $("#cantidadItem").val('');
        $("#descuentoItem").val('');
        $("#idItem").val('');
        $("#btnBuscar").removeClass('hidden');
        $("#btnAgregar").removeClass('hidden');
        $("#btnGuardar").addClass('hidden');
        $("#btnCancelar").addClass('hidden');
    });



</script>

</body>
</html>