<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main"/>
    <title>Comprobante ${comp.prefijo+comp.numero} ${(comp.registrado=="B")?" Anulado":""}</title>
    <style type="text/css">
    .etiqueta {
        width       : 100px;
        height      : 20px;
        line-height : 20px;
        font-weight : bold;
        display     : inline-block;
    }
    </style>
</head>
<body>
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <a href="${g.createLink(action: 'procesosAnulados')}" id="regresar"  class="btn btn-default">Regresar</a>
        <a href="#" class="btn btn-azul" id="imprimir" iden="${comp?.proceso?.id}" nombre="${comp.prefijo + comp.numero}" style="margin-bottom: 10px;">
            <i class="fa fa-print"></i>
            Imprimir
        </a>
    </div>
</div>
<fieldset style="width: 800px;float: left" class="ui-corner-all">
    <legend>Comprobante ${(comp.registrado=="B")?" Anulado":""}</legend>
    <div class="etiqueta">Número:</div> ${comp?.prefijo}${comp?.numero}<br>

    <div class="etiqueta">Descripción:</div> ${comp?.descripcion}     <br>

    <div class="etiqueta">Fecha:</div> ${comp?.fecha?.format('dd/MM/yyyy')}<br>
    <div class="etiqueta">Estado:</div><span style="color: red">${(comp.registrado=="B")?" Anulado":""}${(comp.registrado=="R")?" Mayorizado":""}${(comp.registrado!="R" && comp.registrado!="B" )?" No mayorizado":""}</span> <br>

    <table border="1"  class="table " style="width: 600px;margin-top: 10px;border:1px solid black;padding:5px">

        <tr>
            <th style="width: 140px" align="center">
                Número
            </th>
            <th style="width: 360px" align="center" >
                Cuenta
            </th>
            <th style="width: 60px" align="center" >
                Debe
            </th>
            <th style="width: 60px" align="center" >
                Haber
            </th>

        </tr>
        <g:set var="totalDebe"  value="${0}"/>
        <g:set var="totalHaber" value="${0}"/>

        <g:each in="${asientos}" var="asnt" status="j" >

            <tr>
                <td>
                    ${asnt.cuenta.numero}
                </td>
                <td>
                    ${asnt.cuenta.descripcion}
                </td>
                <td style="text-align: right">
                    ${asnt.debe}
                </td>
                <td style="text-align: right">
                    ${asnt.haber}
                </td>
                <g:set var="totalDebe" value="${totalDebe + asnt.debe}"/>
                <g:set var="totalHaber" value="${totalHaber +asnt.haber}"/>
            </tr>

        </g:each>

        <tr>
            <td>

            </td>

            <td align="center">
                TOTAL:

            </td>

            <td style="text-align: right">
                ${totalHaber.toDouble().round(2)}
            </td>
            <td style="text-align: right">
                ${totalDebe.toDouble().round(2)}
            </td>
        </tr>

    </table>
</fieldset>

<script type="text/javascript">
    $("#imprimir").click(function () {

        var url = "${g.createLink(controller: 'reportes',action: 'comprobante')}/" + $(this).attr("iden")
        location.href = "${g.createLink(controller: 'pdf',action: 'pdfLink')}?url=" + url + "&filename=" + $(this).attr("nombre") + ".pdf"

    });
</script>
</body>
</html>