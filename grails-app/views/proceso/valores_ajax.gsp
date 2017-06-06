<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 19/05/17
  Time: 14:41
--%>
<style type="text/css">

    .colorRojo{
        border-color: #ff0f24;
    }


</style>


<g:if test="${tipo == 'P'}">
    <div class="row" style="font-size: 12px">
        <div class="col-xs-2 negrilla" style="width: 120px">
            Valor:
        </div>
        <div class="col-xs-2 negrilla">
            <g:textField name="valorPago_name" id="valorPago" class="form-control required number validacionNumero" value="${proceso?.valor}"/>
        </div>
    </div>
    <div class="row" style="font-size: 12px">
        <div class="col-xs-2 negrilla" style="width: 120px">
            Tipo de Pago:
        </div>
        <div class="col-xs-5">
            <g:select name="tipoPago_name" from="${cratos.TipoPago.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" value="${proceso?.tipoPago}" class="form-control"/>
        </div>
    </div>
</g:if>
<g:elseif test="${tipo == '-1'}">
    <div class="row" style="height: 80px"></div>
</g:elseif>
<g:elseif test="${tipo == 'N'}">
    <div class="row" style="font-size: 12px">
        <div class="col-xs-2 negrilla" style="width: 120px">
            Valor:
        </div>
        <div class="col-xs-2 negrilla">
            <g:textField name="valorPagoNC_name" id="valorPagoNC" class="form-control required number validacionNumero" value="${proceso?.valor}"/>
        </div>
    </div>
    <div class="row" style="font-size: 12px">
        <div class="col-xs-2 negrilla" style="width: 120px">
            IVA generado:
        </div>
        <div class="col-xs-2 negrilla">
            <input type="text" name="ivaGenerado" id="ivaGenerado"  value="${proceso?.ivaGenerado}" class="required number form-control validacionNumero" validate="required number" ${proceso?.estado == 'R' ?'disabled':''} />
        </div>
    </div>
</g:elseif>
<g:else>
    <g:set var="iva" value="${cratos.ParametrosAuxiliares.list().first().iva}"/>
    <div class="row" style="font-size: 12px">
        <div class="col-xs-2 negrilla" style="width: 120px">
            Base imponible IVA ${iva}%:
        </div>
        <div class="col-xs-2 negrilla">
            <input type="text" name="baseImponibleIva" id="iva12" size="7" value="${proceso?.baseImponibleIva ?: 0.00}" class="required  number form-control validacionNumero" validate="required number" ${proceso?.estado == 'R' ?'disabled':''} />
        </div>
        <div class="col-xs-2 negrilla" style="width: 120px">
            Base imponible IVA 0%:
        </div>
        <div class="col-xs-2 negrilla">
            <input type="text" name="baseImponibleIva0" size="7" id="iva0" value="${proceso?.baseImponibleIva0 ?: 0.00}" class="required number form-control validacionNumero" validate="required number" ${proceso?.estado == 'R' ?'disabled':''} />
        </div>
        <div class="col-xs-2 negrilla" style="width: 120px">
            Base imponible no aplica IVA:
        </div>
        <div class="col-xs-2 negrilla">
            <input type="text" name="baseImponibleNoIva" id="noIva" size="7" value="${proceso?.baseImponibleNoIva ?: 0.00}" class="required number form-control validacionNumero" validate="required number" ${proceso?.estado == 'R' ?'disabled':''} />
        </div>
    </div>
    <div class="row" style="font-size: 12px">
        <div class="col-xs-2 negrilla" style="width: 120px">
            IVA generado:
        </div>
        <div class="col-xs-2 negrilla">
            <input type="text" name="ivaGenerado" id="ivaGenerado"  value="${proceso?.ivaGenerado}" class="required number form-control validacionNumero" validate="required number" ${proceso?.estado == 'R' ?'disabled':''} />
        </div>
        <div class="col-xs-2 negrilla" style="width: 120px">
            ICE generado:
        </div>
        <div class="col-xs-2 negrilla"  >
            <input type="text" name="iceGenerado"  id="iceGenerado" value="${proceso?.iceGenerado ?: 0.00}" class="required number form-control validacionNumero" validate="required number" ${proceso?.estado == 'R' ?'disabled':''} />
        </div>
    </div>
    <div class="row" style="font-size: 12px">
        <div class="col-xs-2 negrilla" style="width: 120px">
            Factura o Documento de compra:
        </div>
        <div class="col-xs-3 negrilla">
            <input type="text" name="facturaEstablecimiento" id="establecimiento" size="3" maxlength="3" value="${proceso?.facturaEstablecimiento}" class=" digits form-control label-shared validacionNumero" validate=" number"
                   title="El número de establecimiento del documento " ${proceso?.estado == 'R' ? 'disabled':''} />
            <input type="text" name="facturaPuntoEmision" id="emision" size="3" maxlength="3" value="${proceso?.facturaPuntoEmision}" class=" digits form-control label-shared validacionNumero " validate=" number"
                   title="El número de punto de emisión del documento" ${proceso?.estado == 'R' ?'disabled':''} />
            <input type="text" name="facturaSecuencial" id="secuencial" size="10" maxlength="9" value="${proceso?.facturaSecuencial}" class=" digits form-control label-shared validacionNumero " validate=" number"
                   title="El número de secuencia del documento"  ${proceso?.estado == 'R' ?'disabled':''} />
        </div>
        <div class="col-xs-2 negrilla" style="width: 120px;margin-left: -30px">
            Autorización:
        </div>
        <div class="col-xs-2 negrilla">
            <input type="text" name="facturaAutorizacion" id="auto" size="10" maxlength="15" value="${proceso?.facturaAutorizacion}" class=" digits form-control label-shared validacionNumero" validate=" number"
                   title="El número autorización de la factura a registrar " ${registro?'disabled':''} />
        </div>
        <div class="col-xs-2 negrilla" style="width: 120px;margin-left: -30px">
            Forma de pago  (emitir factura):
        </div>
        <div class="col-xs-2 negrilla">
            <input type="text" name="facturaAutorizacion" id="auto" size="10" maxlength="15" value="${proceso?.facturaAutorizacion}" class=" digits form-control label-shared validacionNumero" validate=" number"
                   title="El número autorización de la factura a registrar " ${registro?'disabled':''} />
        </div>
    </div>

    <div class="row" style="font-size: 12px">
        <div class="col-xs-2 negrilla" style="width: 120px">
            Datos de la retención a la venta:
        </div>
        <div class="col-xs-3 negrilla">
            Retenido por concepto de IVA:
            <input type="text" name="facturaSecuencial" id="secuencial" size="10" maxlength="9" value="${proceso?.facturaSecuencial}" class=" digits form-control label-shared validacionNumero " validate=" number"
                   title="El número de secuencia del documento"  ${proceso?.estado == 'R' ?'disabled':''} />
        </div>
        <div class="col-xs-2 negrilla" style="width: 120px;margin-left: -30px">
            Retenido por concepto de Renta:
        </div>
        <div class="col-xs-2 negrilla">
            <input type="text" name="facturaAutorizacion" id="auto" size="10" maxlength="15" value="${proceso?.facturaAutorizacion}" class=" digits form-control label-shared validacionNumero" validate=" number"
                   title="El número autorización de la factura a registrar " ${registro?'disabled':''} />
        </div>
    </div>
</g:else>


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

    $(".number").blur(function () {
        if(isNaN($(this).val()))
            $(this).val("0.00")
        if($(this).val()=="")
            $(this).val("0.00")
    });


    function calculaIva() {
        var iva = ${iva ?: 0};
        var val = parseFloat($("#iva12").val());
        var total = (iva / 100) * val;
        $("#ivaGenerado").val(number_format(total, 2, ".", ""));
    }

    calculaIva();

    $("#iva12").keyup(function () {
        calculaIva();
    });


</script>