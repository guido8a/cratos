<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 17/08/17
  Time: 12:43
--%>


<style type="text/css">

    .rojoE{
        color: #ff1e25;
    }

</style>

<g:set var="val" value="${0.0}"/>

<table class="table table-bordered table-hover table-condensed" width="1000px">
    <tbody>
    <g:each in="${reembolsos}" var="reembolso">
        <tr>
            <td width="120px">${reembolso?.proveedor?.nombre}</td>
            <td width="200px">${reembolso?.tipoCmprSustento?.tipoComprobanteSri?.descripcion}</td>
            <td width="80px" style="text-align: center">${reembolso?.reembolsoEstb + " - " + reembolso?.reembolsoEmsn + " - " + reembolso?.reembolsoSecuencial}</td>
            <td width="80px" style="text-align: right"><g:formatNumber number="${reembolso?.valor ?: 0.00}" maxFractionDigits="2" minFractionDigits="2" format="##,##0"/></td>
            <td width="45px" style="text-align: center">
                <g:if test="${reembolso.proceso.estado != 'R'}">
                    <div class="btn-group">
                        <a href="#" class="btn btn-success btn-sm editarReemb" idr="${reembolso?.id}">
                            <i class="fa fa-pencil"></i>
                        </a>
                        <a href="#" class="btn btn-danger btn-sm borrarReemb" idr="${reembolso?.id}">
                            <i class="fa fa-trash-o"></i>
                        </a>
                    </div>
                </g:if>
            </td>
        </tr>
        <g:set var="total" value="${val += reembolso?.valor.toDouble()}"/>
    </g:each>
    </tbody>
</table>

<table class="table table-bordered table-hover table-condensed" width="1000px">

    <thead>
    <tr>
        <th>Valor Total: </th>
        <th>${g.formatNumber(number: proceso?.valor, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2)}</th>
        <th>Reembolsos: </th>
        <th class="${proceso?.valor != total ? 'rojoE' : ''}">${g.formatNumber(number: total, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2)}</th>
        <th>Diferencia: </th>
        <th>${g.formatNumber(number: ((proceso?.valor ?: 0) - (total ?: 0)), format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2)}</th>
    </tr>
    </thead>

</table>

<script type="text/javascript">

    $(".borrarReemb").click(function () {
        var id = $(this).attr('idr');
        bootbox.confirm("<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i> Está seguro de borrar el reembolso?", function (result) {
            if (result) {
                $.ajax({
                   type: 'POST',
                    url: '${createLink(controller: 'reembolso', action: 'borrarReembolso_ajax')}',
                    data:{
                        id: id
                    },
                    success: function (msg) {
                        if(msg == 'ok'){
                            log("Reemnbolso borrado correctamente!","success");
                            cargarTablaReembolso();
                        }else{
                            log("Error al borrar el reembolso","error")
                        }
                    }
                });
            }
        })
    });


    $(".editarReemb").click(function () {
        var id = $(this).attr('idr');
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'proceso', action: 'formReembolso_ajax')}',
            data:{
                proceso: '${proceso?.id}',
                id: id
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
                                            proceso: '${proceso?.id}',
                                            id: id
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


</script>