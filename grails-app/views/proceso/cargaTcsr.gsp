<div class="col-md-2 negrilla">
    Tipo de comprobante:
</div>

<div class="col-md-8 negrilla">
    <g:select class="form-control cmbRequired" name="tipoComprobanteSri.id" id="tipoComprobante"
              from="${data}"
              optionKey="id" title="Tipo de comprobante" optionValue="${{it.codigo  + ' - ' + it.descripcion}}"
              noSelection="${['-1': 'Seleccione...']}" value="${tpcpSri}"/>
</div>

<div class="col-md-2 " style="font-size: 10px">
    Necesario para el ATS
</div>