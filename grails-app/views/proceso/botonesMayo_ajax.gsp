<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 29/05/17
  Time: 10:43
--%>


<div class="btn-toolbar toolbar">
    <div class="btn-group-sm">
        <g:if test="${comprobante.registrado != 'S'}">
            <a href="#" class="btn btnMayorizar btn-success btn-" id="reg_${comprobante?.id}" idComp="${comprobante?.id}" style="margin-bottom: 10px;">
                <i class="fa fa-pencil-square-o"></i>
                Mayorizar
            </a>
        </g:if>
        <g:else>
            <g:if test="${!auxiliares}">
                <a href="#" class="btn btn-danger" id="desmayo" idComp="${comprobante?.id}" style="margin-bottom: 10px;">
                    <i class="fa fa-pencil-square-o "></i>
                    Desmayorizar
                </a>
            </g:if>
            <a href="#" class="btn btn-default" id="imprimir" iden="${comprobante?.proceso?.id}" nombre="${comprobante.prefijo + comprobante.numero}" style="margin-bottom: 10px;">
                <i class="fa fa-print"></i>
                Imprimir
            </a>
        </g:else>
        <g:if test="${cratos.Retencion.countByProceso(comprobante?.proceso) > 0}">
            <g:link class="btn btn-default" action="detalleSri" id="${comprobante?.proceso?.id}">
                SRI
            </g:link>
            <g:if test="${cratos.Retencion.findByProceso(comprobante?.proceso).numeroSecuencial}">
                <g:link controller="reportes3" action="imprimirRetencion" class="btn btn-default btnRetencion" id="${comprobante?.proceso?.id}" params="[empresa: session.empresa.id]">
                    <i class="fa fa-print"></i>
                    Imprimir retención
                </g:link>
            </g:if>
        </g:if>
        %{--<g:set var="activo" value="${false}"/>--}%
        %{--<g:each var="asiento" in="${asientos}" status="i">--}%
            %{--<g:if test="${asiento.cuenta.resultado == 'A'}">--}%
                %{--<g:set var="activo" value="${true}"/>--}%
            %{--</g:if>--}%
        %{--</g:each>--}%

        %{--<g:if test="${activo}">--}%
            %{--<g:link controller="activoFijo" action="list" params="['proceso.id': comprobante?.proceso?.id]" class="btn btn-info">--}%
                %{--<i class="fa fa-desktop"></i>--}%
                %{--Registrar activos fijos--}%
            %{--</g:link>--}%
        %{--</g:if>--}%

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
        var url = "${g.createLink(controller: 'reportes',action: 'comprobante')}/" + $(this).attr("iden");
        location.href = "${g.createLink(controller: 'pdf',action: 'pdfLink')}?url=" + url + "&filename=" + $(this).attr("nombre") + ".pdf"
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
                                cargarComprobante ('${comprobante?.proceso?.id}');
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
        bootbox.confirm("<i class='fa fa-exclamation-circle fa-3x pull-left text-danger text-shadow'></i> Esta seguro de mayorizar este comprobante? Esta acción modificará los saldos", function (result) {
            if (result) {
                openLoader("Mayorizando...");
                $.ajax({
                    type    : "POST",
                    %{--url     : "${g.createLink(controller: 'proceso',action: 'registrarComprobante')}",--}%
                    url     : "${createLink(controller: 'proceso',action: 'mayorizar_ajax')}",
                    data    : "id=" + id,
                    success : function (msg) {
                        var parts = msg.split("_");
                        if(parts[0] == 'ok'){
                            closeLoader();
                            log(parts[1],'success');
                            setTimeout(function () {
                                cargarComprobante ('${comprobante?.proceso?.id}');
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