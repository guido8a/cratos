<div class="col-xs-5">
<g:textField name="esta" id="numEsta" value="${libreta?.numeroEstablecimiento}" readonly="true"
             style="width: 50px" title="Numeración Establecimento"/> -
<g:textField name="emi" id="numEmi" value="${libreta?.numeroEmision}" readonly="true"
             style="width: 50px" title="Numeración Emisión"/>
</div>
<div class="col-xs-7">
<g:textField name="serie" value="${retencion?.numero}"
             class="serie form-control required validacionNumero numSerie" maxlength="9"
             style="width: 120px"/>
    <p class="help-block ui-helper-hidden"></p>
</div>



