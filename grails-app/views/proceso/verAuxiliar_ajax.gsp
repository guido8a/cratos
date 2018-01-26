<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 26/10/17
  Time: 10:43
--%>

%{--<div class="row">--}%
%{--<div class="col-md-2">--}%
%{--<label>Cuenta:</label>--}%
%{--</div>--}%
%{--<div class="col-md-3">--}%
%{--<input type="text" name="codigoAsiento_name" id="codigoAsiento" value="${asiento?.cuenta?.numero}" readonly--}%
%{--style="width: 100px"/>--}%
%{--</div>--}%
%{--<div class="col-md-5" style="margin-left: -45px">--}%
%{--<input type="text" name="nombreAsiento_name" id="nombreAsiento" class="" value="${asiento?.cuenta?.descripcion}"--}%
%{--readonly style="width: 350px" title="${asiento?.cuenta?.descripcion}"/>--}%
%{--</div>--}%

%{--</div>--}%
<div class="row">
    <div class="col-md-2">
        <label>Descripción:</label>
    </div>
    <div class="col-md-6">
        ${auxiliar?.descripcion}
    </div>
</div>
<div class="row">
    <div class="col-md-2">
        <label>Proveedor:</label>
    </div>
    <div class="col-md-6">
        ${auxiliar?.proveedor?.nombre}
    </div>
</div>

<div class="row">
    <div class="col-md-2">
        <label>Factura: </label>
    </div>
    <div class="col-md-10">
        ${auxiliar?.afecta?.asiento?.comprobante?.descripcion} <strong>Documento:</strong> ${auxiliar?.afecta?.factura ?: ''}
    </div>
</div>


<div class="row">
    <div class="col-md-3">
        <label>Forma de Pago:</label>
    </div>
    <div class="col-md-4">
       ${auxiliar?.tipoDocumentoPago?.descripcion}
    </div>
</div>

<div class="row">
    <div class="col-md-3">
        <label>Fecha de Pago:</label>
    </div>
    <div class="col-md-4">
        <g:formatDate date="${auxiliar?.fechaPago}" format="dd-MM-yyyy"/>
    </div>
</div>

<g:if test="${comprobante?.proceso?.tipoProceso?.codigo?.trim() in ['C']}">
    <div class="row">
        <div class="col-md-5">
            <label>Documento por pagar:</label>
        </div>
        <div class="col-md-6">
            <g:textField name="factura" id="factura" class="form-control" value="${auxiliar?.factura ?: ''}"/>
        </div>
    </div>
</g:if>

<g:if test="${comprobante?.proceso?.tipoProceso?.codigo?.trim() in ['P', 'I']}">
    <div class="row">
        <div class="col-md-5">
            <label>Documento con que se paga:</label>
        </div>
        <div class="col-md-6">
            ${auxiliar?.documento ?: ''}
        </div>
    </div>
</g:if>

<div class="row">
    <div class="col-md-2">
        <label>Valor:</label>
    </div>
    <div class="col-md-10">
        <div class="col-md-2">Debe (CxC)</div>
        <div class="col-md-4">
            <g:formatNumber number="${auxiliar ? auxiliar?.debe : 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/>
        </div>
        <div class="col-md-2">Haber (CxP)</div>
        <div class="col-md-4">
            <g:formatNumber number="${auxiliar ? auxiliar?.haber : 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/>
        </div>
    </div>
</div>


