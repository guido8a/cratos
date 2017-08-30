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

    <div class="linea45"></div>

    <div>
        <div class="col-md-2">
            <g:link class="btn btn-primary" action="nuevoProceso">
                <i class="fa fa-file-o"></i> Nueva Transacción
            </g:link>
        </div>
        <div class="col-md-1">
            <g:link class="btn btn-primary" action="procesosAnulados">
                <i class="fa fa-file-o"></i> Anulados
            </g:link>
        </div>



        <div class="row">
            <div class="col-md-2" style="margin-right: 0px; padding: 0; margin-left: 150px ">
                <span class="text-info" style="font-size: 15px"><strong>${session.contabilidad.descripcion}</strong></span>
            </div>
            <div class="col-md-1" >
                <a href="#" class="btn btn-azul" id="btnCambiarConta" style="margin-left: -20px">
                    <i class="fa fa-refresh"></i> Cambiar
                </a>
            </div>
        </div>


        %{--<div class="col-md-2" style="margin-right: 0px; padding: 0 ">--}%
        %{--<span class="text-info" style="font-size: 15px"><strong>${session.contabilidad.descripcion}</strong></span>--}%
        %{--</div>--}%
        %{--<div class="col-md-1" >--}%
        %{--<a href="#" class="btn btn-azul" id="btnCambiarConta" style="margin-left: -20px">--}%
        %{--<i class="fa fa-refresh"></i> Cambiar--}%
        %{--</a>--}%
        %{--</div>--}%
    </div>


    <div class="row" style="margin-bottom: 10px">

        <div class="col-md-4" style="margin-left: 10px;">
            Buscar por:
            <div class="btn-group">
                <input id="buscar" type="search" class="form-control" value="${session.buscar}">
                <span id="limpiaBuscar" class="glyphicon glyphicon-remove-circle"
                      title="Limpiar texto de búsqueda"></span>
            </div>
        </div>


        <div class="col-md-1 " style="margin-left: -20px">
            Desde:
        </div>
        <div class="col-md-2">

            <elm:datepicker name="fechaDesde" title="Fecha desde" id="fd"
                            class="datepicker form-control fechaD"
                            maxDate="new Date()"
                            style="width: 80px; margin-left: -25px"/>
        </div>

        <div class="col-md-1">
            Hasta:
        </div>
        <div class="col-md-2">

            <elm:datepicker name="fechaHasta" title="Fecha hasta"
                            class="datepicker form-control fechaH"
                            maxDate="new Date()"
                            style="width: 80px; margin-left: -15px"/>
        </div>



        <div class="btn-group col-md-2" style="margin-left: -10px;">

            <a href="#" name="busqueda" class="btn btn-info btnBusqueda btn-ajax">
                <i class="fa fa-check-square-o"></i> Buscar</a>

            <a href="#" name="limpiarBus" class="btn btn-warning btnLimpiarBusqueda btn-ajax" title="Limpiar búsqueda" style="height: 34px">
                <i class="fa fa-eraser"></i></a>

        </div>

    </div>

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
            <th class="alinear" style="width: 80px">Comprobante</th>
            <th class="alinear" style="width: 80px">Tipo</th>
            <th class="alinear" style="width: 180px">Proveedor</th>
        </tr>
        </thead>
    </table>

    <div id="bandeja">
    </div>
</div>

<div><strong>Nota</strong>: Si existen muchos registros que coinciden con el criterio de búsqueda, se retorna
como máximo 20 <span style="margin-left: 40px; color: #0b2c89">Se ordena por fecha de proceso desde el más reciente</span>
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




    //    $('.fechaD').datepicker()
    //        .on("input change", function (e) {
    //            asignarMinimo();
    //        });
    //
//    $(".fechaD").change(function () {
//        asignarMinimo();
//    });




//    $(".fechaD").datepicker({
//        onSelect: function() {
//            //- get date from another datepicker without language dependencies
//            var minDate = $('.fechaD').datepicker('getDate');
//            console.log(" -- " + minDate)
//            $(".fechaH").datepicker("change", { minDate: minDate });
//        }
//    });

//
//    function asignarMinimo(){
////        $(".fechaH").attr("minDate",$(".fechaD").val())
////        $('.fechaH').datepicker('option', 'minDate',new Date ($(".fechaD").val()))
////        var minDate = $('.fechaD').datepicker('getDate');
////        console.log(" -- " + minDate)
////        $(".fechaH").datepicker("change", { minDate: new Date($(".fechaD").val()) });
//        $(".fechaH").datepicker('destroy')
//        $(".fechaH").attr("minDate", '22-8-2017');
//
//    }

    cargarBusqueda();

    function cargarBusqueda () {
        $("#bandeja").html("").append($("<div style='width:100%; text-align: center;'/>").append(spinnerSquare64));
        var buscar = $("#buscar").val();
        var desde = $(".fechaD").val();
        var hasta = $(".fechaH").val();
        var datos = "buscar=" + buscar;

        $.ajax({
            type: "POST",
            url: "${g.createLink(controller: 'proceso', action: 'tablaBuscarPrcs')}",
            data: {
                buscar: buscar,
                desde: desde,
                hasta: hasta
            },
            success: function (msg) {
                $("#bandeja").html(msg);
            },
            error: function (msg) {
                $("#bandeja").html("Ha ocurrido un error");
            }
        });
    }

    $(".btnBusqueda").click(function () {

        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
            data:{
                desde: $(".fechaD").val(),
                hasta: $(".fechaH").val()
            },
            success: function (msg){
                if(msg != 'ok'){
                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                    return false;
                }else{
                    cargarBusqueda();
                }
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
        var tp = $tr.data("tipo");
        var cm = $tr.data("cm");



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
                %{--location.href = '${createLink(controller: "proceso", action: "detalleSri")}?id=' + id;--}%
                var url = "${g.createLink(controller: 'reportes3', action: 'imprimirCompDiario')}?id=" + id + "Wempresa=${session.empresa.id}";
                location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=comprobante.pdf";
            }
        };

        var detalle = {
            label: " Detalle",
            icon: "fa fa-bars",
            action: function () {
                location.href = '${createLink(controller: "detalleFactura", action: "detalleGeneral")}?id=' + id;
            }
        };


        var reembolso = {
            label: ' Reembolso',
            icon: 'fa fa-thumbs-up',
            action: function () {
                location.href="${createLink(controller: 'proceso', action: 'reembolso')}/?proceso=" + id
            }
        };
        var comprobante = {
            label: 'Comprobante',
            icon: 'fa fa-calendar-o',
            action: function () {
                location.href="${createLink(controller: 'proceso', action: 'comprobante')}/?proceso=" + id
            }
        };

        items.editar = editar;

        if(tp == 'Compras' || tp == 'Ventas' || tp == 'Transferencias' || tp == 'Nota de crédito'){
            items.detalle = detalle;
        }

        if(tp == 'Compras' && cm == '41'){
            items.reembolso = reembolso
        }


        if(etdo == 'R') {
            items.comprobante = comprobante;
            items.retencion = retencion;
            items.imprimir = imprimir;
        }


        return items
    }

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


    $(".btnLimpiarBusqueda").click(function () {
        $(".fechaD").val('');
        $(".fechaH").val('');
        $("#buscar").val('');
    });



    $(".btnBusquedaFechas").click(function () {
        $.ajax({
            type:'POST',
            url: '${createLink(controller: 'proceso', action:'fechas_ajax')}',
            data:{

            },
            success: function(msg){
                bootbox.dialog({
                    title   : "Búsqueda por fechas",
                    message : msg,
                    //                    class    : "long",
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar : {
                            label     : "<i class='fa fa-save'></i> Aceptar",
                            className : "btn-success",
                            callback  : function () {
                                $.ajax({
                                    type: 'POST',
                                    url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                                    data:{
                                        desde: $(".fechaD").val(),
                                        hasta: $(".fechaH").val()
                                    },
                                    success: function (msg){
                                        if(msg != 'ok'){
                                            bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                                            return false;
                                        }else{

                                        }
                                    }
                                })

                            }
                        }
                    }
                });
            }
        });
    });


</script>

</body>
</html>