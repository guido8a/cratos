<%@ page import="cratos.Asiento; cratos.sri.TipoComprobanteSri; cratos.sri.SustentoTributario" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main"/>
    <title>Transacciones</title>
    <style type="text/css">
    .number{
        text-align: right;
    }
    .filaFP {
        width          : 95%;
        height         : 20px;
        border-bottom  : 1px solid black;
        margin         : 10px;
        vertical-align : middle;
        text-align     : left;
        line-height    : 10px;
        padding-left   : 10px;
        padding-bottom : 20px;
        font-size      : 10px;
    }

    .span-rol {
        padding-right : 10px;
        padding-left  : 10px;
        height        : 16px;
        line-height   : 16px;
        background    : #FFBD4C;
        margin-right  : 5px;
        font-weight   : bold;
        font-size     : 12px;
    }

    .span-eliminar {
        padding-right : 10px;
        padding-left  : 10px;
        height        : 16px;
        line-height   : 16px;
        background    : rgba(255, 2, 10, 0.35);
        margin-right  : 5px;
        font-weight   : bold;
        font-size     : 12px;
        cursor        : pointer;
        float         : right;
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
            <g:if test="${proceso.adquisicion == null && proceso.fact == null && proceso.transferencia == null && !registro}">
                <a href="#" class="btn btn-info" id="registrarProceso">
                    <i class="fa fa-check"></i>
                    Registrar
                </a>
            </g:if>
        </g:if>

        <g:if test="${proceso}">
            <g:if test="${!aux}">
                <g:if test="${proceso?.tipoProceso!='P'}">
                    <g:form action="borrarProceso" class="br_prcs" style="margin:0px;display: inline" >
                        <input type="hidden" name="id" value="${proceso?.id}">
                        <a class="btn btn-danger" id="btn-br-prcs" action="borrarProceso">
                            <i class="fa fa-trash-o"></i>
                            Anular Proceso
                        </a>
                    </g:form>
                </g:if>
            </g:if>
            <g:else>
                <a href="#" class="btn btn-default" style="cursor: default" >
                    <i class="fa fa-ban"></i>
                    Esta transacción no puede ser eliminada ni desmayorizada porque tiene auxiliares registrados.
                </a>
            </g:else>


            <g:if test="${cratos.Retencion.countByProceso(proceso) > 0}">
                <g:link class="btn btn-primary" action="detalleSri" id="${proceso?.id}" style="margin-bottom: 10px;">
                    <i class="fa fa-shield"></i> SRI
                </g:link>
                %{--<g:if test="${cratos.Retencion.findByProceso(proceso).numeroSecuencial}">--}%
                    <g:link controller="reportes3" action="imprimirRetencion" class="btn btn-default btnRetencion" id="${proceso?.id}" params="[empresa: session.empresa.id]" style="margin-bottom: 10px;">
                        <i class="fa fa-print"></i>
                        Imprimir retención
                    </g:link>
                %{--</g:if>--}%
            </g:if>
        </g:if>
    </div>
</div>
<div style="padding: 0.7em; margin-top:5px; display: none;" class="alert alert-danger ui-corner-all" id="divErrores">
    <i class="fa fa-exclamation-triangle"> </i>
    <span style="" id="spanError">Se encontraron los siguientes errores:</span>
    <ul id="listaErrores"></ul>
</div>
<g:form name="procesoForm" action="save" method="post" class="frmProceso">
    <div class="vertical-container" style="margin-top: 25px;color: black;padding-bottom: 10px">
        <p class="css-vertical-text">Descripción</p>
        <div class="linea"></div>

        <input type="hidden" name="id" value="${proceso?.id}" id="idProceso"/>
%{--
        <input type="hidden" name="empleado.id" value="${session.usuario.id}"/>
        <input type="hidden" name="periodoContable.id" value="${session?.contabilidad?.id}"/>
        <input type="hidden" name="data" id="data" value="${session?.contabilidad?.id}"/>
--}%
        <div class="row">
            <div class="col-md-2 negrilla">
                Tipo de transacción:
            </div>
            <div class="col-md-4 negrilla">
                <g:select class="form-control required cmbRequired tipoProcesoSel" name="tipoProceso"  id="tipoProceso"
                          from="${tiposProceso}" label="Proceso tipo: " value="${proceso?.tipoProceso}" optionKey="key"
                          optionValue="value" title="Tipo de la transacción" disabled="${proceso?.id ? 'true':'false'}"/>
            </div>

            <div class="col-md-1 negrilla">
                Fecha de Emisión:
            </div>
            <div class="col-md-2">
                <g:if test="${registro}">
                    ${proceso?.fecha.format("dd-MM-yyyy")}
                </g:if>
                <g:else>
                    <elm:datepicker name="fecha"  title="Fecha de emisión del comprobante" class="datepicker form-control required col-md-3"
                                    value="${proceso?.fecha}"  maxDate="new Date()" style="width: 80px; margin-left: 5px" />
                </g:else>
            </div>

            <div class="col-md-1 negrilla">
                Fecha de registro:
            </div>
            <div class="col-md-2">
                <g:if test="${registro}">
                    ${proceso?.fecha.format("dd-MM-yyyy")}
                </g:if>
                <g:else>
                    <elm:datepicker name="fecharegistro"  title="Fecha de registro en el sistema" class="datepicker form-control required col-md-3"
                                    value="${proceso?.fecha}"  maxDate="new Date()" style="width: 80px; margin-left: 5px" />
                </g:else>
            </div>


        </div>

        <div class="row">
            <div class="col-md-2 negrilla">
                Gestor a utilizar:
            </div>
            <div class="col-md-10 negrilla">
                <g:select class="form-control required" name="gestor.id" from="${cratos.Gestor.findAllByEstadoAndEmpresa('R', session.empresa, [sort: 'nombre'])}"
                          label="Proceso tipo: " value="${proceso?.gestor?.id}" optionKey="id" optionValue="nombre" title="Proceso tipo" disabled="${registro?true:false}" />
            </div>
        </div>

        <div class="row" id="divCargaProveedor">
        </div>

        <div class="row" id="divFilaComprobante">
        </div>

        <div class="row">
            <div class="col-md-2 negrilla">
                Sustento Tributario:
            </div>
            <div class="col-md-5 negrilla">
%{--
                <g:select class=" form-control required cmbRequired" name="sustentoTributario.id" id="sustento"
                          from="${SustentoTributario.list([sort:'codigo'])}"
                          title="Necesario solo si la transacción debe reportarse al S.R.I." optionKey="id"
                          value="${proceso?.sustentoTributario?.id}" noSelection="${['-1':'No aplica']}"
                          disabled="${registro?true:false}" />
--}%
            </div>
            <div class="col-md-2 " style="font-size: 10px;">
                Necesario solo si la transacción debe reportarse al S.R.I.
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 negrilla">
                Tipo de comprobante:
            </div>
%{--
            <div class="col-md-5 negrilla">
                <g:select class="form-control cmbRequired" name="tipoComprobanteSri.id" id="tipoComprobante" from="${TipoComprobanteSri.findAllByIdNotInList([16.toLong(),17.toLong()],[sort:'codigo'])}" optionKey="id" title="Tipo del documento a registrar" optionValue="descripcion"  noSelection="${['-1':'No aplica']}" value="${proceso?.tipoComprobanteSri?.id}" disabled="${registro?true:false}" />
            </div>
--}%
            <div class="col-md-2 " style="font-size: 10px">
                Tipo del documento a registrar.
            </div>
        </div>

        <div class="row">
            <div class="col-md-2 negrilla">
                Descripción:
            </div>
            <div class="col-md-3 negrilla">
                <textArea style='height:80px;width: 700px;resize: none' maxlength="255" name="descripcion"
                          id="descripcion" title="La descripción de la transacción contable"
                          class="form-control required cmbRequired required" ${registro?'disabled':''} >
                    ${proceso?.descripcion}</textArea>
            </div>
        </div>

        <div class="row">
            <div class="col-md-2 negrilla">
                Libretín de Facturas/Retenciones:
            </div>
            <div class="col-md-3 negrilla">
                Selecciona el libretín y fija el secuencial a utilizarse
            </div>
        </div>
    </div>
    <div class="vertical-container" style="margin-top: 25px;color: black;padding-bottom: 10px;">
        <p class="css-vertical-text">Valores</p>
        <div class="linea"></div>
        <div id="divValores"></div>
    </div>

</g:form>
<g:if test="${proceso}">
    <div class="vertical-container" skip="1" style="margin-top: 25px;color: black;min-height: 500px;margin-bottom: 20px">
        <p class="css-vertical-text">Comprobante</p>
        <div class="linea"></div>
        <div id="divComprobante" class="col-md-12" style="margin-bottom: 20px ;padding: 10px;display: none;margin-top: 5px;">
        </div>
    </div>
</g:if>


<!-- Modal -->
<div class="modal fade" id="modal-formas-pago" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Formas de pago</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-2 negrilla" style="width: 140px">
                        Tipo de pago:
                    </div>
                    <div class="col-md-6 negrilla" style="margin-left: -20px" >
                        <g:select name="tipoPago.id" id="comboFP" class=" form-control" from="${cratos.TipoPago.list()}" label="Tipo de pago: " optionKey="id"  optionValue="descripcion" />
                    </div>
                    <div class="col-md-1 negrilla" style="width: 140px">
                        <g:if test="${!registro}">
                            <a href="#" id="agregarFP" class="btn btn-azul">
                                <i class="fa fa-plus"></i>
                                Agregar
                            </a>
                        </g:if>
                    </div>
                </div>
                <div class="ui-corner-all" style="height: 170px;border: 1px solid #000000;width: 100%;margin-left: 5px;margin-top: 20px" id="detalle-fp">
                    <g:each in="${fps}" var="f">
                        <div class="filaFP ui-corner-all fp-${f.tipoPago.id}" fp="${f.tipoPago.id}" >
                            <g:if test="${!registro}">
                                <span class='span-eliminar ui-corner-all' title='Click para eliminar'>Eliminar</span>
                            </g:if>
                            ${f.tipoPago.descripcion}
                        </div>
                    </g:each>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal" id="btnCerrarPagos"><i class="fa fa-save"></i> Cerrar y continuar</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- Modal -->
<div class="modal fade" id="modal-proveedor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel-proveedor">Proveedor</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-2 negrilla" style="width: 140px">
                        <select id="tipoPar" style="margin-right: 5px;" class="form-control">
                            <option value="1">RUC</option>
                            <option value="2">Nombre</option>
                        </select>
                    </div>
                    <div class="col-md-5 negrilla" style="margin-left: -20px" >
                        <input type="text" id="parametro" class="form-control" style="margin-right: 10px;">
                    </div>
                    <div class="col-md-1 negrilla" style="width: 140px">
                        <a href="#" id="buscar" class="btn btn-azul">
                            <i class="fa fa-search"></i>
                            Buscar
                        </a>
                    </div>
                </div>
                <div class="ui-corner-all" style="height: 400px;border: 1px solid #000000; width: 100%;margin-left: 0px;margin-top: 20px;overflow-y: auto" id="resultados"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Cerrar</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<script type="text/javascript">


    cargarTipo($(".tipoProcesoSel option:selected").val());
//    cargarBotonGuardar($(".tipoProcesoSel option:selected").val());
    cargarBotonBuscar($(".tipoProcesoSel option:selected").val());
    <g:if test="${proceso?.id && (proceso?.tipoProceso == 'P' || proceso?.tipoProceso == 'N')}">
        cargarComPago();
    </g:if>
    cargarProveedor($(".tipoProcesoSel option:selected").val());
    cargarComprobante('${proceso?.id}');

    $("#tipoProceso").change(function () {
        var tipo = $(".tipoProcesoSel option:selected").val();

        $("#listaErrores").html('');
        $("#divErrores").hide();

        if(tipo == 'N' || tipo == 'P'){
            cargarComPago()
        }else{
            $("#divFilaComprobante").html('')
        }
        cargarTipo(tipo);
//        cargarBotonGuardar(tipo);
        cargarBotonBuscar(tipo);

        if(tipo != '-1'){
            cargarProveedor(tipo);
        }else{
            $("#divFilaComprobante").html('');
            $("#divCargaProveedor").html('');
        }
    });

    function  cargarProveedor (tipo) {
        if(tipo != '-1'){
            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'proceso', action: 'proveedor_ajax')}",
                data:{
                    proceso: '${proceso?.id}',
                    tipo: tipo
                },
                success: function (msg) {
                    $("#divCargaProveedor").html(msg)
                }
            });
        }else{
            $("#divCargaProveedor").html('')
        }
    }

    function cargarComPago(){
        var idComprobante = $("#comprobanteSel").val();
        var idProveedor = $("#prov_id").val();
        $.ajax({
            type:'POST',
            async: 'true',
            url: "${createLink(controller: 'proceso', action: 'filaComprobante_ajax')}",
            data:{
                proceso: '${proceso?.id}',
                proveedor: idProveedor,
                comprobante : idComprobante
            },
            success: function (msg){
                $("#divFilaComprobante").html(msg)
            }
        });
    }

/*
    function cargarBotonGuardar (tipo) {
        if(tipo == '-1'){
            $("#guardarProceso").addClass('hidden')
        }else{
            $("#guardarProceso").removeClass('hidden')
        }
    }
*/

    function cargarBotonBuscar (tipo) {
        if(tipo != '-1'){
            $("#btn_buscar").removeClass('hidden')
        }else{
            $("#btn_buscar").addClass('hidden')
        }
    }

    function cargarTipo (tipo) {
        $.ajax({
            type:'POST',
            url: "${createLink(controller: 'proceso', action: 'valores_ajax')}",
            data:{
                proceso: '${proceso?.id}',
                tipo: tipo
            },
            success: function (msg){
                $("#divValores").html(msg)
            }
        });
    }

    jQuery.fn.svtContainer = function () {

        var title = this.find(".css-vertical-text")
        title.css({"cursor":"pointer"})
        title.attr("title","Minimizar")
        var fa=$("<i class='fa fa-arrow-left fa-fw' style='font-size: 20px !important;'></i>")
        var texto=$("<span class='texto' style='display: none;margin-left: 10px;color:#0088CC'> (Clic aquí para expandir)</span>")
        title.addClass("open")
        title.prepend(fa)
        title.append(texto)
        title.bind("click",function(){
            if($(this).parent().attr("skip")!="1"){
                if($(this).hasClass("open")){
                    $(this).parent().find(".row").hide("blind")
                    $(this).removeClass("open");
                    $(this).addClass("closed")
                    $(this).removeClass("css-vertical-text")
                    $(this).find(".texto").show()
                    setTimeout('$(this).parent().css({"height":"30px"});',30)
                }else{
                    $(this).parent().css({"height":"auto"});
                    $(this).parent().find(".row").show("slide")
                    $(this).removeClass("closed");
                    $(this).addClass("open")
                    $(this).addClass("css-vertical-text")
                    $(this).attr("title","Maximizar")
                    $(this).find(".texto").hide()
                }
            }
        });
        return this;
    }

    function calculaIva() {
        var iva = ${iva ?: 0};
        var val = parseFloat($("#iva12").val());
        var total = (iva / 100) * val;
        $("#ivaGenerado").val(number_format(total, 2, ".", ""));
    }

    $(function () {
        $(".vertical-container").svtContainer()
        <g:if test="${proceso && registro}">
        $(".css-vertical-text").click()
        </g:if>

        $("#btn-br-prcs").click(function(){
            bootbox.confirm("Está seguro? si esta transacción tiene un comprobante, este será anulado. " +
                    "Esta acción es irreversible",function(result){
                if(result){
                    $(".br_prcs").submit()
                }
            })
        });

        $("#tipoProceso").change(function(){
            if($(this).val()=="A"){
                bootbox.alert('Para realizar un ajuste, ponga el valor total dentro del campo "Base imponible no aplica IVA" y asegurese de seleccionar el gestor contable correcto')
                $("#iva0").val("0.00").attr("disabled",true)
                $("#iva12").val("0.00").attr("disabled",true)
                $("#ivaGenerado").val("0.00").attr("disabled",true)
                $("#iceGenerado").val("0.00").attr("disabled",true)
            }else{
                $("#iva0").attr("disabled",false)
                $("#iva12").attr("disabled",false)
                $("#ivaGenerado").attr("disabled",false)
                $("#iceGenerado").attr("disabled",false)
            }
        })

        $("#abrir-fp").click(function(){
            $('#modal-formas-pago').modal('show')
        })

        $("#btn_buscar").click(function(){
            $('#modal-proveedor').modal('show')
        });


//        $("#agregarFP").click(function(){
//            var band = true
//            var message
//            if ($(".filaFP").size() == 5) {
//                message = "<b>Ya ha asignado el máximo de 5 formas de  pago</b>"
//                band = false
//            }
//            if ($(".fp-"+$("#comboFP").val()).size() >0) {
//                message = "<b>Ya ha asignado la forma de pago "+$("#comboFP option:selected").text()+ " previamente.</b>"
//                band = false
//            }
//            if (band) {
//                var div = $("<div class='filaFP ui-corner-all'>")
//                var span = $("<span class='span-eliminar ui-corner-all' title='Click para eliminar'>Eliminar</span>")
//                div.html($("#comboFP option:selected").text())
//                div.append(span)
//                div.addClass("fp-"+$("#comboFP").val())
//                div.attr("fp",$("#comboFP").val())
//                span.bind("click", function () {
//                    $(this).parent().remove()
//                })
//                $("#detalle-fp").append(div)
//            }else{
//                bootbox.alert(message)
//            }
//        });
//

        $(".span-eliminar").bind("click", function () {
            $(this).parent().remove()
        })

        $("#guardarProceso").click(function() {
            var bandData=true
            var error=""
            var info=""
            var tipoP = $(".tipoProcesoSel option:selected").val();

            console.log("guardar con tipoP:", tipoP);

            if($("#tipoProceso").val()=="-1") {
                error += "<li>Seleccione el tipo de la transacción</li>"
            } else {
                if(tipoP == 'P' || tipoP == 'N'){

                    $("#listaErrores").html('');
                    $("#divErrores").hide();

                    if($("#fecha").val().length<10){
                        error+="<li>Seleccione la fecha del comprobante</li>"
                    }
                    if($("#fecharegsitro").val().length<10){
                        error+="<li>Seleccione la fecha de registro</li>"
                    }
                    if($("#descripcion").val().length<1){
                        error+="<li>Llene el campo Descripción</li>"
                    }

                    if($("#prov").val()== "" || $("#prov").val()== null){
                        error+="<li>Seleccione el proveedor</li>"
                    }

                    if($("#comprobanteDesc").val() == '' || $("#comprobanteDesc").val() == null){
                        error+="<li>Seleccione un comprobante</li>"
                    }

                    if($("#valorPago").val() == 0 || $("#valorPago").val() == null){
                        error+="<li>Ingrese un valor</li>"
                    }

                    if(tipoP == 'P'){

                        console.log("pago " + parseFloat($("#valorPago").val()))
                        console.log("saldo " + parseFloat($("#comprobanteSaldo1").val()))

                        if( parseFloat($("#valorPago").val()) > parseFloat($("#comprobanteSaldo").val())){
                            error+="<li>El valor ingresado es mayor al saldo del comprobante a pagar!</li>";

                            $("#valorPago").removeClass('required');
                            $("#valorPago").addClass('colorRojo');
                        }
                    }
                } else {
                    $("#listaErrores").html("")
                    if($("#fecha").val().length<10){
                        error+="<li>Seleccione la fecha de registro</li>"
                    }
                    if($("#descripcion").val().length<1){
                        error+="<li>Llene el campo Descripción</li>"
                    }
                    if($("#tipoProceso").val()=="-1"){
                        error+="<li>Seleccione el tipo de la transacción</li>"
                    }else{
                        if($("#tipoProceso").val()=="C" || $("#tipoProceso").val()=="V" ){

                            if($("#sustento").val()=="-1"){
                                error+="<li>Seleccione un sustento tributario (Necesario si el tipo de transacción es Compras o Ventas)</li>"
                            }
                            if($("#tipoComprobante").val()=="-1"){
                                error+="<li>Seleccione el tipo de documento a registrar (Necesario si el tipo de transacción es Compras o Ventas)</li>"
                            }else{
                                if($("#establecimiento").val().length<3){
                                    error+="<li>Ingrese el número de establecimiento del documento (Primera parte del campo documento) </li>"
                                }
                                if($("#emision").val().length<3){
                                    error+="<li>Ingrese el número de emisión del documento (Segunda parte del campo documento)</li>"
                                }
                                if($("#secuencial").val().length<1){
                                    error+="<li>Ingrese el número de secuencia del documento (Tercera parte del campo documento)</li>"
                                }
                            }
                        }
                    }
                    var iva0=$("#iva0").val()
                    var iva12=$("#iva12").val()
                    var noIva=$("#noIva").val()
                    if(isNaN(iva12)){
                        iva12=-1
                    }
                    if(isNaN(noIva)){
                        noIva=-1
                    }
                    if(isNaN(iva0)){
                        iva0=-1
                    }
                    if(iva12*1<0 ){
                        error+="<li>La base imponible iva ${iva}% debe ser un número positivo</li>"
                    }
                    if(iva0*1<0 ){
                        error+="<li>La base imponible iva 0% debe ser un número positivo</li>"
                    }
                    if(noIva*1<0 ){
                        error+="<li>La base imponible no aplica iva debe ser un número positivo</li>"
                    }
                    var base=iva0*1+iva12*1+noIva*1
                    if(base<=0){
                        error+="<li>La suma de las bases imponibles no puede ser cero</li>"
                    }else{
                        var impIva=$("#ivaGenerado").val()
                        var impIce=$("#iceGenerado").val()
                        if(isNaN(impIva)){
                            impIva=-1
                        }
                        if(isNaN(impIce)){
                            impIce=-1
                        }
                        if(impIva*1>0 && iva12*1<=0){
                            error+="<li>No se puede generar IVA si la base imponible iva ${iva}% es cero</li>"
                        }
                        if(impIce*1*impIva*1<0){
                            error+="<li>Los impuestos generados no pueden ser negativos</li>"
                        }else{
                            if((impIce*1+impIva*1)>base){
                                error+="<li>Los impuestos generados no pueden ser superiores a la suma de las bases imponibles</li>"
                            }
                        }
                    }
//            if($(".filaFP").size() <1){
//                info+="No ha asignado formas de pago para la transacción contable"
//                bandData=false
//            }
                    if(bandData){
                        var data =""
                        $(".filaFP").each(function(){
                            data+=$(this).attr("fp")+";"

                        })
                        $("#data").val(data)
                    }
                }

            }


            if(error!=""){

                $("#listaErrores").append(error)
                $("#listaErrores").show()
                $("#divErrores").show()
            }else{
                if(info!=""){
                    info+=" Esta seguro de continuar?"
                    bootbox.confirm(info,function(result){

                        if(result){

                            $(".frmProceso").submit();
                        }
                    })
                }else{
                    openLoader("Guardando..");
                    $(".frmProceso").submit();
                    closeLoader()
                }
            }
            closeLoader()

        });

        calculaIva();

        $("#iva12").keyup(function () {
            calculaIva();
        });

        $(".number").blur(function () {
            if(isNaN($(this).val()))
                $(this).val("0.00")
            if($(this).val()=="")
                $(this).val("0.00")
        });

        $("#buscar").click(function () {
            var tipo = $(".tipoProcesoSel option:selected").val();
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'proceso',action: 'buscarProveedor')}",
                data    : "par=" + $("#parametro").val() + "&tipo=" + $("#tipoPar").val() + "&tipoProceso=" + tipo,
                success : function (msg) {
                    $("#resultados").html(msg).show("slide")
                }
            });

        });

        $("#registrarProceso").click(function () {
            bootbox.confirm("<i class='fa fa-exclamation-circle fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea registrar el proceso contable? </br> Una vez registrado, la información NO podrá ser cambiada.</p>", function(result){
                if(result){
                    openLoader("Registrando...");
                    $.ajax({
                        type    : "POST",
                        url     : "${g.createLink(controller: 'proceso',action: 'registrar')}",
                        data    : "id=" + $("#idProceso").val(),
                        success : function (msg) {
                            // $("#registro").html(msg).show("slide");
                            closeLoader()
                            location.reload(true);
                        },
                        error   : function () {
                            bootbox.alert("Ha ocurrido un error. Por favor revise el gestor y los valores del proceso.")
                        }
                    });
                }

            })
        });
    });

    function cargarComprobante (proceso) {
        $.ajax({
            type:'POST',
            url:"${createLink(controller: 'proceso',action: 'comprobante_ajax')}",
            data:{
                proceso: proceso
            },
            success: function (msg) {
                $("#divComprobante").html(msg).show("slide");
            }
        });
    }

</script>
</body>
</html>
