<util:renderHTML html="${msg}"/>

<style type="text/css">
table {
    table-layout: fixed;
    overflow-x: scroll;
}
th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}
</style>

<g:set var="clase" value="${'principal'}"/>

<div class="" style="width: 99.7%;height: ${msg == '' ? 600 : 575}px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" width="1060px">
        <g:each in="${data}" var="dato" status="z">

            <tr id="${dato.prcs__id}" data-id="${dato.prcs__id}" data-ed="${dato.prcsetdo}" class="${clase}">
                <td width="65px">
                    ${dato?.prcsfcha.format("dd-MM-yyyy")}
                </td>

                <td width="240px" style="color:#186063">
                    ${dato?.prcsdscr}
                </td>

                <td width="85px">
                    ${dato.prcsetdo == 'R' ? 'Registrado' : 'No registrado'}
                </td>

                <td width="80px" class="text-info">
                    ${dato.cmprnmro}
                </td>

                <td width="80px" class="text-info">
                    ${dato.tpps}
                </td>

                <td width="170px" class="text-info">
                    ${dato.prve}
                </td>
            </tr>
        </g:each>
    </table>
</div>


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
