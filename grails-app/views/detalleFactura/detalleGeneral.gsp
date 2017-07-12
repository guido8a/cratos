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
</head>

<body>

<div class="col-md-12" style="text-align: center; margin-bottom: 20px">
       <b style="font-size: 18px;">Detalle de ${proceso?.tipoProceso?.id == 1 ? ' Compras' : (proceso?.tipoProceso?.id == 2 ? ' Ventas' : ' Transferencias')}</b>
</div>
<div class="col-md-12">

    <div class="col-md-5">
        <g:select from="${bodegas}" name="bodegasName" class="form-control" optionValue="descripcion" optionKey="id"/>
    </div>

    <div class="col-md-5">
        <g:select from="${centros}" name="centroName" class="form-control" optionValue="nombre" optionKey="id"/>
    </div>

</div>

<div class="col-md-2">
    <b>Código</b>
    <g:textField name="codigo_name" id="codigoItem" class="form-control" value="" readonly="true"/>
</div>
<div class="col-md-4" style="margin-left: -25px">
    <b>Nombre</b>
    <g:textField name="nombre_name" id="nombreItem" class="form-control" value="" readonly="true"/>
</div>
<div class="col-md-2" style="margin-left: -25px">
    <b>Precio</b>
    <g:textField name="precio_name" id="precioItem" class="form-control" value=""/>
</div>
<div class="col-md-1" style="margin-left: -25px">
    <b>Cantidad</b>
    <g:textField name="cantidad_name" id="cantidadItem" class="form-control" value=""/>
</div>
<g:if test="${proceso?.tipoProceso?.id != 8}">
    <div class="col-md-2" style="margin-left: -25px">
        <b>Descuento</b>
        <g:textField name="descuento_name" id="descuentoItem" class="form-control" value=""/>
    </div>
</g:if>

<div class="col-md-2" style="margin-top: 20px">
    <b></b>
    <a href="#" id="btnBuscar" class="btn btn-info" title="Buscar Item">
        <i class="fa fa-search"></i>
    </a>
    <a href="#" id="btnAgregar" class="btn btn-success" title="Agregar Item">
        <i class="fa fa-plus"></i>
    </a>
</div>

<div class="vertical-container" style="position: relative;float: left;width: 95%;padding-left: 45px">
    <p class="css-vertical-text">Detalle de Items</p>
    <div class="linea" style="height: 98%;"></div>
    <table class="table table-bordered table-hover table-condensed" style="margin-top: 10px">
        <thead>
        <tr>
            <th style="width: 70px">Código</th>
            <th style="width: 250px">Descripción</th>
            <th style="width: 70px">Unidad</th>
            <th style="width: 70px">Cantidad</th>
            <th style="width: 70px">P.U.</th>
            <g:if test="${proceso?.tipoProceso?.id != 8}">
                <th style="width: 70px">% Descuento</th>
            </g:if>
            <th style="width: 70px">Total</th>
        </tr>
        </thead>
    </table>
    <div style="width: 99.7%;height: 500px;overflow-y: auto;float: right;" id="detalle"></div>
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


</script>




</body>
</html>