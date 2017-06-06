<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 05/06/17
  Time: 10:51
--%>

<div class="col-md-5">
    <g:textField class="form-control" title="El porcentaje de rentención del IR" name="porcentajeIR" value="${concepto?.porcentaje}" readonly="true" style="text-align: right"/>
</div>

<div class="col-md-7">
    <g:textField class="form-control" title="el valor retenido del IR" name="valorRetenido" value="${g.formatNumber(number: retenido, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2)}" readonly="true" style="text-align: right"/>
</div>
