<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/08/17
  Time: 11:04
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Reembolso</title>
</head>

<body>

<div class="btn-group" style="margin-right: 20px">
    <a href="#" class="btn btn-success previous" id="irProceso">
        <i class="fa fa-chevron-left"></i>
        Proceso
    </a>
    %{--<a href="#" class="btn btn-success" id="comprobanteN">--}%
        %{--<i class="fa fa-calendar-o"></i>--}%
        %{--Comprobante--}%
    %{--</a>--}%
    <a href="#" class="btn btn-success disabled" id="reembolsoN">
        <i class="fa fa-thumbs-up"></i>
        Reembolso
    </a>
</div>


<g:if test="${proceso}">
    <div class="vertical-container" skip="1" style="margin-top: 5px; color:black; margin-bottom:20px; height:700px; max-height: 620px; overflow: auto;">
        <p class="css-vertical-text">Reembolso</p>

        <div class="linea"></div>

        <div class="col-md-10" style="margin-top: 10px; margin-bottom: 10px">
            <g:if test="${proceso?.estado != 'R'}">
                <div class="btn-group" style="float: left;">
                    <a href="#" class="btn btn-success" id="agregarN">
                        <i class="fa fa-plus"></i>
                        Agregar
                    </a>
                </div>
            </g:if>
        </div>

        <table class="table table-bordered table-hover table-condensed" width="1000px">
            <thead>
            <tr>
                <th width="120px">Proveedor</th>
                <th width="200px">Tipo de Comprobante</th>
                <th width="80px">Documento</th>
                <th width="80px">Valor</th>
                <th width="45px"><i class="fa fa-pencil"></i></th>
            </tr>
            </thead>
        </table>

        <div id="divReembolso" class="col-xs-12"style="margin-bottom: 0px ;padding: 0px;margin-top: 5px; height: 450px">
        </div>
    </div>
</g:if>


<script type="text/javascript">

    cargarTablaReembolso();

    function cargarTablaReembolso () {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'proceso', action: 'tablaReembolso_ajax')}',
            data:{
                proceso: '${proceso?.id}'
            },
            success: function (msg) {
                $("#divReembolso").html(msg)
            }
        });
    }

    $("#agregarN").click(function () {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'proceso', action: 'formReembolso_ajax')}',
            data:{
                proceso: '${proceso?.id}'
            },
            success: function (msg) {
                bootbox.dialog({
                    title: 'Agregar reembolso',
                    message: msg,
//                    class: 'long',
                    buttons:{
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                                bootbox.hideAll();
                            }
                        },
                        guardar:{
                            label: "<i class='fa fa-save'></i> Guardar",
                            className: "btn-success",
                            callback: function () {

                                var $form = $("#reembolsoForm");

                                if($form.valid()){
                                    $.ajax({
                                        type: 'POST',
                                        url: '${createLink(controller: 'reembolso', action: 'guardarReembolso_ajax')}',
                                        data:{
                                            proveedor: $("#prve_idPro").val(),
                                            comprobante: $("#tipoComprobante option:selected").val(),
                                            establecimiento: $("#dcmtEstablecimientoR").val(),
                                            emision: $("#dcmtEmisionR").val(),
                                            secuencial: $("#dcmtSecuencialR").val(),
                                            autorizacion: $("#dcmtAutorizacionR").val(),
                                            fecha: $("#fechaR_input").val(),
                                            baseImponibleIva: $("#ivaR").val(),
                                            baseImponibleIva0: $("#iva0R").val(),
                                            noAplicaIva: $("#noIvaR").val(),
                                            excentoIva: $("#excentoIvaR").val(),
                                            ivaGenerado: $("#ivaGeneradoR").val(),
                                            iceGenerado: $("#iceGeneradoR").val(),
                                            proceso: '${proceso?.id}'
                                        },
                                        success: function (msg) {
                                            if(msg == 'ok'){
                                                log("Reemnbolso agregado correctamente!","success");
                                                cargarTablaReembolso();
                                            }else{
                                                log("Error al agregar el reembolso","error")
                                            }
                                        }
                                    });

                                    bootbox.hideAll();
                                }else{
                                    return false;
                                }


                            }
                        }
                    }
                })
            }
        });
    });


    $("#comprobanteN").click(function () {
        location.href="${createLink(controller: 'proceso', action: 'comprobante')}/?proceso=" + '${proceso?.id}'
    })

    $("#irProceso").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'verificarReembolsos_ajax')}',
            data:{
                proceso: '${proceso?.id}'
            },
            success: function (msg){
                if(msg == 'ok'){
                    location.href='${createLink(controller: 'proceso', action: 'nuevoProceso')}/?id=' + '${proceso?.id}'
                }else{
                    bootbox.confirm("<i class='fa fa-warning fa-3x pull-left text-warning text-shadow'></i> La sumatoria de los valores de reembolsos no es igual al total del valor de la transacción!. <br> Desea abandonar esta pantalla?", function (result) {
                        if(result){
                            location.href='${createLink(controller: 'proceso', action: 'nuevoProceso')}/?id=' + '${proceso?.id}'
                        }
                    })
                }
            }
        });
    })

</script>

</body>
</html>