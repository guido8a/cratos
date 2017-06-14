<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 07/06/17
  Time: 11:16
--%>

<g:textField class=" form-control number" title="El valor retenido del ICE." name="valorRetenidoICE" readonly="true" value="${g.formatNumber(number: valor, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2)}" style="text-align: right"/>
