<div class="col-xs-2 negrilla">
    Libretín de ${tipo}:
</div>

<div class="col-xs-5">

    <g:select name="libretin" from="${libretin}" value="${proceso?.documentoEmpresa?.id}"
              class="form-control" optionKey="id" libre="1" disabled="${proceso?.estado == 'R' ? true : false}"
              optionValue="${{"Desde: " + it?.numeroDesde + ' - Hasta: ' + it?.numeroHasta + " - Autorización: " +
                      it?.fechaAutorizacion?.format("dd-MM-yyyy")}}"/>
    <g:hiddenField name="libretinName" id="idLibre" value=""/>
</div>
<div class="col-xs-5">
    %{--<g:textField name="numEstablecimiento" id="numEstablecimiento" readonly="true"  style="width: 50px"--}%
                 %{--title="Número de Establecimento" value="${proceso?.facturaEstablecimiento ? (proceso?.facturaEstablecimiento?.length() >= 3 ?  proceso?.facturaEstablecimiento :  (proceso?.facturaEstablecimiento?.length() == 2 ? "0" + proceso?.facturaEstablecimiento : "00" + proceso?.facturaEstablecimiento)) : (String.valueOf(estb).length() >= 3 ? estb : (String.valueOf(estb).length() == 2 ? "0" + estb : "00" + estb ))}"/> ---}%

    <g:textField name="numEstablecimiento" id="numEstablecimiento" readonly="true"  style="width: 50px"
                 title="Número de Establecimento" value="${proceso?.facturaEstablecimiento ?: estb}"/> -

    <g:textField name="numeroEmision" id="numEmision" readonly="true" style="width: 50px"
                 title="Numeración Emisión" value="${proceso?.facturaPuntoEmision?:emsn}"/>

    <g:textField name="serie" id="serie" value="${proceso?.facturaSecuencial?:nmro}" maxlength="9"
                 class="form-control required validacionNumeroSinPuntos" readonly="${proceso?.estado == 'R' ? true : false}"
                 style="width: 120px; display: inline"/>
    <p class="help-block ui-helper-hidden" id="error_serie"></p>
</div>



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


    $("#libretin").change(function () {
//        console.log('libretin..')
        var idLibretin = $("#libretin option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'numeracion_ajax')}',
            data: {
                libretin: idLibretin,
                tpps: $(".tipoProcesoSel option:selected").val()
            },
            success: function (msg) {
                var partes = msg.split('_');
//                $("#libretin_id").val(idLibretin)
                $("#numEstablecimiento").val(partes[0])
                $("#numEmision").val(partes[1])
                $("#serie").val(partes[2])
            }
        })
    });

    $("#serie").change(function () {
//        console.log('serie--libretin..')
        var idLibretin = $("#libretin option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'validaSerie_ajax')}',
            data: {
                serie: $(this).val(),
                fcdt: idLibretin,
                id  : "${proceso?.id}"
            },
            success: function (msg) {
                var partes = msg.split('_');
                if(partes[0] == 'no') {
                    $("#serie").addClass("error");
                    $("#error_serie").html(partes[1]);
                    $("#error_serie").show();
                } else {
                    $("#serie").removeClass("error");
                    $("#error_serie").hide();
                }
            }
        })
    });

</script>
