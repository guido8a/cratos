<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 22/06/17
  Time: 13:04
--%>

<style type="text/css">

.bien{
    border-color: transparent;
}

.mal{
    border-color: #ff0f24;
}
.igual{
    border-color: #2fd152;
}


</style>


<g:textField class="form-control number ${total > base ? 'mal' : (total == base ? 'igual' : 'bien')}" title="Total Base Imponible" name="totalBase_name" id="totalBase" readonly="true" value="${g.formatNumber(number: total, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2)}"
             style="text-align: right;"/>


