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
            <th colspan="5"></th>
            <th class="centro" colspan="2">Valor Retención</th>
            <th></th>
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
        <g:each in="${ventas}" var="venta" status="j">
            <tr style="width: 2100px">
                <td style="width: 40px">${j+1}</td>
                <td style="width: 70px"><g:formatDate date="${venta?.fechaIngresoSistema}" format="dd-MM-yyyy"/></td>
                <td class="centro" style="width: 150px">${venta?.facturaEstablecimiento + " " + venta?.facturaPuntoEmision + " " + venta?.facturaSecuencial}</td>
                <td class="centro" style="width: 320px">${venta?.proveedor?.nombre}</td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${venta?.excentoIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${venta?.baseImponibleIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${venta?.ivaGenerado ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${venta?.valor ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px">${venta?.retencionVenta}</td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${venta?.retenidoIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${venta?.retenidoRenta ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${((venta?.retenidoIva?.toDouble() + venta?.retenidoRenta?.toDouble()) ?: 0)}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

</body>
</html>