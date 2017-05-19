<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 19/05/17
  Time: 14:41
--%>

%{--<g:if test="${proceso?.tipoProceso == 'P'}">--}%
<g:if test="${tipo == 'P'}">
    <div class="row" style="font-size: 12px">
        <div class="col-xs-2 negrilla" style="width: 120px">
            Valor:
        </div>
        <div class="col-xs-2 negrilla">
            <g:textField name="valorPago_name" class="form-control required number" value="${proceso?.valor}"/>
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
<g:else>
    <g:set var="iva" value="${cratos.ParametrosAuxiliares.list().first().iva}"/>
    <div class="row" style="font-size: 12px">
        <div class="col-xs-2 negrilla" style="width: 120px">
            Base imponible IVA ${iva}%:
        </div>
        <div class="col-xs-2 negrilla">
            <input type="text" name="baseImponibleIva" id="iva12" size="7" value="${proceso?.baseImponibleIva ?: 0.00}" class="required  number form-control" validate="required number" ${proceso?.estado == 'R' ?'disabled':''} />
        </div>
        <div class="col-xs-2 negrilla" style="width: 120px">
            Base imponible IVA 0%:
        </div>
        <div class="col-xs-2 negrilla">
            <input type="text" name="baseImponibleIva0" size="7" id="iva0" value="${proceso?.baseImponibleIva0 ?: 0.00}" class="required number form-control" validate="required number" ${proceso?.estado == 'R' ?'disabled':''} />
        </div>
        <div class="col-xs-2 negrilla" style="width: 120px">
            Base imponible no aplica IVA:
        </div>
        <div class="col-xs-2 negrilla">
            <input type="text" name="baseImponibleNoIva" id="noIva" size="7" value="${proceso?.baseImponibleNoIva ?: 0.00}" class="required number form-control" validate="required number" ${proceso?.estado == 'R' ?'disabled':''} />
        </div>
    </div>
    <div class="row" style="font-size: 12px">
        <div class="col-xs-2 negrilla" style="width: 120px">
            IVA generado:
        </div>
        <div class="col-xs-2 negrilla">
            <input type="text" name="ivaGenerado" id="ivaGenerado"  value="${proceso?.ivaGenerado}" class="required number form-control" validate="required number" ${proceso?.estado == 'R' ?'disabled':''} />
        </div>
        <div class="col-xs-2 negrilla" style="width: 120px">
            ICE generado:
        </div>
        <div class="col-xs-2 negrilla"  >
            <input type="text" name="iceGenerado"  id="iceGenerado" value="${proceso?.iceGenerado ?: 0.00}" class="required number form-control" validate="required number" ${proceso?.estado == 'R' ?'disabled':''} />
        </div>
    </div>
    <div class="row" style="font-size: 12px">
        %{--<div class="col-xs-2 negrilla" style="width: 120px">--}%
            %{--Documento:--}%
        %{--</div>--}%
        %{--<div class="col-xs-3 negrilla">--}%
            %{--<input type="text" name="facturaEstablecimiento" id="establecimiento" size="3" maxlength="3" value="${proceso?.facturaEstablecimiento}" class=" digits form-control label-shared " validate=" number"--}%
                   %{--title="El número de establecimiento del documento " ${registro?'disabled':''} />--}%
            %{--<input type="text" name="facturaPuntoEmision" id="emision" size="3" maxlength="3" value="${proceso?.facturaPuntoEmision}" class=" digits form-control label-shared " validate=" number"--}%
                   %{--title="El número de punto de emisión del documento" ${registro?'disabled':''} />--}%
            %{--<input type="text" name="facturaSecuencial" id="secuencial" size="10" maxlength="9" value="${proceso?.facturaSecuencial}" class=" digits form-control label-shared  " validate=" number"--}%
                   %{--title="El número de secuencia del documento"  ${registro?'disabled':''} />--}%
        %{--</div>--}%
        %{--<div class="col-xs-2 negrilla" style="width: 120px;margin-left: -30px">--}%
            %{--Autorización:--}%
        %{--</div>--}%
        %{--<div class="col-xs-2 negrilla">--}%
            %{--<input type="text" name="facturaAutorizacion" id="auto" size="10" maxlength="15" value="${proceso?.facturaAutorizacion}" class=" digits form-control label-shared " validate=" number"--}%
                   %{--title="El número autorización de la factura a registrar " ${registro?'disabled':''} />--}%
        %{--</div>--}%
    </div>


</g:else>
