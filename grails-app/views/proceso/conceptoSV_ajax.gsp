<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 06/06/17
  Time: 12:03
--%>

<div class="col-md-3">
    <g:textField class="form-control" title="El porcentaje de rentención del IR en SERVICIOS" name="porcentajeIRSV" value="${concepto?.porcentaje}" readonly="true" style="text-align: right"/>
</div>

<div class="col-md-7">
    <g:textField class="form-control" title="el valor retenido del IR en SERVICIOS" name="valorRetenidoSV" value="${g.formatNumber(number: retenido, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2)}" readonly="true" style="text-align: right"/>
</div>
