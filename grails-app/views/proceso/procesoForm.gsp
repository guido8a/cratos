<%@ page import="cratos.Asiento; cratos.sri.TipoComprobanteSri" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main"/>
    <title>Transacciones</title>
    <style type="text/css">
    .number {
        text-align: right;
    }

    .filaFP {
        width: 95%;
        height: 20px;
        border-bottom: 1px solid #d0d0d0;
        margin: 10px;
        vertical-align: middle;
        text-align: left;
        line-height: 10px;
        padding-left: 10px;
        padding-bottom: 20px;
        font-size: 10px;
    }

    .span-rol {
        padding-right: 10px;
        padding-left: 10px;
        height: 16px;
        line-height: 16px;
        background: #FFBD4C;
        margin-right: 5px;
        font-weight: bold;
        font-size: 12px;
    }

    .span-eliminar {
        padding-right: 10px;
        padding-left: 10px;
        height: 16px;
        line-height: 16px;
        background: rgba(255, 2, 10, 0.35);
        margin-right: 5px;
        /*font-weight: bold;*/
        font-size: 12px;
        cursor: pointer;
        float: right;
    }
    </style>
</head>

<body>
<g:if test="${flash.message}">
    <div class="alert ${flash.tipo == 'error' ? 'alert-danger' : flash.tipo == 'success' ? 'alert-success' : 'alert-info'} ${flash.clase}">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <g:if test="${flash.tipo == 'error'}">
            <i class="fa fa-warning fa-2x pull-left"></i>
        </g:if>
        <g:elseif test="${flash.tipo == 'success'}">
            <i class="fa fa-check-square fa-2x pull-left"></i>
        </g:elseif>
        <g:elseif test="${flash.tipo == 'notFound'}">
            <i class="icon-ghost fa-2x pull-left"></i>
        </g:elseif>
        <p>
            ${flash.message}
        </p>
    </div>
</g:if>
<div class="btn-toolbar toolbar">
    <div class="btn-group">

        <g:link class="btn btn-info" action="buscarPrcs">
            <i class="fa fa-chevron-left"></i>
            Lista de Procesos
        </g:link>
    </div>

    <div class="btn-group">
        <g:if test="${!proceso || (proceso?.estado == 'N')}">
            <a href="#" class="btn btn-success" id="guardarProceso">
                <i class="fa fa-save"></i>
                Guardar
            </a>
        </g:if>
        <g:if test="${params.id}">
            %{--<g:if test="${proceso.adquisicion == null && proceso.factura == null && proceso.transferencia == null && !registro && cratos.Retencion.findByProceso(proceso)}">--}%
            <g:if test="${proceso.adquisicion == null && proceso.factura == null && proceso.transferencia == null && !registro}">
                <a href="#" class="btn btn-info" id="registrarProceso">
                    <i class="fa fa-check"></i>
                    Registrar
                </a>
            </g:if>
        </g:if>

        <g:if test="${proceso}">
            <g:if test="${!aux}">
                <g:if test="${proceso?.tipoProceso != 'P'}">
                    <g:form action="borrarProceso" class="br_prcs" style="margin:0px;display: inline">
                        <input type="hidden" name="id" value="${proceso?.id}">
                        <a class="btn btn-danger" id="btn-br-prcs" action="borrarProceso">
                            <i class="fa fa-trash-o"></i>
                            Anular Proceso
                        </a>
                    </g:form>
                </g:if>
            </g:if>
            <g:else>
                <a href="#" class="btn btn-default" style="cursor: default">
                    <i class="fa fa-ban"></i>
                    Esta transacción no puede ser eliminada ni desmayorizada porque tiene auxiliares registrados.
                </a>
            </g:else>


            %{--<g:if test="${proceso?.estado != 'R'}">--}%
                <g:link class="btn btn-primary" action="detalleSri" id="${proceso?.id}" style="margin-bottom: 10px;">
                    <i class="fa fa-money"></i> Retenciones
                </g:link>
            %{--</g:if>--}%

            <g:if test="${cratos.Retencion.findByProceso(proceso)}">
                <g:link controller="reportes3" action="imprimirRetencion" class="btn btn-default btnRetencion"
                        id="${proceso?.id}" params="[empresa: session.empresa.id]" style="margin-bottom: 10px;">
                    <i class="fa fa-print"></i>
                    Imprimir retención
                </g:link>
            </g:if>
        </g:if>


        <a href="#" class="btn btn-default" style="cursor: default" id="abrir-fp">
            <i class="fa fa-usd"></i>
            Forma de Pago
        </a>
    </div>
</div>

<div style="padding: 0.7em; margin-top:5px; display: none;" class="alert alert-danger ui-corner-all" id="divErrores">
    <i class="fa fa-exclamation-triangle"></i>
    <span style="" id="spanError">Se encontraron los siguientes errores:</span>
    <ul id="listaErrores"></ul>
</div>
<g:form name="procesoForm" action="save" method="post" class="frmProceso">
    <input type="hidden" name="proveedor.id" id="prve__id" value="${proceso?.proveedor?.id}">

    <div class="vertical-container" style="margin-top: 25px;color: black;padding-bottom: 10px">
        <p class="css-vertical-text">Descripción</p>

        <div class="linea"></div>

        <input type="hidden" name="id" value="${proceso?.id}" id="idProceso"/>
                %{--<input type="hidden" name="empleado.id" value="${session.usuario.id}"/>--}%
                %{--<input type="hidden" name="periodoContable.id" value="${session?.contabilidad?.id}"/>--}%
            <input type="hidden" name="data" id="data"/>
        <div class="row">
            <div class="col-xs-2 negrilla">
                Tipo de transacción:
            </div>

            <div class="col-xs-4 negrilla">
                %{--
                                <g:select class="form-control required cmbRequired tipoProcesoSel" name="tipoProceso" id="tipoProceso"
                                          from="${tiposProceso}" label="Proceso tipo: " value="${proceso?.tipoProceso}" optionKey="key"
                                          optionValue="value" title="Tipo de la transacción"
                                          disabled="${proceso?.id ? 'true' : 'false'}"/>
                --}%
                <g:select class="form-control required cmbRequired tipoProcesoSel" name="tipoProceso" id="tipoProceso"
                          from="${tiposProceso}" label="Proceso tipo: " value="${proceso?.tipoProceso}" optionKey="key"
                          optionValue="value" title="Tipo de la transacción" disabled="${registro ? true : false}"/>
            </div>

            <div class="col-xs-1 negrilla">
                Fecha de Emisión:
            </div>

            <div class="col-xs-2">
                <g:if test="${registro}">
                    ${proceso?.fecha.format("dd-MM-yyyy")}
                </g:if>
                <g:else>
                    <elm:datepicker name="fecha" title="Fecha de emisión del comprobante"
                                    class="datepicker form-control required col-xs-3"
                                    value="${proceso?.fecha}" maxDate="new Date()"
                                    style="width: 80px; margin-left: 5px"/>
                </g:else>
            </div>

            <div class="col-xs-1 negrilla">
                Fecha de registro:
            </div>

            <div class="col-xs-2">
                <g:if test="${registro}">
                    ${proceso?.fecha.format("dd-MM-yyyy")}
                </g:if>
                <g:else>
                    <elm:datepicker name="fecharegistro" title="Fecha de registro en el sistema"
                                    class="datepicker form-control required col-xs-3"
                                    value="${proceso?.fecha}" maxDate="new Date()"
                                    style="width: 80px; margin-left: 5px"/>
                </g:else>
            </div>

        </div>

        <div class="row">
            <div class="col-xs-2 negrilla">
                Gestor a utilizar:
            </div>

            <div class="col-xs-10 negrilla">
                <g:select class="form-control required" name="gestor.id"
                          from="${cratos.Gestor.findAllByEstadoAndEmpresa('R', session.empresa, [sort: 'nombre'])}"
                          label="Proceso tipo: " value="${proceso?.gestor?.id}" optionKey="id" optionValue="nombre"
                          title="Proceso tipo" disabled="${registro ? true : false}"/>
            </div>
        </div>

        <div class="row" id="divCargaProveedor">
        </div>

        <div class="row" id="divFilaComprobante">
        </div>

        <div class="row" id="divSustento">
        </div>

        <div class="row" id="divComprobanteSustento">
        </div>

        <div class="row">
            <div class="col-xs-2 negrilla">
                Descripción:
            </div>

            <div class="col-xs-10 negrilla">
                <textArea style="height:55px;resize: none" maxlength="255" name="descripcion"
                          id="descripcion" title="La descripción de la transacción contable"
                          class="form-control" ${registro ? 'readonly' : ''}>${proceso?.descripcion}</textArea>
            </div>
        </div>

        <div class="row" id="libretinFacturas">
            <div class="col-xs-2 negrilla">
                Libretín de Facturas:
            </div>

            <div class="col-xs-5">
                <g:select name="libretin" from="${libreta}" value="${retencion?.documentoEmpresa}"
                          class="form-control" optionKey="id" libre="1"
                          optionValue="${{"Desde: " + it?.numeroDesde + ' - Hasta: ' + it?.numeroHasta + " - Autorización: " +
                                  it?.fechaAutorizacion?.format("dd-MM-yyyy")}}"/>
                <g:hiddenField name="libretinName" id="idLibre" value=""/>
            </div>
            <div class="col-xs-5">
                <g:textField name="numEstablecimiento" id="numEstablecimiento" readonly="true"  style="width: 50px"
                             title="Número de Establecimento"/> -
                <g:textField name="numeroEmision" id="numEmision" readonly="true" style="width: 50px" title="Numeración Emisión"/>

                <g:textField name="serie" id="serie" value="${retencion?.numero}" maxlength="9" class="form-control required validacionNumero"
                             style="width: 120px; display: inline"/>

            </div>
            <p class="help-block ui-helper-hidden"></p>
        </div>

%{--
        <div class="row" id="libretinFacturas">
            <div class="col-xs-2 negrilla">
                Libretín de Facturas:
            </div>

            <div class="col-xs-5">
                <g:select name="comprobanteFactura" from="${libreta}" value="${''}"
                          class="form-control libretinFactura" optionKey="id" libre="1"
                          optionValue="${{
                              "Desde: " + it?.numeroDesde + ' - Hasta: ' + it?.numeroHasta +
                                      " - Autorización: " + it?.fechaAutorizacion?.format("dd-MM-yyyy")
                          }}"
                          noSelection="${['-1': 'Seleccione...']}"/>
            </div>

            <div class="col-xs-2" id="divNumeracionFactura" style="text-align: right">
            </div>
            <div class="col-xs-3 grupo" style="margin-left: 0px; display: inline">
                <g:textField name="secuencial" value="${''}" class="form-control validacionNumeroSinPuntos required"
                             style="width: 120px" maxlength="15" placeholder="Secuencial"/>
            </div>
        </div>
--}%

        <div class="row" id="pagoProceso">
            <div class="col-xs-2 negrilla">
                <label>Pago Local o Exterior</label>
            </div>
            <div class="col-xs-3">
                <g:select class="form-control" name="pago"
                          from="${['01': 'PAGO A RESIDENTE', '02': 'PAGO A NO RESIDENTE']}" optionKey="key" optionValue="value"
                          value="${retencion?.pago}"/>
            </div>

            <div class="exterior col-xs-12" hidden="hidden">
                <fieldset>
                    <div class="col-xs-12">
                        <div class="col-xs-1">
                            <label>País:</label>
                        </div>
                        <div class="col-xs-2">
                            <g:select class="form-control" style="margin-left: -20px;"
                                      name="pais" from="${cratos.sri.Pais.list([sort: 'nombre'])}"
                                      optionKey="id" optionValue="nombre" value="${retencion?.pais?.id}"/>
                        </div>

                        <div class="col-xs-4">
                            <label>Aplica convenio de doble tributación?</label> <br/>
                            <g:radioGroup class="convenio" labels="['SI', 'NO']" values="['SI', 'NO']" name="convenio_name"
                                          value="${proceso?.autorizacion?:'NO'}">
                                ${it?.label} ${it?.radio}
                            </g:radioGroup>
                        </div>

                        <div class="col-xs-5">
                            <label>Pago sujeto a retención en aplicación de la norma legal</label><br/>
                            <g:radioGroup class="norma" labels="['SI', 'NO']" values="['SI', 'NO']" name="norma_name"
                                          value="${retencion?.normaLegal}">${it?.label} ${it?.radio}</g:radioGroup>
                        </div>
                    </div>
                </fieldset>
            </div>  %{--//exterior--}%
        </div>

    </div>

    <div class="vertical-container" style="margin-top: 25px;color: black;padding-bottom: 10px;">
        <p class="css-vertical-text" id="lblValores">Val</p>

        <div class="linea"></div>

        <div id="divValores"></div>
    </div>

</g:form>
<g:if test="${proceso}">
    <div class="vertical-container" skip="1" style="margin-top: 5px; color:black; margin-bottom:20px; height:auto; max-height: 520px; overflow: auto;">
        <p class="css-vertical-text">Comprobante</p>

        <div class="linea"></div>

        <div id="divComprobante" class="col-xs-12"
             style="margin-bottom: 0px ;padding: 0px;display: none;margin-top: 5px;">
        </div>
    </div>
</g:if>


<!-- Modal -->
<div class="modal fade" id="modal-formas-pago" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Formas de pago</h4>
            </div>

            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-3 negrilla" style="width: 140px">
                        Tipo de pago:
                    </div>

                    <div class="col-xs-7 negrilla" style="margin-left: -20px">
                        <g:select name="tipoPago.id" id="comboFP" class=" form-control" from="${cratos.TipoPago.list()}"
                                  label="Tipo de pago: " optionKey="id" optionValue="descripcion"/>
                    </div>

                    <div class="col-xs-2 negrilla">
                        <g:if test="${!registro}">
                            <a href="#" id="agregarFP" class="btn btn-azul">
                                <i class="fa fa-plus"></i>
                                Agregar
                            </a>
                        </g:if>
                    </div>
                </div>

                <div class="ui-corner-all"
                     style="height: 170px;border: 1px solid #000000;width: 100%;margin-left: 5px;margin-top: 20px"
                     id="detalle-fp">
                    <g:each in="${fps}" var="f">
                        <div class="filaFP ui-corner-all fp-${f.tipoPago.id}" fp="${f.tipoPago.id}">
                            <g:if test="${!registro}">
                                <span class='span-eliminar ui-corner-all' title='Click para eliminar'>Eliminar</span>
                            </g:if>
                            ${f.tipoPago.descripcion}
                        </div>
                    </g:each>
                </div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal" id="btnCerrarPagos"><i
                        class="fa fa-save"></i> Cerrar y continuar</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- Modal -->
<div class="modal fade" id="modal-proveedor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel-proveedor">Seleccione el Proveedor</h4>
            </div>

            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-2 negrilla" style="width: 140px">
                        <select id="tipoPar" style="margin-right: 5px;" class="form-control">
                            <option value="1">RUC</option>
                            <option value="2">Nombre</option>
                        </select>
                    </div>

                    <div class="col-xs-5 negrilla" style="margin-left: -20px">
                        <input type="text" id="parametro" class="form-control" style="margin-right: 10px;">
                    </div>

                    <div class="col-xs-1 negrilla" style="width: 140px">
                        <a href="#" id="buscarPrve" class="btn btn-azul">
                            <i class="fa fa-search"></i>
                            Buscar
                        </a>
                    </div>

                </div>

                <div class="ui-corner-all"
                     style="height: 400px;border: 1px solid #000000; width: 100%;margin-left: 0px;margin-top: 20px;overflow-y: auto"
                     id="resultados"></div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Cerrar
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<script type="text/javascript">


    function validarNumSinPuntos(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
        (ev.keyCode >= 96 && ev.keyCode <= 105) ||
        ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
        ev.keyCode == 37 || ev.keyCode == 39 );
    }

    $(".validacionNumeroSinPuntos").keydown(function (ev) {
        return validarNumSinPuntos(ev);
    }).keyup(function () {
    });

    cargarNumeracionFactura($(".libretinFactura option:selected").val());

    function cargarNumeracionFactura(id) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'numeracionFactura_ajax')}',
            data: {
                libretin: id
            },
            success: function (msg) {
                $("#divNumeracionFactura").html(msg)
            }
        });
    }

    $(".libretinFactura").change(function () {
        var idLibretin = $(".libretinFactura option:selected").val();
        cargarNumeracionFactura(idLibretin);
    });


//    cargarTipo($(".tipoProcesoSel option:selected").val());
    //    cargarBotonGuardar($(".tipoProcesoSel option:selected").val());
    cargarBotonBuscar($(".tipoProcesoSel option:selected").val());
    <g:if test="${proceso?.id && (proceso?.tipoProceso == 'P' || proceso?.tipoProceso == 'N' || proceso?.tipoProceso == 'D')}">
    cargarComPago();
    </g:if>
    //    cargarProveedor($(".tipoProcesoSel option:selected").val());
    cargarComprobante('${proceso?.id}');

    $(document).ready(function () {
        var tipo = $(".tipoProcesoSel option:selected").val();
        var prve = $("#prve__id").val();
        console.log("prve__id:", prve);

        $("#listaErrores").html('');
        $("#divErrores").hide();

        $("#sustento").html('');
        $("#susteno").hide();
        $("#divFilaComprobante").html('');
        $("#divFilaComprobante").hide();

        cargarTipo(tipo);

        if (prve && (tipo == 'C' || tipo == 'V')) {
            cargarProveedor(tipo);
//            cargarTcsr(prve)
        }

        if("${!proceso?.id}") {
            cargarProveedor(tipo)
        }

        if ("${proceso?.sustentoTributario}") {
            console.log("proceso:", "${proceso?.tipoCmprSustento?.id}");
            cargarSstr("${proceso?.proveedor?.id}")
        }

        setTimeout(function () {
            if ("${proceso?.tipoCmprSustento}") {
                $("#tipoCmprSustento").change();
            }
        }, 1000);
    });

    $("#tipoProceso").change(function () {
        var tipo = $(".tipoProcesoSel option:selected").val();
        console.log('tipo...:', tipo);
        $("#divComprobanteSustento").html('');
        $("#divComprobanteSustento").hide();
        $("#divSustento").html('');
        $("#divSustento").hide();

        if (tipo == 'C' || tipo == 'V' || tipo == 'P' || tipo == 'I' || tipo == 'N' || tipo == 'D') {
            cargarProveedor(tipo);
        } else {
            $("#divCargaProveedor").html('');
            $("#divCargaProveedor").hide();
        }

        cargarTipo(tipo);

        /*
                if (tipo == 'N' || tipo == 'I' || tipo == 'P' || tipo == 'D') {
                    cargarComPago();
                    $("#divFilaComprobante").show();
                } else {
                    $("#divFilaComprobante").html('');
                    $("#divFilaComprobante").hide();
                }

                console.log('pone hide');

                cargarBotonBuscar(tipo);
        */

        if (tipo != 'V') {
            $("#libretinFacturas").hide()
        } else {
            $("#libretinFacturas").show()
        }

        if (tipo != 'C') {
            console.log('No es C');
            $("#pagoProceso").hide()
        } else {
            console.log('Es C...');
            $("#pagoProceso").show()
        }
    });

    /*
     $("#sustento").click(function () {
     console.log("clic en sustento")
     var prve = $("#prve__id").val();
     if(!prve) {
     $("#btn_buscar").click()
     }
     });
     */

    function cargarSstr(prve) {
        var tptr = $(".tipoProcesoSel option:selected").val();

        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'cargaSstr')}",
            data: {
                tptr: tptr,
                prve: prve,
                sstr: "${proceso?.sustentoTributario?.id}",
                tpcp: "${proceso?.tipoCmprSustento?.id}",
                etdo: "${proceso?.estado}"
            },
            success: function (msg) {
                console.log('ok....')
                $("#divSustento").html(msg)
                $("#divSustento").show()
            }
        });
    };

    function cargarTcsr(prve) {
        var tptr = $(".tipoProcesoSel option:selected").val();
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'cargaTcsr')}",
            data: {
                tptr: tptr,
                prve: prve,
                sstr: "${proceso?.sustentoTributario?.id}",
                tpcp: "${proceso?.tipoCmprSustento?.id}",
                etdo: "${proceso?.estado}"
            },
            success: function (msg) {
                $("#divComprobanteSustento").html(msg)
                $("#divComprobanteSustento").show()
            }
        });
    };

    function cargarProveedor(tipo) {
        console.log('cargar prve:', tipo)
        if (tipo != '-1') {
            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'proceso', action: 'proveedor_ajax')}",
                data: {
                    proceso: '${proceso?.id}',
                    tipo: tipo,
                    id: $("#prve__id").val()
                },
                success: function (msg) {
                    $("#divCargaProveedor").html(msg)
                    $("#divCargaProveedor").show()
                }
            });
        } else {
            $("#divCargaProveedor").html('')
            $("#divCargaProveedor").hidel()
        }
    }

    function cargarComPago() {
//        var idComprobante = $("#comprobanteSel").val();
        var idProveedor = $("#prve_id").val();
        console.log('buca prve...');
        $.ajax({
            type: 'POST',
            async: 'true',
            url: "${createLink(controller: 'proceso', action: 'filaComprobante_ajax')}",
            data: {
                proceso: '${proceso?.id}',
                proveedor: idProveedor
            },
            success: function (msg) {
                $("#divFilaComprobante").html(msg)
            }
        });
    }


    function cargarBotonBuscar(tipo) {
        if (tipo != '-1') {
            $("#btn_buscar").removeClass('hidden')
        } else {
            $("#btn_buscar").addClass('hidden')
        }
    }

    function cargarTipo(tipo) {
//        var flecha = "<i class='fa fa-arrow-left fa-fw' style='font-size: 20px !important; margin-left: -30px'></i>"
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'valores_ajax')}",
            data: {
                proceso: '${proceso?.id}',
                tipo: tipo
            },
            success: function (msg) {
                $("#divValores").html(msg)
                if(tipo == 'C' || tipo == 'V' || tipo == 'N' || tipo == 'D') {
//                    $("#lblValores").html(flecha + "Valores")
                    $("#lblValores").html("Valores")
                } else {
//                    $("#lblValores").html(flecha + "Val")
                    $("#lblValores").html("Val")
                }
            }
        });
    }

/*
    jQuery.fn.svtContainer = function () {
        var title = this.find(".css-vertical-text")
        title.css({"cursor": "pointer"})
        title.attr("title", "Minimizar")
        var fa = $("<i class='fa fa-arrow-left fa-fw' style='font-size: 20px !important; margin-left: -30px; color: #0088CC'></i>")
        var texto = $("<span class='texto' style='display: none; margin-left: 10px; color:#0088CC; font-size: 20px ' > (Clic aquí para expandir)</span>")
        title.addClass("open")
        title.prepend(fa)
        title.append(texto)
        title.bind("click", function () {
            if ($(this).parent().attr("skip") != "1") {
                if ($(this).hasClass("open")) {
                    $(this).parent().find(".row").hide("blind")
                    $(this).parent().find(".linea").hide("blind")
                    $(this).removeClass("open");
                    $(this).addClass("closed")
                    $(this).removeClass("css-vertical-text")
                    $(this).find(".texto").show()
                    setTimeout('$(this).parent().css({"height":"30px"});', 30)
                } else {
                    $(this).parent().css({"height": "auto"});
                    $(this).parent().find(".row").show("slide")
                    $(this).parent().find(".linea").show("slide")
                    $(this).removeClass("closed");
                    $(this).addClass("open")
                    $(this).addClass("css-vertical-text")
                    $(this).attr("title", "Maximizar")
                    $(this).find(".texto").hide()
                }
            }
        });
        return this;
    }
*/

    function calculaIva() {
        var iva = ${iva ?: 0};
        var val = parseFloat($("#iva12").val());
        var total = (iva / 100) * val;
        $("#ivaGenerado").val(number_format(total, 2, ".", ""));
    }

    $(function () {
//        $(".vertical-container").svtContainer()
        <g:if test="${proceso && registro}">
        $(".css-vertical-text").click()
        </g:if>

        $("#btn-br-prcs").click(function () {
            bootbox.confirm("Está seguro? si esta transacción tiene un comprobante, este será anulado. " +
                    "Esta acción es irreversible", function (result) {
                if (result) {
                    $(".br_prcs").submit()
                }
            })
        });

        $("#abrir-fp").click(function () {
            $('#modal-formas-pago').modal('show')
        })

        $("#btn_buscar").click(function () {
            console.log("clickf1")
            $('#modal-proveedor').modal('show')
        });

        $("#prve").dblclick(function () {
            console.log("clickfff")
            $("#btn_buscar").click()
        });


        $("#agregarFP").click(function(){
            var band = true
            var message
            if ($(".filaFP").size() == 5) {
                message = "<b>Ya ha asignado el máximo de 5 formas de  pago</b>"
                band = false
            }
            if ($(".fp-"+$("#comboFP").val()).size() >0) {
                message = "<b>Ya ha asignado la forma de pago "+$("#comboFP option:selected").text()+ " previamente.</b>"
                band = false
            }
            if (band) {
                var div = $("<div class='filaFP ui-corner-all'>")
                var span = $("<span class='span-eliminar ui-corner-all' title='Click para eliminar'>Eliminar</span>")
                div.html($("#comboFP option:selected").text())
                div.append(span)
                div.addClass("fp-"+$("#comboFP").val())
                div.attr("fp",$("#comboFP").val())
                span.bind("click", function () {
                    $(this).parent().remove()
                })
                $("#detalle-fp").append(div)
            }else{
                bootbox.alert(message)
            }
        });


        $(".span-eliminar").bind("click", function () {
            $(this).parent().remove()
        })

        $("#guardarProceso").click(function () {
            var bandData = true
            var error = ""
            var info = ""
            var tipoP = $(".tipoProcesoSel option:selected").val();

            if (tipoP != 'A') {   /* no es ajuste */

                $("#listaErrores").html('');
                $("#divErrores").hide();

                if ($("#fecha_input").val().length < 10) {
                    error += "<li>Seleccione la fecha de emisión</li>"
                }
                if ($("#fecharegistro_input").val().length < 10) {
                    error += "<li>Seleccione la fecha de registro</li>"
                }
                if ($("#descripcion").val().length < 1) {
                    error += "<li>Llene el campo Descripción</li>"
                }

                if ($("#prve").val() == "" || $("#prve").val() == null) {
                    error += "<li>Seleccione el proveedor</li>"
                }

                if ($("#tipoComprobante").val() == '' || $("#tipoComprobante").val() == null) {
                    error += "<li>Seleccione un comprobante</li>"
                }

                if ($("#iva12").val() == 0 && $("#iva0").val() == 0 && $("#noIva").val() == 0) {
                    error += "<li>Ingrese valores en la base imponible</li>"
                }

                if (tipoP == 'V') {
                    if ($("#secuencial").val() == '' && tipoP == 'V') {
                        error += "<li>Ingrese el número secuencial de la factura</li>"
                    } else {
                        if (revisarSerieFactura() == 'no') {
                            error += "<li>El numero de serie ingresado no se encuentra en el rango del libretin seleccionado</li>"
                        }
                        if (validarSerieFactura() == 'no') {
                            error += "<li>El numero de serie ingresado ya se encuentra asignado</li>"
                        }
                    }
                }

                if (tipoP == 'C' || tipoP == 'N' || tipoP == 'D') {
                    if ($("#dcmtEstablecimiento").val() == '') {
                        error += "<li>Ingrese el número de establecimiento del Documento</li>"
                    }
                    if ($("#dcmtEmision").val() == '') {
                        error += "<li>Ingrese punto de emisión del Documento</li>"
                    }
                    if (parseInt($("#dcmtSecuencial").val()) < 1) {
                        error += "<li>Ingrese el número del Documento</li>"
                    }
                    if ($("#dcmtAutorizacion").val() == '') {
                        error += "<li>Ingrese el número de autorización del Documento</li>"
                    }
                }


                if (tipoP == 'P') {

//                        console.log("pago " + parseFloat($("#valorPago").val()))
//                        console.log("saldo " + parseFloat($("#comprobanteSaldo1").val()))

                    if (parseFloat($("#valorPago").val()) > parseFloat($("#comprobanteSaldo").val())) {
                        error += "<li>El valor ingresado es mayor al saldo del comprobante a pagar!</li>";

                        $("#valorPago").removeClass('required');
                        $("#valorPago").addClass('colorRojo');
                    }
                }
            } else {
                $("#listaErrores").html("")
                if ($("#fecha").val().length < 10) {
                    error += "<li>Seleccione la fecha de emisión</li>"
                }
                if ($("#descripcion").val().length < 1) {
                    error += "<li>Llene el campo Descripción</li>"
                }
                if ($("#tipoProceso").val() == "-1") {
                    error += "<li>Seleccione el tipo de la transacción</li>"
                } else {
                    if ($("#tipoProceso").val() == "C" || $("#tipoProceso").val() == "V") {

                        if ($("#sustento").val() == "-1") {
                            error += "<li>Seleccione un sustento tributario (Necesario si el tipo de transacción es Compras o Ventas)</li>"
                        }
                        if ($("#tipoComprobante").val() == "-1") {
                            error += "<li>Seleccione el tipo de comprobante a registrar (Necesario si el tipo de transacción es Compras o Ventas)</li>"
                        } else {
                            if ($("#establecimiento").val().length < 3) {
                                error += "<li>Ingrese el número de establecimiento del documento (Primera parte del campo documento) </li>"
                            }
                            if ($("#emision").val().length < 3) {
                                error += "<li>Ingrese el número de emisión del documento (Segunda parte del campo documento)</li>"
                            }
                            if ($("#secuencial").val().length < 1) {
                                error += "<li>Ingrese el número de secuencia del documento (Tercera parte del campo documento)</li>"
                            }
                        }
                    }
                }
                var iva0 = $("#iva0").val()
                var iva12 = $("#iva12").val()
                var noIva = $("#noIva").val()
                if (isNaN(iva12)) {
                    iva12 = -1
                }
                if (isNaN(noIva)) {
                    noIva = -1
                }
                if (isNaN(iva0)) {
                    iva0 = -1
                }
                if (iva12 * 1 < 0) {
                    error += "<li>La base imponible iva ${iva}% debe ser un número positivo</li>"
                }
                if (iva0 * 1 < 0) {
                    error += "<li>La base imponible iva 0% debe ser un número positivo</li>"
                }
                if (noIva * 1 < 0) {
                    error += "<li>La base imponible no aplica iva debe ser un número positivo</li>"
                }
                var base = iva0 * 1 + iva12 * 1 + noIva * 1
                if (base <= 0) {
                    error += "<li>La suma de las bases imponibles no puede ser cero</li>"
                } else {
                    var impIva = $("#ivaGenerado").val()
                    var impIce = $("#iceGenerado").val()
                    if (isNaN(impIva)) {
                        impIva = -1
                    }
                    if (isNaN(impIce)) {
                        impIce = -1
                    }
                    if (impIva * 1 > 0 && iva12 * 1 <= 0) {
                        error += "<li>No se puede generar IVA si la base imponible iva ${iva}% es cero</li>"
                    }
                    if (impIce * 1 * impIva * 1 < 0) {
                        error += "<li>Los impuestos generados no pueden ser negativos</li>"
                    } else {
                        if ((impIce * 1 + impIva * 1) > base) {
                            error += "<li>Los impuestos generados no pueden ser superiores a la suma de las bases imponibles</li>"
                        }
                    }
                }
            }

            if($(".filaFP").size() <1){
                info+="No ha asignado formas de pago para la transacción contable"
                bandData=false
            }

            if (bandData) {
                var data = ""
                $(".filaFP").each(function () {
                    data += $(this).attr("fp") + ";"
                })
                $("#data").val(data)
            }

            if (error != "") {

                $("#listaErrores").append(error)
                $("#listaErrores").show()
                $("#divErrores").show()
            } else {
                if (info != "") {
                    info += " Esta seguro de continuar?"
                    bootbox.confirm(info, function (result) {

                        if (result) {

                            $(".frmProceso").submit();
                        }
                    })
                } else {
                    openLoader("Guardando..");
                    $(".frmProceso").submit();
                    closeLoader()
                }
            }
            closeLoader()

        });

        calculaIva();


        function revisarSerieFactura() {
            var regresa = $.ajax({
                type: 'POST',
                async: false,
                url: '${createLink(controller: 'proceso', action: 'comprobarSerieFactura_ajax')}',
                data: {
                    libretin: $("#comprobanteFactura option:selected").val(),
                    serie: $("#serieFactura").val()
                },
                success: function (msg) {
                }
            });
            return regresa.responseText
        }

        function validarSerieFactura() {
            var regresaV = $.ajax({
                type: 'POST',
                async: false,
                url: '${createLink(controller: 'proceso', action: 'validarSerieFactura_ajax')}',
                data: {
                    proceso: '${proceso?.id}',
                    serie: $("#serieFactura").val()
                },
                success: function (msg) {
                }
            });
            return regresaV.responseText
        }

        $("#iva12").keyup(function () {
            calculaIva();
        });

        $(".number").blur(function () {
            if (isNaN($(this).val()))
                $(this).val("0.00")
            if ($(this).val() == "")
                $(this).val("0.00")
        });

        $("#buscarPrve").click(function () {
            console.log('bbbbbb');
            var tipo = $(".tipoProcesoSel option:selected").val();
            console.log('buscar...', tipo);
            $.ajax({
                type: "POST",
                url: "${g.createLink(controller: 'proceso',action: 'buscarProveedor')}",
                data: "par=" + $("#parametro").val() + "&tipo=" + $("#tipoPar").val() + "&tipoProceso=" + tipo,
                success: function (msg) {
                    $("#resultados").html(msg).show("slide")
                }
            });
        });

        $("#parametro").keyup(function (ev) {
            if (ev.keyCode == 13) {
                $("#buscarPrve").click();
            }
        });

        $("#registrarProceso").click(function () {
            bootbox.confirm("<i class='fa fa-exclamation-circle fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea registrar la transacción? </br> Una vez registrado, la información NO podrá ser cambiada.</p>", function (result) {
                if (result) {
                    openLoader("Registrando...");
                    $.ajax({
                        type: "POST",
                        url: "${g.createLink(controller: 'proceso',action: 'registrar')}",
                        data: "id=" + $("#idProceso").val(),
                        success: function (msg) {
                            // $("#registro").html(msg).show("slide");
                            closeLoader()
                            location.reload(true);
                        },
                        error: function () {
                            bootbox.alert("Ha ocurrido un error. Por favor revise el gestor y los valores del proceso.")
                        }
                    });
                }

            })
        });
    });

    function cargarComprobante(proceso) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso',action: 'comprobante_ajax')}",
            data: {
                proceso: proceso
            },
            success: function (msg) {
                $("#divComprobante").html(msg).show("slide");
            }
        });
    }


    cargarExterior($("#pago option:selected").val());

    $("#pago").change(function () {
        cargarExterior($(this).val())
    });

    function cargarExterior(pago) {
        if (pago == '02') {
            $(".exterior").show();
        } else {
            $(".exterior").hide();
            $(".norma").attr("checked", false);
            $(".convenio").attr("checked", false);
        }
    }


    $("#libretin").change(function () {
        console.log('libretin..')
        var idLibretin = $("#libretin option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'numeracion_ajax')}',
            data: {
                libretin: idLibretin
            },
            success: function (msg) {
                var partes = msg.split('_');
                $("#numEstablecimiento").val(partes[0])
                $("#numEmision").val(partes[1])
            }
        })
    });


    $("#procesoForm").validate({
        errorClass: "help-block",
        errorPlacement: function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success: function (label) {
            label.parents(".grupo").removeClass('has-error');
        },
        rules: {
            serie: {
                remote: {
                    type: 'POST',
                    url: "${createLink(controller: 'proceso', action: 'validarSerie_ajax')}",
                    data: {
                        fcdt: $("#libretin option:selected").val(),
                        id  : "${retencion?.id}"
                    }
                }
            }
        },
        messages: {
            serie : {
                remote : "Número de comprobante no válido!"
            }
        }
    });




</script>
</body>
</html>
