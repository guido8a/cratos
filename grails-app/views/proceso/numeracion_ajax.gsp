<div class="col-xs-2 negrilla">
    Libretín de Facturas:
</div>

<div class="col-xs-5">
    <g:select name="libretin" from="${libretin}" value="${retencion?.documentoEmpresa}"
              class="form-control" optionKey="id" libre="1"
              optionValue="${{"Desde: " + it?.numeroDesde + ' - Hasta: ' + it?.numeroHasta + " - Autorización: " +
                      it?.fechaAutorizacion?.format("dd-MM-yyyy")}}"/>
    <g:hiddenField name="libretinName" id="idLibre" value=""/>
</div>
<div class="col-xs-5">
    <g:textField name="numEstablecimiento" id="numEstablecimiento" readonly="true"  style="width: 50px"
                 title="Número de Establecimento" value="${proceso?.facturaEstablecimiento?:estb}"/> -
    <g:textField name="numeroEmision" id="numEmision" readonly="true" style="width: 50px"
                 title="Numeración Emisión" value="${proceso?.facturaPuntoEmision?:emsn}"/>

    <g:textField name="serie" id="serie" value="${proceso?.facturaSecuencial?:nmro}" maxlength="9"
                 class="form-control required validacionNumero"
                 style="width: 120px; display: inline"/>

</div>
<p class="help-block ui-helper-hidden"></p>


<script type="text/javascript">
    $("#libretin").change(function () {
        console.log('libretin..')
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
                $("#numEstablecimiento").val(partes[0])
                $("#numEmision").val(partes[1])
                $("#serie").val(partes[2])
            }
        })
    });

</script>
