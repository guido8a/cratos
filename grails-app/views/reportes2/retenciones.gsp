<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 10/10/17
  Time: 15:09
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 01/09/17
  Time: 12:11
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>Retenciones</title>

    <rep:estilos orientacion="p" pagTitle="${"Retenciones"}"/>

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

<rep:headerFooter title="${'Retenciones'}" subtitulo="${'Datos'}" empresa="${empresa}"/>

<h2>
    PERÍODO DEL <g:formatDate date="${desde}" format="dd-MM-yyyy"/>

    AL <g:formatDate date="${hasta}" format="dd-MM-yyyy"/>
</h2>


<div>

    <table border="1">

        <thead>
        <tr style="font-size: 11px; width: 810px">
            <th align="center" style="width: 60px">Fecha</th>
            <th align="center" style="width: 200px;">Retención</th>
            <th align="center" style="width: 120px">Documento</th>
            <th align="center" style="width: 330px">Beneficiario</th>
            <th align="center" style="width: 100px">Valor</th>
        </tr>
        </thead>

        <tbody>

        %{--<g:set var="totalDebe" value="${0.0}"/>--}%
        %{--<g:set var="totalHasta" value="${0.0}"/>--}%

        <g:each in="${retenciones}" var="retencion" status="j">
            <g:set var="renta" value="${retencion?.renta}"/>
            <g:set var="servicios" value="${retencion?.rentaServicios}"/>
            <g:set var="rentaIVA" value="${retencion?.ivaBienes}"/>
            <g:set var="serviciosIVA" value="${retencion?.ivaServicios}"/>
            <g:set var="secuencial" value="${retencion?.numeroComprobante?.split("-")[2]}"/>
            <g:set var="secuencial2" value="${'0' * (9 - retencion?.numeroComprobante?.split("-")[2].size()) + secuencial}"/>

            <tr style="width: 810px">
                <td style="width: 60px"><g:formatDate date="${retencion?.fechaEmision}" format="dd-MM-yyyy" /></td>
                <td style="width: 200px;" class="centro">${retencion?.numeroComprobante?.split("-")[0] + " - " + retencion?.numeroComprobante?.split("-")[1] + " - " + secuencial2}</td>
                <td style="width: 120px">${retencion?.proceso?.documento}</td>
                <td style="width: 330px">${retencion?.persona}</td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${renta + servicios + rentaIVA + serviciosIVA}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

</body>
</html>