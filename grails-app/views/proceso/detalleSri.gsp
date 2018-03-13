<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Detalle SRI</title>

    <style type="text/css">

    .fila {
        height: 30px;
        clear: both;
    }

    input[type="text"]:read-only { color: blue; }

    .esconder {
        display: none;
    }

    #fechaEmision_name_input {
        background-color: #fff; !important;
    }

    </style>
</head>

<body>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link class="btn regresar btn-info btn-ajax" action="buscarPrcs">
            <i class="fa fa-chevron-left"></i> Lista de Procesos</g:link>
        <g:link class="btn regresar btn-warning btn-ajax" id="${proceso?.id}" action="nuevoProceso">
            <i class="fa fa-chevron-left"></i> Proceso
        </g:link>
    </div>

    <g:if test="${proceso?.estado != 'R'}">
        <div class="btn-group">
            <a href="#" class="btn btn-success" id="btnGuardar">
                <i class="fa fa-floppy-o"></i> Guardar</a>
        </div>
    </g:if>

    <div class="text-info negrilla" style="margin-left: 10px; text-align: right; width: 350px; display: inline-block; font-size: 16px">Transacción: ${proceso.descripcion}</div>

    <div class="btn-group" style="margin-right: 20px; margin-left: 10px">
        <g:if test="${proceso?.estado == 'R'}">
            <a href="#" class="btn btn-success" id="comprobanteN">
                <i class="fa fa-calendar-o"></i>
                Comprobante
            </a>
        </g:if>
    </div>

    <div class="btn-group" style="margin-right: 20px; margin-left: 10px">
        <g:if test="${retencion?.proceso?.estado =='R'}">
            <g:if test="${retencion?.estado == 'S'}">
                <a href="#" class="btn btn-warning registrar" title="Desregistrar la Retención">
                    <i class="fa fa-check"></i>
                    Desregistrar
                </a>
            </g:if>
            <g:else>
                <g:if test="${retencion?.total > 0}">
                    <a href="#" class="btn btn-info registrar" title="Registrar la Retención">
                        <i class="fa fa-check"></i>
                        Registrar
                    </a>
                </g:if>
            </g:else>
            <a href="#" class="btn btn-primary" id="btnRetencion" title="Imprimir la Retención">
                <i class="fa fa-print"></i>
                Imprimir retención
            </a>
        </g:if>
    </div>
</div>

<div style="padding: 0.7em; margin-top:5px; display: none;" class="alert alert-danger ui-corner-all"
     id="divErroresDetalle">
    <i class="fa fa-exclamation-triangle"></i>
    <span style="" id="spanError">Se encontraron los siguientes errores:</span>
    <ul id="listaErrores"></ul>
</div>

<g:form name="sriForm">
    <div class="vertical-container ancho" style="height: 120px; margin-top: 30px">
        <p class="css-vertical-text">Retención</p>

        <div class="linea"></div>

        <div class="col-xs-12">
            <div class="col-xs-1 negrilla">
                Proveedor:
            </div>

            <div class="col-xs-2">
                <input type="text" name="proveedor.ruc" class="form-control " id="prov" readonly="true"
                       value="${proceso?.proveedor?.ruc ?: ''}" title="RUC del proveedor o cliente" style="width: 160px;"
                       placeholder="RUC"/>
            </div>

            <div class="col-xs-4">
                <input type="text" name="proveedor.nombre" class="form-control  label-shared" id="prov_nombre"
                       readonly="true" value="${proceso?.proveedor?.nombre ?: ''}"
                       title="Nombre del proveedor o cliente" style="width: 340px; margin-right: 60px"
                       placeholder="Nombre"/>
            </div>

            <div class="col-xs-2 text-info" style="margin-top: -20px">
                Base Imponible:
                <input type="text" name="baseImponible" class="form-control " id="baseImponible" readonly
                       value="${proceso?.baseImponibleIva + proceso?.flete}" title="Base Imponible"
                       style="width: 120px; text-align: right"/>
            </div>
            <div class="col-xs-1 text-info" style="margin-top: -20px">
                IVA:
                <input type="text" name="ivaGenerado" class="form-control " id="ivaGenerado" readonly
                       value="${proceso?.ivaGenerado}" title="Base Imponible"
                       style="margin-left: -40px; width: 100px; text-align: right"/>
            </div>

        </div>

        <div class="col-xs-12" style="margin-top: 10px">

            <div class="col-xs-1 negrilla">
                Fecha Emisión:
            </div>

            <div class="col-xs-2">
                <elm:datepicker name="fechaEmision_name" class="datepicker required form-control fechaEmision"
                                value="${retencion?.fechaEmision ?: proceso.fechaIngresoSistema}"/>
            </div>

            <div class="col-xs-2 negrilla">
                Comprobante N°:
            </div>

            <div class="col-xs-4" style="margin-left: -30px">
                <g:select name="libretin" from="${libreta}" value="${retencion?.documentoEmpresa}"
                          class="form-control" optionKey="id" libre="1"
                          optionValue="${{"Desde: " + it?.numeroDesde + ' - Hasta: ' + it?.numeroHasta + " - Autorización: " +
                                  it?.fechaAutorizacion?.format("dd-MM-yyyy")}}"/>
                <g:hiddenField name="libretinName" id="idLibre" value=""/>
            </div>
            <div class="col-xs-3">
                <g:textField name="numEstablecimiento" id="numEstablecimiento" readonly="true"  style="width: 50px"
                             title="Número de Establecimento"/> -
                <g:textField name="numeroEmision" id="numEmision" readonly="true" style="width: 50px"
                             title="Numeración Emisión"/>

                <g:textField name="serie" id="serie" value="${retencion?.numero?: ''}" maxlength="10"
                             class="form-control required validacionNumero"  style="width: 100px; display: inline"/>
            </div>






            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>


    <div class="vertical-container" style="height: 200px;">
        <p class="css-vertical-text">Impuesto a la Renta</p>

        <div class="linea"></div>
        <div class="fila" style="margin-top: 30px">
            <div class="col-xs-7">
                <label>Retención Impuesto a la Renta Bienes</label>
                <g:select class="form-control" name="conceptoRenta"
                          from="${crirBienes}"
                          optionKey="id" optionValue="${{ it.codigo + ' : ' + it.porcentaje + '% ' + it.descripcion }}"
                          value="${retencion?.conceptoRIRBienes?.id ?: -1}" noSelection="${['-1': 'Seleccione...']}"/>
            </div>

            <div class="col-xs-2">
                <label>Base Imponible</label>
                <g:textField class="form-control number baseB" title="La base imponible del IR."
                             style="text-align: right" name="baseRenta"
                             value="${retencion?.baseRenta ?: proceso?.baseImponibleIva + proceso?.flete}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>

            <div class="col-xs-1">
                <label>Porcentaje</label>
                <g:textField class="form-control" title="% de rentención" name="porcentaje"
                             readonly="true"
                             style="text-align: right; width: 70px;"/>
            </div>

            <div class="col-xs-2">
                <label>Valor Retenido</label>
                <g:textField class="form-control number required" title="Valor retenido" name="valorRetenido"
                             value="${g.formatNumber(number: retenido, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2)}"
                             style="text-align: right"/>
            </div>
        </div>

        <div class="fila" style="margin-top: 50px">
            <div class="col-xs-7">
                <label>Retención Impuesto a la Renta Servicios</label>
                <g:select class="form-control" name="conceptoRentaSrvc"
                          from="${crirServicios}"
                          optionKey="id" optionValue="${{ it.codigo + ' - ' + it.descripcion }}"
                          value="${retencion?.conceptoRIRServicios?.id ?: -1}" noSelection="${['-1': 'Seleccione...']}"/>
            </div>

            <div class="col-xs-2">
                <label>Base Imponible</label>
                <g:textField class="form-control number brs"
                             title="La base imponible del IR." style="text-align: right" name="baseRentaSrvc"
                             value="${retencion?.baseRentaServicios ?: 0}"/>
            </div>

            <div class="col-xs-1">
                <label>Porcentaje</label>
                <g:textField class="form-control" title="% de rentención" name="porcentajeSrvc"
                             readonly="true" style="text-align: right; width: 70px;"/>
            </div>

            <div class="col-xs-2">
                <label>Valor Servicios</label>
                <g:textField class="form-control number required" title="Valor retenido" name="valorRetenidoSrvc"
                             value="${g.formatNumber(number: retenido, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2)}"
                             style="text-align: right"/>
            </div>
            <div class="col-xs-2">
            </div>

        </div>

        <div style="margin-top: 45px">
            <div class="col-xs-3">
            </div>
            <div class="col-xs-4" style="text-align: right">
                Total base imponible aplicada a la Renta
            </div>

            <div class="col-xs-2">
                <g:textField class=" form-control" title="Total imponible renta" name="sumaRenta"
                             readonly="true" style="text-align: right"/>
            </div>

            <div class="col-xs-1">
            </div>
            <div class="col-xs-2">
                <g:textField class=" form-control" title="Total imponible renta" name="sumaRtcnRenta"
                             readonly="true" style="text-align: right"/>
            </div>

        </div>

    </div>


    <div class="vertical-container" id="divIVA" style="height: 140px; margin-top: 20px">
        <p class="css-vertical-text">Retención IVA</p>

        <div class="linea"></div>


        <div class="fila" style="margin-bottom: 10px">
            <div class="col-xs-2 negrilla">
                Retención Bienes
            </div>

            <div class="col-xs-3">
                <g:select name="pcivBienes" from="${pcivBien}"
                          class="form-control pori"
                          optionValue="descripcion" optionKey="id" value="${retencion?.pcntIvaBienes?.id}"/>
            </div>

            <div class="col-xs-1 negrilla">
                Base Imponible
            </div>

            <div class="col-xs-2">
                <g:textField class=" form-control number"
                             title="La base imponible IVA bienes" name="baseIvaBienes"
                             id="baseIvaBienes" value="${retencion?.baseIvaBienes ?: 0}" style="text-align: right"/>
            </div>

            <div class="col-xs-1 negrilla">
                <span style="margin-left: -10px;">%</span>
                <g:textField class=" form-control number" readonly="true" title="Porcentaje" name="pcntIvaBienes"
                             style="text-align: right; width: 50px; display: inline; margin-left:0px"/>
            </div>

            <div class="col-xs-1 negrilla">
                Valor
            </div>
            <div class="col-xs-2">
                <g:textField class=" form-control number required"
                             title="Valor retenido IVA bienes" name="ivaBienes"
                             value="${retencion?.ivaBienes ?: 0}" style="text-align: right"/>
            </div>

        </div>

        <div class="fila" style="margin-bottom: 10px">
            <div class="col-xs-2 negrilla">
                Retención Servicios
            </div>

            <div class="col-xs-3">
                <g:select name="pcivServicios" id="pcivSrvc"
                          from="${cratos.sri.PorcentajeIva.list([sort: 'descripcion', order: 'desc'])}" class="form-control pori"
                          optionValue="descripcion" optionKey="id" value="${retencion?.pcntIvaServicios?.id}"/>
            </div>

            <div class="col-xs-1 negrilla">
                Base Imponible
            </div>

            <div class="col-xs-2">
                <g:textField class=" form-control number"
                             title="La base imponible IVA servicios" name="baseIvaServicios"
                             value="${retencion?.baseIvaServicios ?: 0}" style="text-align: right"/>
            </div>

            <div class="col-xs-1 negrilla">
                <span style="margin-left: -10px;">%</span>
                <g:textField class=" form-control number" readonly="true" title="Porcentaje" name="pcntIvaSrvc"
                             style="text-align: right; width: 50px; display: inline; margin-left:0px"/>
            </div>

            <div class="col-xs-1 negrilla">
                Valor
            </div>
            <div class="col-xs-2">
                <g:textField class=" form-control number required"
                             title="Valor IVA retenido servicios" name="ivaServicios"
                             value="${retencion?.ivaServicios ?: 0}" style="text-align: right"/>
            </div>

        </div>

        <div style="margin-top: 20px">
            <div class="col-xs-2">
            </div>
            <div class="col-xs-4" style="text-align: right">
                Total IVA
            </div>

            <div class="col-xs-2">
                <g:textField class=" form-control number"
                             title="Total base imponible IVA" name="sumaIva"
                             readonly="true" value="${sumaIva ?: 0}" style="text-align: right"/>
            </div>

            <div class="col-xs-2">
                Total Retenido IVA
            </div>
            <div class="col-xs-2">
                <g:textField class=" form-control number" title="Total retención IVA" name="sumaRtcnIva"
                             readonly="true" style="text-align: right"/>
            </div>
        </div>

    </div>
%{--</div>--}%
%{--</div>--}%
    <div style="margin-top: 20px">
        <div class="col-xs-8">
        </div>
        <div class="col-xs-2">
            Total Retenido
        </div>
        <div class="col-xs-2">
            <g:textField class=" form-control number" title="Total retención IVA" name="sumaRetenido"
                         readonly="true" style="text-align: right"/>
        </div>
    </div>

</g:form>
<script type="text/javascript">


    revisarComboServicios($("#conceptoRentaSrvc option:selected").val());

    function revisarComboServicios (valor) {
        if(valor == '-1'){
            $("#porcentajeSrvc").val(0);
        }
    }

    $("#conceptoRenta").change(function () {
        var concepto = $("#conceptoRenta option:selected").val();
        if (concepto == '23') {
            $("#conceptoRIRServicios").addClass('esconder');
            $("#divIVA").addClass('esconder');
            $("#serie").val(0);
            $("#serie").attr('readonly', true);
            $("#baseRenta").val(${proceso?.baseImponibleIva});
            $("#baseRentaSrvc").val(0).attr('readonly', false);
        } else {

            if(concepto == '-1'){
                $("#conceptoRIRServicios").removeClass('esconder');
                $("#divIVA").removeClass('esconder');
                $("#baseRenta").val(0).attr('readonly', true);
                $("#baseRentaSrvc").val(${retencion?.baseRentaServicios ?: 0});
            }else{
                $("#conceptoRIRServicios").removeClass('esconder');
                $("#divIVA").removeClass('esconder');
                $("#serie").attr('readonly', false);
                $("#baseRenta").val(${retencion?.baseRenta ?: 0}).attr('readonly', false);
                $("#baseRentaSrvc").val(${retencion?.baseRentaServicios ?: 0});
            }
        }

        cargarRetencionRIR(concepto, 'B');
    });

    $("#conceptoRentaSrvc").change(function () {
        var concepto = $("#conceptoRentaSrvc option:selected").val();
        revisarComboServicios(concepto);
        cargarRetencionRIR(concepto, 'S');
    });

    function cargarRetencionRIR(id, tipo) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'cargaCrir_ajax')}",
            data: {
                id: id
            },
            success: function (msg) {
                if(tipo == 'B') {
                    $("#porcentaje").val(msg)
                    actualizaRenta()
                    actualizarTotal(id)
                } else {
                    $("#porcentajeSrvc").val(msg)
                    actualizaRenta()
                    actualizarTotal(id)
                }
            }
        });
    }

    $("#baseRenta").change(function () {
        actualizaRenta()
        actualizarTotal()
    });

    $("#baseRentaSrvc").change(function () {
        actualizaRenta()
        actualizarTotal()
    });

    $("#valorRetenido").change(function () {
        totalesRenta()
        actualizarTotal()
    });

    $("#valorRetenidoSrvc").change(function () {
        totalesRenta()
        actualizarTotal()
    });

    $("#ivaBienes").change(function () {
        totalesIva()
        actualizarTotal()
    });

    $("#ivaServicios").change(function () {
        totalesIva()
        actualizarTotal()
    });


    $(".brs").keydown(function (ev) {

    }).keyup(function () {
        if( $("#baseRentaSrvc").val() == ''){
            $("#baseRentaSrvc").val(0)
        }
    });

    $("#baseRenta").keydown(function (ev) {

    }).keyup(function () {
        if( $("#baseRenta").val() == ''){
            $("#baseRenta").val(0)
        }
    });

    $("#baseIvaBienes").keydown(function (ev) {

    }).keyup(function () {
        if( $("#baseIvaBienes").val() == ''){
            $("#baseIvaBienes").val(0)
        }
    });

    $("#baseIvaServicios").keydown(function (ev) {

    }).keyup(function () {
        if( $("#baseIvaServicios").val() == ''){
            $("#baseIvaServicios").val(0)
        }
    });


    function actualizaRenta() {
        var pcnt = parseFloat($("#porcentaje").val())
        var pcntSrvc = parseFloat($("#porcentajeSrvc").val())
        var base = parseFloat($("#baseRenta").val())
        var baseSrvc = parseFloat($("#baseRentaSrvc").val())
        var rtcn     = Math.round(pcnt * base)/ 100;
        var rtcnSrvc = Math.round(pcntSrvc * baseSrvc)/ 100;

        $("#valorRetenido").val(parseFloat(rtcn).toFixed(2));
        $("#valorRetenidoSrvc").val(parseFloat(rtcnSrvc).toFixed(2));
        $("#sumaRenta").val(parseFloat(Math.round((base + baseSrvc)*100)/100).toFixed(2));
        $("#sumaRtcnRenta").val(parseFloat(Math.round((rtcn + rtcnSrvc)*100)/100).toFixed(2));
    }

    function actualizarTotal(concepto) {

        var pcnt = parseFloat($("#porcentaje").val())
        var pcntSrvc = parseFloat($("#porcentajeSrvc").val())
        var base = parseFloat($("#baseRenta").val())
        var baseSrvc = parseFloat($("#baseRentaSrvc").val())
        var rtcn     = Math.round(pcnt * base)/ 100;
        var rtcnSrvc = Math.round(pcntSrvc * baseSrvc)/ 100;

        $("#valorRetenido").val(parseFloat(rtcn).toFixed(2));
        $("#valorRetenidoSrvc").val(parseFloat(rtcnSrvc).toFixed(2));

        var baseI = parseFloat($("#baseIvaBienes").val());
        var baseSrvcI = parseFloat($("#baseIvaServicios").val());
        var pcntI = parseFloat($("#pcntIvaBienes").val());
        var pcntSrvcI =parseFloat($("#pcntIvaSrvc").val());

        var rtcnI = Math.round(pcntI * baseI)/ 100;
        var rtcnSrvcI = Math.round(pcntSrvcI * baseSrvcI)/ 100;

        var totalIva = parseFloat(((rtcnI + rtcnSrvcI)*100)/100).toFixed(2);
        var totalRenta = parseFloat(Math.round((rtcn + rtcnSrvc)*100)/100).toFixed(2);

        if(concepto == '23'){
            $("#sumaRetenido").val(parseFloat(Math.round((parseFloat(totalRenta))*100)/100).toFixed(2));
        }else{
            $("#sumaRetenido").val(parseFloat(Math.round((parseFloat(totalIva) + parseFloat(totalRenta))*100)/100).toFixed(2));
        }



    }

    function totalesRenta() {
        var vr = parseFloat($("#valorRetenido").val());
        var vrs = parseFloat($("#valorRetenidoSrvc").val());
        var br = parseFloat($("#baseRenta").val());
        var brs = parseFloat($("#baseRentaSrvc").val());
        var pcr = $("#porcentaje").val();
        var pcrs = $("#porcentajeSrvc").val();

        var rt = parseFloat(br) * parseFloat(pcr)/100;
        var rts = parseFloat(brs) * parseFloat(pcrs)/100;
        if(isNaN(rts)) {rts = 0}

        if(isNaN(vrs)) {
            vrs = 0;
            $("#valorRetenidoSrvc").val(0);
        }
        if(isNaN(vr)) {
            vr = 0;
            $("#valorRetenido").val(0);
        }

//        console.log('calculado:', rt, 'valor:', vrs, 'rt', rt, 'rts', rts, 'brs', brs, 'pcrs', pcrs)
        if(Math.abs(rt - vr) > 0.01) {
            $("#valorRetenido").val(rt)
            $("#valorRetenido").focus()
        } else if(Math.abs(rts - vrs) > 0.01) {
            $("#valorRetenidoSrvc").val(rts)
            $("#valorRetenidoSrvc").focus()
        } else {
            $("#sumaRtcnRenta").val(parseFloat((rt + rts).toFixed(2)));
        }
    }

    function totalesIva() {
        var iva = parseFloat($("#ivaBienes").val());
        var srvc = parseFloat($("#ivaServicios").val());
        var iva_b = parseFloat($("#baseIvaBienes").val()) * parseFloat($("#pcntIvaBienes").val())/100;
        var iva_s = parseFloat($("#baseIvaServicios").val()) * parseFloat($("#pcntIvaSrvc").val())/100;
//        console.log('calculado:', iva_b, 'valor:', iva)
        if(Math.abs(iva - iva_b) > 0.01) {
            $("#ivaBienes").val(iva_b)
            $("#ivaBienes").focus()
        } else if(Math.abs(iva_s - srvc) > 0.01) {
            $("#ivaServicios").val(iva_s)
            $("#ivaServicios").focus()
        } else {
            $("#sumaRtcnIva").val(parseFloat((iva_b + iva_s).toFixed(2)));
        }
    }

    $("#pcivBienes").change(function () {
        var id = $("#pcivBienes option:selected").val();
        if(id == '7'){
            $("#baseIvaBienes").val(0)
        }
        cargarPciv(id, 'B')
    });

    $("#pcivSrvc").change(function () {
        var id = $("#pcivSrvc option:selected").val();
        if(id=='7'){
            $("#baseIvaServicios").val(0)
        }
        cargarPciv(id, 'S')
    });

    $(".registrar").click(function() {
        bootbox.confirm("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'>" +
            "</i> Esta seguro de registrar esta retención?. Esta acción no se puede deshacer!", function (result) {
            if (result) {

                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller: 'retencion', action: 'registrar')}",
                    data: {
                        id: "${retencion?.id}"
                    },
                    success: function (msg) {
                        location.reload()
                    }
                });
            }
        });
    });

    function cargarPciv(id, tipo) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'carga_pciv')}",
            data: {
                id: id
            },
            success: function (msg) {
                if(tipo == 'B') {
                    $("#pcntIvaBienes").val(msg)
                    actualizaIva()
                    actualizarTotal()
                } else {
                    $("#pcntIvaSrvc").val(msg)
                    actualizaIva()
                    actualizarTotal()
                }
            }
        });
    }

    $("#baseIvaBienes").change(function () {
        actualizaIva()
        actualizarTotal()
    });

    $("#baseIvaServicios").change(function () {
        actualizaIva()
        actualizarTotal()
    });

    function actualizaIva() {
        var pcnt = parseFloat($("#pcntIvaBienes").val())
        var pcntSrvc = parseFloat($("#pcntIvaSrvc").val())
        var base = parseFloat($("#baseIvaBienes").val())
        var baseSrvc = parseFloat($("#baseIvaServicios").val())
//        var rtcn = Math.round(pcnt * base * 0.12)/ 100;
        var rtcn = Math.round(pcnt * base)/ 100;
//        var rtcnSrvc = Math.round(pcntSrvc * baseSrvc * 0.12)/ 100;
        var rtcnSrvc = Math.round(pcntSrvc * baseSrvc)/ 100;

        $("#ivaBienes").val(parseFloat(rtcn).toFixed(2));
        $("#ivaServicios").val(parseFloat(rtcnSrvc).toFixed(2));
        $("#sumaIva").val(parseFloat(Math.round((base + baseSrvc)*100)/100).toFixed(2));
        $("#sumaRtcnIva").val(parseFloat(Math.round((rtcn + rtcnSrvc)*100)/100).toFixed(2));
    }


    $("#btnGuardar").click(function () {
//        console.log('clic ..guardar...')
        var error = '';
        var concepto = $("#conceptoRenta option:selected").val();
        var pcivB = $("#pcivBienes option:selected").val()
        var pcivS = $("#pcivSrvc option:selected").val()

//        console.log('pciv:', pcivB, pcivS)

        $("#listaErrores").html('');

        if (!$(".fechaEmision").val()) {
            error += "<li>Seleccione la fecha de emisión de la retención</li>"
        }
        if (($("#serie").val() == '') || !($("#libretin option:selected").val())) {
            if (concepto != '23') {
                error += "<li>Ingrese el número de comprobante de la retención</li>"
            }
        } else {
            if (concepto != '23') {
                if( (parseFloat($("#baseImponible").val())) != parseFloat($("#sumaRenta").val()) ) {
//                    console.log(parseFloat($('#baseImponible').val()) + parseFloat($("#baseRentaSrvc").val()));
//                    console.log(parseFloat($('#sumaRenta').val()));
                    error += "<li>Revise los valores de base imponible Renta</li>"
                }
                if((pcivB != 7) || (pcivS != 7)) {
                    if( parseFloat($("#ivaGenerado").val()) != parseFloat($("#sumaIva").val()) ) {
                        error += "<li>Revise los valores de base imponible IVA</li>"
                    }
                }
            }
        }

        if (error == '') {
            $("#divErroresDetalle").hide();
            openLoader("Guardando..");

            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'proceso', action: 'saveRetencion_ajax')}',
                data: {
                    proceso: '${proceso?.id}',
                    conceptoRIRBienes: $("#conceptoRenta").val(),
                    conceptoRIRServicios: $("#conceptoRentaSrvc").val(),
                    documentoEmpresa: $("#libretin").val(),
                    pcntIvaBienes: $("#pcivBienes").val(),
                    pcntIvaServicios: $("#pcivSrvc").val(),

                    numero: $("#serie").val(),
                    fechaEmision: $(".fechaEmision").val(),

                    baseIvaBienes: $("#baseIvaBienes").val(),
                    ivaBienes: $("#ivaBienes").val(),
                    baseIvaServicios: $("#baseIvaServicios").val(),
                    ivaServicios: $("#ivaServicios").val(),
                    baseRenta: $("#baseRenta").val(),
                    renta: $("#valorRetenido").val(),
                    baseRentaServicios: $("#baseRentaSrvc").val(),
                    rentaServicios: $("#valorRetenidoSrvc").val(),

                    retencion: '${retencion?.id}'
                },
                success: function (msg) {
                    if (msg == 'ok') {
                        log("Retención guardada correctamente", "success")
                        setTimeout(function () {
                            location.href = '${createLink(controller: 'proceso', action: 'detalleSri')}/' +
                            ${proceso?.id}
                        }, 800);
                    } else {
                        log(msg, "error")
                    }
                    closeLoader()
                }
            });

        } else {
            $("#listaErrores").append(error);
            $("#listaErrores").show();
            $("#divErroresDetalle").show()
        }
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


    function validarNum(ev) {
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
        ev.keyCode == 37 || ev.keyCode == 39 ||
        ev.keyCode == 110 || ev.keyCode == 190);
    }

    $(".validacionNumero").keydown(function (ev) {
        return validarNumSinPuntos(ev);
    }).keyup(function () {

    });


    $("#libretin").change(function () {
        var idLibretin = $("#libretin option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'libretin_ajax')}',
            data: {
                libretin: idLibretin,
                proceso: "${proceso?.id}",
                fcha: $("#fechaEmision_name_input").val(),
                rtcn: "${retencion?.id}"
            },
            success: function (msg) {
                var partes = msg.split('_');
                $("#numEstablecimiento").val(partes[0])
                $("#numEmision").val(partes[1])
                if(partes[2]) {
                    $("#serie").val(partes[2])
                }
            }
        })
    });


    $("#sriForm").validate({
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


    function validarNumDec(ev) {
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
        ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 190 || ev.keyCode == 110);
    }


    $(function () {
        $(".regresar").button();
        $(".grabar").button();

        $("#sriForm").validate({
            errorLabelContainer: "#listaErrores",
            wrapper: "li",
            invalidHandler: function (form, validator) {
                var errors = validator.numberOfInvalids();
                console.log("**" + errors);
                if (errors) {
                    var message = errors == 1
                        ? 'Se encontró 1 error.'
                        : 'Se encontraron ' + errors + ' errores';
                    $("#divErrores").show();
                    $("#spanError").html(message);

                } else {
                    $("#divErrores").hide();
                }
            }
        });

        $(".grabar").click(function () {
//            console.log('clase grabar')
            if ($("#sriForm").valid()) {
                var id = ${proceso?.id};
//                        console.log("entro grabar");
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'proceso' ,action: 'guardarSri')}",
                    data: {
                        id: id,
                        credito: $("#credito").val(),
                        pago: $("#pago").val(),
                        fechaEmision: $("#fechaEmision_input").val(),
                        numeroEstablecimiento: $("#numeroEstablecimiento").val(),
                        numeroEmision: $("#numeroPuntoEmision").val(),
                        numeroSecuencial: $("#retSecu").val(),
                        numeroAutorizacion: $("#retAutorizacion").val(),
                        concepto: $("#conceptoRIRBienes").val(),
                        base: $("#baseImponible").val(),
                        porcentaje: $("#porcentajeIR").val(),
                        valorRetenido: $("#valorRetenido").val(),
                        iceBase: $("#iceBase").val(),
                        icePorcentaje: $("#icePorcentaje").val(),
                        valorRetenidoIce: $("#valorRetenidoIce").val(),
                        bienesBase: $("#bienesBase").val(),
                        bienesPorcentaje: $("#bienesPorcentaje").val(),
                        valorRetenidoBienes: $("#valorRetenidoBienes").val(),
                        serviciosBase: $("#serviciosBase").val(),
                        serviciosPorcentaje: $("#serviciosPorcentaje").val(),
                        valorRetenidoServicios: $("#valorRetenidoServicios").val(),
//                        convenio: getConvenio(),
//                        normaLegal: getNorma(),
//                        pais: $("#pais").val()
                    },
                    success: function (msg) {

//                        console.log("--->>>" + msg)
                        if (msg == "ok") {
//                                    $("#divErrores").hide();
//                                    $("#divSuccess").show();
                            $("#divErrores").addClass("hide");
                            $("#divSuccess").removeClass("hide");

//                    $("#spanSuc").html(msg)
                        } else {
//                                    $("#divSuccess").hide();
//                                    $("#divErrores").show();
                            $("#divSuccess").addClass("hide");
                            $("#divErrores").removeClass("hide");
                            $("#spanError").html(msg);
                        }
                    }
                });
            }
        });
    });

    $(document).ready(function () {
//        console.log('listo...');
        $("#conceptoRenta").change();
        var concepto = $("#conceptoRenta option:selected").val();
        cargarRetencionRIR(concepto, 'B');
        var conceptosr = $("#conceptoRentaSrvc option:selected").val();
        cargarRetencionRIR(conceptosr, 'S');
        $("#baseRenta").change();
        $("#libretin").change();
        $("#pcivBienes").change();
        $("#pcivSrvc").change();
    });

    $("#comprobanteN").click(function () {
        location.href="${createLink(controller: 'proceso', action: 'comprobante')}/?proceso=" + '${proceso?.id}'
    })


    $("#btnRetencion").click(function () {
//        var establecimiento = $("#numEstablecimiento").val();
//        var emision = $("#numEmision").val();
        %{--url = "${g.createLink(controller:'reportes3' , action: 'imprimirRetencion')}?id=" + '${proceso?.id}' + "Wempresa=${session.empresa.id}" + "Westablecimiento=" + establecimiento + "Wemision=" + emision;--}%
        url = "${g.createLink(controller:'reportes3' , action: 'imprimirRetencion')}?id=" + '${proceso?.id}' + "Wempresa=${session.empresa.id}";
        location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=resultadoIntegral.pdf"
    });


</script>

</body>
</html>