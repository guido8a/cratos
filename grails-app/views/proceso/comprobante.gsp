<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 10/08/17
  Time: 15:21
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Comprobante del Proceso </title>
</head>

<body>

<div class="btn-group" style="margin-right: 20px">
    <a href="#" class="btn btn-warning previous" id="irProceso">
        <i class="fa fa-chevron-left"></i>
        Proceso
    </a>
    <g:link class="btn btn-info" controller="proceso" action="buscarPrcs">
        <i class="fa fa-chevron-left"></i>
        Lista de Procesos
    </g:link>
    <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'C' && proceso?.tipoCmprSustento?.tipoComprobanteSri?.codigo?.trim() == '41'}">
        <a href="#" class="btn btn-success" id="reembolsoN">
            <i class="fa fa-thumbs-up"></i>
            Reembolso
        </a>
    </g:if>
    <g:if test="${proceso?.tipoProceso?.id == 1}">
        <g:link class="btn btn-success" action="detalleSri" id="${proceso?.id}" style="margin-bottom: 10px;">
            <i class="fa fa-money"></i> Retenciones
        </g:link>
    </g:if>
</div>



<g:if test="${proceso}">
    <div class="vertical-container" skip="1" style="margin-top: 5px; color:black; margin-bottom:20px; height:700px; max-height: 720px; overflow: auto;">
        <p class="css-vertical-text">Comprobante</p>

        <div class="linea"></div>

        <div id="divComprobanteP" class="col-xs-12"style="margin-bottom: 0px ;padding: 0px;margin-top: 5px; height: 650px">
        </div>
    </div>
</g:if>




<script type="text/javascript">

    cargarComprobanteP('${proceso?.id}');

    function cargarComprobanteP(proceso) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso',action: 'comprobante_ajax')}",
            data: {
                proceso: proceso
            },
            success: function (msg) {
                $("#divComprobanteP").html(msg);
            }
        });
    }

    $("#irProceso").click(function () {
        location.href='${createLink(controller: 'proceso', action: 'nuevoProceso')}/?id=' + '${proceso?.id}'
    });

    $("#reembolsoN").click(function () {
        location.href="${createLink(controller: 'proceso', action: 'reembolso')}/?proceso=" + '${proceso?.id}'
    });

</script>

</body>
</html>