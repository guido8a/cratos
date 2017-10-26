<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 29/05/17
  Time: 10:43
--%>

<div class="btn-toolbar toolbar">
    <div class="btn-group-sm">
        <g:if test="${comprobante.registrado != 'S'}">
            <g:if test="${band}">
                <a href="#" class="btn btnMayorizar btn-success" id="reg_${comprobante?.id}" idComp="${comprobante?.id}" style="margin-bottom: 10px;">
                    <i class="fa fa-pencil-square-o"></i>
                    Mayorizar
                </a>
            </g:if>
        </g:if>
        <g:else>
            <a href="#" class="btn btn-danger" id="desmayo" idComp="${comprobante?.id}" style="margin-bottom: 10px;">
                <i class="fa fa-pencil-square-o "></i>
                Desmayorizar
            </a>
            <a href="#" class="btn btn-info" id="imprimir" iden="${comprobante?.proceso?.id}" nombre="${comprobante.prefijo + comprobante.numero}" style="margin-bottom: 10px;">
                <i class="fa fa-print"></i>
                Imprimir
            </a>
        </g:else>
    </div>
</div>

<script type="text/javascript">

    $(".btnRetencion").click(function () {
        var file = "retencion.pdf";
        var url = $(this).attr("href");
        var actionUrl = "${createLink(controller:'pdf',action:'pdfLink')}?filename=" + file + "&url=" + url;
        location.href = actionUrl;
        return false;
    });

    $("#imprimir").click(function () {
        %{--var url--}%

        %{--<g:if test="${comprobante?.proceso?.tipoProceso?.codigo?.trim() in ['P','I']}">--}%
        %{--url = "${g.createLink(controller: 'reportes',action: 'comprobante2')}/" + $(this).attr("iden");--}%
        %{--</g:if>--}%
        %{--<g:else>--}%
         %{--url = "${g.createLink(controller: 'reportes',action: 'comprobante')}/" + $(this).attr("iden");--}%
        %{--</g:else>--}%
        %{--location.href = "${g.createLink(controller: 'pdf',action: 'pdfLink')}?url=" + url + "&filename=" + $(this).attr("nombre") + ".pdf"--}%

        var url = "${g.createLink(controller: 'reportes3', action: 'imprimirCompDiario')}?id=" + '${comprobante?.proceso?.id}' + "Wempresa=${session.empresa.id}";
        location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=comprobante.pdf";
    });

    $("#desmayo").click(function () {
        var id = $(this).attr("idComp");
        bootbox.confirm("<i class='fa fa-exclamation-circle fa-3x pull-left text-danger text-shadow'></i> Esta seguro de desmayorizar este comprobante? Esta acción modificará los saldos", function (result) {
            if (result) {
                openLoader("Desmayorizando...");
                $.ajax({
                    type    : "POST",
                    %{--url     : "${g.createLink(controller: 'proceso',action: 'desmayorizar')}",--}%
                    url     : "${createLink(controller: 'proceso',action: 'desmayorizar_ajax')}",
                    data    : "id=" + id,
                    success : function (msg) {
                        var parts = msg.split("_");
                        if(parts[0] == 'ok'){
                            log(parts[1],"success");
                            closeLoader();
                            setTimeout(function () {
                                location.href="${createLink(controller: 'proceso', action: 'comprobante')}?proceso=" + '${comprobante?.proceso?.id}'
                                cargarComprobanteP('${comprobante?.proceso?.id}');
                                cargarAsiento('${comprobante?.id}');
                                cargarBotones('${comprobante?.id}');
                            }, 800);

                        }else{
                            closeLoader();
                            log(parts[1],'error');
                        }
                    }
                });
            }
        });
    });

    $(".btnMayorizar").click(function () {
        var id = $(this).attr("idComp");
        bootbox.confirm("<i class='fa fa-exclamation-circle fa-3x pull-left text-danger text-shadow'>" +
                "</i> Esta seguro de mayorizar este comprobante? Esta acción modificará los saldos", function (result) {
            if (result) {
                openLoader("Mayorizando...");
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller: 'proceso',action: 'mayorizar_ajax')}",
                    data    : "id=" + id,
                    success : function (msg) {
                        var parts = msg.split("_");
                        if(parts[0] == 'ok'){
                            closeLoader();
                            log(parts[1],'success');
                            setTimeout(function () {
                                location.href="${createLink(controller: 'proceso', action: 'comprobante')}?proceso=" + '${comprobante?.proceso?.id}';
                                cargarComprobanteP('${comprobante?.proceso?.id}');
                                cargarAsiento('${comprobante?.id}');
                                cargarBotones('${comprobante?.id}');
                            }, 800);

                        }else{
                            closeLoader();
                            log(parts[1],'error');
                        }
                    }
                });
            }
        })
    });

</script>