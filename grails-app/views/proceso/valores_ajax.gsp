<style type="text/css">
    .colorRojo{
        border-color: #ff0f24;
    }
</style>

<g:if test="${tipo == 'P' || tipo == 'A' || tipo == 'I'}">
    <div class="row" style="font-size: 12px">
        <div class="col-xs-2 negrilla" style="width: 120px">
            Valor:
        </div>
        <div class="col-xs-2 negrilla">
            <g:textField name="valorPago_name" id="valorPago" class="form-control required number validacionNumero"
                         value="${proceso?.valor}"/>
        </div>
    </div>
</g:if>
<g:elseif test="${tipo == 'N' || tipo == 'D'}">
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
<g:elseif test="${tipo == 'C' || tipo == 'V'}">
    <g:set var="iva" value="${cratos.ParametrosAuxiliares.list().first().iva}"/>

    <g:if test="${tipo == 'C'}">
    <div class="row" style="font-size: 12px">
        <div class="col-xs-3 negrilla">
            Documento registrado:
        </div>
        <div class="col-xs-4 negrilla" style="margin-left: -95px">
            <div class="col-xs-3">
            <input type="text" name="dcmtEstablecimiento" id="dcmtEstablecimiento" size="3" maxlength="3" style="width: 60px;"
                   value="${proceso?.procesoSerie01}" class="form-control validacionNumero"
                   validate=" number" placeholder="Establ." ${proceso?.estado == 'R' ? 'disabled':''} />
            </div>
            <div class="col-xs-3">
            <input type="text" name="dcmtEmision" id="dcmtEmision" size="3" maxlength="3" style="width: 60px;"
                   value="${proceso?.procesoSerie02}"
                   class="form-control validacionNumero " validate=" number" placeholder="Emisión"
                   title="El número de punto de emisión del documento" ${proceso?.estado == 'R' ?'disabled':''} />
            </div>
            <div class="col-xs-6">
            <input type="text" name="dcmtSecuencial" id="dcmtSecuencial" size="10" maxlength="9" style="width: 110px;"
                   value="${proceso?.secuencial}"
                   class="form-control label-shared validacionNumero " validate=" number"
                   title="El número de secuencia del documento"  ${proceso?.estado == 'R' ?'disabled':''} placeholder="Secuencial" />
            </div>
        </div>
        <div class="col-xs-2 negrilla" style="width: 120px;margin-left: -30px; text-align: right">
            Autorización:
        </div>
        <div class="col-xs-2 negrilla">
            <input type="text" name="dcmtAutorizacion" id="dcmtAutorizacion" size="10" maxlength="15"
                   value="${proceso?.autorizacion}" class=" digits form-control label-shared validacionNumero"
                   validate=" number" placeholder="Autorización"
                   title="El número autorización de la factura a registrar " ${registro?'disabled':''} />
        </div>
    </div>
    </g:if>

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
</g:elseif>


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