<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="cratos.Empresa; cratos.TipoProceso; cratos.utilitarios.BuscadorService" %>

<%
    def buscadorServ = grailsApplication.classLoader.loadClass('cratos.utilitarios.BuscadorService').newInstance()
%>

<html>
<head>
    <meta name="layout" content="main">
    <title>Procesos Contables</title>

    <style type="text/css">

    .alinear {
        text-align: center !important;
    }
    </style>

</head>

<body>



<div style="margin-top: -15px;" class="vertical-container">
    <p class="css-icono" style="margin-bottom: -15px"><i class="fa fa-folder-open-o"></i></p>

    <div class="linea45"></div>

    <div class="row" style="border-style: solid; border-radius:6px; border-width: 1px;
    height: 40px; border-color: #0c6cc2; margin-left: 10px;">
            <div class="col-xs-5" style="margin-left: 5px; margin-top: 2px;">
                <g:link class="btn btn-success" action="nuevoProceso" style="margin-left: -15px">
                    <i class="fa fa-file-o"></i> Nueva Transacción
                </g:link>
                <g:link class="btn btn-primary" action="procesosAnulados">
                    <i class="fa fa-times-circle"></i> Ir a Anulados
                </g:link>
            </div>
        <div style="margin-top: 2px; margin-right: 5px; text-align: right">
            <span class="text-info" style="font-size: 15px"><strong>${session?.contabilidad?.descripcion ?: 'No existe contabilidad asignada'}</strong></span>
                <a href="#" class="btn btn-azul" id="btnCambiarConta" style="margin-left: 5px;"
                   title="Cambiar a otra Contabilidad">
                    <i class="fa fa-refresh"></i> Cambiar
                </a>
        </div>
    </div>


    <div class="row" style="margin-bottom: 10px;">

        <div class="row-fluid">
            <div style="margin-left: 20px;">
                <div class="col-xs-5">
                    <div class="col-xs-4">
                        <b>Buscar por: </b>
                        <elm:select name="buscador" from = "${buscadorServ.parmProcesos()}" value="${params.buscador}"
                                    optionKey="campo" optionValue="nombre" optionClass="operador" id="buscador_con"
                                    style="width: 120px" class="form-control"/>
                    </div>
                    <div class="col-xs-4">
                        <strong style="margin-left: 20px;">Operación:</strong>
                        <span id="selOpt"></span>
                    </div>
                    <div class="col-xs-4">
                        <b style="margin-left: 20px">Criterio: </b>
                        <g:textField name="criterio" style="margin-right: 10px; width: 100%" value="${params.criterio}"
                                     id="criterio_con" class="form-control"/>

                    </div>
                </div>

                <div class="col-xs-2" style="margin-left: -20px;">
                    Desde:
                    <elm:datepicker name="fechaDesde" title="Fecha desde" id="fd" class="datepicker form-control fechaD"
                                    maxDate="new Date()"/>
                </div>

                <div class="col-xs-2" style="margin-left: -20px;">
                    Hasta:
                    <elm:datepicker name="fechaHasta" title="Fecha hasta" class="datepicker form-control fechaH"
                                    maxDate="new Date()"/>
                </div>

                <div class="col-xs-2" style="margin-left: -20px; width: 160px;">
                    Tipo:
                    <elm:select name="buscador" from = "${cratos.TipoProceso.list([sort:'codigo'])}" value="params.tpps?:0"
                                noSelection="${[0:'Todos']}" optionKey="id" optionValue="descripcion" id="tipo_proceso"
                                class="form-control"/>
                </div>

                <div class="btn-group col-xs-1" style="margin-left: -10px; margin-top: 20px; width: 110px;">

                    <a href="#" name="busqueda" class="btn btn-info" id="btnBusqueda" title="Buscar"
                       style="height: 34px; padding: 9px; width: 46px">
                        <i class="fa fa-search"></i></a>

                    <a href="#" name="limpiarBus" class="btn btn-warning" id="btnLimpiarBusqueda"
                       title="Borrar criterios" style="height: 34px; padding: 9px; width: 34px">
                        <i class="fa fa-eraser"></i></a>
                </div>

            </div>

        </div>
    </div>
</div>

<div style="margin-top: 30px; min-height: 650px" class="vertical-container">
    <p class="css-vertical-text">Procesos encontrados</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 1070px">
        <thead>
        <tr>
            <th class="alinear" style="width: 100px">Fecha</th>
            <th class="alinear" style="width: 280px">Descripción</th>
            <th class="alinear" style="width: 40px">R.</th>
            <th class="alinear" style="width: 160px">Documento</th>
            <th class="alinear" style="width: 80px">Valor</th>
            <th class="alinear" style="width: 70px">Ret.</th>
            <th class="alinear" style="width: 80px">Tipo</th>
            <th class="alinear" style="width: 260px">Proveedor</th>
        </tr>
        </thead>
    </table>

    <div id="bandeja">
    </div>
</div>

<div><strong>Nota</strong>: Si existen muchos registros que coinciden con el criterio de búsqueda, se retorna
como máximo 30 <span style="margin-left: 40px; color: #0b2c89">Se ordena por fecha de proceso desde el más reciente</span>
</div>

<div class="modal fade " id="dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
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


<script type="text/javascript">


    $(function () {
        $("#limpiaBuscar").click(function () {
            $("#buscar").val('');
        });
    });

    cargarBusqueda();

    function cargarBusqueda () {
        var id = parseInt(${session?.contabilidad?.id})
        console.log("cont", id);
        if(id > 0) {
            $("#bandeja").html("").append($("<div style='width:100%; text-align: center;'/>").append(spinnerSquare64));
            var desde = $(".fechaD").val();
            var hasta = $(".fechaH").val();
            $.ajax({
                type: "POST",
                url: "${g.createLink(controller: 'proceso', action: 'tablaBuscarPrcs')}",
                data: {
                    buscador: $("#buscador_con").val(),
                    criterio: $("#criterio_con").val(),
                    operador: $("#oprd").val(),
                    desde: desde,
                    hasta: hasta,
                    tpps: $("#tipo_proceso").val()
                },
                success: function (msg) {
                    $("#bandeja").html(msg);
                },
                error: function (msg) {
                    $("#bandeja").html("Ha ocurrido un error");
                }
            });
        } else {
            location.href = '${createLink(controller: "contabilidad", action: "list")}?id=-1';
        }

    }

    $("#btnBusqueda").click(function () {

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
            $("#btnBusqueda").click();
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
        var dtll = $tr.data("dtll");
        var rtcn = $tr.data("rtcn");

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
            icon: "fa fa-print",
            action: function () {
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
            icon: 'fa fa-clipboard',
            action: function () {
                location.href="${createLink(controller: 'proceso', action: 'comprobante')}/?proceso=" + id
            }
        };

        items.editar = editar;

//        if(tp == 'Compras' || tp == 'Ventas' || tp == 'Transferencias' || tp == 'Nota de crédito'){
        if(dtll){
            items.detalle = detalle;
        }

        if(rtcn){
            items.retencion = retencion;
        }

        if(tp == 'Compras' && cm == '41'){
            items.reembolso = reembolso
        }

        if(etdo == 'R') {
            items.comprobante = comprobante;
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


    $("#btnLimpiarBusqueda").click(function () {
        $(".fechaD, .fechaH, #criterio_con").val('');
    });

    $("#buscador_con").change(function(){
        var anterior = "${params.operador}";
        var opciones = $(this).find("option:selected").attr("class").split(",");
        poneOperadores(opciones);
        /* regresa a la opción seleccionada */
//        $("#oprd option[value=" + anterior + "]").prop('selected', true);
    });


    function poneOperadores (opcn) {
        var $sel = $("<select name='operador' id='oprd' style='width: 120px' class='form-control'>");
        for(var i=0; i<opcn.length; i++) {
            var opt = opcn[i].split(":");
            var $opt = $("<option value='"+opt[0]+"'>"+opt[1]+"</option>");
            $sel.append($opt);
        }
        $("#selOpt").html($sel);
    };

    /* inicializa el select de oprd con la primea opción de busacdor */
    $(document).ready(function() {
        $("#buscador_con").change();
    });




</script>

</body>
</html>