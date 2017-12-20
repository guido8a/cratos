<style type="text/css">
.colorRojo {
    border-color: #ff0f24;
}
</style>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>


%{--<g:if test="${tipo == '4' || tipo == '5' || tipo == '8'}">--}%
<g:if test="${tipo in ['3', '4', '5', '8']}">
    <div class="row" style="font-size: 12px">
        <div class="col-xs-2 negrilla" style="width: 120px">
            Valor:
        </div>

        <div class="col-xs-2 negrilla">
            <g:textField name="valorPago" id="valorPago" class="form-control required number validacionNumero"
                         value="${proceso?.valor ?: 0}" disabled="${proceso?.estado == 'R' ? true : false}"/>
        </div>
    </div>
</g:if>

%{--<g:elseif test="${tipo == '1' || tipo == '2' || tipo == '3' || tipo == '6' || tipo == '7'}">--}%
<g:elseif test="${tipo in ['1', '2', '3', '6', '7']}">
    %{--<g:set var="iva" value="${cratos.ParametrosAuxiliares.list().first().iva}"/>--}%

    <g:if test="${tipo == '1'}">
        <div class="row" style="font-size: 12px">
            <div class="col-xs-3 negrilla">
                Documento registrado:
            </div>

            <div class="col-xs-4 negrilla" style="margin-left: -60px">
                <div class="col-xs-3">
                    <input type="text" name="dcmtEstablecimiento" id="dcmtEstablecimiento" size="3" maxlength="3"
                           style="width: 60px;"
                           value="${proceso?.procesoSerie01}" class="form-control validacionNumero"
                           validate=" number" placeholder="Establ." ${proceso?.estado == 'R' ? 'disabled' : ''}/>
                </div>

                <div class="col-xs-3">
                    <input type="text" name="dcmtEmision" id="dcmtEmision" size="3" maxlength="3" style="width: 60px;"
                           value="${proceso?.procesoSerie02}"
                           class="form-control validacionNumero " validate=" number" placeholder="Emisión"
                           title="El número de punto de emisión del documento" ${proceso?.estado == 'R' ? 'disabled' : ''}/>
                </div>

                <div class="col-xs-6">
                    <input type="text" name="dcmtSecuencial" id="dcmtSecuencial" size="10" maxlength="9"
                           style="width: 110px;"
                           value="${proceso?.secuencial}"
                           class="form-control label-shared validacionNumero " validate=" number"
                           title="El número de secuencia del documento" ${proceso?.estado == 'R' ? 'disabled' : ''}
                           placeholder="Secuencial"/>
                </div>
            </div>

            <div class="col-xs-2 negrilla" style="width: 120px;margin-left: -30px; text-align: right">
                Autorización:
            </div>

            <div class="col-xs-4 negrilla">
                <input type="text" name="dcmtAutorizacion" id="dcmtAutorizacion" size="49" maxlength="49"
                       style="width: 360px;"
                       value="${proceso?.autorizacion?: atrz}" class="digits form-control validacionNumero required"
                       title="El número autorización de la factura a registrar "
                       validate=" number" placeholder="Autorización" ${proceso?.estado == 'R' ? 'disabled' : ''}/>

%{--
                <input type="text" name="dcmtAutorizacion" id="dcmtAutorizacion" size="49" maxlength=49"
                       value="${proceso?.autorizacion?: atrz}" class="digits form-control label-shared validacionNumero required"
                       validate=" number" placeholder="Autorización"
                       title="El número autorización de la factura a registrar " ${proceso?.estado == 'R' ? 'disabled' : ''} style="width: 350px"/>
--}%

            </div>
        </div>

    %{--TODO: si se trata de NC o ND se presenta esta sección --}%
        <g:if test="${data}">
        <div class="row text-info" style="font-size: 12px">
            <div class="col-xs-2 negrilla">
                Documento afectado:
            </div>
            <div class="col-xs-10 negrilla text-info">
                <g:select class="text-info form-control cmbRequired " name="mdfcComprobante.id" id="mdfcComprobante"
                          from="${data}"
                          optionKey="id" title="Tipo de comprobante"
                          optionValue="${{ it.codigo + ' - ' + it.descripcion }}"
                          noSelection="${['-1': 'Seleccione...']}" value="${proceso?.modificaCmpr?.id ?: 1}"
                          disabled="${proceso?.estado == 'R' ? true : false}"/>
            </div>
        </div>

        <div class="row text-info" style="font-size: 12px; margin-bottom: 20px">
            <div class="col-xs-3 negrilla">
                Documento modificado:
            </div>
            <div class="col-xs-4 negrilla" style="margin-left: -60px">
                <div class="col-xs-3 text-info">
                    <input type="text" name="mdfcEstablecimiento" id="mdfcEstablecimiento" size="3" maxlength="3"
                           style="width: 60px; color:   !important;"
                           value="${proceso?.modificaSerie01}" class="form-control validacionNumero"
                           validate=" number" placeholder="Establ." ${proceso?.estado == 'R' ? 'disabled' : ''}/>
                </div>

                <div class="col-xs-3 text-info">
                    <input type="text" name="mdfcEmision" id="mdfcEmision" size="3" maxlength="3" style="width: 60px;"
                           value="${proceso?.modificaSerie02}"
                           class="form-control validacionNumero " validate=" number" placeholder="Emisión"
                           title="El número de punto de emisión del documento" ${proceso?.estado == 'R' ? 'disabled' : ''}/>
                </div>

                <div class="col-xs-6 text-info">
                    <input type="text" name="mdfcSecuencial" id="mdfcSecuencial" size="10" maxlength="9"
                           style="width: 110px;"
                           value="${proceso?.modificaScnc}"
                           class="form-control label-shared validacionNumero " validate=" number"
                           title="El número de secuencia del documento" ${proceso?.estado == 'R' ? 'disabled' : ''}
                           placeholder="Secuencial"/>
                </div>
            </div>

            <div class="col-xs-2 negrilla" style="width: 120px;margin-left: -30px; text-align: right">
                Autorización:
            </div>

            <div class="col-xs-2 negrilla">
                <input type="text" name="mdfcAutorizacion" id="mdfcAutorizacion" size="10" maxlength="15"
                       value="${proceso?.modificaAutorizacion}" class=" digits form-control label-shared validacionNumero"
                       validate=" number" placeholder="Autorización"
                       title="El número autorización de la factura a registrar " ${proceso?.estado == 'R' ? 'disabled' : ''}/>
            </div>
        </div>
        </g:if>
    </g:if>

    <div class="row" style="font-size: 12px">
        <div class="col-xs-1 negrilla" style="width: 100px">
            Base Impo. IVA ${valorIva}%:
        </div>

        <div class="col-xs-2 negrilla" style="margin-left: -20px">
            <input type="text" name="baseImponibleIva" id="iva12" size="7" value="${proceso?.baseImponibleIva ?: 0.00}"
                   class="required  number form-control validacionNumero valor"
                   validate="required number" ${proceso?.estado == 'R' ? 'readonly' : ( band ? 'readonly' : '')} />
        </div>

        <div class="col-xs-1 negrilla" style="width: 100px">
            Base impo. IVA 0%:
        </div>

        <div class="col-xs-2 negrilla" style="margin-left: -20px">
            <input type="text" name="baseImponibleIva0" size="7" id="iva0" value="${proceso?.baseImponibleIva0 ?: 0.00}"
                   class="required number form-control validacionNumero valor"
                   validate="required number"  ${proceso?.estado == 'R' ? 'readonly' : ( band ? 'readonly' : '')}  />
        </div>

        <div class="col-xs-1 negrilla" style="width: 100px">
            No aplica el IVA:
        </div>

        <div class="col-xs-2 negrilla" style="margin-left: -20px">
            <input type="text" name="baseImponibleNoIva" id="noIva" size="7"
                   value="${proceso?.baseImponibleNoIva ?: 0.00}" class="required number form-control validacionNumero valor"
                   validate="required number" ${proceso?.estado == 'R' ? 'readonly' : ( band ? 'readonly' : '')}  />
        </div>

        <div class="col-xs-1 negrilla" style="width: 100px">
            Excento del IVA:
        </div>

        <div class="col-xs-2 negrilla" style="margin-left: -20px">
            <input type="text" name="excentoIva" id="excentoIva" size="7"
                   value="${proceso?.excentoIva ?: 0.00}" class="required number form-control validacionNumero valor"
                   validate="required number" ${proceso?.estado == 'R' ? 'readonly' : ( band ? 'readonly' : '')}  />
        </div>
    </div>

    <div class="row" style="font-size: 12px">
        <div class="col-xs-1 negrilla" style="width: 100px">
            IVA generado:
        </div>

        <div class="col-xs-2 negrilla" style="margin-left: -20px">
            <input type="text" name="ivaGenerado" id="ivaGenerado" value="${proceso?.ivaGenerado}"
                   class="required number form-control validacionNumero valor"
                   validate="required number"  ${proceso?.estado == 'R' ? 'readonly' : ( band ? 'readonly' : '')}  />
        </div>

        <div class="col-xs-1 negrilla" style="width: 100px">
            ICE generado:
        </div>

        <div class="col-xs-2 negrilla" style="margin-left: -20px">
            <input type="text" name="iceGenerado" id="iceGenerado" value="${proceso?.iceGenerado ?: 0.00}"
                   class="required number form-control validacionNumero valor"
                   validate="required number"  ${proceso?.estado == 'R' ? 'readonly' : ( band ? 'readonly' : '')} />
        </div>

        <div class="col-xs-1 negrilla" style="width: 100px">
            Flete:
        </div>

        <div class="col-xs-2 negrilla" style="margin-left: -20px">
            <input type="text" name="flete" id="flete" value="${proceso?.flete ?: 0.00}"
                   class="required number form-control validacionNumero valor"
                   validate="required number"  ${proceso?.estado == 'R' ? 'readonly' : ''}  />
        </div>

        <div class="col-xs-1 negrilla text-info" style="width: 100px">
            Valor Total:
        </div>
        <div class="col-xs-2 negrilla text-info" style="margin-left: -20px">
            <input type="text" name="total" id="total" value="${proceso?.valor ?: 0.00}"
                   class="required number form-control validacionNumero"
                   validate="required number"  readonly style="font-weight: bold" />
        </div>
    </div>

    %{--<g:if test="${tipo == '2'}">--}%
        %{--<div class="row" style="font-size: 12px; margin-top: 20px">--}%
            %{--<div class="col-xs-1 negrilla text-info" style="width: 120px;">--}%
                %{--Documento de retención:--}%
            %{--</div>--}%

            %{--<div class="col-xs-3 negrilla" style="margin-left: -20px; width: 240px;">--}%
                %{--<input type="text" name="retencionVenta" id="retencionVenta" value="${proceso?.retencionVenta}"--}%
                       %{--class="form-control" ${proceso?.estado == 'R' ? 'readonly':''} />--}%
            %{--</div>--}%

        %{--<div class="col-xs-2 negrilla text-info">--}%
            %{--Valor retenido del IVA:--}%
        %{--</div>--}%

        %{--<div class="col-xs-2 negrilla" style="margin-left: -20px">--}%
            %{--<input type="text" name="retenidoIva" id="retenidoIva" value="${proceso?.retenidoIva ?: 0.00}"--}%
                   %{--class="required number form-control validacionNumero valor"--}%
                   %{--validate="required number"  ${proceso?.estado == 'R' ? 'readonly':''} />--}%
        %{--</div>--}%

        %{--<div class="col-xs-2 negrilla text-info">--}%
            %{--Valor retenido del Impuesto a la Renta:--}%
        %{--</div>--}%

        %{--<div class="col-xs-2 negrilla" style="margin-left: 0px">--}%
            %{--<input type="text" name="retenidoRenta" id="retenidoRenta" value="${proceso?.retenidoRenta ?: 0.00}"--}%
                   %{--class="required number form-control validacionNumero valor"--}%
                   %{--validate="required number"  ${proceso?.estado == 'R' ? 'readonly' : ''}  />--}%
        %{--</div>--}%
        %{--</div>--}%
    %{--</g:if>--}%

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
        ev.keyCode == 110 || ev.keyCode == 190 || ev.ctrlKey);
    }

    $(".validacionNumero").keydown(function (ev) {
        return validarNum(ev);
    }).keyup(function () {

    });

    $(".number").blur(function () {
        if (isNaN($(this).val()))
            $(this).val("0.00")
        if ($(this).val() == "")
            $(this).val("0.00")
        calculaIva()
    });

    $("#dcmtAutorizacion").bind('paste', function() {
        $('span').text('paste behaviour detected!')
    });

    function calculaIva() {
        var iva = ${valorIva ?: 0};
        var val = parseFloat($("#iva12").val());
        var ice = parseFloat($("#iceGenerado").val());
        var total = (iva / 100) * (val + ice);
        $("#ivaGenerado").val(number_format(total, 2, ".", ""));
    }

    function calculaTotal() {
        var bsnz = parseFloat($("#iva12").val());
        var bs_0 = parseFloat($("#iva0").val());
        var bsni = parseFloat($("#noIva").val());
        var bsex = parseFloat($("#excentoIva").val());
        var iva = parseFloat($("#ivaGenerado").val());
        var ice = parseFloat($("#iceGenerado").val());
        var flte = parseFloat($("#flete").val());
        var total = bsnz + bs_0 + bsni + bsex + iva + ice + flte;
//        console.log('recalcula IVA...')
        $("#total").val(number_format(total, 2, ".", ""));
    }

//    $("#iva12").keyup(function () {
//        calculaIva();
//    });

    $(".valor").keyup(function () {
        calculaIva();
        calculaTotal();
    });

//    $("#retenidoIva").keyup(function (ev){
//        var ivaG = ($("#ivaGenerado").val()*100)/100
//        var retenido = ($("#retenidoIva").val()*100)/100
//        if(retenido > ivaG){
//            $("#retenidoIva").val( number_format((ivaG ? ivaG : 0),2,".",""))
//        }
//    });
//
//    $("#iva12").change(function () {
//        var ivaG = ($("#ivaGenerado").val()*100)/100
//        $("#retenidoIva").val( number_format((ivaG ? ivaG : 0),2,".",""))
//        colocarBase();
//    });
//
//    $("#retenidoRenta").keyup(function (ev) {
//        var retenidoR = ($("#retenidoRenta").val()*100)/100
//        var totalBases = calcularBases()
//        if(retenidoR > totalBases){
//            $("#retenidoRenta").val( number_format((totalBases ? totalBases : 0),2,".",""))
//        }
//    });

//    function calcularBases () {
//        var totalBases = ($("#iva12").val()*100)/100 + ($("#iva0").val()*100)/100 + ($("#noIva").val()*100)/100 + ($("#excentoIva").val()*100)/100
//        return totalBases
//    }

//    function colocarBase() {
//        var totalBases = calcularBases()
//        $("#retenidoRenta").val( number_format((totalBases ? totalBases : 0),2,".",""))
//    }

//    $("#iva0").change(function () {
//        colocarBase()
//    });
//
//    $("#noIva").change(function () {
//        colocarBase()
//    });
//
//    $("#excentoIva").change(function () {
//        colocarBase()
//    });



</script>