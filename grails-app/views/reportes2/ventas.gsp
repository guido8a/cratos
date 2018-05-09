<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 13/10/17
  Time: 10:31
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 12/10/17
  Time: 14:54
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>Ventas</title>

    <rep:estilos orientacion="l" pagTitle="${"Ventas"}"/>

    <style type="text/css">

    html {
        font-family: Verdana, Arial, sans-serif;
        /*font-size: 15px;*/
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

    .tam{
        font-size: 9px;
    }

    </style>

</head>

<body>

<rep:headerFooter title="${'Ventas'}" subtitulo="${'Datos'}" empresa="${empresa}"/>

<h2>
    PERÍODO DEL <g:formatDate date="${desde}" format="dd-MM-yyyy"/>
    AL <g:formatDate date="${hasta}" format="dd-MM-yyyy"/>
</h2>


<div>
    <table border="1">
        <thead>
        <tr>
            <th colspan="3"></th>
            <th class="centro">Cliente</th>
            <th colspan="4"></th>
            <th class="centro" colspan="4">Valor Retención</th>
        </tr>
        <tr style="font-size: 11px; width: 2100px">
            <th align="center" style="width: 40px">N°</th>
            <th align="center" style="width: 70px">Fecha</th>
            <th align="center" style="width: 150px;">N°</th>
            <th align="center" style="width: 320px">Nombre</th>
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

        <g:set var="totales" value="${0}"/>
        <g:set var="totales2" value="${0}"/>
        <g:set var="totalExcento" value="${0}"/>
        <g:set var="totalGravado" value="${0}"/>
        <g:set var="totalIva" value="${0}"/>
        <g:set var="totalIva2" value="${0}"/>
        <g:set var="totalRenta" value="${0}"/>

        <g:each in="${ventas}" var="venta" status="j">
            <tr style="width: 2100px;" class="tam">
                <td style="width: 40px">${j+1}</td>
                <td style="width: 70px"><g:formatDate date="${venta?.fechaIngresoSistema}" format="dd-MM-yyyy"/></td>
                <td class="izquierda" style="width: 150px">${venta?.facturaEstablecimiento + " " + venta?.facturaPuntoEmision + " " + venta?.facturaSecuencial}</td>
                <td class="izquierda tam" style="width: 320px">${venta?.proveedor?.nombre}</td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${venta?.excentoIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${venta?.baseImponibleIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${venta?.ivaGenerado ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${venta?.valor ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="centro tam" style="width: 100px">${venta?.retencionVenta}</td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${venta?.retenidoIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${venta?.retenidoRenta ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${((venta?.retenidoIva?.toDouble() + venta?.retenidoRenta?.toDouble()) ?: 0)}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>

                <g:set var="totales" value="${totales += (venta?.valor ?: 0)}"/>
                <g:set var="totales2" value="${totales2 += ((venta?.retenidoIva?.toDouble() + venta?.retenidoRenta?.toDouble()) ?: 0)}"/>
                <g:set var="totalExcento" value="${totalExcento += (venta?.excentoIva ?: 0)}"/>
                <g:set var="totalGravado" value="${totalGravado += (venta?.baseImponibleIva ?: 0)}"/>
                <g:set var="totalIva" value="${totalIva += (venta?.ivaGenerado ?: 0)}"/>
                <g:set var="totalIva2" value="${totalIva2 += (venta?.retenidoIva ?: 0)}"/>
                <g:set var="totalRenta" value="${totalRenta += (venta?.retenidoRenta ?: 0)}"/>
            </tr>
        </g:each>

        <tr style="width: 100%">
            <td colspan="4" class="derecha" style="background: #bbb"><b>TOTALES:</b></td>
            <td class="derecha"><g:formatNumber number="${totalExcento ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            <td class="derecha"><g:formatNumber number="${totalGravado ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            <td class="derecha"><g:formatNumber number="${totalIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            <td class="derecha"><g:formatNumber number="${totales ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            <td class="derecha" colspan="1" style="background: #bbb"><b>TOTALES:</b></td>
            <td class="derecha"><g:formatNumber number="${totalIva2 ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            <td class="derecha"><g:formatNumber number="${totalRenta ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            <td class="derecha"><g:formatNumber number="${totales2 ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>

        </tbody>
    </table>
</div>

</body>
</html>