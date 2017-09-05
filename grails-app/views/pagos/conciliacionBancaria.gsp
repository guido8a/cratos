<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 23/06/14
  Time: 10:50 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Conciliación Bancaria</title>

    <link href="${resource(dir: 'css', file: 'aco.css')}" rel="stylesheet">

    <style type="text/css">

    </style>
</head>

<body>


<div class="alert alert-info" style="text-align: center">
    <strong> Conciliación Bancaria </strong>

    <div class="row">
        <div class="col-md-4">
            Saldo Anterior :
        </div>
        <div class="col-md-4">
            <g:textField name="saldo_name" value="" class="form-control" readonly=""/>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">

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
                    <div class="panel-body animated zoomOut">


                        <table class="table table-bordered table-hover table-condensed" style="margin-top: 10px">
                            <thead>
                            <tr>
                                <th style="width: 90px"># Cheque</th>
                                <th style="width: 200px">Beneficiario</th>
                                <th style="width: 50px">Fecha</th>
                                <th style="width: 50px">Valor</th>
                                <th style="width: 30px">Cobro/Pago</th>
                            </tr>
                            </thead>
                        </table>

                        <div style="width: 99.7%;height: 500px;overflow-y: auto;float: right;" id="divTablaDetalle"></div>
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
    </div>
</div>

<div class="alert alert-success" style="text-align: center; margin-top: 40px">
    <div class="row">
        <div class="col-md-4">
            Saldo en Libros :
        </div>
        <div class="col-md-3">
            <g:textField name="saldoLibros_name" value="" class="form-control" readonly=""/>
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

%{--<div class="panel-group" id="accordion">--}%
%{--<div class="panel panel-default">--}%
%{--<g:set var="reporte" value="retrasados"/>--}%
%{--<div class="panel-heading">--}%
%{--<h4 class="panel-title">--}%
%{--<a data-toggle="collapse" data-parent="#accordion" href="#collapse_${reporte}">--}%
%{--Pagos--}%
%{--</a>--}%
%{--</h4>--}%
%{--</div>--}%

%{--<div id="collapse_${reporte}" class="panel-collapse collapse in">--}%
%{--<div class="panel-body">--}%
%{--<form class="form-horizontal">--}%
%{--<div class="alert alert-info">--}%

%{--</div>--}%
%{--</form>--}%
%{--</div>--}%
%{--</div>--}%
%{--</div>--}%

%{--<div class="panel panel-default">--}%
%{--<g:set var="reporte" value="generados"/>--}%
%{--<div class="panel-heading">--}%
%{--<h4 class="panel-title">--}%
%{--<a data-toggle="collapse" data-parent="#accordion" href="#collapse_${reporte}">--}%
%{--Depositos y Transferencias--}%
%{--</a>--}%
%{--</h4>--}%
%{--</div>--}%

%{--<div id="collapse_${reporte}" class="panel-collapse collapse">--}%
%{--<div class="panel-body">--}%
%{--<form class="form-horizontal">--}%
%{--<div class="alert alert-info">--}%

%{--</div>--}%

%{--<div class="row">--}%

%{--</div>--}%

%{--<div class="row">--}%
%{--<div class="col-md-12">--}%

%{--</div>--}%
%{--</div>--}%
%{--</form>--}%
%{--</div>--}%
%{--</div>--}%
%{--</div>--}%
%{--</div>--}%


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
</script>


</body>
</html>