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

</style>


<div class="etiqueta"><label>Comprobante: </label></div> ${comprobante?.descripcion}<br>
<div class="etiqueta">Tipo:</div> ${comprobante?.tipo?.descripcion}<br>
<div class="etiqueta">Número:</div> ${comprobante?.prefijo}${comprobante?.numero}<br>

<div class="btn-group" style="float: right; margin-top: -40px">
    <a href="#" class="btn btn-success btnAgregarAsiento" comp="${comprobante?.id}" title="Agregar asiento contable">
        <i class="fa fa-plus"> Agregar Asiento</i>
    </a>
</div>


<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr>
        <th style="width: 100px;">Asiento</th>
        <th style="width: 280px">Nombre</th>
        <th style="width: 80px">Valor</th>
        <th style="width: 80px">Valor</th>
        <th style="width: 70px"><i class="fa fa-pencil"></i> </th>
    </tr>
    </thead>
</table>

<div class="row-fluid"  style="width: 99.7%;height: 130px;overflow-y: auto;float: right;margin-bottom: 20px">
    <div class="span12">
        <table class="table table-bordered table-hover table-condensed">
            <tbody>
            <g:each in="${asientos}" var="asiento">
                <g:if test="${asiento.comprobante == comprobante}">
                    <tr>
                        <td style="width: 100px">${asiento?.cuenta?.numero}</td>
                        <td style="width: 280px">${asiento?.cuenta?.descripcion}</td>
                        <td style="width: 80px">${asiento.debe ? g.formatNumber(number: asiento.debe, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2) : 0.00}</td>
                        <td style="width: 80px">${asiento.haber ? g.formatNumber(number: asiento.haber, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2) : 0.00}</td>
                        <td style="text-align: center; width: 60px">
                            <div class="btn-group">
                                <a href="#" class="btn btn-success btn-sm btnEditarAsiento" idAs="${asiento?.id}" title="Editar asiento">
                                    <i class="fa fa-pencil"></i>
                                </a>
                                <a href="#" class="btn btn-danger btn-sm btnEliminarAsiento" idAs="${asiento?.id}" title="Eliminar asiento">
                                    <i class="fa fa-times"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                </g:if>
            </g:each>
            </tbody>
        </table>
    </div>
</div>

<g:if test="${auxiliares}">
    <table class="table table-bordered table-hover table-condensed">
        <thead>
        <tr>
            <th style="width: 160px;" class="colorAtras">Auxiliar Cuenta</th>
            <th style="width: 150px" class="colorAtras">Proveedor</th>
            <th style="width: 80px" class="colorAtras">Fecha Pago</th>
            <th style="width: 80px" class="colorAtras">Pagar</th>
            <th style="width: 80px" class="colorAtras">Cobrar</th>
            <th style="width: 60px" class="colorAtras"><i class="fa fa-pencil"></i> </th>
        </tr>
        </thead>
    </table>

    <div class="row-fluid"  style="width: 99.7%;height: 100px;overflow-y: auto;float: right; margin-bottom: 20px">
        <div class="span12">
            <table class="table table-bordered table-hover table-condensed">
                <tbody>
                <g:each in="${auxiliares}" var="auxiliar">
                    <g:if test="${auxiliar.asiento.comprobante == comprobante}">
                        <tr>
                            <td style="width: 150px">${auxiliar?.asiento?.cuenta?.descripcion}</td>
                            <td style="width: 150px">${auxiliar?.proveedor?.nombre}</td>
                            <td style="width: 70px">${auxiliar?.fechaPago?.format("dd-MM-yyyy")}</td>
                            <td style="width: 70px">${auxiliar?.debe ? g.formatNumber(number: auxiliar.debe, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2) : 0.00}</td>
                            <td style="width: 70px">${auxiliar.haber ? g.formatNumber(number: auxiliar.haber, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2) : 0.00}</td>
                            <td style="text-align: center; width: 60px">
                                <div class="btn-group">
                                    <a href="#" class="btn btn-success btn-sm btnEditarAuxiliar" idAs="${auxiliar?.id}" title="Editar auxiliar">
                                        <i class="fa fa-pencil"></i>
                                    </a>
                                    <a href="#" class="btn btn-danger btn-sm btnEliminarAuxiliar" idAs="${auxiliar?.id}" title="Eliminar auxiliar">
                                        <i class="fa fa-times"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </g:if>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</g:if>


<script type="text/javascript">

    $(".btnAgregarAsiento").click(function () {
        agregar('${comprobante?.id}', null)
    });

    $(".btnEditarAsiento").click(function () {
        var idAsiento = $(this).attr('idAs');
        agregar(${comprobante?.id}, idAsiento)
    });

    $(".btnEliminarAsiento").click(function () {
        var idAsiento = $(this).attr('idAs');
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el asiento contable?.</p>",
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
                                                    log("Error al guardar el error contable","error");
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



</script>