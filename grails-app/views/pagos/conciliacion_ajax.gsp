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
    %{--<strong> Conciliación Bancaria </strong>--}%
    <div class="row">
        <div class="col-md-4">
            Saldo Anterior :
        </div>
        <div class="col-md-4">
            <g:textField name="saldo_name" value="${res[0].sldobnco}" class="form-control" readonly=""/>
        </div>
    </div>
</div>

%{--<div class="container">--}%
    %{--<div class="row">--}%
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
                        <table class="table table-bordered table-hover table-condensed" style="margin-top: 10px">
                            <thead>
                            <tr style="width: 100%">
                                <th style="width: 14%"># Cheque</th>
                                <th style="width: 10%">Documento</th>
                                <th style="width: 20%">Descripción</th>
                                <th style="width: 15%">Beneficiario</th>
                                <th style="width: 12%">Fecha</th>
                                <th style="width: 10%">Debe</th>
                                <th style="width: 10%">Haber</th>
                                <th style="width: 9%">Cobro/Pago</th>
                            </tr>
                            </thead>
                        </table>

                        <div style="width: 99.7%;height: 300px;overflow-y: auto;float: right;" id="divTablaDetalle">
                            <table class="table table-bordered table-hover table-condensed" style="margin-top: 3px">
                                <tbody>
                                <g:each in="${res}" var="con">
                                    <g:if test="${con?.tpps == 'P'}">
                                        <tr style="width: 100%">
                                            <td style="width: 14%"></td>
                                            <td style="width: 10%">${con.dcmt}</td>
                                            <td style="width: 20%">${con.axlrdscr}</td>
                                            <td style="width: 15%">${con.prve}</td>
                                            <td style="width: 12%"><g:formatDate date="${con.axlrfcpg}" format="dd-MM-yyyy"/></td>
                                            <td class="derecha" style="width: 10%">${con.axlrdebe}</td>
                                            <td class="derecha" style="width: 10%">${con.axlrhber}</td>
                                            <td style="width: 9%"> <g:checkBox name="valores_name" id="valores" class="form-control valo" data-on-Label="Si"/></td>
                                        </tr>
                                    </g:if>
                                </g:each>
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
                    <div class="panel-body animated zoomOut">
                        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
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
                    <div class="panel-body animated zoomOut">
                        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
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
                    <div class="panel-body animated zoomOut">
                        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                    </div>
                </div>
            </div>
        </div>
    %{--</div>--}%
%{--</div>--}%

<div class="alert alert-success" style="text-align: center; margin-top: 30px">
    <div class="row">
        <div class="col-md-4">
            Saldo en Libros :
        </div>
        <div class="col-md-3">
            <g:textField name="saldoLibros_name" value="${res[0].sldolbro}" class="form-control" readonly=""/>
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
    })


    $(function() {
        $(".valo").checkboxpicker({
        });
    });


</script>


</body>
</html>