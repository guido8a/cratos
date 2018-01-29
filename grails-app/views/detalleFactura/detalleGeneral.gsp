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
    <title>Detalle de ${proceso?.tipoProceso?.codigo?.trim() == 'C' ? ' Compras' : (proceso?.tipoProceso?.codigo?.trim() == 'V' ? ' Ventas' : (proceso?.tipoProceso?.codigo?.trim() == 'T' ? 'Transferencias' : 'Nota de Crédito'))}</title>
    <style type="text/css">

    .camposTexto {
        text-align: center;
        margin-left: -25px;
    }

    </style>
</head>

<body>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link class="btn btn-primary btn-ajax" id="${proceso?.id}" controller="proceso"
                action="nuevoProceso">
            <i class="fa fa-chevron-left"></i> Proceso
        </g:link>
        <g:link class="btn btn-info" controller="proceso" action="buscarPrcs">
            <i class="fa fa-chevron-left"></i>
            Lista de Procesos
        </g:link>
    </div>
    <div class="btn-group">
        <g:if test="${!truncar}">
            <g:link class="btn btn-success btn-ajax" id="${proceso?.id}" controller="proceso"
                    action="actlProceso">
                <i class="fa fa-save"></i> Guardar
            </g:link>
        </g:if>
        <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'V'}">
            <a href="#" class="btn btn-info" id="btnImprimirDetalle">
                <i class="fa fa-print"></i> Imprimir Factura
            </a>
        </g:if>
    </div>
</div>


<div class="col-xs-12" style="text-align: center; margin-bottom: 20px">
    <b style="font-size: 18px;">Detalle de ${proceso?.tipoProceso?.codigo?.trim() == 'C' ? ' Compras' : (proceso?.tipoProceso?.codigo?.trim() == 'V' ? ' Ventas' : (proceso?.tipoProceso?.codigo?.trim() == 'T' ? 'Transferencias' : 'Nota de Crédito'))} de "${proceso?.descripcion}"</b>
</div>

<div class="vertical-container ${truncar ? 'hidden' : ''}" style="position: relative;float: left;width: 95%;padding-left: 45px;">
    <p class="css-vertical-text">Item</p>

    <div class="linea" style="height: 98%;"></div>

    <div class="col-xs-12" style="margin-bottom: 10px">
        <div class="col-xs-5" style="text-align: center">
            <b>Bodega</b>
            <g:select from="${bodegas}" name="bodegasName" id="bodegas" class="form-control" optionValue="descripcion"
                      optionKey="id"/>
        </div>

        <div class="col-xs-5" style="text-align: center">
            <b>Centro de Costos</b>
            <g:select from="${centros}" name="centroName" id="centros" class="form-control" optionValue="nombre"
                      optionKey="id"/>
        </div>

    </div>
    <g:hiddenField name="idItem_name" id="idItem" value=""/>
    <g:hiddenField name="idDetalle_name" id="idDetalle" value=""/>
    <g:hiddenField name="cantiOriginal_name" id="cantiOriginal" value=""/>

    <div class="col-xs-2" style="text-align: center">
        <b>Código</b>
        <g:textField name="codigo_name" id="codigoItem" class="form-control" value="" readonly="true"/>
    </div>

    <div class="col-xs-4 camposTexto" style="margin-left: -25px; width: 400px">
        <b>Nombre</b>
        <g:textField name="nombre_name" id="nombreItem" class="form-control" value="" readonly="true"/>
    </div>

    <div class="col-xs-1" style="width: 140px;">
        <b>Precio</b>
        <g:textField name="precio_name" id="precioItem" class="form-control number pre" value=""
                     style="text-align: right;" readonly="${proceso?.tipoProceso?.codigo?.trim() == 'NC' }"/>
    </div>

    <div class="col-xs-1 camposTexto">
        <b>Cant.</b>
        <g:textField name="cantidad_name" id="cantidadItem" class="form-control validacionNumeroSinPuntos canti" value=""
                     style="text-align: right"/>
    </div>
    <g:if test="${proceso?.tipoProceso?.codigo?.trim() != 'T'}">
        <div class="col-xs-1" style="margin-left: -25px">
            <b>Desc.</b>
            <g:textField name="descuento_name" id="descuentoItem" class="form-control number desc" value=""
                         style="text-align: right"/>
        </div>

        <div class="col-xs-1" style="margin-left: -25px; width: 140px;">
            <b>Total</b>
            <g:textField name="total_name" id="totalItem" class="form-control number tot" value=""
                         style="text-align: right; width: 120px"
                         readonly="${proceso?.tipoProceso?.codigo?.trim() == 'V'}"/>
        </div>
    </g:if>


    <div class="col-xs-2" style="margin-top: 25px; margin-bottom: 15px; margin-left: -10px; width: 110px">
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
            <th style="width: 90px">Código</th>
            <th style="width: 200px">Descripción</th>
            <th style="width: 50px">Bodega</th>
            <th style="width: 50px">C. Cost.</th>
            <th style="width: 30px">Uni</th>
            <th style="width: 40px">Canti</th>
            <th style="width: 80px">P.U.</th>
            <g:if test="${proceso?.tipoProceso?.id != 8}">
                <th style="width: 50px">% Desc</th>
            </g:if>
            <th style="width: 90px">Total</th>
            <th style="width: 60px"><i class="fa fa-pencil"></i></th>
        </tr>
        </thead>
    </table>

    <div style="width: 99.7%;height: 500px;overflow-y: auto;float: right;" id="divTablaDetalle"></div>
</div>

<script type="text/javascript">

    $("#btnImprimirDetalle").click(function () {

        switch (${empresa?.ruc}) {
            case 0992149892001:
                url = "${g.createLink(controller:'reportes2' , action: 'factura')}?id=" + '${proceso?.id}' + "Wemp=${session.empresa.id}";
                location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=detalle.pdf"
                break;
            case 1702155502101:
                url = "${g.createLink(controller:'reportes2' , action: 'factura_E2')}?id=" + '${proceso?.id}' + "Wemp=${session.empresa.id}";
                location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=detalle.pdf"
                break;
        }
    });

    $(".btnIrProceso").click(function () {
        location.href='${createLink(controller: 'proceso', action: 'nuevoProceso')}?id=' + '${proceso?.id}'
    });

    function validarNumSinPuntos(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
        (ev.keyCode >= 96 && ev.keyCode <= 105) ||
        ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
        ev.keyCode == 37 || ev.keyCode == 39 );
    }

    $(".validacionNumeroSinPuntos").keydown(function (ev) {
        return validarNumSinPuntos(ev);
    }).keyup(function () {
    });

    $("#codigoItem").dblclick(function () {
        buscarItem();
    });

    $("#btnBuscar").click(function () {
        buscarItem();
    });

    function buscarItem() {
        var bodega = $("#bodegas").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'detalleFactura', action: 'buscarItems_ajax')}',
            data: {
                proceso: '${proceso?.id}',
                bodega: bodega
            },
            success: function (msg) {
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
        var idDet = $("#idDetalle").val();
        guardarDetalle(idDet)
    });

    $("#btnGuardar").click(function () {
        var idDet = $("#idDetalle").val();
        guardarDetalle(idDet)
//        $("#btnBuscar").removeClass('hidden');
//        $("#btnAgregar").removeClass('hidden');
//        $("#btnGuardar").addClass('hidden');
//        $("#btnCancelar").addClass('hidden');
    });

    function guardarDetalle(id) {
        var item = $("#idItem").val();
        var precio = $("#precioItem").val();
        var cantidad = $("#cantidadItem").val();
        var descuento = $("#descuentoItem").val();
        var bodega = $("#bodegas").val();
        var centro = $("#centros").val();
        var original = $("#cantiOriginal").val();
        if (!item) {
            log("Debe seleccionar un item!", 'error')
        } else {
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'detalleFactura', action: 'guardarDetalle_ajax')}',
                data: {
                    item: item,
                    precio: precio,
                    cantidad: cantidad,
                    descuento: descuento,
                    bodega: bodega,
                    centro: centro,
                    proceso: '${proceso?.id}',
                    id: id,
                    original: original
                },
                success: function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == 'ok') {
                        log(parts[1], "success");
                        cargarTablaDetalle();
                        cancelar();
                        ocultar();
                    } else {
                        log(parts[1], "error");
                    }
                }
            });
        }


    }


    cargarTablaDetalle();

    function cargarTablaDetalle() {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'detalleFactura', action: 'tablaDetalle_ajax')}',
            data: {
                proceso: '${proceso?.id}'
            },
            success: function (msg) {
                $("#divTablaDetalle").html(msg)
            }

        });
    }

    $(".canti").blur(function () {
        if (isNaN($(this).val()))
            $(this).val("1")
        if ($(this).val() == "")
            $(this).val("1")
        if ($(this).val() == 0)
            $(this).val("1")
    });

    $(".desc").blur(function () {
        if (isNaN($(this).val()))
            $(this).val("0")
        if ($(this).val() == "")
            $(this).val("0")
    });

    $(".pre").blur(function () {
        if (isNaN($(this).val()))
            $(this).val("1")
        if ($(this).val() == "")
            $(this).val("1")
    });

    $(".tot").keyup(function () {
        var pr = 0;

        if (!$(".pre").val()) {
            $(".pre").val(1)
        }

        if (!$(".canti").val()) {
            $(".canti").val(1)
        }

        if (isNaN($(this).val())) {
            var to = $(".pre").val() * $(".canti").val();
            $(this).val(to.toFixed(2))
        } else {
            pr = $(".tot").val() / $(".canti").val();
            $(".pre").val(pr.toFixed(4))
        }
        if ($(this).val() == "") {
            var to1 = $(".pre").val() * $(".canti").val();
            $(this).val(to1.toFixed(2))
        } else {
            pr = $(".tot").val() / $(".canti").val();
            $(".pre").val(pr.toFixed(4))
        }

    });

    $(".pre").keyup(function () {
        calcularTotal();
    });


    %{--$( document ).ready(function() {--}%
        %{--if(${proceso?.tipoProceso?.codigo?.trim() == 'C'}){--}%
            %{--$(".canti").keyup(function () {--}%
                %{--calcularTotal();--}%
            %{--});--}%
        %{--}else{--}%
            %{--$(".canti").keyup(function () {--}%
                %{--verificarExistencia();--}%
                %{--calcularTotal();--}%
            %{--});--}%
        %{--}--}%
    %{--});--}%

    $(".desc").keyup(function () {
        calcularTotal();
    });


    function calcularTotal() {
        if (!$(".pre").val()) {
            $(".pre").val(1)
        }

        if (!$(".canti").val()) {
            $(".canti").val(1)
        }

        var to = 0
        if (${proceso?.tipoProceso?.codigo?.trim() == 'V'}) {
            if (!$(".desc").val()) {
                $(".desc").val(0)
            }
            to = ($(".pre").val() ) * (1 - ($(".desc").val() / 100)) * $(".canti").val();
        } else {
            to = ($(".pre").val() ) * $(".canti").val();
        }

        $(".tot").val(to.toFixed(2))



    }

//    function verificarExistencia () {
//        var cantidad = $(".canti").val()
//        var item = $("#idItem").val()
//        var original = $("#cantiOriginal").val()
//
//        if(Math.round(cantidad*100)/100 > Math.round(original*100)/100){
//            $(".canti").val(original)
//        }
//    }


    $("#btnCancelar").click(function () {
        cancelar();
        ocultar();
    });

    function cancelar() {
        $("#idDetalle").val('');
        $("#codigoItem").val('');
        $("#nombreItem").val('');
        $("#precioItem").val('');
        $("#cantidadItem").val('').attr('readonly', false);
        $("#descuentoItem").val('');
        $("#idItem").val('');
        $("#totalItem").val('').attr('readonly', false);
        $("#cantiOriginal").val('')
    }

    function ocultar() {
        $("#btnBuscar").removeClass('hidden');
        $("#btnAgregar").removeClass('hidden');
        $("#btnGuardar").addClass('hidden');
        $("#btnCancelar").addClass('hidden');
    }



</script>

</body>
</html>