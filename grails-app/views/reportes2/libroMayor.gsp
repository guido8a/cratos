<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 01/09/17
  Time: 12:11
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>Libro Mayor</title>

    <rep:estilos orientacion="p" pagTitle="${"Libro Mayor"}"/>

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

<rep:headerFooter title="${'Libro Mayor'}" subtitulo="${'Datos'}" empresa="${empresa}"/>

<h2>CUENTA : ${cuenta?.numero + " - " + cuenta?.descripcion?.toUpperCase()}</h2>

<h2>
    PERÍODO DEL <g:formatDate date="${desde}" format="dd-MM-yyyy"/>

    AL <g:formatDate date="${hasta}" format="dd-MM-yyyy"/>
</h2>


<div>

    <table border="1">

        <thead>
        <tr style="font-size: 11px">
            <th align="center" style="width: 60px">Fecha</th>
            <th align="center" style="width: 100px;">Documento</th>
            <th align="center" style="width: 230px">Descripción</th>
            <th align="center" style="width: 80px;">Debe</th>
            <th align="center" style="width: 80px;">Haber</th>
            <th align="center" style="width: 80px">Saldo</th>
        </tr>
        </thead>

        <tbody>

        <g:set var="totalDebe" value="${0.0}"/>
        <g:set var="totalHasta" value="${0.0}"/>

        <g:each in="${res}" var="cuenta" status="j">

            <g:set var="totalDebe" value="${totalDebe += cuenta.slmsdebe.toDouble()}"/>
            <g:set var="totalHasta" value="${totalHasta += cuenta.slmshber.toDouble()}"/>

            <tr>
                <td>${cuenta.cmprfcha}</td>
                <td class="centro">${j == 0 ? '' : cuenta.cmprdcmt}</td>
                <td>${cuenta.cmprdscr}</td>
                <g:if test="${j == 0}">
                    <td class="derecha">${''}</td>
                    <td class="derecha">${''}</td>
                </g:if>
                <g:else>
                    <td class="derecha"><g:formatNumber number="${cuenta.slmsdebe.toDouble()}" locale="en_US" format="##,##0" minFractionDigits="2" maxFractionDigits="2"/> </td>
                    <td class="derecha"><g:formatNumber number="${cuenta.slmshber.toDouble()}" locale="en_US" format="##,##0" minFractionDigits="2" maxFractionDigits="2"/> </td>
                </g:else>
                %{--<td class="derecha">${j == 0 ? '' :cuenta.slmshber}</td>--}%
                <td class="derecha"><g:formatNumber number="${cuenta?.slmssldo?.toDouble() ?: 0}" locale="en_US" format="##,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                %{--<td class="derecha"><g:formatNumber number="${cuenta.slmsdebe.toDouble() - cuenta.slmshber.toDouble()}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>--}%
            </tr>
        </g:each>
        </tbody>
    </table>
    <table>
        <thead>
        <tr>
            <th style="width: 480px" class="derecha">Total: </th>
            <th style="width: 90px" class="derecha"><g:formatNumber number="${totalDebe}" maxFractionDigits="2" minFractionDigits="2" format="##,##0" locale="en_US"/></th>
            <th style="width: 90px" class="derecha"><g:formatNumber number="${totalHasta}" maxFractionDigits="2" minFractionDigits="2" format="##,##0" locale="en_US"/></th>
            <th style="width: 90px" class="derecha"><g:formatNumber number="${res?.last()?.slmssldo ?: 0}" maxFractionDigits="2" minFractionDigits="2" format="##,##0" locale="en_US"/></th>
        </tr>
        </thead>
    </table>

</div>

</body>
</html>