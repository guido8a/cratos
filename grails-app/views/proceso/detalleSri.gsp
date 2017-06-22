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

    .colorT{
        color: #0088cc;
    }

    .colorS{
        border-color: #ff0f24;
    }

    .soloLectura {
        /*display: none;*/
        pointer-events: none;
    }

    .esconder{
        display: none;
    }
    </style>
</head>

<body>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link class="btn regresar btn-primary btn-ajax" id="${proceso?.id}" action="nuevoProceso">
            <i class="fa fa-chevron-left"></i> Proceso</g:link>
        <g:link class="btn regresar btn-info btn-ajax" action="buscarPrcs">
            <i class="fa fa-chevron-left"></i> Lista de Procesos</g:link>
    </div>
    <div class="btn-group">
        <a href="#" class="btn btn-success" id="btnGuardarRetencion"><i class="fa fa-floppy-o"></i> Guardar</a>
    </div>
</div>


<div style="padding: 0.7em; margin-top:5px; display: none;" class="alert alert-danger ui-corner-all" id="divErroresDetalle">
    <i class="fa fa-exclamation-triangle"> </i>
    <span style="" id="spanError">Se encontraron los siguientes errores:</span>
    <ul id="listaErrores"></ul>
</div>



<g:form name="sriForm">
    <div class="vertical-container vertical-container-list ancho">
        <p class="css-vertical-text">Retención</p>
        <div class="linea"></div>
        <div class="col-md-12" style="margin-bottom: 10px" id="divComprobanteR">
            <div class="col-md-2 negrilla">
                Comprobante N°:
            </div>
            <div class="col-md-3">
                <g:select name="comprobanteSel"
                          from="${libreta}"  value="${retencion?.documentoEmpresa}"
                          class="form-control libretin" optionKey="id" libre="1"
                          optionValue="${{"Desde: " + it?.numeroDesde + ' - Hasta: ' + it?.numeroHasta + " - Autorización: " + it?.fechaAutorizacion?.format("dd-MM-yyyy")}}"/>
                <g:hiddenField name="libretinName" id="idLibre" value=""/>
            </div>

            <div class="col-md-7">
                <div class="col-md-5" id="divNumeracion">
                </div>
                <div class="col-md-3 grupo">
                    <g:textField name="serie" value="${retencion?.numero}" class="serie form-control required validacionNumero numSerie" style="width: 170px" maxlength="15"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </div>
        </div>

        <div class="col-md-12">
            <div class="col-md-2 negrilla">
                Proveedor:
            </div>
            <div class="col-md-3">
                <input type="text" name="proveedor.ruc" class="form-control " id="prov" readonly="true" value="${proceso?.proveedor?.ruc ?: ''}" title="RUC del proveedor o cliente" style="width: 150px" placeholder="RUC"/>
            </div>
            <div class="col-md-5">
                <input type="text" name="proveedor.nombre" class="form-control  label-shared" id="prov_nombre" readonly="true" value="${proceso?.proveedor?.nombre ?: ''}" title="Nombre del proveedor o cliente" style="width: 300px; margin-left: -100px" placeholder="Nombre"/>
            </div>
        </div>

        <div class="col-md-12" style="margin-top: 20px">
            <div class="col-md-2 negrilla">
                Dirección:
            </div>
            <div class="col-md-8">
                <input type="text" name="proveedorDir" class="form-control " id="dir" value="${retencion?.direccion ?: proceso?.proveedor?.direccion}" title="Dirección del proveedor o cliente"/>
            </div>
        </div>

        <div class="col-md-12" style="margin-top: 20px">
            <div class="col-md-2 negrilla">
                Teléfono:
            </div>
            <div class="col-md-2">
                <input type="text" name="proveedorTel" class="form-control " id="tel"  value="${retencion?.telefono ?: proceso?.proveedor?.telefono}" title="Teléfono del proveedor o cliente"/>
            </div>

            <div class="col-md-2 negrilla">
                Fecha Registro:
            </div>
            <div class="col-md-2">
                <elm:datepicker name="fechaRegistro_name" class="datepicker required form-control fechaRegistro" value="${retencion?.fecha}" />
            </div>

            <div class="col-md-2 negrilla">
                Fecha Emisión:
            </div>
            <div class="col-md-2">
                <elm:datepicker name="fechaEmision_name" class="datepicker required form-control fechaEmision" value="${retencion?.fechaEmision}" />
            </div>

        </div>

    </div>

    <div class="vertical-container vertical-container-list">
        <p class="css-vertical-text">Retención Imp. Renta</p>
        <div class="linea"></div>

        <div class="panel panel-success">
            <div class="panel-heading">Bienes</div>
            <div class="panel-body">

                <div class="fila" style="margin-bottom: 10px">
                    <div class="col-md-4" style="margin-left: 40px">
                        <label>Concepto de la Retención del IR</label>
                    </div>

                    <div class="col-md-2" style="margin-left: 10px">
                        <label>Base Imponible</label>
                    </div>

                    <div class="col-md-1" style="margin-left: 40px">
                        <label>%</label>
                    </div>

                    <div class="col-md-3">
                        <label>Valor Retenido Bienes</label>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class=" col-md-4" style="margin-left: 15px">
                        <g:select class="form-control" name="conceptoRetencionImpuestoRenta"
                                  from="${cratos.ConceptoRetencionImpuestoRenta.list().sort{it.codigo}}" optionKey="id" optionValue="${{it.codigo + ' - ' + it.descripcion}}" value="${retencion?.conceptoRIRBienes?.id}"/>
                    </div>

                    <div class="col-md-2" style="margin-left: 35px">
                        <g:textField class="form-control number baseB" title="La base imponible del IR." style="text-align: right" name="baseImponible" value="${retencion?.baseRenta ?: base}"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>

                    <div class="col-md-5" style="margin-left: 35px" id="divRBI">

                    </div>
                </div>
            </div>
        </div>

        <div class="panel panel-info" id="divRetencionServicios">
            <div class="panel-heading">Servicios</div>
            <div class="panel-body">

                <div class="fila" style="margin-bottom: 10px">

                    <div class="col-md-4" style="margin-left: 40px">
                        <label>Concepto de la Retención del IR</label>
                    </div>

                    <div class="col-md-2" style="margin-left: 10px">
                        <label>Base Imponible</label>
                    </div>

                    <div class="col-md-1" style="margin-left: 40px">
                        <label>%</label>
                    </div>

                    <div class="col-md-3">
                        <label>Valor Retenido Servicios</label>
                    </div>

                </div>

                <div class="col-md-12">
                    <div class=" col-md-4" style="margin-left: 15px">
                        <g:select class="form-control" name="conceptoServicios"
                                  from="${cratos.ConceptoRetencionImpuestoRenta.list().sort{it.codigo}}" optionKey="id" optionValue="${{it.codigo + ' - ' + it.descripcion}}" value="${retencion?.conceptoRIRServicios?.id}"/>
                    </div>

                    <div class="col-md-2" style="margin-left: 35px">
                        <g:textField class="form-control number baseS"
                                     title="La base imponible del IR."  style="text-align: right" name="baseImponibleSV" value="${retencion?.baseRentaServicios ?: 0}"/>
                    </div>

                    <div class="col-md-5" style="margin-left: 35px" id="divRSV">

                    </div>
                </div>
            </div>
        </div>

        <div class="alert alert-warning" role="alert" style="height: 60px;">
            <div class="col-md-4" style="margin-right: 56px; text-align: center">
                <label>Total Base Imponible</label>
            </div>
            <div class="col-md-2" id="divTotalesRenta">

            </div>
        </div>

    </div>


    <div class="vertical-container vertical-container-list" id="divIVA">
        <p class="css-vertical-text">Retención IVA</p>
        <div class="linea"></div>

        <div class="col-md-12">
            <div class="col-md-9"></div>
            <div class="col-md-1"><span class="input-group-addon"><strong>Base</strong></span></div>
            <div class="col-md-1" style="margin-left: -15px"><span class="input-group-addon"><strong>%</strong></span></div>
            <div class="col-md-1"><span class="input-group-addon"><strong>Valor</strong></span></div>
        </div>

        <div class="col-md-12">
            <div class="col-md-3 negrilla">
                Porcentaje IVA
            </div>
            <div class="col-md-3">
                <g:select name="porcentajeIva_name" id="porcentajeIva"
                          from="${cratos.sri.PorcentajeIva.list().sort{it.descripcion}}" class="form-control pori" optionValue="descripcion" optionKey="id" value="${retencion?.porcentajeIva?.id}"/>
            </div>
            <div class="col-md-1">
            </div>

            <div class="col-md-2 negrilla">
                ICE
            </div>
            <div class="fac2">
                <g:textField class=" form-control number"
                             title="La base imponible del ICE es obligatoria. Puede ingresar 0." name="iceBase_name" id="iceBase" value="${retencion?.baseIce ?: 0}" style="text-align: right"/>
            </div>

            <div class="fac2" id="divP1">
                <g:textField class=" form-control number"
                             title="El porcentaje del ICE es obligatorio. Puede ingresar 0." name="icePorcentaje_name" id="icePorcentaje" value="${retencion?.porcentajeIce ?: 0}" style="text-align: right"/>
            </div>

            <div class="fac2" id="divV1"></div>
        </div>

        <div class="col-md-12">

            <div class="col-md-3 negrilla">
                IVA
            </div>
            <div class="col-md-3">
                <g:textField class="form-control" name="iva12" value="${proceso?.ivaGenerado ?: 0}" readonly="true" style="text-align: right"/>
            </div>
            <div class="col-md-1">
            </div>


            <div class="col-md-2 negrilla">
                BIENES
            </div>
            <div class="fac2">
                <g:textField class=" form-control number"
                             title="La base imponible de Bienes es obligatoria. Puede ingresar 0." name="bienesBase_name"  id="bienesBase" value="${retencion?.baseBienes ?: 0}" style="text-align: right"/>
            </div>

            <div class="fac2" id="divP2">
                %{--<g:textField class=" form-control number"--}%
                             %{--title="El porcentaje de Bienes es obligatorio. Puede ingresar 0." name="bienesPorcentaje_name" id="bienesPorcentaje" value="${retencion?.porcentajeBienes ?: 0}" style="text-align: right"/>--}%
            </div>

            <div class="fac2" id="divV2">
            </div>


        </div>
        <div class="col-md-12" style="margin-bottom: 20px;">
            <div class="col-md-3 negrilla">
                Aplica Crédito Tributario
            </div>
            <div class="col-md-3">
                <g:select class=" form-control" name="credito" from="${['SI', 'NO']}" readonly="false" value="${retencion?.creditoTributario}"/>
            </div>

            <div class="col-md-1">
            </div>

            <div class="col-md-2 negrilla">
                SERVICIOS
            </div>
            <div class="fac2">
                <g:textField class=" form-control number"
                             title="La base imponible de Servicios es obligatoria. Puede ingresar 0."
                             name="servicioBase_name" id="servicioBase" value="${retencion?.baseServicios ?: 0}" style="text-align: right"/>
            </div>

            <div class="fac2" id="divP3">
                %{--<g:textField class=" form-control number"--}%
                             %{--title="El porcentaje de Servicios es obligatorio. Puede ingresar 0."--}%
                             %{--name="serviciosPorcentaje_name" id="serviciosPorcentaje" value="${retencion?.porcentajeServicios ?: 0}" style="text-align: right"/>--}%
            </div>

            <div class="fac2" id="divV3">
            </div>
        </div>

        <div class="col-md-12">
            <div class="col-md-3 negrilla">
                <label>Pago Local o Exterior</label>
            </div>
            <div class="col-md-3">
                <g:select class="form-control" name="pago"
                          from="${['01': 'LOCAL', '02': 'EXTERIOR']}" optionKey="key" optionValue="value" value="${retencion?.pago}"/>
            </div>
            <div class="col-md-3">
            </div>
            <div class="fac2" id="divTotalBase">
            </div>
            <div class="fac2"></div>
            <div class="fac2" id="divTotal2"></div>
        </div>

        <div class="exterior" style="margin-left: 40px; margin-right: 30px; margin-top: 10px; margin-bottom: 15px" hidden="hidden">
            <fieldset>
                <legend>Pago al Exterior</legend>

                <div class="fila">
                    <div class="uno">
                        <label style="margin-left: -40px">País</label>
                    </div>
                    <div class="dos">
                        <g:select class="form-control"
                                  name="pais" from="${cratos.sri.Pais.list([sort: 'nombre'])}"
                                  optionKey="id" optionValue="nombre" style="width: 250px; margin-left: -100px" value="${retencion?.pais?.id}"/>
                    </div>
                </div>

                <div style="margin-top: 20px">
                    <label style="margin-right: 30px">Aplica convenio de doble tributación?</label>
                    <g:radioGroup class="convenio" labels="['SI', 'NO']" values="['SI', 'NO']" name="convenio_name" value="${retencion?.convenio}">${it?.label} ${it?.radio}</g:radioGroup>
                </div>

                <div style="margin-top: 20px">
                    <label style="margin-right: 30px">Pago sujeto a retención en aplicación de la norma legal</label>
                    <g:radioGroup class="norma" labels="['SI', 'NO']" values="['SI', 'NO']" name="norma_name" value="${retencion?.normaLegal}">${it?.label} ${it?.radio}</g:radioGroup>
                </div>
                <legend></legend>
            </fieldset>
        </div>  %{--//exterior--}%
    </div>

</g:form>
<script type="text/javascript">


    $("#conceptoRetencionImpuestoRenta").change(function (){
        var concepto = $("#conceptoRetencionImpuestoRenta option:selected").val();
        if(concepto == '23'){
            $("#divRetencionServicios").addClass('esconder')
            $("#divIVA").addClass('esconder')
            $("#divComprobanteR").addClass('esconder')
        }else{
            $("#divRetencionServicios").removeClass('esconder')
            $("#divIVA").removeClass('esconder')
            $("#divComprobanteR").removeClass('esconder')
        }
    });


//    cargarPorcentajeIva($("#porcentajeIva option:selected").val())
    cargarBienes($("#porcentajeIva option:selected").val())
    cargarServicios($("#porcentajeIva option:selected").val())

    $("#porcentajeIva").change(function () {
        var porcentaje = $("#porcentajeIva option:selected").val()
//        cargarPorcentajeIva(porcentaje)
        cargarBienes(porcentaje)
        cargarServicios(porcentaje)
        cargarValorRetencionBI(porcentaje, $("#bienesBase").val());
        cargarValorRetencionSV(porcentaje, $("#servicioBase").val());
//        cargarTotalValor();
    });


    function cargarBienes(porcentaje) {
        $.ajax({
           type: 'POST',
            async: true,
            url: '${createLink(controller: 'proceso', action: 'valoresBienes_ajax')}',
            data:{
                porcentaje: porcentaje,
                bienesBase: $("#bienesBase").val()
            },
            success: function (msg){
                $("#divP2").html(msg)
            }
        });
    }
    function cargarServicios (porcentaje){
        $.ajax({
            type: 'POST',
            async: true,
            url: '${createLink(controller: 'proceso', action: 'valoresServicio_ajax')}',
            data:{
                porcentaje: porcentaje,
                serviciosBase: $("#servicioBase").val()
            },
            success: function (msg){
                $("#divP3").html(msg)
            }
        });
    }


    function cargarPorcentajeIva (sel){
        if(sel == '7'){
            $("#credito").addClass('soloLectura')
            $(".exterior").hide();
            $("#pago").val('01').addClass('soloLectura')
            $("#icePorcentaje").addClass('soloLectura')
            $("#bienesPorcentaje").addClass('soloLectura')
            $("#serviciosPorcentaje").addClass('soloLectura')
            $("#iceBase").addClass('soloLectura')
            $("#bienesBase").addClass('soloLectura')
            $("#servicioBase").addClass('soloLectura')
            $("#porcentajeIva").addClass('colorS')
        }else{
            $("#credito").removeClass('soloLectura')
            $("#pago").removeClass('soloLectura')
            $("#icePorcentaje").removeClass('soloLectura')
            $("#bienesPorcentaje").removeClass('soloLectura')
            $("#serviciosPorcentaje").removeClass('soloLectura')
            $("#iceBase").removeClass('soloLectura')
            $("#bienesBase").removeClass('soloLectura')
            $("#servicioBase").removeClass('soloLectura')
            $("#porcentajeIva").removeClass('colorS')
        }
    }


    $("#btnGuardarRetencion").click(function (){

        var error = '';
        var concepto = $("#conceptoRetencionImpuestoRenta option:selected").val();

        $("#listaErrores").html('');

        if(!$(".fechaEmision").val()){
            error+="<li>Seleccione la fecha de emisión de la retención</li>"
        }
        if(!$(".fechaRegistro").val()){
            error+="<li>Seleccione la fecha de registro de la retención</li>"
        }
        if($("#serie").val() == ''){
            if(concepto != '23'){
                error+="<li>Ingrese el número de comprobante de la retención</li>"
            }
        }else{
            if(concepto != '23'){
                if(revisarSerie() == 'no'){
                    error+="<li>El numero de comprobante ingresado no se encuentra en el rango del libretin seleccionado</li>"
                }
                if(validarSerie() == 'no'){
                    error+="<li>El numero de comprobante ingresado ya se encuentra asignado</li>"

                }
            }
        }

        if($("#dir").val() == ''){
            error+="<li>Ingrese la dirección del proveedor</li>"
        }

        if($("#tel").val() == ''){
            error+="<li>Ingrese el teléfono del proveedor</li>"
        }

        if(($("#baseImponible").val() == 0 || !$("#baseImponible").val()) && ($("#baseImponibleSV").val() == 0 || !$("#baseImponibleSV").val())){
            error+="<li>Ingrese una base imponible para el Impuesto a la Renta</li>"
        }else{
            var bi = $("#baseImponible").val()
            var bis = $("#baseImponibleSV").val()
            if(parseFloat(bi ? bi : 0) + parseFloat(bis ? bis : 0) > ${base}){
                error+="<li>Ingrese un valor menor o igual a la base imponible</li>"
            }
        }

        if($("#pago").val() == '02' && concepto != '23'){
            if(!$(".convenio:checked").val()){
                error+="<li>Seleccione si aplica o no el convenio de doble tributación</li>"
            }
            if(!$(".norma:checked").val()){
                error+="<li>Seleccione si el pago de la retencion esta sujeto a la norma legal </li>"
            }
        }

        if(($("#iceBase").val() == 0 || !$("#iceBase").val()) && ($("#bienesBase").val() == 0 || !$("#bienesBase").val()) && ($("#servicioBase").val() == 0 || !$("#servicioBase").val())){
            if(concepto != '23'){
                error+="<li>Ingrese al menos un valor diferente de cero (Retención IVA)</li>"
            }
        }else{
            var ib = $("#iceBase").val()
            var bb = $("#bienesBase").val()
            var sb =  $("#servicioBase").val()
            if( parseFloat(ib ? ib : 0)+ parseFloat(bb ? bb : 0) + parseFloat(sb ? sb : 0) > ${base} ){
                if(concepto != '23'){
                    error+="<li>La suma de las bases debe ser menor o igual a la base imponible (Retención IVA)</li>"
                }
            }
        }

        if(error == ''){
            $("#divErroresDetalle").hide();
            openLoader("Guardando..");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'proceso', action: 'saveRetencion_ajax')}',
                data:{
                    proceso: '${proceso?.id}',
                    conceptoRIRBienes: $("#conceptoRetencionImpuestoRenta").val(),
                    conceptoRIRServicios : $("#conceptoServicios").val(),
                    documentoEmpresa: $("#comprobanteSel").val(),
                    porcentajeIva: $("#porcentajeIva").val(),
                    pais: $("#pais").val(),
                    direccion: $("#dir").val(),
                    fecha: $(".fechaRegistro").val(),
                    numeroComprobante: $("#serie").val(),
                    telefono: $("#tel").val(),
                    fechaEmision: $(".fechaEmision").val(),
                    convenio: $(".convenio:checked").val(),
                    normaLegal: $(".norma:checked").val() ,
                    creditoTributario:$("#credito").val(),
                    baseRenta: $(".baseB").val(),
                    renta: $("#valorRetenido").val(),
                    baseRentaServicios: $(".baseS").val(),
                    rentaServicios: $("#valorRetenidoSV").val(),
                    baseIce: $("#iceBase").val(),
                    porcentajeIce: $("#icePorcentaje").val(),
                    ice: $("#valorRetenidoICE").val(),
                    baseBienes: $("#bienesBase").val(),
                    porcentajeBienes: $("#bienesPorcentaje").val(),
                    bienes: $("#valorRetenidoBienes").val(),
                    baseServicios: $("#servicioBase").val(),
                    porcentajeServicios: $("#serviciosPorcentaje").val(),
                    servicios: $("#valorRetenidoServicios").val(),
                    iva: $("#iva12").val(),
                    pago: $("#pago").val(),
                    retencion: '${retencion?.id}'
                },
                success: function (msg){
                    if(msg == 'ok'){
                        log("Retención guardada correctamente","success")
                        setTimeout(function () {
//                              location.reload()
                            location.href='${createLink(controller: 'proceso', action: 'detalleSri')}/' + ${proceso?.id}
                        }, 800);
                    }else{
                        log("Error al guardar la información de la retención","error")
                    }
                    closeLoader()
                }
            });

        }else{
            $("#listaErrores").append(error);
            $("#listaErrores").show();
            $("#divErroresDetalle").show()
        }

    });

    function revisarSerie () {
        var regresa = $.ajax({
            type: 'POST',
            async: false,
            url:'${createLink(controller: 'proceso', action: 'comprobarSerie_ajax')}',
            data:{
                libretin: $("#comprobanteSel option:selected").val(),
                serie: $("#serie").val()
            },
            success: function (msg){
            }
        });
        return regresa.responseText
    }

    function validarSerie () {
        var regresaV = $.ajax({
            type: 'POST',
            async: false,
            url:'${createLink(controller: 'proceso', action: 'validarSerie_ajax')}',
            data:{
                retencion: '${retencion?.id}',
                serie: $("#serie").val()
            },
            success: function (msg){
            }
        });
        return regresaV.responseText
    }

    cargarTotalesRenta();

    $(".baseB").keyup(function () {
        cargarTotalesRenta();
    });

    $(".baseS").keyup(function () {
        cargarTotalesRenta();
    });

    function cargarTotalesRenta () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'totalesRenta_ajax')}",
            data:{
                bienes: $(".baseB").val(),
                servicios: $(".baseS").val(),
                base: '${base}'
            },
            success: function (msg) {
                $("#divTotalesRenta").html(msg)
            }
        });
    }


    $("#iceBase").keyup(function () {
        cargarValorRetencionICE($("#icePorcentaje").val(), $("#iceBase").val());
        cargarTotalBase();
    });

    $("#bienesBase").keyup(function () {
//        cargarValorRetencionBI($("#bienesPorcentaje").val(), $("#bienesBase").val());
        cargarValorRetencionBI($("#porcentajeIva").val(), $("#bienesBase").val());
        cargarTotalBase();
        cargarTotalValor();
    });

    $("#servicioBase").keyup(function () {
//        cargarValorRetencionSV($("#serviciosPorcentaje").val(), $("#servicioBase").val());
        cargarValorRetencionSV($("#porcentajeIva").val(), $("#servicioBase").val());
        cargarTotalBase();
        cargarTotalValor();
    });

    $("#icePorcentaje").keyup(function () {
        cargarValorRetencionICE($("#icePorcentaje").val(), $("#iceBase").val());
    });

//    $("#bienesPorcentaje").keyup(function () {
//        cargarValorRetencionBI($("#bienesPorcentaje").val(), $("#bienesBase").val());
//    });

//    $("#serviciosPorcentaje").keyup(function () {
//        cargarValorRetencionSV($("#serviciosPorcentaje").val(), $("#servicioBase").val());
//    });

    cargarValorRetencionICE($("#icePorcentaje").val(), $("#iceBase").val());
    cargarValorRetencionBI($("#porcentajeIva").val(), $("#bienesBase").val());
    cargarValorRetencionSV($("#porcentajeIva").val(), $("#servicioBase").val());
    cargarTotalBase();
    cargarTotalValor();

    function cargarValorRetencionSV (porcentaje, base) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action:'calcularValorSV_ajax')}',
            data: {
                porcentaje: porcentaje,
                base: base
            },
            success: function (msg) {
                $("#divV3").html(msg)
            }
        });
    }

    function cargarValorRetencionBI (porcentaje, base) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action:'calcularValorBI_ajax')}',
            data: {
                porcentaje: porcentaje,
                base: base
            },
            success: function (msg) {
                $("#divV2").html(msg)
            }
        });
    }

    function cargarValorRetencionICE (porcentaje, base) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action:'calcularValorICE_ajax')}',
            data: {
                porcentaje: porcentaje,
                base: base
            },
            success: function (msg) {
                $("#divV1").html(msg)
            }
        });
    }

    function cargarCeldaPorcentaje (porcentaje){
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'porcentaje_ajax')}",
            data:{
                porcentaje: porcentaje
            },
            success: function (msg){
                $("#divP1").html(msg)
                $("#divP2").html(msg)
                $("#divP3").html(msg)
            }
        });
    }

    function cargarTotalBase () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'totalBase_ajax')}",
            data:{
                ice:  $("#iceBase").val(),
                bienes: $("#bienesBase").val(),
                servicios: $("#servicioBase").val(),
                base: '${base}'
            },
            success: function (msg1){
                $("#divTotalBase").html(msg1)
            }
        });
    }


    function cargarTotalValor () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'totaValor_ajax')}",
            data:{
//                ice:  $("#iceBase").val(),
                bienes: $("#valorRetenidoBienes").val(),
                servicios: $("#valorRetenidoServicios").val(),
                base: '${base}',
                porcentaje: $("#porcentajeIva option:selected").val()
            },
            success: function (msg1){
                $("#divTotal2").html(msg1)
            }
        });
    }

    cargarRBI($("#conceptoRetencionImpuestoRenta option:selected").val(), $("#baseImponible").val());

    $("#conceptoRetencionImpuestoRenta").change(function () {
        var idConcepto = $("#conceptoRetencionImpuestoRenta option:selected").val();
        var baseBI = $("#baseImponible").val();
        cargarRBI(idConcepto, baseBI);
    });

    function cargarRBI (id, base) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'concepto_ajax')}",
            data:{
                idConcepto: id,
                base: base
            },
            success: function (msg) {
                $("#divRBI").html(msg)
            }
        });
    }


    $("#baseImponibleSV").keyup(function () {
        cargarRSV($("#conceptoServicios option:selected").val(), $("#baseImponibleSV").val())
    });


    cargarRSV($("#conceptoServicios option:selected").val(), $("#baseImponibleSV").val());

    $("#conceptoServicios").change(function () {
        var idConcepto = $("#conceptoServicios option:selected").val();
        var baseSV = $("#baseImponibleSV").val();
        cargarRSV(idConcepto, baseSV);
    });


    function cargarRSV(idConceptoSV, baseSV){
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'conceptoSV_ajax')}",
            data:{
                idConcepto: idConceptoSV,
                base: baseSV
            },
            success: function (msg) {
                $("#divRSV").html(msg)
            }
        });
    }


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
//        return validarNum(ev);
        return validarNumSinPuntos(ev);
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


    $(".libretin").change(function  () {
        var idLibretin = $(".libretin option:selected").val();
        cargarNumeracion(idLibretin);
    });


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

            baseImponible:{
                remote : {
                    type: 'POST',
                    url:"${createLink(controller: 'proceso', action: 'validarBase_ajax')}",
                    data:{
                        baseBienes: $(".baseB").val(),
                        baseServicios: $(".baseS").val(),
                        baseImponible: ${base}
                    }
                }
            }
        },
        messages       : {
//            serie : {
//                remote : "Número de comprobante ya existente!"
//            },
            baseImponible :{
                remote : "Error, valor ingresado mayor a la base"
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
                        concepto               : $("#conceptoRIRBienes").val(),
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

        cargarExterior($("#pago option:selected").val());

        $("#pago").change(function () {
            cargarExterior($(this).val())
        });

        function cargarExterior (pago) {
            if (pago == '02') {
                $(".exterior").show();
            } else {
                $(".exterior").hide();
                $(".norma").attr("checked", false);
                $(".convenio").attr("checked", false);
            }
        }



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