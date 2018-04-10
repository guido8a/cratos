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

.registrado {
    font-weight: bold;
    color: #df960b;
}
.reg {
    color: #286e9f;
}
.noReg {
    font-weight: bold;
    color: #aa6;
}
</style>

<g:set var="clase" value="${'principal'}"/>

<div class="" style="width: 99.7%;height: ${msg == '' ? 600 : 575}px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" width="1060px">
        <g:each in="${data}" var="dato" status="z">

            <tr id="${dato.prcs__id}" data-id="${dato.prcs__id}" data-ed="${dato.prcsetdo}" data-tipo="${dato?.tpps}"
                data-cm='${cratos.Proceso.get(dato.prcs__id).tipoCmprSustento?.tipoComprobanteSri?.codigo?.trim()}'
                data-dtll='${dato.dtll}' data-rtcn='${dato.rtcn}' data-rtvn='${dato.rtvn}'
                class="${clase}">
                <td width="100px">
                    ${dato?.prcsfcha.format("dd-MM-yyyy")}
                </td>

                <td width="280px" style="color:#186063">
                    ${dato?.prcsdscr}
                </td>

                <td width="40px" class="${dato.prcsetdo == 'R-S' ? 'registrado' : dato.prcsetdo == 'R' ? 'reg' : 'noReg'}">
                    ${dato.prcsetdo}
                </td>

                <td width="160px" class="text-info">
                    ${dato.cmprnmro}
                </td>

                <td width="60px" class="text-info">
                    ${dato.prcs__id}
                </td>

                <td width="80px" class="text-info" style="text-align: right">
                    ${dato.prcsvlor}
                </td>
                <td width="70px" class="text-info" style="text-align: right">
                    ${dato.rtcn}
                </td>
                <td width="80px" class="text-info">
                    ${dato.tpps}
                </td>

                <td width="190px" class="text-info">
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
