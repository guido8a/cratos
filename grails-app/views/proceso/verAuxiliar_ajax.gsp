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
    <div class="col-md-3">
        ${auxiliar?.descripcion}
    </div>
</div>
<div class="row">
    <div class="col-md-2">
        <label>Proveedor:</label>
    </div>
    <div class="col-md-3">
        ${auxiliar?.proveedor?.nombre}
    </div>
</div>

<div class="row">
    <div class="col-md-2">
        <label>Factura: </label>
    </div>
    <div class="col-md-10">
        ${auxiliar?.factura}
    </div>
</div>


<div class="row">
    <div class="col-md-2">
        <label>Forma de Pago:</label>
    </div>
    <div class="col-md-4">
       ${auxiliar?.tipoDocumentoPago?.descripcion}
    </div>

    <div class="col-md-2">
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
            <g:textField name="referencia_name" id="referencia" class="form-control" value="${auxiliar?.documento ?: ''}"/>
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
            <g:textField type="number" name="valorAuxiliarP_name" id="valorPagar"
                         class="validacionNumero form-control valorP required" placeholder="${auxiliar ? auxiliar?.debe : 0}"
                         style="width: 120px;" value="${auxiliar ? auxiliar?.debe : 0}" />
            %{--<g:fo--}%
        </div>
        <div class="col-md-2">Haber (CxP)</div>
        <div class="col-md-4">
            <g:textField type="number" name="valorAuxiliarC_name" id="valorCobrar"
                         placeholder="${auxiliar ? auxiliar?.haber : 0}"
                         class="validacionNumero form-control valorC required" style="width: 120px;"
                         value="${auxiliar ? auxiliar?.haber : 0}" />
        </div>
    </div>
</div>


