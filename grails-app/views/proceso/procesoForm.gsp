<%@ page import="cratos.TipoComprobanteSri; cratos.SustentoTributario" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main"/>
    <title>Transacciones</title>
    <style type="text/css">
    .etiqueta {
        width       : 100px;
        height      : 20px;
        line-height : 20px;
        font-weight : bold;
        display     : inline-block;
    }
    
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
        <g:if test="${!registro}">
            <a href="#" class="btn btn-azul" id="guardarProceso">
                <i class="fa fa-save"></i>
                Guardar
            </a>
        </g:if>
        <g:if test="${params.id}">
            <g:if test="${proceso.adquisicion == null && proceso.fact == null && proceso.transferencia == null && !registro}">
                <a href="#" class="btn btn-success" id="registrarProceso">
                    <i class="fa fa-pencil-square-o"></i>
                    Registrar
                </a>
            </g:if>
        </g:if>
        <g:link class="btn btn-default" action="index">
            <i class="fa fa-times"></i>
            Cancelar
        </g:link>
        <g:if test="${proceso}">
            <g:if test="${!aux}">
                <g:if test="${proceso?.tipoProceso!='P'}">
                    <g:form action="borrarProceso" class="br_prcs" style="margin:0px;display: inline" >
                        <input type="hidden" name="id" value="${proceso?.id}">
                        <a class="btn btn-danger" id="btn-br-prcs" action="borrarProceso">
                            <i class="fa fa-basket"></i>
                            Borrar Proceso
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
        </g:if>
    </div>
</div>
<div style="padding: 0.7em; margin-top:5px; display: none;" class="alert alert-danger ui-corner-all" id="divErrores">
    %{--<span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>--}%
    <i class="fa fa-exclamation-triangle"> </i>
    <span style="" id="spanError">Se encontraron los siguientes errores:</span>

    <ul id="listaErrores"></ul>
</div>
<g:form name="procesoForm" action="save" method="post" class="frmProceso">
    <div class="vertical-container" style="margin-top: 25px;color: black;padding-bottom: 10px">
        <p class="css-vertical-text">Descripción</p>
        <div class="linea"></div>

        <input type="hidden" name="id" value="${proceso?.id}" id="idProceso"/>
        <input type="hidden" name="empleado.id" value="${session.usuario.id}"/>
        <input type="hidden" name="periodoContable.id" value="${session?.contabilidad?.id}"/>
        <input type="hidden" name="data" id="data" value="${session?.contabilidad?.id}"/>
        <div class="row">
            <div class="col-xs-2 negrilla">
                Gestor:
            </div>
            <div class="col-xs-3 negrilla">
                <g:select class="form-control required" name="gestor.id" from="${cratos.Gestor.findAllByEstadoAndEmpresa('A', session.empresa, [sort: 'nombre'])}"
                          label="Proceso tipo: " value="${proceso?.gestor?.id}" optionKey="id" optionValue="nombre" title="Proceso tipo" disabled="${registro?true:false}" />
            </div>
            <div class="col-xs-2 negrilla">
                Tipo de transacción:
            </div>
            <div class="col-xs-3 negrilla">
                <g:select class="form-control required cmbRequired" name="tipoProceso"  id="tipoProceso" from="${tiposProceso}"
                          label="Proceso tipo: " value="${proceso?.tipoProceso}" optionKey="key" optionValue="value" title="Tipo de la transacción"  disabled="${registro?true:false}"/>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-2 negrilla">
                Fecha:
            </div>
            <div class="col-xs-3 ">
                <g:if test="${registro}">
                    ${proceso?.fecha.format("dd-MM-yyyy")}
                </g:if>
                <g:else>
                    <elm:datepicker name="fecha"  title="Fecha de registro a la contabilidad " class="datepicker form-control required" value="${proceso?.fecha}"  maxDate="new Date()" style="width: 80px; margin-left: 5px" />
                </g:else>
            </div>
            <div class="col-xs-2 negrilla">
                Proveedor:
            </div>
            <div class="col-xs-4 negrilla">
                <input type="text" name="proveedor.ruc" class="form-control  label-shared" id="prov" disabled="true" value="${proceso?.proveedor?.ruc}" title="El proveedor o cliente"/>
                <g:if test="${!registro}">
                    <a href="#" id="btn_buscar" class="btn btn-azul">
                        <i class="fa fa-search"></i>
                        Buscar
                    </a>
                </g:if>
                <input type="hidden" name="proveedor.id" id="prov_id" value="${proceso?.proveedor?.id}">
            </div>
        </div>
        <div class="row">
            <div class="col-xs-2 negrilla">
                Sustento Tributario:
            </div>
            <div class="col-xs-5 negrilla">
                <g:select class=" form-control required cmbRequired" name="sustentoTributario.id" id="sustento" from="${SustentoTributario.list([sort:'codigo'])}" title="Necesario solo si la transacción debe reportarse al S.R.I." optionKey="id"   value="${proceso?.sustentoTributario?.id}"  noSelection="${['-1':'No aplica']}" disabled="${registro?true:false}" />
            </div>
            <div class="col-xs-2 " style="font-size: 10px;">
                Necesario solo si la transacción debe reportarse al S.R.I.
            </div>
        </div>
        <div class="row">
            <div class="col-xs-2 negrilla">
                Tipo de documento:
            </div>
            <div class="col-xs-5 negrilla">
                <g:select class="form-control cmbRequired" name="tipoComprobanteSri.id" id="tipoComprobante" from="${TipoComprobanteSri.findAllByIdNotInList([16.toLong(),17.toLong()],[sort:'codigo'])}" optionKey="id" title="Tipo del documento a registrar" optionValue="descripcion"  noSelection="${['-1':'No aplica']}" value="${proceso?.tipoComprobanteSri?.id}" disabled="${registro?true:false}" />
            </div>
            <div class="col-xs-2 " style="font-size: 10px">
                Tipo del documento a registrar.
            </div>
        </div>
        <div class="row">
            <div class="col-xs-2 negrilla">
                Descripción:
            </div>
            <div class="col-xs-3 negrilla">
                <textArea style='height:80px;width: 700px;resize: none' maxlength="255" name="descripcion" id="descripcion" title="La descripción de la transacción contable" class="form-control required cmbRequired" ${registro?'disabled':''} >${proceso?.descripcion}</textArea>
            </div>
        </div>
    </div>
    <div class="vertical-container" style="margin-top: 25px;color: black;padding-bottom: 10px;">
        <p class="css-vertical-text">Valores</p>
        <div class="linea"></div>
        <g:set var="iva" value="${cratos.ParametrosAuxiliares.list().first().iva}"/>
        <div class="row" style="font-size: 12px">
            <div class="col-xs-2 negrilla" style="width: 120px">
                Base imponible IVA ${iva}%:
            </div>
            <div class="col-xs-2 negrilla">
                <input type="text" name="baseImponibleIva" id="iva12" size="7" value="${proceso?.baseImponibleIva ?: 0.00}" class="required  number form-control" validate="required number" ${registro?'disabled':''} />
            </div>
            <div class="col-xs-2 negrilla" style="width: 120px">
                Base imponible IVA 0%:
            </div>
            <div class="col-xs-2 negrilla">
                <input type="text" name="baseImponibleIva0" size="7" id="iva0" value="${proceso?.baseImponibleIva0 ?: 0.00}" class="required number form-control" validate="required number" ${registro?'disabled':''} />
            </div>
            <div class="col-xs-2 negrilla" style="width: 120px">
                Base imponible no aplica IVA:
            </div>
            <div class="col-xs-2 negrilla">
                <input type="text" name="baseImponibleNoIva" id="noIva" size="7" value="${proceso?.baseImponibleNoIva ?: 0.00}" class="required number form-control" validate="required number" ${registro?'disabled':''} />
            </div>
        </div>


        <div class="row" style="font-size: 12px">
            <div class="col-xs-2 negrilla" style="width: 120px">
                IVA generado:
            </div>
            <div class="col-xs-2 negrilla">
                <input type="text" name="ivaGenerado" id="ivaGenerado"  value="${proceso?.ivaGenerado}" class="required number form-control" validate="required number" ${registro?'disabled':''} />
            </div>
            <div class="col-xs-2 negrilla" style="width: 120px">
                ICE generado:
            </div>
            <div class="col-xs-2 negrilla"  >
                <input type="text" name="iceGenerado"  id="iceGenerado" value="${proceso?.iceGenerado ?: 0.00}" class="required number form-control" validate="required number" ${registro?'disabled':''} />
            </div>
        </div>
        <div class="row" style="font-size: 12px">
            <div class="col-xs-2 negrilla" style="width: 120px">
                Documento:
            </div>
            <div class="col-xs-4 negrilla">
                <input type="text" name="facturaEstablecimiento" id="establecimiento" size="3" maxlength="3" value="${proceso?.facturaEstablecimiento}" class=" digits form-control label-shared " validate=" number"
                       title="El número de establecimiento del documento " ${registro?'disabled':''} />
                <input type="text" name="facturaPuntoEmision" id="emision" size="3" maxlength="3" value="${proceso?.facturaPuntoEmision}" class=" digits form-control label-shared " validate=" number"
                       title="El número de punto de emisión del documento" ${registro?'disabled':''} />
                <input type="text" name="facturaSecuencial" id="secuencial" size="10" maxlength="9" value="${proceso?.facturaSecuencial}" class=" digits form-control label-shared  " validate=" number"
                       title="El número de secuencia del documento"  ${registro?'disabled':''} />
            </div>
            <div class="col-xs-2 negrilla" style="width: 120px;margin-left: -30px">
                Autorización:
            </div>
            <div class="col-xs-2 negrilla">
                <input type="text" name="facturaAutorizacion" id="auto" size="10" maxlength="15" value="${proceso?.facturaAutorizacion}" class=" digits form-control label-shared " validate=" number"
                       title="El número autorización de la factura a registrar " ${registro?'disabled':''} />
            </div>
            <div class="col-xs-3 negrilla" style="width: 140px">
                <a href="#" id="abrir-fp" class="btn btn-azul">
                    <i class="fa fa-credit-card"></i>
                    Registrar formas de pago
                </a>
            </div>
        </div>

    </div>
</g:form>
<g:if test="${proceso}">
    <div class="vertical-container" skip="1" style="margin-top: 25px;color: black;min-height: 250px;margin-bottom: 20px">
        <p class="css-vertical-text">Comprobante</p>
        <div class="linea"></div>
        <div id="registro" style=" margin-left: 40px;margin-bottom: 10px ;padding: 10px;display: none;margin-top: 5px;width: 850px;">
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
                    <div class="col-xs-2 negrilla" style="width: 140px">
                        Tipo de pago:
                    </div>
                    <div class="col-xs-6 negrilla" style="margin-left: -20px" >
                        <g:select name="tipoPago.id" id="comboFP" class=" form-control" from="${cratos.TipoPago.list()}" label="Tipo de pago: " optionKey="id"  optionValue="descripcion" />
                    </div>
                    <div class="col-xs-1 negrilla" style="width: 140px">
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
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar y continuar</button>
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
                    <div class="col-xs-2 negrilla" style="width: 140px">
                        <select id="tipoPar" style="margin-right: 5px;" class="form-control">
                            <option value="1">RUC</option>
                            <option value="2">Nombre</option>
                        </select>
                    </div>
                    <div class="col-xs-5 negrilla" style="margin-left: -20px" >
                        <input type="text" id="parametro" class="form-control" style="margin-right: 10px;">
                    </div>
                    <div class="col-xs-1 negrilla" style="width: 140px">
                        <a href="#" id="buscar" class="btn btn-azul">
                            <i class="fa fa-search"></i>
                            Buscar
                        </a>
                    </div>
                </div>

                <div class="ui-corner-all" style="height: 400px;border: 1px solid #000000; width: 100%;margin-left: 0px;margin-top: 20px;overflow-y: auto" id="resultados"></div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">

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
        var iva = ${iva};
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
            bootbox.confirm("Está seguro? si esta transacción tiene un comprobante, este será anulado. Esta acción es irreversible",function(result){
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
        })

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
        /*todo guardar proceso..... move on*/
        $("#guardarProceso").click(function() {

            openLoader("Validando")
            var bandData=true
            var error=""
            var info=""
            $("#listaErrores").html("")
            if($("#fecha_input").val().length<10){
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
            if($(".filaFP").size() <1){
                info+="No ha asignado formas de pago para la transacción contable"
                bandData=false
            }
            if(bandData){
                var data =""
                $(".filaFP").each(function(){
                    data+=$(this).attr("fp")+";"

                })
                $("#data").val(data)
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
                    $(".frmProceso").submit();
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

            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'proceso',action: 'buscarProveedor')}",
                data    : "par=" + $("#parametro").val() + "&tipo=" + $("#tipoPar").val(),
                success : function (msg) {
                    //$("#registro").html(msg).show("slide");

                    $("#resultados").html(msg).show("slide")
                }
            });

        });

        $("#registrarProceso").click(function () {
            bootbox.confirm("Esta seguro?.<br>Una vez registrada la transacción no se podrá hacer modificaciones.",function(result){
                if(result){
                    openLoader()
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

        <g:if test="${proceso}">
        //                console.log("entro")
        openLoader("Cargando")
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(action: 'cargaComprobantes')}",
            data    : "proceso=" + $("#idProceso").val(),
            success : function (msg) {
                $("#registro").html(msg).show("slide");
                closeLoader()
            }
        });

        </g:if>

    });
</script>

</body>

</html>
