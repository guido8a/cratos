<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/19/13
  Time: 12:56 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Detalle SRI</title>

    <style type="text/css">
    .ui-state-success {
        background-color : #006600;
        color            : white;
        border           : solid 1px #00aa00;
    }

    .fila, .uno, .dos, .tres, .cuatro {
        height : 30px;
    }

    .uno, .dos, .tres, .cuatro, .fac1, .fac2 {
        float : left;
    }

    .fila {
        clear       : both;
        margin-left : 40px;
        /*background: pink;*/
    }

    .uno {
        width       : 220px;
        padding-top : 10px;
        height      : 20px;
        /*background: red;*/
    }

    .dos {
        width : 145px;
        /*background: blue;*/

    }

    .tres {
        width         : 165px;
        padding-top   : 10px;
        padding-right : 5px;
        height        : 20px;
        text-align    : right;
        /*background: green;*/
    }

    .cuatro {
        width      : 100px;
        text-align : center;
        /*background: orange;*/
    }

    .cuatro input {
        width : 85px;
    }

    .dos select {
        width : 250px;
    }

    .seis {
        width         : 55px;
        padding-top   : 10px;
        padding-right : 5px;
        height        : 20px;
        text-align    : right;
    }

    .fac1 {
        width : 125px;
    }

    .fac2 {
        width : 80px;
    }
    </style>
</head>

<body>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link class="btn regresar btn-primary btn-ajax" id="${proceso?.id}" action="show">
            <i class="fa fa-chevron-left"></i> Proceso</g:link>
        <g:link class="btn regresar btn-info btn-ajax" action="buscarPrcs">
            <i class="fa fa-chevron-left"></i> Lista de Procesos</g:link>
    </div>
    <div class="btn-group">
        <g:link class="btn grabar btn-success btn-ajax" id="grabar"><i class="fa fa-floppy-o"></i> Guardar</g:link>
    </div>
</div>


<g:form name="sriForm">

    <div class="vertical-container vertical-container-list">
        <p class="css-vertical-text">Retención</p>
        <div class="linea"></div>

        <div class="col-md-12" style="margin-bottom: 10px">
            <div class="col-md-2 negrilla">
                Comprobante N°:
            </div>
            <div class="col-md-3">
                <g:select name="compro" from="${libreta}" value="" class="form-control libretin" optionKey="id" optionValue="${{"Desde: " + it?.numeroDesde + ' - Hasta: ' + it?.numeroHasta + " - Autorización: " + it?.fechaAutorizacion?.format("dd-MM-yyyy")}}"/>
            </div>

            <div class="col-md-7">
                <div class="col-md-5" id="divNumeracion">
                </div>

                %{--<g:form class="retencion" name="frm-retencion" action="#">--}%
                    <div class="col-md-3 grupo">
                        <g:textField name="serie" value="${retencion?.numero}" class="serie form-control required validacionNumero numSerie" style="width: 170px" maxlength="15"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                %{--</g:form>--}%
            </div>

        </div>


        <div class="col-md-12" style="margin-bottom: 10px">
            <div class="col-md-2 negrilla">
                Fecha Emisión:
            </div>
            <div class="col-md-9 negrilla">
                <div class="col-md-3">
                    <elm:datepicker name="fechaEmision" class="datepicker required form-control" value="${retencion?.fechaEmision}" />
                </div>
            </div>
        </div>

        %{--<div class="fila " style="min-height: 15px;height: 15px;">--}%
        %{--<div class="fac1">--}%
        %{--<label style="">Fecha Emisión</label>--}%
        %{--</div>--}%

        %{--<div class="fac2" style="margin-left: 20px">--}%
        %{--<label>N° Esta.</label>--}%
        %{--</div>--}%

        %{--<div class="fac2">--}%
        %{--<label>N° Emisión</label>--}%
        %{--</div>--}%

        %{--<div class="fac1" style="margin-left: 40px">--}%
        %{--<label>N° Secuencial</label>--}%
        %{--</div>--}%

        %{--<div class="fac1" style="width: 300px;">--}%
        %{--<label>N° Autorización del Comprobante</label>--}%
        %{--</div>--}%
        %{--</div>--}%

        %{--<div class="fila" style="margin-bottom: 20px">--}%
        %{--<div class="fac1">--}%
        %{--<elm:datepicker name="fechaEmision" class="datepicker required form-control" value="${retencion?.fechaEmision}" />--}%
        %{--</div>--}%

        %{--<div class="fac2" style="margin-left: 20px">--}%
        %{--<g:textField class=" form-control required digits" title="El número de establecimiento del comprobante de retención es obligatorio." maxlength="3" name="numeroEstablecimiento" style="width: 60px" value="${retencion?.numeroEstablecimiento}"/>--}%
        %{--</div>--}%

        %{--<div class="fac2" style="margin-left: 20px">--}%
        %{--<g:textField class=" form-control required digits" title="El número de punto de emisión del comprobante de retención es obligatorio." maxlength="3" name="numeroPuntoEmision" style="width: 60px" value="${retencion?.numeroPuntoEmision}"/>--}%
        %{--</div>--}%

        %{--<div class="fac1" style="margin-left: 20px">--}%
        %{--<g:textField class=" form-control required digits" title="El número de secuencial del comprobante de retención es obligatorio." maxlength="9" name="retSecu" style="width: 100px" value="${retencion?.numeroSecuencial}"/>--}%
        %{--</div>--}%

        %{--<div class="fac1">--}%
        %{--<g:textField class=" form-control required digits" title="El número de autorización del comprobante de retención es obligatorio." maxlength="10" name="retAutorizacion" value="${retencion?.numeroAutorizacionComprobante}"/>--}%
        %{--</div>--}%
        %{--</div>--}%

        <div class="col-md-12">
            <div class="col-md-2 negrilla">
                Proveedor:
            </div>
            <div class="col-md-9 negrilla">
                <div class="col-md-3">
                    <input type="text" name="proveedor.ruc" class="form-control " id="prov" disabled="true" value="${proceso?.proveedor?.ruc ?: ''}" title="RUC del proveedor o cliente" style="width: 140px" placeholder="RUC"/>
                </div>
                <div class="col-md-5">
                    <input type="text" name="proveedor.nombre" class="form-control  label-shared" id="prov_nombre" disabled="true" value="${proceso?.proveedor?.nombre ?: ''}" title="Nombre del proveedor o cliente" style="width: 300px" placeholder="Nombre"/>
                </div>
            </div>
        </div>

        <div class="col-md-12" style="margin-top: 20px">
            <div class="col-md-2 negrilla">
                Dirección:
            </div>
            <div class="col-md-9 negrilla">
                <div class="col-md-8">
                    <input type="text" name="proveedorDir" class="form-control " id="dir" disabled="true" value="${proceso?.proveedor?.direccion ?: ''}" title="Dirección del proveedor o cliente"/>
                </div>
            </div>
        </div>

        <div class="col-md-12" style="margin-top: 20px">
            <div class="col-md-2 negrilla">
                Teléfono:
            </div>
            <div class="col-md-9 negrilla">
                <div class="col-md-3">
                    <input type="text" name="proveedorTel" class="form-control " id="tel" disabled="true" value="${proceso?.proveedor?.telefono ?: ''}" title="Teléfono del proveedor o cliente"/>
                </div>
            </div>
        </div>


    </div>

    <h3>Datos para informar al SRI (Anexo Transaccional Simplificado)</h3>


    <div class="vertical-container vertical-container-list">
        <p class="css-vertical-text">Retención Imp. Renta</p>
        <div class="linea"></div>

        <div class="" style="margin-left: 40px; margin-top: 20px; margin-bottom: 25px">
            <label style="margin-left: 320px">Impuesto a la Renta</label>
        </div>

        <div class="fila" style="margin-bottom: 10px">


            <div class="col-md-4" style="margin-left: 40px">
                <label>Concepto de la Retención del IR</label>
            </div>

            <div class="col-md-2" style="margin-left: 10px">
                <label>Base Imponible</label>
            </div>

            <div class="col-md-2" style="margin-left: 40px">
                <label>%RBI</label>
            </div>

            <div class="col-md-2">
                <label>Valor Retenido IR</label>
            </div>

        </div>

        <div class="col-md-12">

            <div class=" col-md-4" style="margin-left: 15px">
                %{--<g:select class="form-control" style="width: 330px" name="conceptoRetencionImpuestoRenta"--}%
                %{--from="${cratos.ConceptoRetencionImpuestoRenta?.list()}" optionKey="id" optionValue="${{it.codigo + ' - ' + it.descripcion}}"/>--}%
            </div>

            <div class="col-md-2" style="margin-left: 35px">
                <g:textField class="form-control required number" title="La base imponible del IR es obligatoria. Puede ingresar 0." name="baseImponible" value="${detalleRetencion?.base}"/>
            </div>

            <div class="col-md-2" style="margin-left: 35px">
                <g:textField class="form-control required number" title="El porcentaje de rentención del IR es obligatorio. Puede ingresar 0." name="porcentajeIR" value="${detalleRetencion?.porcentaje}"/>
            </div>

            <div class="col-md-2" style="margin-left: 35px">
                <g:textField class="form-control required number" title="el valor retenido del IR es obligatorio. Puede ingresar 0." name="valorRetenido"/>
            </div>

        </div>

        %{--<div class="" style="margin-left: 40px;margin-bottom: 35px">--}%

        %{--<div class="uno" style="width: 230px">--}%
        %{--<label>Concepto de la Retención del IR</label>--}%
        %{--</div>--}%

        %{--<div class="dos" style="margin-left: 15px">--}%

        %{--<g:select class="form-control  " style="width: 330px" name="conceptoRetencionImpuestoRenta"--}%
        %{--from="${cratos.ConceptoRetencionImpuestoRenta?.list()}" optionKey="id" optionValue="${{--}%
        %{--it.codigo + ' - ' + it.descripcion--}%
        %{--}}"/>--}%
        %{--</div>--}%

        %{--<div class="tres" style="width: 55px !important; margin-left: 110px"></div>--}%
        %{--<g:each in="${detalleRetencion}" var="detalle">--}%
        %{--<g:if test="${detalle?.impuesto?.sri == 'RNT'}">--}%
        %{--<div class="cuatro" style="margin-left: 35px">--}%
        %{--<g:textField class="form-control required number" title="La base imponible del IR es obligatoria. Puede ingresar 0." name="baseImponible" value="${detalleRetencion?.base}"/>--}%
        %{--</div>--}%

        %{--<div class="cuatro">--}%
        %{--<g:textField class="form-control required number" title="El porcentaje de rentención del IR es obligatorio. Puede ingresar 0." name="porcentajeIR" value="${detalleRetencion?.porcentaje}"/>--}%
        %{--</div>--}%

        %{--<div class="cuatro">--}%
        %{--<g:textField class="form-control required number" title="el valor retenido del IR es obligatorio. Puede ingresar 0." name="valorRetenido"/>--}%
        %{--</div>--}%
        %{--</g:if>--}%
        %{--<g:else>--}%
        %{--<div class="cuatro" style="margin-left: 35px">--}%
        %{--<g:textField class="form-control required number" title="La base imponible del IR es obligatoria. Puede ingresar 0." name="baseImponible" value="${0}"/>--}%
        %{--</div>--}%

        %{--<div class="cuatro">--}%
        %{--<g:textField class="form-control required number" title="El porcentaje de rentención del IR es obligatorio. Puede ingresar 0." name="porcentajeIR" value="${0}"/>--}%
        %{--</div>--}%

        %{--<div class="cuatro">--}%
        %{--<g:textField class="form-control required number" title="el valor retenido del IR es obligatorio. Puede ingresar 0." name="valorRetenido"/>--}%
        %{--</div>--}%
        %{--</g:else>--}%
        %{--</g:each>--}%

        %{--</div>--}%

        %{--<div class="" style="margin-left: 40px; margin-top: 80px !important; margin-bottom: 25px; margin-right: 25px;">--}%

        %{--<label style="margin-left: 320px">Datos del Comprobante de Retención</label>--}%

        %{--</div>--}%







    </div> %{--//texto vertical fin--}%




    <div class="vertical-container vertical-container-list">
        <p class="css-vertical-text">Retención IVA</p>
        <div class="linea"></div>


        <div style="padding: 0.7em; margin-top:5px;"  class="alert alert-success hide" id="divSuccess">
            <i class="fa fa-check pull-left"></i>

            <span id="spanSuc">Grabado Correctamente</span>

            <ul id="listaSuc"></ul>
        </div>

        <div style="padding: 0.7em; margin-top:5px; " class="alert alert-danger hide" id="divErrores">
            <i class="fa fa-warning pull-left"></i>
            <span id="spanError">Ha ocurrido un error</span>

            <ul id="listaErrores"></ul>
        </div>

        <div class="" style="margin-left: 40px; margin-top: 10px; margin-bottom: -5px">
            <label>N° Establecimiento</label>
            <label style="margin-left: 25px">N° Emisión</label>
            <label style="margin-left: 65px">N° Autorización del Comprobante</label>
        </div>

        <div class="" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
            <g:textField name="facturaEstablecimiento" style="width: 100px;" disabled="disabled" >${proceso?.facturaEstablecimiento}</g:textField>
            <g:textField name="facturaPuntoEmision" style="width: 100px; margin-left: 50px" disabled="disabled" >${proceso?.facturaPuntoEmision}</g:textField>
            <g:textField name="autorizacionSri" style="width: 250px; margin-left: 50px" disabled="disabled" >${proceso?.proveedor?.autorizacionSri}</g:textField>
        </div>

        <div class="" style="margin-left: 40px; margin-top: 20px; margin-bottom: 15px">
            <label>Aplica Crédito Tributario</label>
            <g:select class="ui-corner-all" name="credito" from="${['SI', 'NO']}" style="margin-left: 10px;"/>

        </div>

        <div class="" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
            <label>Pago Local o Exterior</label>
            <g:select class="ui-corner-all" name="pago"
                      from="${['01': 'LOCAL', '02': 'EXTERIOR']}" optionKey="key" optionValue="value" style="margin-left: 30px"/>
        </div>


        <div class="exterior" style="margin-left: 40px; margin-right: 30px; margin-top: 10px; margin-bottom: 15px" hidden="hidden">
            <fieldset>
                <legend>Pago al Exterior</legend>

                <div class="fila">
                    <div class="uno">
                        <label style="margin-left: -40px">País</label>
                    </div>
                    <div class="dos">
                        <g:select class="form-control " name="pais" from="${cratos.sri.Pais.list([sort: 'nombre'])}" optionKey="id" optionValue="nombre" style="width: 250px; margin-left: -100px"/>

                    </div>
                </div>

                <div style="margin-top: 20px">
                    <label style="margin-right: 30px">Aplica convenio de doble tributación?</label>
                    <g:radioGroup class="convenio" labels="['SI', 'NO']" values="['SI', 'NO']" name="convenio" value="">${it?.label} ${it?.radio}</g:radioGroup>
                </div>

                <div style="margin-top: 20px">
                    <label style="margin-right: 30px">Pago sujeto a retención en aplicación de la norma legal</label>
                    <g:radioGroup class="norma" labels="['SI', 'NO']" values="['SI', 'NO']" name="norma" value="">${it?.label} ${it?.radio}</g:radioGroup>
                </div>
                <legend></legend>
            </fieldset>
        </div>  %{--//exterior--}%

        <div class="fila" style="margin-bottom: 20px">
            <div class="uno"></div>

            <div class="dos"></div>

            <div class="tres"></div>

            <div class="cuatro" style="margin-left: 45px">
                <label>Base Retención</label>
            </div>

            <div class="cuatro">
                <label>% Ret</label>
            </div>

            <div class="cuatro">
                <label>Valor Retenido</label>
            </div>
        </div>


    %{--//old--}%

        <g:each in="${detalleRetencion}" var="detalle">
            <div class="fila" >



                <div class="uno">
                    <label style="width: 230px">Base Imponible no Objeto de IVA</label>
                </div>

                <div class="dos" style="margin-left: 15px">
                    <g:textField class="form-control" name="noObjetoIva" value="${proceso?.baseImponibleNoIva}" disabled="disabled"/>
                </div>

                <div class="tres" style="margin-left: 35px">
                    <label>ICE</label>
                </div>


                <g:if test="${detalle?.impuesto?.sri == 'ICE'}">
                    <div class="cuatro">
                        <g:textField class=" form-control required number" title="La base imponible del ICE es obligatoria. Puede ingresar 0." name="iceBase" value="${detalle?.base}"/>
                    </div>

                    <div class="cuatro">
                        <g:textField class=" form-control required number" title="El porcentaje del ICE es obligatorio. Puede ingresar 0." name="icePorcentaje" value="${detalle?.porcentaje}"/>
                    </div>

                    <div class="cuatro">
                        <g:textField class=" form-control required number" title="El valor retenido del ICE es obligatorio. Puede ingresar 0." name="valorRetenidoIce" value="${detalle?.total}"/>
                    </div>
                </g:if>
                <g:else>
                    <div class="cuatro">
                        <g:textField class=" form-control required number" title="La base imponible del ICE es obligatoria. Puede ingresar 0." name="iceBase" value="${0}"/>
                    </div>

                    <div class="cuatro">
                        <g:textField class=" form-control required number" title="El porcentaje del ICE es obligatorio. Puede ingresar 0." name="icePorcentaje" value="${0}"/>
                    </div>

                    <div class="cuatro">
                        <g:textField class=" form-control required number" title="El valor retenido del ICE es obligatorio. Puede ingresar 0." name="valorRetenidoIce" value="${0}"/>
                    </div>
                </g:else>

            </div>


            <div class="fila">
                <div class="uno">
                    <label>Base Imponible IVA 0%</label>
                </div>

                <div class="dos" style="margin-left: 15px">
                    <g:textField class="form-control" name="biIva0" value="${proceso?.baseImponibleIva0}" disabled="disabled"/>
                </div>

                <div class="tres" style="margin-left: 35px">
                    <label>IVA(1) Bienes</label>
                </div>

                <g:if test="${detalle?.impuesto?.sri == 'BNS'}">
                    <div class="cuatro">
                        <g:textField class="form-control required number" title="La base imponible del IVA es obligatoria. Puede ingresar 0." name="bienesBase" value="${detalle?.base}"/>
                    </div>

                    <div class="cuatro">
                        <g:textField class="form-control required number" title="El porcentaje del IVA es obligatorio. Puede ingresar 0." name="bienesPorcentaje" value="${detalle?.porcentaje}"/>
                    </div>

                    <div class="cuatro">
                        <g:textField class="form-control required number" title="El valor retenido del IVA es obligatorio. Puede ingresar 0." name="valorRetenidoBienes" value="${detalle?.total}"/>
                    </div>
                </g:if>
                <g:else>
                    <div class="cuatro">
                        <g:textField class="form-control required number" title="La base imponible del IVA es obligatoria. Puede ingresar 0." name="bienesBase" value="${0}"/>
                    </div>

                    <div class="cuatro">
                        <g:textField class="form-control required number" title="El porcentaje del IVA es obligatorio. Puede ingresar 0." name="bienesPorcentaje" value="${0}"/>
                    </div>

                    <div class="cuatro">
                        <g:textField class="form-control required number" title="El valor retenido del IVA es obligatorio. Puede ingresar 0." name="valorRetenidoBienes" value="${0}"/>
                    </div>

                </g:else>
            </div>

            <div class="fila">
                <div class="uno">
                    <label>Base Imponible IVA 12%</label>
                </div>

                <div class="dos" style="margin-left: 15px">
                    <g:textField class="form-control" name="biIva12" value="${proceso?.baseImponibleIva}" disabled="disabled"/>

                </div>

                <div class="tres" style="margin-left: 35px">
                    <label>IVA(2) Servicios y 100%</label>
                </div>
                <g:if test="${detalle?.impuesto?.sri == 'SRV'}">
                    <div class="cuatro">
                        <g:textField class="form-control required number" title="La base imponible del IVA es obligatoria. Puede ingresar 0." name="serviciosBase" value="${detalle?.base}"/>
                    </div>

                    <div class="cuatro">
                        <g:textField class="form-control required number" title="El porcentaje del IVA es obligatorio. Puede ingresar 0." name="serviciosPorcentaje" value="${detalle?.porcentaje}"/>
                    </div>

                    <div class="cuatro">
                        <g:textField class="form-control required number" title="El valor retenido del IVA es obligatorio. Puede ingresar 0." name="valorRetenidoServicios" value="${detalle?.total}"/>
                    </div>
                </g:if>
                <g:else>
                    <div class="cuatro">
                        <g:textField class="form-control required number" title="La base imponible del IVA es obligatoria. Puede ingresar 0." name="serviciosBase" value="${0}"/>
                    </div>

                    <div class="cuatro">
                        <g:textField class="form-control required number" title="El porcentaje del IVA es obligatorio. Puede ingresar 0." name="serviciosPorcentaje" value="${0}"/>
                    </div>

                    <div class="cuatro">
                        <g:textField class="form-control required number" title="El valor retenido del IVA es obligatorio. Puede ingresar 0." name="valorRetenidoServicios" value="${0}"/>
                    </div>
                </g:else>

            </div>
        </g:each>


    %{--<div class="" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">--}%
        <div class="fila" style="margin-bottom: 30px">
            <div class="uno">
                <label>IVA</label>
            </div>

            <div class="dos" style="margin-left: 15px">
                <g:textField class="form-control  " name="iva12" value="${proceso?.ivaGenerado}" disabled="disabled"/>
            </div>

            <div class="tres"></div>

            <div class="cuatro"></div>

            <div class="cuatro"></div>

            <div class="cuatro"></div>

        </div>

    </div>











%{--</div>--}%
</g:form>
<script type="text/javascript">



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
        return validarNum(ev);
    }).keyup(function () {

    });


    cargarNumeracion($(".libretin option:selected").val());

    function cargarNumeracion (id) {
        $.ajax({
            type:'POST',
            url: '${createLink(controller: 'proceso', action: 'numeracion_ajax')}',
            data:{
                libretin: id
            },
            success: function (msg) {
                $("#divNumeracion").html(msg)
            }
        });
    }

    $(".libretin").change(function () {
        var idLibretin = $(".libretin option:selected").val();
        cargarNumeracion(idLibretin);
//        $("#numSerie").val('')

    });



//    foo(function(result) {
//        // Code that depends on 'result'
//    });
//
//
//
//    function foo(callback) {
//        console.log("callback " + callback)
//        if(callback){
//            log("Número de serie válido","success")
//        }else{
//            log("El número de serie ingresado no es válido!", "error")
//        }
//    }



    $("#sriForm").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        },
        rules  : {
            serie : {
                remote : {
                    type: 'POST',
                    url:"${createLink(controller: 'proceso', action: 'validarSerie_ajax')}",
                    data:{
                        numero: $(".numSerie").val(),
                        libretin: $(".libretin option:selected").val()
                    }
                }
            }
        },
        messages       : {
            serie : {
                remote : "Número de serie incorrecto"
            }
        }
    });



    %{--function validarSerie (num) {--}%
        %{--$.ajax({--}%
            %{--type: 'POST',--}%
            %{--url:"${createLink(controller: 'proceso', action: 'validarSerie_ajax')}",--}%
            %{--data:{--}%
                %{--numero: num,--}%
                %{--libretin: $(".libretin option:selected").val()--}%
            %{--},--}%
            %{--success: function (msg) {--}%
                %{--console.log("---> " + msg)--}%
                %{--if(msg == 'true'){--}%
                    %{--log("Número de serie válido","success")--}%
                %{--}else{--}%
                    %{--log("El número de serie ingresado no es válido!", "error")--}%
                %{--}--}%
            %{--}--}%
        %{--});--}%
    %{--}--}%



    %{--$(".numSerie").keydown(function (ev) {--}%

    %{--}).keydown(function () {--}%
        %{--var numeracion = $(".numSerie").val();--}%
        %{--validarSerie(numeracion)--}%
    %{--});--}%


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

    function calculoRetencion() {
        var total = 0
        total = (parseFloat($("#baseImponible").val()) * parseFloat($("#porcentajeIR").val())) / 100
        $("#valorRetenido").val(number_format(total, 2, ".", ""))
    }

    $(function () {
        $(".regresar").button();
        $(".grabar").button();

        $("#sriForm").validate({
            errorLabelContainer : "#listaErrores",
            wrapper             : "li",
            invalidHandler      : function (form, validator) {
                var errors = validator.numberOfInvalids();
//                        console.log("**" + errors);
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

        $("#anioSri").val("${new Date().format('yyyy')}").change(function () {
            var anio = $(this).val();
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'getPeriodos')}",
                data    : {
                    anio : anio
                },
                success : function (msg) {
                    $("#mesSri").html(msg);
                }
            });
        });

        calculoRetencion();

        $("#baseImponible").keydown(function (ev) {
            var val = $(this).val();
            var dec = 2;
            if (ev.keyCode == 110 || ev.keyCode == 190) {
                if (!dec) {
                    return false;
                } else {
                    if (val.length == 0) {
                        $(this).val("0");
                    }
                    if (val.indexOf(".") > -1) {
                        return false;
                    }
                }
            } else {
                if (val.indexOf(".") > -1) {
                    if (dec) {
                        var parts = val.split(".");
                        var l = parts[1].length;
                        if (l >= dec) {
//                                return false;
                        }
                    }
                } else {
                    return validarNumDec(ev);
                }
            }
            return validarNumDec(ev);
        }).keyup(function () {
            calculoRetencion();
        });

        $("#porcentajeIR").keydown(function (ev) {
            var val = $(this).val();
            var dec = 2;
            if (ev.keyCode == 110 || ev.keyCode == 190) {
                if (!dec) {
                    return false;
                } else {
                    if (val.length == 0) {
                        $(this).val("0");
                    }
                    if (val.indexOf(".") > -1) {
                        return false;
                    }
                }
            } else {
                if (val.indexOf(".") > -1) {
                    if (dec) {
                        var parts = val.split(".");
                        var l = parts[1].length;
                        if (l >= dec) {
//                                return false;
                        }
                    }
                } else {
                    return validarNumDec(ev);
                }
            }
            return validarNumDec(ev);
        }).keyup(function () {
            calculoRetencion()
        });

        $(".grabar").click(function () {
            if ($("#sriForm").valid()) {
                var id = ${proceso?.id};
//                        console.log("entro grabar");
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'proceso' ,action: 'guardarSri')}",
                    data    : {
                        id                     : id,
                        credito                : $("#credito").val(),
                        pago                   : $("#pago").val(),
                        fechaEmision           : $("#fechaEmision_input").val(),
                        numeroEstablecimiento  : $("#numeroEstablecimiento").val(),
                        numeroEmision          : $("#numeroPuntoEmision").val(),
                        numeroSecuencial       : $("#retSecu").val(),
                        numeroAutorizacion     : $("#retAutorizacion").val(),
                        concepto               : $("#conceptoRetencionImpuestoRenta").val(),
                        base                   : $("#baseImponible").val(),
                        porcentaje             : $("#porcentajeIR").val(),
                        valorRetenido          : $("#valorRetenido").val(),
                        iceBase                : $("#iceBase").val(),
                        icePorcentaje          : $("#icePorcentaje").val(),
                        valorRetenidoIce       : $("#valorRetenidoIce").val(),
                        bienesBase             : $("#bienesBase").val(),
                        bienesPorcentaje       : $("#bienesPorcentaje").val(),
                        valorRetenidoBienes    : $("#valorRetenidoBienes").val(),
                        serviciosBase          : $("#serviciosBase").val(),
                        serviciosPorcentaje    : $("#serviciosPorcentaje").val(),
                        valorRetenidoServicios : $("#valorRetenidoServicios").val(),
                        convenio               : getConvenio(),
                        normaLegal             : getNorma(),
                        pais                   : $("#pais").val()
                    },
                    success : function (msg) {

                        console.log("--->>>" + msg)
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
            else {


            }
        });

        $("#pago").change(function () {
            if ($(this).val() == '02') {
                $(".exterior").show();
//                        $(".exterior").attr("hidden", false);
            } else {
                $(".exterior").hide();
//                        $(".exterior").attr("hidden", true);
                $(".norma").attr("checked", false);
                $(".convenio").attr("checked", false);
            }
        });

        function getNorma() {
            var result;
            var radioButtons = $(".norma");
            for (var i = 0; i < radioButtons.length; i++) {
                if (radioButtons[i].checked) {
                    result = radioButtons[i].value;
                }
            }

            return result
        }

        function getConvenio() {
            var result;
            var radioButtons = $(".convenio");
            for (var i = 0; i < radioButtons.length; i++) {
                if (radioButtons[i].checked) {
                    result = radioButtons[i].value;
                }
            }

            return result
        }

    });
</script>

</body>
</html>