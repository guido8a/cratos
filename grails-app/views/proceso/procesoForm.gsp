<%@ page import="cratos.inventario.Bodega; cratos.Asiento; cratos.sri.TipoComprobanteSri" %>
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

    .span-eliminar {
        padding-right: 10px;
        padding-left: 10px;
        height: 16px;
        line-height: 16px;
        background: rgba(255, 2, 10, 0.35);
        margin-right: 5px;
        font-size: 12px;
        cursor: pointer;
        float: right;
    }

    .error{
        color: red;
        font-weight: normal;
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

    <div class="btn-group" style="margin-right: 20px">
        <a href="#" class="btn btn-success previous disabled" id="procesoN">
            <i class="fa fa-gear"></i>
            Proceso
        </a>
        <g:if test="${proceso?.estado == 'R'}">
            <a href="#" class="btn btn-success" id="comprobanteN">
                <i class="fa fa-calendar-o"></i>
                Comprobante
            </a>

        </g:if>
        <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'C'}">
            <g:link class="btn btn-success" action="detalleSri" id="${proceso?.id}" style="margin-bottom: 10px;">
                <i class="fa fa-money"></i> Retenciones
            </g:link>
        </g:if>

        <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'C' && proceso?.tipoCmprSustento?.tipoComprobanteSri?.codigo?.trim() == '41'}">
            <a href="#" class="btn btn-success" id="reembolsoN">
                <i class="fa fa-thumbs-up"></i>
                Reembolso
            </a>
        </g:if>
    </div>

    <div class="btn-group">
        <g:if test="${!proceso || (proceso?.estado == 'N')}">
            <a href="#" class="btn btn-success" id="guardarProceso">
                <i class="fa fa-save"></i>
                Guardar
            </a>
        </g:if>
        <g:if test="${params.id}">
            <g:if test="${!(proceso?.estado == 'R')}">
                <a href="#" class="btn btn-info" id="registrarProceso">
                    <i class="fa fa-check"></i>
                    Registrar
                </a>
            </g:if>
        </g:if>

        <g:if test="${proceso}">
            <g:if test="${!aux}">
                <g:if test="${proceso?.tipoProceso?.id != 4}">
                    <g:form action="borrarProceso" class="br_prcs" style="display: inline">
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

        %{--<g:if test="${proceso?.tipoProceso?.id == 1}">--}%
        %{--<g:link class="btn btn-primary" action="detalleSri" id="${proceso?.id}" style="margin-bottom: 10px;">--}%
        %{--<i class="fa fa-money"></i> Retenciones--}%
        %{--</g:link>--}%
        %{--</g:if>--}%
            <g:if test="${cratos.Retencion.findByProceso(proceso)}">
                <g:link controller="reportes3" action="imprimirRetencion" class="btn btn-default btnRetencion"
                        id="${proceso?.id}" params="[empresa: session.empresa.id]" style="margin-bottom: 10px;">
                    <i class="fa fa-print"></i>
                    Imprimir retención
                </g:link>
            </g:if>
            <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'C' || proceso?.tipoProceso?.codigo?.trim() == 'V' || proceso?.tipoProceso?.codigo?.trim() == 'T' || proceso?.tipoProceso?.codigo?.trim() == 'NC'}">
                <a href="#" class="btn btn-warning" id="btnDetalle" style="color: #0b0b0b">
                    <i class="fa fa-list"></i>
                    Detalle
                </a>
            </g:if>
        </g:if>


        <a href="#" class="btn btn-primary" style="cursor: default; margin-right: 20px" id="abrir-fp">
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
    <input type="hidden" id="libretin_id" value="${proceso?.proveedor?.id}">

    <div class="vertical-container" style="margin-top: 25px;color: black;padding-bottom: 10px">
        <p class="css-vertical-text">Descripción</p>

        <div class="linea"></div>

        <input type="hidden" name="id" value="${proceso?.id}" id="idProceso"/>
        <input type="hidden" name="data" id="data"/>
        <div class="row">
            <div class="col-xs-2 negrilla">
                Fecha de Emisión:
            </div>
            <div class="col-xs-2">
                <g:if test="${(proceso?.estado == 'R')}">
                    ${proceso?.fechaEmision?.format("dd-MM-yyyy")}
                </g:if>
                <g:else>
                    <elm:datepicker name="fecha" title="Fecha de emisión del comprobante"
                                    class="datepicker form-control required col-xs-3 fechaE"
                                    value="${proceso?.fechaEmision}" maxDate="new Date()"
                                    style="width: 80px; margin-left: 5px"/>
                </g:else>
            </div>

            <div class="col-xs-1 negrilla">
                Fecha<br>Registro:
            </div>

            <div class="col-xs-2">
                <g:if test="${(proceso?.estado == 'R')}">
                    ${proceso?.fechaIngresoSistema?.format("dd-MM-yyyy")}
                </g:if>
                <g:else>
                    <elm:datepicker name="fechaingreso" title="Fecha de registro en el sistema"
                                    class="datepicker form-control required col-xs-3"
                                    value="${proceso?.fechaIngresoSistema}" maxDate="new Date()"
                                    style="width: 80px; margin-left: 5px"/>
                </g:else>
            </div>

            <div class="col-xs-1 negrilla">
                Estable-<br>cimiento:
            </div>

            <div class="col-xs-1 negrilla">
                <g:textField name="establecimiento" id="establecimiento" class="form-control required validacionNumeroSinPuntos" maxlength="3" value="${proceso?.establecimiento}" disabled="${proceso?.estado == 'R' ?: false}"/>
            </div>

            <div class="col-xs-1 negrilla">
                Tipo de transacción:
            </div>

            <div class="col-xs-2 negrilla">
                <g:select class="form-control required cmbRequired tipoProcesoSel ${proceso ? '' : 'hidden'}" name="tipoProceso" id="tipoProceso"
                          from="${cratos.TipoProceso.list(sort: 'codigo')}" label="Proceso tipo: "
                          value="${proceso?.tipoProceso?.id}" optionKey="id"
                          optionValue="descripcion" title="Tipo de la transacción" disabled="${proceso?.estado == 'R' ?: false}" />
            </div>




        </div>

        <div class="row" id="gestorDiv"></div>
        <div class="row" id="divCargaProveedor"></div>
        <div class="row" id="divFilaComprobante"></div>
        <div class="row" id="divSustento"></div>
        <div class="row" id="divComprobanteSustento"></div>

        <div class="row">
            <div class="col-xs-2 negrilla">
                Descripción:
            </div>

            <div class="col-xs-10 negrilla">
                <g:textField name="descripcion" id="descripcion" value="${proceso?.descripcion}" maxlength="255"
                             class="form-control required" readonly="${proceso?.estado == 'R' ?: false}" />
            </div>
        </div>
        <div class="row hidden" id="bodegas">
            <div class="col-xs-2 negrilla">
                Bodega que entrega:
            </div>

            <div class="col-xs-4 negrilla">
                <g:select class="form-control required cmbRequired tipoProcesoSel" name="bodega" id="bodega"
                          from="${cratos.inventario.Bodega.list(sort: 'descripcion')}" label="Bodega"
                          value="${proceso?.bodega?.id}" optionKey="id"
                          optionValue="descripcion" title="Bodega que entrega" disabled="${proceso?.estado == 'R' ?: false}" />
            </div>
            <div class="col-xs-2 negrilla" style="text-align: right">
                Bodega que recibe:
            </div>

            <div class="col-xs-4 negrilla" id="divBodegaRecibe"></div>
        </div>

        <div class="row" id="libretinFacturas">
        </div>

        <div class="row" id="pagoProceso">
            <div class="col-xs-2 negrilla">
                <label>Pago Local o Exterior</label>
            </div>
            <div class="col-xs-3">
                <g:select class="form-control" name="pago"
                          from="${['01': '01 - PAGO A RESIDENTE', '02': '02 - PAGO A NO RESIDENTE']}" optionKey="key"
                          optionValue="value" value="${proceso?.pago}" disabled="${proceso?.estado == 'R' ?: false}"/>
            </div>

            <div class="exterior col-xs-12" hidden="hidden" style="margin-top: 20px">
                <fieldset>
                    <div class="col-xs-12">
                        <div class="col-xs-1" style="margin-left: -20px">
                            <label>País:</label>
                        </div>
                        <div class="col-xs-2">
                            <g:select class="form-control" style="margin-left: -30px; width: 230px"
                                      name="pais" from="${cratos.sri.Pais.list([sort: 'nombre'])}"
                                      optionKey="id" optionValue="nombre" value="${proceso?.pais?.id}"
                                      disabled="${proceso?.estado == 'R' ?: false}"/>
                        </div>
                        <div class="col-xs-4">
                            <label style="margin-left: 50px">Aplica convenio de doble tributación?</label> <br/>
                            <div style="margin-left: 50px">
                                <g:radioGroup class="convenio" labels="['SI', 'NO']" values="['SI', 'NO']" name="convenio"
                                              value="${proceso?.convenio?:'NO'}">
                                    ${it?.label} ${it?.radio}
                                </g:radioGroup>
                            </div>
                        </div>

                        <div class="col-xs-5">
                            <label>Pago sujeto a retención en aplicación de la norma legal</label><br/>
                            <g:radioGroup class="norma" labels="['SI', 'NO']" values="['SI', 'NO']" name="norma"
                                          value="${proceso?.normaLegal?:'NO'}">${it?.label} ${it?.radio}</g:radioGroup>
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
%{--<g:if test="${proceso}">--}%
%{--<div class="vertical-container" skip="1" style="margin-top: 5px; color:black; margin-bottom:20px; height:auto; max-height: 520px; overflow: auto;">--}%
%{--<p class="css-vertical-text">Comprobante</p>--}%

%{--<div class="linea"></div>--}%

%{--<div id="divComprobante" class="col-xs-12"--}%
%{--style="margin-bottom: 0px ;padding: 0px;display: none;margin-top: 5px;">--}%
%{--</div>--}%
%{--</div>--}%
%{--</g:if>--}%


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
                        <g:if test="${!(proceso?.estado == 'R')}">
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
                            <g:if test="${!(proceso?.estado == 'R')}">
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


    $("#btnDetalle").click(function () {
        location.href='${createLink(controller: 'detalleFactura', action: 'detalleGeneral')}/?id=' + '${proceso?.id}' + '&tipo=' + '${proceso?.tipoProceso?.codigo}'
    });


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

    //    cargarProveedor($(".tipoProcesoSel option:selected").val());
    %{--cargarComprobante('${proceso?.id}');--}%

    $(document).ready(function () {
        var tipo = $(".tipoProcesoSel option:selected").val();
        var prve = $("#prve__id").val();
//        console.log("prve__id:", prve);

        $("#listaErrores").html('');
        $("#divErrores").hide();

        $("#sustento").html('');
        $("#susteno").hide();
        $("#divFilaComprobante").html('');
        $("#divFilaComprobante").hide();
        $("#libretinFacturas").hide()

        cargaGestor(tipo)
        if("${!proceso?.id}") {
            cargarProveedor(tipo)
        }

        if (prve && (tipo == '1')) {
            $("#libretinFacturas").hide()
            $("#pagoProceso").show()
            cargarProveedor(tipo);
            if ("${proceso?.sustentoTributario}") {
                %{--console.log("proceso:", "${proceso?.tipoCmprSustento?.id}");--}%
                cargarSstr("${proceso?.proveedor?.id}")
            }

            setTimeout(function () {
                if ("${proceso?.tipoCmprSustento}") {
                    $("#tipoCmprSustento").change();
                    cargarTipo(tipo, "${proceso?.tipoCmprSustento?.id}", "${proceso?.proveedor?.id}", "${proceso?.tipoProceso?.id}");
                }
            }, 1000);
        }

        if (prve && (tipo == '2')) {
            $("#libretinFacturas").show()
            $("#pagoProceso").hide()
            cargarProveedor(tipo);
            cargarTcsr(prve)
//            cargarTipo(tipo);
        }

        if (tipo == '2' || tipo == '6' || tipo == '7') {
            cargarLibretin();
            $("#libretinFacturas").show()
            $("#pagoProceso").hide()
        } else {
            $("#libretinFacturas").hide()
        }


        if (tipo == '3') {
            $("#libretinFacturas").hide()
            $("#pagoProceso").hide()
//            cargarTipo(tipo);
        }

        if (tipo == '4' || tipo == '5' || tipo == '6' || tipo == '7') {
            $("#libretinFacturas").hide()
            $("#pagoProceso").hide()
            $("#divFilaComprobante").show()
//            cargarTipo(tipo);
        }

        cargarBotonBuscar($(".tipoProcesoSel option:selected").val());
        if (tipo =='4' || tipo == '6' || tipo == '7' || tipo == '5') {
//            console.log('carga ComPago')
            cargarCompPago();
        }

        if(tipo != '1') {
            cargarTipo(tipo);
            $("#pagoProceso").hide()
        }

        if(tipo == '8') {
            $("#bodegas").removeClass('hidden');
        } else {
            $("#bodegas").addClass('hidden');
        }

    });

    $("#tipoProceso").change(function () {
        var tipo = $(".tipoProcesoSel option:selected").val();

        $("#divComprobanteSustento").html('');
        $("#divComprobanteSustento").hide();
        $("#divSustento").html('');
        $("#divSustento").hide();

        if (tipo == '1' || tipo == '2' || tipo == '4' || tipo == '5' || tipo == '6' || tipo == '7') {
            cargarProveedor(tipo);
        } else {
            $("#divCargaProveedor").html('');
            $("#divCargaProveedor").hide();
        }

        if(tipo != 'C') {
            cargarTipo(tipo);  //carga valores
        }

        if (tipo == '2' || tipo == '6' || tipo == '7') {
//            console.log('libretin con tpps:', tipo);
//            $("#libretin").change();
            cargarLibretin();
            $("#libretinFacturas").show()
        } else {
            $("#libretinFacturas").hide()
        }

        if (tipo != '1') {
//            console.log('No es C');
            $("#pagoProceso").hide()
        } else {
//            console.log('Es C...');
            $("#pagoProceso").show()
        }

        if (tipo == '4' || tipo == '5' || tipo == '6' || tipo == '7') {
            cargarCompPago()
        } else {
            $("#divFilaComprobante").hide()
        }

        cargaGestor(tipo);

        if(tipo == '8') {
            $("#bodegas").removeClass('hidden');
        } else {
            $("#bodegas").addClass('hidden');
        }
    });

    //    $("#tipoComprobante").change(function () {
    //        console.log("cambia tpcp")
    //        console.log("cambia tpcp", $("#tipoComprobante").val())
    //        cargarTipo( $(".tipoProcesoSel option:selected").val(), $("#tipoComprobante").val() );
    //    });


    function cargaGestor(tipo) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'cargaGestor')}",
            data: {
                tipo: tipo,
                gstr_id: "${proceso?.gestor?.id}",
                rgst: "${proceso?.estado}",
                proceso: '${proceso?.id}'
            },
            success: function (msg) {
//                console.log('ok....')
                $("#gestorDiv").html(msg)
                $("#gestorDiv").show()
            }
        });
    };

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
//                console.log('ok....')
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
//        console.log('cargar prve:', tipo)
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

    function cargarCompPago() {
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
                $("#divFilaComprobante").show()
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

    function cargarTipo(tipo, tpcp, prve, tpps) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'valores_ajax')}",
            data: {
                proceso: '${proceso?.id}',
                tipo: tipo,
                tpcp: tpcp,
                prve: prve,
                tpps: tpps
            },
            success: function (msg) {
                $("#divValores").html(msg).show("slide")
                if(tipo == '1' || tipo == '2' || tipo == '6' || tipo == '7') {
//                    $("#lblValores").html(flecha + "Valores")
                    $("#lblValores").html("Valores")
                } else {
//                    $("#lblValores").html(flecha + "Val")
                    $("#lblValores").html("Val")
                }
            }
        });
    }

    $(function () {
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
//            console.log("clickf1")
            $('#modal-proveedor').modal('show')
        });

        $("#prve").dblclick(function () {
//            console.log("clickfff")
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


            $("#listaErrores").html('');
            $("#divErrores").hide();

            if (tipoP == '1') {   /* compras */
                if ($("#fecha_input").val().length < 10) {
                    error += "<li>Seleccione la fecha de emisión</li>"
                }
                if ($("#fechaingreso_input").val().length < 10) {
                    error += "<li>Seleccione la fecha de registro</li>"
                }
                if ($("#prve").val() == "" || $("#prve").val() == null) {
                    error += "<li>Seleccione el proveedor</li>"
                }
                if ($("#descripcion").val().length < 1) {
                    error += "<li>Llene el campo Descripción</li>"
                }

                if ($("#tipoCmprSustento").val() == '-1' || $("#tipoCmprSustento").val() == null) {
                    error += "<li>Seleccione el sustento tributario</li>"
                }

                if ($("#tipoComprobante").val() == '-1' || $("#tipoComprobante").val() == null) {
                    error += "<li>Seleccione el comprobante</li>"
                }

                if ($("#iva12").val() == 0 && $("#iva0").val() == 0 && $("#noIva").val() == 0) {
                    error += "<li>Ingrese valores en la base imponible</li>"
                }

                if (!$("#dcmtEstablecimiento").val()) {
                    error += "<li>Ingrese el número de establecimiento del Documento</li>"
                }
                if (!$("#dcmtEmision").val()) {
                    error += "<li>Ingrese punto de emisión del Documento</li>"
                }
                if (!$("#dcmtSecuencial").val()) {
                    error += "<li>Ingrese el número del Documento</li>"
                }
                if (!$("#dcmtAutorizacion").val()) {
                    error += "<li>Ingrese el número de autorización del Documento</li>"
                }

                if($(".filaFP").size() <1){
                    info+="No ha asignado formas de pago para la transacción contable"
                    bandData=false
                }

                if(($(".filaFP").size() <1) && (parseFloat($("#total").val()) >= 1000)){
                    error += "El valor del proceso requiere que se registre la forma de pago"
                }

                if (bandData) {
                    var data = ""
                    $(".filaFP").each(function () {
                        data += $(this).attr("fp") + ";"
                    })
                    $("#data").val(data)
                }
            }

            if (tipoP == '2') {   /* ventas */
                if ($("#fecha_input").val().length < 10) {
                    error += "<li>Seleccione la fecha de emisión</li>"
                }
                if ($("#fechaingreso_input").val().length < 10) {
                    error += "<li>Seleccione la fecha de registro</li>"
                }
                if ($("#prve").val() == "" || $("#prve").val() == null) {
                    error += "<li>Seleccione el proveedor</li>"
                }
                if ($("#descripcion").val().length < 1) {
                    error += "<li>Llene el campo Descripción</li>"
                }

                if ($("#tipoComprobante").val() == '-1' || $("#tipoComprobante").val() == null) {
                    error += "<li>Seleccione el comprobante</li>"
                }

                if ($("#iva12").val() == 0 && $("#iva0").val() == 0 && $("#noIva").val() == 0) {
                    error += "<li>Ingrese valores en la base imponible</li>"
                }

                if (!$("#numEstablecimiento").val()) {
                    error += "<li>Seleccione un libretín de facturas/li>"
                }
                if (!$("#serie").val()) {
                    error += "<li>Ingrese secuencial de la factura a emitir</li>"
                }
            }

            if (tipoP == '3') {   /* Ajustes */
                if ($("#fecha_input").val().length < 10) {
                    error += "<li>Seleccione la fecha de emisión</li>"
                }
                if ($("#fechaingreso_input").val().length < 10) {
                    $("#fechaingreso_input").val($("#fecha_input").val())
                }
                if ($("#descripcion").val().length < 1) {
                    error += "<li>Llene el campo Descripción</li>"
                }

                if ($("#valorPago").val() == 0) {
                    error += "<li>Ingrese el valor del ajuste</li>"
                }
            }

            if(tipoP == '5'){
                if ($("#descripcion").val().length < 1) {
                    error += "<li>Llene el campo Descripción</li>"
                }

                if ($("#valorPago").val() == 0) {
                    error += "<li>Ingrese el valor del ajuste</li>"
                }
                if ($("#prve").val() == "" || $("#prve").val() == null) {
                    error += "<li>Seleccione el proveedor</li>"
                }
                if(!$("#comprobanteSel").val()){
                    error += "<li>Seleccione el comprobante</li>"
                }
            }

            if (tipoP == '6' || tipoP == '7') {   /* Nota de crédito y débito */

                if ($("#iva12").val() == 0 && $("#iva0").val() == 0 && $("#noIva").val() == 0) {
                    error += "<li>Ingrese valores en la base imponible</li>"
                }
                if ((parseFloat($("#iva12").val()) + parseFloat($("#iva0").val()) + parseFloat($("#noIva").val()) +
                    parseFloat($("#ivaGenerado").val()) + parseFloat($("#iceGenerado").val()) +
                    parseFloat($("#flete").val())) > parseFloat($("#comprobanteSaldo").val()) ) {
                    error += "<li>Revise el valores de base imponible e impuestos generados</li>"
                }

                if ($("#serie").hasClass('error')){
                    error += "<li>Revise el número de de la Nota de Crédito</li>"
                }

                if ($("#descripcion").val().length < 1) {
                    error += "<li>Llene el campo Descripción</li>"
                }

                if(!$("#comprobanteSel").val()){
                    error += "<li>Seleccione el comprobante</li>"
                }
            }

            if (tipoP == '7') {   /* Nota de débito */
                if (isNaN(parseFloat($("#comprobanteSaldo").val()))) {
                    error += "<li>No hay comprobante, seleccione uno</li>"
                }

                if ((parseFloat($("#valorPagoNC").val()) + parseFloat($("#ivaGeneradoNC").val())) > parseFloat($("#comprobanteSaldo").val()) ||
                    (parseFloat($("#valorPagoNC").val()) + parseFloat($("#ivaGeneradoNC").val())) <= 0 ) {
                    error += "<li>Revise el valor de la Nota de Crédito y el IVA</li>"
                }

                if ($("#serie").hasClass('error')){
                    error += "<li>Revise el número de de la Nota de Crédito</li>"
                }
            }



            if(!$("#establecimiento").val()){
                error += "<li>Ingrese un número de establecimiento</li>"
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

//        calculaIva();

        $(".number").blur(function () {
            if (isNaN($(this).val()))
                $(this).val("0.00")
            if ($(this).val() == "")
                $(this).val("0.00")
        });

        $("#buscarPrve").click(function () {
            var tipo = $(".tipoProcesoSel option:selected").val();
//            console.log('buscar...', tipo);
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

    %{--function cargarComprobante(proceso) {--}%
    %{--$.ajax({--}%
    %{--type: 'POST',--}%
    %{--url: "${createLink(controller: 'proceso',action: 'comprobante_ajax')}",--}%
    %{--data: {--}%
    %{--proceso: proceso--}%
    %{--},--}%
    %{--success: function (msg) {--}%
    %{--$("#divComprobante").html(msg).show("slide");--}%
    %{--}--}%
    %{--});--}%
    %{--}--}%


    cargarExterior($("#pago option:selected").val());

    $("#pago").change(function () {
        cargarExterior($(this).val())
    });

    $("#fecha_input").change(function () {
        if ($("#fechaingreso_input").val().length < 10) {
            $("#fechaingreso_input").val($("#fecha_input").val())
        }
    });

    function cargarExterior(pago) {
        if (pago == '02') {
            $(".exterior").show();
        } else {
            $(".exterior").hide();
        }
    }


    $("#libretin").change(function () {
        console.log('libretin..')
        var idLibretin = $("#libretin option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'numeracion_ajax')}',
            data: {
                libretin: idLibretin,
                tpps: $(".tipoProcesoSel option:selected").val(),
                fcha: $("#fecha_input").val()
            },
            success: function (msg) {
                var partes = msg.split('_');
                $("#numEstablecimiento").val(partes[0])
                $("#numEmision").val(partes[1])
                $("#serie").val(partes[2])
            }
        })
    });

    function cargarLibretin() {
        var fcha =  $("#fecha_input").val()
        if(fcha){
            if(fcha.length < 10) {
                $(".tipoProcesoSel").val(0);
                $("#fecha_input").focus();
            } else {
                var tpps = $(".tipoProcesoSel option:selected").val();
                $.ajax({
                    type: 'POST',
                    async: 'true',
                    url: "${createLink(controller: 'proceso', action: 'numeracion_ajax')}",
                    data: {
                        proceso: '${proceso?.id}',
                        tpps: tpps,
                        fcha: $("#fecha_input").val()
                    },
                    success: function (msg) {
                        $("#libretinFacturas").html(msg)
                        $("#libretinFacturas").show()
                    }
                });
            }
        }
    }

    $(".fechaE").change(function () {
        revisarFecha();
    });

    revisarFecha();

    function revisarFecha () {
        if($(".fechaE").val() != '' || $(".fechaE").val()){
            $(".tipoProcesoSel").removeClass('hidden')
        }
    }

    revisarBodega($("#bodega").val());

    $("#bodega").change(function () {
        var bodega = $("#bodega").val();
        revisarBodega(bodega)
    });

    function revisarBodega (bodega) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'bodegaRecibe_ajax')}',
            data:{
                bodega: bodega,
                proceso: '${proceso?.id}'
            },
            success: function (msg){
                $("#divBodegaRecibe").html(msg)
            }
        });
    }

    $("#comprobanteN").click(function () {
        location.href="${createLink(controller: 'proceso', action: 'comprobante')}/?proceso=" + '${proceso?.id}'
    })

    $("#reembolsoN").click(function () {
        location.href="${createLink(controller: 'proceso', action: 'reembolso')}/?proceso=" + '${proceso?.id}'
    });

</script>
</body>
</html>
