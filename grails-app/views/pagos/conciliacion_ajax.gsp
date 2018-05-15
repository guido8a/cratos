<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 02/02/18
  Time: 10:49
--%>

<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 23/06/14
  Time: 10:50 AM
--%>

<link href="${resource(dir: 'css', file: 'aco.css')}" rel="stylesheet">
<script src="${resource(dir: 'js/plugins/Toggle-Button-Checkbox/js', file: 'bootstrap-checkbox.js')}"></script>


<style type="text/css">

td{
    font-size: 12px;
}

.derecha{
    text-align: right;
}

</style>

<div class="alert alert-info" style="text-align: center">
    <div class="row">
        <div class="col-md-4">
            Saldo Anterior :
        </div>
        <div class="col-md-4">
            <g:textField name="saldo_name" value="${res[0]?.sldobnco}" class="form-control" readonly=""/>
        </div>
    </div>
</div>

<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
    <div class="panel panel-custom">
        <div class="panel-heading" role="tab" id="headingOne">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                    <i class="glyphicon glyphicon-plus"></i>
                    Pagos
                </a>
            </h4>
        </div>
        <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
            %{--<div class="panel-body animated zoomOut">--}%
            <div class="panel-body">
            <g:if test="${pago != 0}">
                <table class="table table-bordered table-hover table-condensed" style="margin-top: 10px">
                    <thead>
                    <tr style="width: 100%">
                        <th style="width: 14%">Documento</th>
                        <th style="width: 12%">Factura</th>
                        <th style="width: 20%">Descripción</th>
                        <th style="width: 15%">Beneficiario</th>
                        <th style="width: 12%">Fecha</th>
                        <th style="width: 10%">Debe</th>
                        <th style="width: 10%">Haber</th>
                        <th style="width: 9%">Cobro/Pago</th>
                    </tr>
                    </thead>
                </table>

                <div style="width: 99.7%;height: ${pago == 0 ? 100 : 300}px;overflow-y: auto;float: right;" id="divTablaDetalle">
                    <table class="table table-bordered table-hover table-condensed" style="margin-top: 3px">
                        <tbody>

                            <g:each in="${res}" var="con">
                                <g:if test="${con?.tpps == 'P'}">
                                    <tr style="width: 100%">
                                        <td style="width: 14%">${con.refe}</td>
                                        <td style="width: 10%">${con.dcmt}</td>
                                        <td style="width: 20%">${con.axlrdscr}</td>
                                        <td style="width: 15%">${con.prve}</td>
                                        <td style="width: 12%"><g:formatDate date="${con.axlrfcpg}" format="dd-MM-yyyy"/></td>
                                        <td class="derecha" style="width: 10%">${con.axlrdebe}</td>
                                        <td class="derecha" style="width: 10%">${con.axlrhber}</td>
                                        <td style="width: 9%"> <g:checkBox name="valores_name" id="valores" data-id="${con?.axlr__id}" class="form-control valo" data-on-Label="Si" value="${cratos.Auxiliar.get(con?.axlr__id).pagado == 'S'}"/></td>
                                    </tr>
                                </g:if>
                            </g:each>
                        </g:if>
                        <g:else>
                            <div class="alert alert-warning" style="text-align: center">
                                No existen registros de pagos
                            </div>
                        </g:else>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-custom">
        <div class="panel-heading" role="tab" id="headingTwo">
            <h4 class="panel-title">
                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                    <i class="glyphicon glyphicon-plus"></i>
                    Depositos y Transferencias
                </a>
            </h4>
        </div>
        <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
            <div class="panel-body">
                <g:if test="${transferencia != 0}">
                <table class="table table-bordered table-hover table-condensed" style="margin-top: 10px">
                    <thead>
                    <tr style="width: 100%">
                        <th style="width: 14%">Documento</th>
                        <th style="width: 12%">Factura</th>
                        <th style="width: 20%">Descripción</th>
                        <th style="width: 15%">Beneficiario</th>
                        <th style="width: 12%">Fecha</th>
                        <th style="width: 10%">Debe</th>
                        <th style="width: 10%">Haber</th>
                        <th style="width: 9%">Cobro/Pago</th>
                    </tr>
                    </thead>
                </table>

                <div style="width: 99.7%;height: ${transferencia == 0 ? 100 : 300}px;overflow-y: auto;float: right;" id="divTablaDetalle2">
                    <table class="table table-bordered table-hover table-condensed" style="margin-top: 3px">
                        <tbody>

                            <g:each in="${res}" var="con">
                                <g:if test="${con?.tpps == 'T'}">
                                    <tr style="width: 100%">
                                        <td style="width: 14%"></td>
                                        <td style="width: 10%">${con.dcmt}</td>
                                        <td style="width: 20%">${con.axlrdscr}</td>
                                        <td style="width: 15%">${con.prve}</td>
                                        <td style="width: 12%"><g:formatDate date="${con.axlrfcpg}" format="dd-MM-yyyy"/></td>
                                        <td class="derecha" style="width: 10%">${con.axlrdebe}</td>
                                        <td class="derecha" style="width: 10%">${con.axlrhber}</td>
                                        %{--<td style="width: 9%"> <g:checkBox name="valores2_name" id="valores2" class="form-control valo2" data-on-Label="Si"/></td>--}%
                                        <td style="width: 9%"> <g:checkBox name="valores_name" id="valores" data-id="${con?.axlr__id}" class="form-control valo" data-on-Label="Si" value="${cratos.Auxiliar.get(con?.axlr__id).pagado == 'S'}"/></td>
                                    </tr>
                                </g:if>
                            </g:each>
                        </g:if>
                        <g:else>
                            <div class="alert alert-warning" style="text-align: center">
                                No existen registros de transferencias
                            </div>
                        </g:else>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-custom">
        <div class="panel-heading" role="tab" id="headingThree">
            <h4 class="panel-title">
                <i class="glyphicon glyphicon-plus"></i>
                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                    Notas de Crédito
                </a>
            </h4>
        </div>
        <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
            <div class="panel-body">
                <g:if test="${credito != 0}">
                <table class="table table-bordered table-hover table-condensed" style="margin-top: 10px">
                    <thead>
                    <tr style="width: 100%">
                        <th style="width: 14%">Documento</th>
                        <th style="width: 12%">Factura</th>
                        <th style="width: 20%">Descripción</th>
                        <th style="width: 15%">Beneficiario</th>
                        <th style="width: 12%">Fecha</th>
                        <th style="width: 10%">Debe</th>
                        <th style="width: 10%">Haber</th>
                        <th style="width: 9%">Cobro/Pago</th>
                    </tr>
                    </thead>
                </table>

                <div style="width: 99.7%;height: ${credito == 0 ? 100 : 300}px;overflow-y: auto;float: right;" id="divTablaDetalle3">
                    <table class="table table-bordered table-hover table-condensed" style="margin-top: 3px">
                        <tbody>

                            <g:each in="${res}" var="con">
                                <g:if test="${con?.tpps == 'NC'}">
                                    <tr style="width: 100%">
                                        <td style="width: 14%"></td>
                                        <td style="width: 10%">${con.dcmt}</td>
                                        <td style="width: 20%">${con.axlrdscr}</td>
                                        <td style="width: 15%">${con.prve}</td>
                                        <td style="width: 12%"><g:formatDate date="${con.axlrfcpg}" format="dd-MM-yyyy"/></td>
                                        <td class="derecha" style="width: 10%">${con.axlrdebe}</td>
                                        <td class="derecha" style="width: 10%">${con.axlrhber}</td>
                                        %{--<td style="width: 9%"> <g:checkBox name="valores3_name" id="valores3" class="form-control valo3" data-on-Label="Si"/></td>--}%
                                        <td style="width: 9%"> <g:checkBox name="valores_name" id="valores" data-id="${con?.axlr__id}" class="form-control valo" data-on-Label="Si" value="${cratos.Auxiliar.get(con?.axlr__id).pagado == 'S'}"/></td>

                                    </tr>
                                </g:if>
                            </g:each>
                        </g:if>
                        <g:else>
                            <div class="alert alert-warning" style="text-align: center">
                                No existen registros de notas de crédito
                            </div>
                        </g:else>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-custom">
        <div class="panel-heading" role="tab" id="headingFour">
            <h4 class="panel-title">
                <i class="glyphicon glyphicon-plus"></i>
                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                    Notas de Débito
                </a>
            </h4>
        </div>
        <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
            <div class="panel-body">
                <g:if test="${debito != 0}">
                <table class="table table-bordered table-hover table-condensed" style="margin-top: 10px">
                    <thead>
                    <tr style="width: 100%">
                        <th style="width: 14%">Documento</th>
                        <th style="width: 12%">Factura</th>
                        <th style="width: 20%">Descripción</th>
                        <th style="width: 15%">Beneficiario</th>
                        <th style="width: 12%">Fecha</th>
                        <th style="width: 10%">Debe</th>
                        <th style="width: 10%">Haber</th>
                        <th style="width: 9%">Cobro/Pago</th>
                    </tr>
                    </thead>
                </table>
                <div style="width: 99.7%;height: ${debito == 0 ? 100 : 300}px;overflow-y: auto;float: right;" id="divTablaDetalle4">
                    <table class="table table-bordered table-hover table-condensed" style="margin-top: 3px">
                        <tbody>

                            <g:each in="${res}" var="con">
                                <g:if test="${con?.tpps == 'ND'}">
                                    <tr style="width: 100%">
                                        <td style="width: 14%"></td>
                                        <td style="width: 10%">${con.dcmt}</td>
                                        <td style="width: 20%">${con.axlrdscr}</td>
                                        <td style="width: 15%">${con.prve}</td>
                                        <td style="width: 12%"><g:formatDate date="${con.axlrfcpg}" format="dd-MM-yyyy"/></td>
                                        <td class="derecha" style="width: 10%">${con.axlrdebe}</td>
                                        <td class="derecha" style="width: 10%">${con.axlrhber}</td>
                                        %{--<td style="width: 9%"> <g:checkBox name="valores4_name" id="valores4" class="form-control valo4" data-on-Label="Si"/></td>--}%
                                        <td style="width: 9%"> <g:checkBox name="valores_name" id="valores" data-id="${con?.axlr__id}" class="form-control valo" data-on-Label="Si" value="${cratos.Auxiliar.get(con?.axlr__id).pagado == 'S'}"/></td>

                                    </tr>
                                </g:if>
                            </g:each>
                        </g:if>
                        <g:else>
                            <div class="alert alert-warning" style="text-align: center">
                                No existen registros de notas de débito
                            </div>
                        </g:else>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="alert alert-success" style="text-align: center; margin-top: 30px">
    <div class="row">
        <div class="col-md-4">
            Saldo en Libros :
        </div>
        <div class="col-md-3">
            <g:textField name="saldoLibros_name" value="${res[0]?.sldolbro}" class="form-control" readonly=""/>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            Cheques girados y no cobrados :
        </div>
        <div class="col-md-3">
            <g:textField name="noCobrados_name" value="" class="form-control" readonly=""/>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            Saldo de estado de cuenta :
        </div>
        <div class="col-md-3">
            <g:textField name="saldoEstado_name" value="" class="form-control" readonly=""/>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function() {

        function toggleChevron(e) {
            $(e.target)
                .prev('.panel-heading')
                .find("i")
                .toggleClass('rotate-icon');
            $('.panel-body.animated').toggleClass('zoomIn zoomOut');
        }

        $('#accordion').on('hide.bs.collapse', toggleChevron);
        $('#accordion').on('show.bs.collapse', toggleChevron);
    });


    $(function() {
        $(".valo").checkboxpicker({
        });
    });


    $(".valo").change(function () {
        openLoader("Guardando...");
        var valores = $(this).prop('checked');
        var auxiliar = $(this).data("id");
        $.ajax({
            type:'POST',
            url:'${createLink(controller: 'pagos', action: 'guardarConciliacion_ajax')}',
            data:{
                valor: valores,
                aux: auxiliar
            },
            success: function (msg){
                closeLoader();
                if(msg == 'ok'){
                    log("Guardado correctamente!", "success")
                }else{
                    log("Error al guardar", "error")
                }
            }
        });
    });


</script>


%{--</body>--}%
%{--</html>--}%