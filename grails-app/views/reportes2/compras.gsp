<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 12/10/17
  Time: 14:54
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>Compras</title>

    <rep:estilos orientacion="l" pagTitle="${"Compras"}"/>

    <style type="text/css">

    html {
        font-family: Verdana, Arial, sans-serif;
        font-size: 15px;
    }

    .hoja {
        width: 25cm;

    }

    h1, h2, h3 {
        text-align: center;
    }

    table {
        border-collapse: collapse;
        width: 100%;
    }

    th, td {
        vertical-align: middle;
    }

    th {
        background: #bbb;
    }

    .derecha{
        text-align: right;
    }

    .centro{
        text-align: center;
    }

    </style>

</head>

<body>

<rep:headerFooter title="${'Compras - ' + tipo}" subtitulo="${'Datos'}" empresa="${empresa}"/>

<h2>
    PERÍODO DEL <g:formatDate date="${desde}" format="dd-MM-yyyy"/>
    AL <g:formatDate date="${hasta}" format="dd-MM-yyyy"/>
</h2>


<div>
    <table border="1">
        <thead>
        %{--<tr>--}%
            %{--<th colspan="3"></th>--}%
            %{--<th class="centro">Proveedor</th>--}%
            %{--<th colspan="5"></th>--}%
            %{--<th class="centro" colspan="4">Valor Retención</th>--}%

        %{--</tr>--}%
        <tr style="font-size: 11px; width: 2100px">
            <th align="center" style="width: 80px">N°</th>
            <th align="center" style="width: 80px">Fecha</th>
            <th align="center" style="width: 100px;">N°</th>
            <th align="center" style="width: 320px">Proveedor</th>
            <th align="center" style="width: 100px;">Documento</th>
            <th align="center" style="width: 100px">Excento</th>
            <th align="center" style="width: 100px">Gravado</th>
            <th align="center" style="width: 100px">IVA</th>
            <th align="center" style="width: 100px">Total</th>
            <th align="center" style="width: 100px">N°Retención</th>
            <th align="center" style="width: 100px">IVA</th>
            <th align="center" style="width: 100px">RENTA</th>
            <th align="center" style="width: 100px">Total</th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${procesos}" var="proceso" status="j">
            <g:set var="retencion" value="${cratos.Retencion.findByProceso(proceso)}"/>
            <tr style="width: 2100px">
                <td style="width: 80px">${j+1}</td>
                <td style="width: 100px"><g:formatDate date="${proceso?.fechaIngresoSistema}" format="dd-MM-yyyy"/></td>
                <td class="centro" style="width: 100px">${cratos.Comprobante.findByProceso(proceso)?.numero}</td>
                <td class="centro" style="width: 300px">${proceso?.proveedor?.nombre}</td>
                <td class="derecha" style="width: 100px">${proceso?.documento}</td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${proceso?.excentoIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${proceso?.baseImponibleIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${proceso?.ivaGenerado ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${proceso?.valor ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px">${retencion?.numeroComprobante}</td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${( (retencion?.ivaBienes?.toDouble() ?: 0) + (retencion?.ivaServicios?.toDouble() ?: 0)) ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${( (retencion?.renta?.toDouble() ?: 0) + (retencion?.rentaServicios?.toDouble() ?: 0)) ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${( (retencion?.ivaBienes?.toDouble() ?: 0) + (retencion?.ivaServicios?.toDouble() ?: 0) ?: 0) + ((retencion?.renta?.toDouble() ?: 0) + (retencion?.rentaServicios?.toDouble() ?: 0) ?: 0)}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

</body>
</html>