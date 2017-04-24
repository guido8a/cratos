<g:if test="${!pagos}">
    <div class="errors" style="padding-left: 10px;">
        No hay pagos registrados.
    </div>
</g:if>
<g:if test="${pagos.size() > 0}">
    <g:set var="totalD" value="${0}"/>
    <g:set var="totalH" value="${0}"/>
    <table class="table table-striped" style="font-size: 12px;width: 95%">
        <thead>
        <tr>
            <th>Fecha</th>
            <th>Documento</th>
            <th>Referencia</th>
            <th>Monto</th>
        </tr>
        </thead>
        <tbody style="border:1px solid black">
        <g:set var="tot" value="${0}"/>
        <g:each var="p" in="${pagos}" status="i">
            <tr>
                <td>${p.fecha.format("dd-MM-yyyy")}</td>
                <g:if test="${p.tipo=='P'}">
                    <td>${p.formaDePago?.tipoPago?.descripcion}</td>
                    <td>${p.referencia}</td>
                    <td style="text-align: right;">
                        <g:formatNumber number="${p.monto}" minFractionDigits="2" maxFractionDigits="2"/>
                    </td>
                    <g:set var="tot" value="${tot.toDouble() + p.monto}"></g:set>
                </g:if>
                <g:else>
                    <td>${(p.tipo=='D')?'Nota de débito':'Nota de crédito'}</td>
                    <td>${p.establecimiento+"-"+p.emision+"-"+p.secuencial}</td>
                    <td style="text-align: right;">
                        <g:formatNumber number="${p.monto+p.impuesto}" minFractionDigits="2" maxFractionDigits="2"/>
                    </td>
                    <g:set var="tot" value="${tot.toDouble() + p.monto+p.impuesto}"></g:set>
                </g:else>
            </tr>
        </g:each>
        <tr>
            <td>TOTAL:</td>
            <td colspan="2"></td>
            <td style="background-color: #d0ffd0;text-align: right">
                <g:formatNumber number="${tot}" minFractionDigits="2" maxFractionDigits="2"/>
            </td>
        </tr>
        </tbody>
    </table>
</g:if>