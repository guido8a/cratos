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

    .letra{
        font-size: 11px;
        font-weight: bold;
    }

    </style>
</head>

<body>


<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
    <div class="panel panel-custom">
        <div class="panel-heading" role="tab" id="headingOne">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseBuscar" aria-expanded="true" aria-controls="collapseBuscar">
                    <i class="glyphicon glyphicon-plus"></i>
                    Buscar
                </a>
            </h4>
        </div>
        <div id="collapseBuscar" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
            %{--<div class="panel-body animated">--}%
            <div class="panel-body">
                <div style="margin-top: 30px; min-height: 130px" class="vertical-container">
                    <p class="css-vertical-text">Buscar</p>

                    <div class="linea"></div>

                    <div class="fila col-md-12" style="width: 100%; margin-bottom: 10px">
                        <div class="col-md-2">
                            <label class="letra">Cuenta por pagar: </label>
                        </div>
                        <div class="col-md-4">
                            <g:if test="${pp}">
                                <g:select name="grupo_name" id="cuentaPagos"
                                          from="${pagos}"
                                          optionKey="id" optionValue="${{it.numero + " - " + it.descripcion}}" noSelection="['-1': 'Seleccione la cuenta por pagar...']"
                                          class="form-control" style="color: #cf0e21"/>
                            </g:if>
                            <g:else>
                                <g:select name="grupo_name" id="cuentaPagos"
                                          from="${""}"
                                          optionKey="id" optionValue="${{it.numero + " - " + it.descripcion}}" noSelection="['-1': 'Seleccione la cuenta por pagar...']"
                                          class="form-control" style="color: #cf0e21"/>
                            </g:else>

                        </div>


                        <div class="col-md-2">
                            <label class="letra">Cuenta por cobrar: </label>
                        </div>
                        <div class="col-md-4">
                            <g:if test="${pc}">
                                <g:select name="grupo_name" id="cuentaCobros"
                                          from="${cobros}"
                                          optionKey="id" optionValue="${{it.numero + " - " + it.descripcion}}" noSelection="['-1': 'Seleccione la cuenta por cobrar...']"
                                          class="form-control" style="color: #42a151"/>
                            </g:if>
                            <g:else>
                                <g:select name="grupo_name" id="cuentaCobros"
                                          from="${""}"
                                          optionKey="id" optionValue="${{it.numero + " - " + it.descripcion}}" noSelection="['-1': 'Seleccione la cuenta por cobrar...']"
                                          class="form-control" style="color: #42a151"/>
                            </g:else>

                        </div>
                    </div>

                    <div class="fila col-md-12" style="width: 100%; margin-bottom: 10px">
                        <div class="col-md-2">
                            <label class="letra" style="text-align: center">Cuenta Bancaria: </label>
                        </div>
                        <div class="col-md-4">
                            <g:if test="${pb}">
                                <g:select name="grupo_name" id="cuentaBancaria"
                                          from="${bancos}"
                                          optionKey="id" optionValue="${{it.numero + " - " + it.descripcion}}" noSelection="['-1': 'Seleccione la cuenta bancaria...']"
                                          class="form-control"/>
                            </g:if>
                            <g:else>
                                <g:select name="grupo_name" id="cuentaBancaria"
                                          from="${""}"
                                          optionKey="id" optionValue="${{it.numero + " - " + it.descripcion}}" noSelection="['-1': 'Seleccione la cuenta bancaria...']"
                                          class="form-control"/>
                            </g:else>

                        </div>


                        <div class="col-md-1">
                            <label class="letra">Desde: </label>
                        </div>
                        <div class="col-md-2">
                            <elm:datepicker name="fechaDesde_name" title="Fecha desde" id="fechaHasta" class="datepicker form-control fechaDe"
                                            maxDate="new Date()"/>
                        </div>

                        <div class="col-md-1">
                            <label class="letra">Hasta: </label>
                        </div>
                        <div class="col-md-2">
                            <elm:datepicker name="fechaHasta_name" title="Fecha hasta" id="fechaDesde" class="datepicker form-control fechaHa"
                                            maxDate="new Date()"/>
                        </div>

                    </div>


                    <div class="fila col-md-12">
                        <div class="col-md-5"></div>
                        <div class="col-md-2">
                            <a href="#" class="btn btn-info" id="btnBuscar">
                                <i class="fa fa-search"></i> Buscar
                            </a>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>




<div id="conciliacion" style="margin-top: 20px">

</div>


<script type="text/javascript">

    $("#btnBuscar").click(function () {
        var b = $("#cuentaBancaria").val();
        var c = $("#cuentaCobros").val();
        var p = $("#cuentaPagos").val();
        var fechaDesde = $(".fechaDe").val();
        var fechaHasta = $(".fechaHa").val();

        if(p == '-1'){
            bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una cuenta por pagar!")
        }else{
            if(c == '-1'){
                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una cuenta por cobrar!")
            }else{
                if(b == '-1'){
                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una cuenta bancaria!")
                }else{
                    if(fechaDesde == '' || fechaHasta == ''){
                        bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione las fechas!")
                    }else{
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                            async: true,
                            data:{
                                desde: fechaDesde,
                                hasta: fechaHasta
                            },
                            success: function (msg){
                                if(msg == 'ok'){
                                    $.ajax({
                                        type:'POST',
                                        url:'${createLink(controller: 'pagos', action: 'conciliacion_ajax')}',
                                        data:{
                                            bancaria: b,
                                            pago: p,
                                            cobro: c,
                                            desde: fechaDesde,
                                            hasta: fechaHasta
                                        },
                                        success: function (msg) {
                                        $("#conciliacion").html(msg)
                                        }
                                    });
                                }else{
                                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                                    return false;
                                }
                            }
                        });
                    }
                }
            }
        }


    });


</script>


</body>
</html>