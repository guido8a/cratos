<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 21/08/18
  Time: 11:47
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 20/08/18
  Time: 15:04
--%>

<table class="table table-bordered table-hover table-condensed" style="margin-top: 1px">
    <tbody>
    <g:each in="${detalles}" status="i" var="detalle">
        <tr data-id="${detalle.id}">
            <td style="width: 50%">${detalle?.empleado?.persona?.nombre + " " + detalle?.empleado?.persona?.apellido}</td>
            %{--<td class="centrado" style="width: 25%">${detalle?.rubroTipoContrato?.descripcion}</td>--}%
            <td class="centrado" style="width: 25%">${detalle?.valor}</td>
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
