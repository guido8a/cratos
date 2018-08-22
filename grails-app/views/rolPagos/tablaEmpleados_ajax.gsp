<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 20/08/18
  Time: 15:04
--%>

<table class="table table-bordered table-hover table-condensed" style="margin-top: 1px">
    <tbody>
    <g:each in="${detalles.empleado.unique()}" status="i" var="detalle">
        <g:set var="totIng" value="${0}"/>
        <g:set var="totDes" value="${0}"/>
        <tr data-id="${detalle.id}" data-rol="${rolPagos?.id}">
            <td class="izquierda" style="width: 55%">${detalle?.persona?.nombre + " " + detalle?.persona?.apellido}</td>
            <g:each in="${ingresos}" var="ing">
                <g:if test="${ing.key == detalle}">
                    <td class="centrado" style="width: 15%">
                        <g:formatNumber number="${ing.value}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/>
                        <g:set var="totIng" value="${ing.value}"/>
                    </td>
                </g:if>
            </g:each>
            <g:each in="${descuentos}" var="des">
                <g:if test="${des.key == detalle}">
                    <td class="centrado" style="width: 15%">
                        <g:formatNumber number="${des.value}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/>
                        <g:set var="totDes" value="${des.value}"/>
                    </td>
                </g:if>
            </g:each>
            <td class="centrado" style="width: 15%">
                <g:formatNumber number="${(totIng + totDes) ?: 0}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $(function () {
        $("tr").contextMenu({
            items  : createContextMenu,
            onShow : function ($element) {
                $element.addClass("trHighlight");
            },
            onHide : function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });
    });


</script>

