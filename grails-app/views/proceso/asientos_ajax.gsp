<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 11/05/17
  Time: 13:13
--%>

<style type="text/css">
.colorAtras{
    background-color: #ffbd4c;
    color: #0b0b0b;
}

.colorAsiento {
    color: #0b0b0b;
    background-color: #5aa6ff;
}

.derecha{
    text-align: right;
}

</style>


<div class="etiqueta"><label>Comprobante: </label> </div>${comprobante?.descripcion}
<div class="etiqueta"><label>Tipo:</label> ${comprobante?.tipo?.descripcion}</div>
<div class="etiqueta"><label>Número:</label> ${comprobante?.prefijo}${comprobante?.numero}</div>

<g:if test="${comprobante?.registrado != 'S'}">
    <div class="btn-group" style="float: right; margin-top: -40px">
        <a href="#" class="btn btn-success btnAgregarAsiento" comp="${comprobante?.id}" title="Agregar asiento contable">
            <i class="fa fa-plus"> Agregar Asiento</i>
        </a>
    </div>
</g:if>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr>
        <th style="width: 90px;">Asiento</th>
        <th style="width: 300px">Nombre</th>
        <th style="width: 70px">DEBE</th>
        <th style="width: 70px">HABER</th>
        <th style="width: 70px"><i class="fa fa-pencil"></i> </th>
    </tr>
    </thead>
</table>

<div class="row-fluid"  style="width: 99.7%;height: 200px;overflow-y: auto;float: right;margin-bottom: 20px">
    <div class="span12">
        <table class="table table-bordered table-condensed">
            <tbody>
            <g:each in="${asientos}" var="asiento">
                <g:if test="${asiento.comprobante == comprobante}">
                    <tr class="colorAsiento">
                        <td style="width: 140px">${asiento?.cuenta?.numero}</td>
                        <td style="width: 370px" colspan="3">${asiento?.cuenta?.descripcion}</td>
                        <td style="width: 100px" class="derecha">${asiento.debe ? g.formatNumber(number: asiento.debe, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2) : 0.00}</td>
                        <td style="width: 100px" class="derecha">${asiento.haber ? g.formatNumber(number: asiento.haber, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2) : 0.00}</td>
                        <td style="text-align: center; width: 115px">
                            <g:if test="${asiento?.comprobante?.registrado != 'S'}">
                                <div class="btn-group">
                                    <a href="#" class="btn btn-success btn-sm btnEditarAsiento" idAs="${asiento?.id}" title="Editar asiento">
                                        <i class="fa fa-pencil"></i>
                                    </a>
                                    <a href="#" class="btn btn-warning btn-sm btnAgregarAuxiliar" idAs="${asiento?.id}" title="Agregar auxiliar">
                                        <i class="fa fa-plus"></i>
                                    </a>
                                    <a href="#" class="btn btn-danger btn-sm btnEliminarAsiento" idAs="${asiento?.id}" title="Eliminar asiento">
                                        <i class="fa fa-times"></i>
                                    </a>
                                </div>
                            </g:if>
                        </td>
                    </tr>

                    <g:if test="${cratos.Auxiliar.findAllByAsiento(asiento)}">
                        <g:set var="auxiliares1" value="${cratos.Auxiliar.findAllByAsiento(asiento)}" />
                        <g:each in="${auxiliares1}" var="auxiliar">
                            <g:if test="${auxiliar.asiento.comprobante == comprobante}">
                                <tr>
                                    <th class="colorAtras" style="width: 70px;">Auxiliar</th>
                                    <th style="width: 150px" class="colorAtras">Proveedor</th>
                                    <th style="width: 80px" class="colorAtras">F.Pago</th>
                                    <th style="width: 100px" class="colorAtras">Pagar a</th>
                                    <th style="width: 80px" class="colorAtras">Pagar</th>
                                    <th style="width: 80px" class="colorAtras">Cobrar</th>
                                    <th style="width: 60px" class="colorAtras"><i class="fa fa-pencil"></i> </th>
                                </tr>
                                <tr class="colorAtras">
                                    <td></td>
                                    <td style="width: 150px">${auxiliar?.proveedor?.nombre}</td>
                                    <td style="width: 70px">${auxiliar?.fechaPago?.format("dd-MM-yyyy")}</td>
                                    <td style="width: 100px"></td>
                                    <td style="width: 70px" class="derecha">${auxiliar?.debe ? g.formatNumber(number: auxiliar.debe, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2) : 0.00}</td>
                                    <td style="width: 70px" class="derecha">${auxiliar.haber ? g.formatNumber(number: auxiliar.haber, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2) : 0.00}</td>

                                    <td style="text-align: center; width: 50px">
                                        <g:if test="${auxiliar?.asiento?.comprobante?.registrado != 'S'}">
                                            <div class="btn-group">
                                                <a href="#" class="btn btn-success btn-sm btnEditarAuxiliar" idAu="${auxiliar?.id}" title="Editar auxiliar">
                                                    <i class="fa fa-pencil"></i>
                                                </a>
                                                <a href="#" class="btn btn-danger btn-sm btnEliminarAuxiliar" idAu="${auxiliar?.id}" title="Eliminar auxiliar">
                                                    <i class="fa fa-trash-o"></i>
                                                </a>
                                            </div>
                                        </g:if>
                                    </td>
                                </tr>
                            </g:if>
                        </g:each>
                    </g:if>

                </g:if>
            </g:each>
            </tbody>
        </table>
    </div>
</div>

<div class="span12">
    <div id="divTotalesAsientos" style="width: 1020px; height: 20px;"></div>
</div>

<script type="text/javascript">

    <g:if test="${proceso?.id}">
    cargarTotalesAsientos('${proceso?.id}', '${comprobante?.id}');
    </g:if>


    function cargarTotalesAsientos(proceso, comprobante) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'totalesAsientos_ajax')}',
            data: {
                proceso: proceso,
                comprobante: comprobante
            },
            success: function (msg) {
                $("#divTotalesAsientos").html(msg)
            }
        });
    };




    $(".btnAgregarAsiento").click(function () {
        agregar('${comprobante?.id}', null)
    });

    $(".btnEditarAsiento").click(function () {
        var idAsiento = $(this).attr('idAs');
        agregar(${comprobante?.id}, idAsiento)
    });

    $(".btnAgregarAuxiliar").click(function () {
        var idAsiento = $(this).attr('idAs');
        agregarAuxiliar(${comprobante?.id}, idAsiento, null)
    });

    $(".btnEditarAuxiliar").click(function () {
        var idAux = $(this).attr('idAu');
        agregarAuxiliar(${comprobante?.id}, null, idAux)
    });

    $(".btnEliminarAsiento").click(function () {
        var idAsiento = $(this).attr('idAs');
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el asiento contable?</p>",
            buttons : {
                cancelar : {
                    label     : "<i class='fa fa-times'></i> Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash-o'></i> Borrar",
                    className : "btn-danger",
                    callback  : function () {
                        openLoader("Borrando..");
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'borrarAsiento_ajax')}',
                            data:{
                                asiento: idAsiento,
                                comprobante: '${comprobante?.id}'
                            },
                            success: function (msg){
                                var parts = msg.split("_");
                                if(parts[0] == 'ok'){
                                    log(parts[1],"success");
                                    cargarComprobante('${proceso?.id}');
                                    closeLoader();
                                }else{
                                    log(parts[1],"error");
                                    closeLoader();
                                }
                            }
                        });
                    }
                }
            }
        });
    });

    function agregar(compro, idAsiento){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso',action: 'formAsiento_ajax')}',
            data:{
                comprobante: compro,
                asiento: idAsiento
            },
            success: function (msg){
                bootbox.dialog({
                    title   : idAsiento ? "Editar Asiento" : "Nuevo Asiento",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        eliminar : {
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                if($("#valorAsientoDebe").val() == 0 && $("#valorAsientoHaber").val()== 0){
                                    bootbox.alert("Ingrese un valor distinto a cero")
                                    return false;
                                }else{
                                    if($("#idCuentaNueva").val()){
                                        openLoader("Guardando..");
                                        $.ajax({
                                            type: 'POST',
                                            url: '${createLink(controller: 'proceso', action: 'guardarAsiento_ajax')}',
                                            data:{
                                                asiento: idAsiento,
                                                cuenta: $("#idCuentaNueva").val(),
                                                debe : $("#valorAsientoDebe").val(),
                                                haber : $("#valorAsientoHaber").val(),
                                                proceso: '${proceso?.id}',
                                                comprobante: '${comprobante?.id}'
                                            },
                                            success: function (msg){
                                                if(msg == 'ok'){
                                                    log("Asiento contable guardado correctamente","success");
                                                    cargarComprobante('${proceso?.id}');
                                                    closeLoader();
                                                }else{
                                                    log("Error al guardar asiento contable","error");
                                                    closeLoader();
                                                }
                                            }
                                        });
                                    }else{
                                        bootbox.alert("Seleccione una cuenta")
                                        return false;
                                    }
                                }
                            }
                        }
                    }
                });
            }
        });
    }


    $(".btnEliminarAuxiliar").click(function () {
        var idAuxiliar = $(this).attr('idAu');
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el auxiliar contable?</p>",
            buttons : {
                cancelar : {
                    label     : "<i class='fa fa-times'></i> Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash-o'></i> Borrar",
                    className : "btn-danger",
                    callback  : function () {
                        openLoader("Borrando..");
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'borrarAuxiliar_ajax')}',
                            data:{
                                auxiliar: idAuxiliar,
                                comprobante: '${comprobante?.id}'
                            },
                            success: function (msg){
                                var parts = msg.split("_");
                                if(parts[0] == 'ok'){
                                    log(parts[1],"success");
                                    cargarComprobante('${proceso?.id}');
                                    closeLoader();
                                }else{
                                    log(parts[1],"error");
                                    closeLoader();
                                }
                            }
                        });
                    }
                }
            }
        });
    });


    function agregarAuxiliar(compro, idAsiento, idAuxiliar){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso',action: 'formAuxiliar_ajax')}',
            data:{
                comprobante: compro,
                asiento: idAsiento,
                auxiliar: idAuxiliar
            },
            success: function (msg){
                bootbox.dialog({
                    title   : idAuxiliar ? "Editar Auxiliar" : "Nuevo Auxiliar",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        eliminar : {
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                if($("#valorPagar").val() == 0 && $("#valorCobrar").val()== 0){
                                    bootbox.alert("Ingrese un valor distinto a cero");
                                    return false;
                                }else{
                                    openLoader("Guardando..");
                                    $.ajax({
                                        type: 'POST',
                                        url: '${createLink(controller: 'proceso', action: 'guardarAuxiliar_ajax')}',
                                        data:{
                                            asiento: idAsiento,
                                            debe : $("#valorPagar").val(),
                                            haber : $("#valorCobrar").val(),
                                            comprobante: '${comprobante?.id}',
                                            tipoPago: $("#tipoPago").val(),
                                            fechaPago: $(".fechaPago").val(),
                                            proveedor: $("#proveedor").val(),
                                            descripcion:  $("#descripcionAux").val(),
                                            auxiliar: idAuxiliar
                                        },
                                        success: function (msg){
                                            if(msg == 'ok'){
                                                log("Auxiliar contable guardado correctamente","success");
                                                cargarComprobante('${proceso?.id}');
                                                closeLoader();
                                            }else{
                                                log("Error al guardar el auxiliar contable","error");
                                                closeLoader();
                                            }
                                        }
                                    });
                                }
                            }
                        }
                    }
                });
            }
        });
    }


</script>