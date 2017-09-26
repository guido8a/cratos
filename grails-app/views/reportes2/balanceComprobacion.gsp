<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 25/09/17
  Time: 15:23
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

    <title>Balance de Comprobación</title>

    <rep:estilos orientacion="p" pagTitle="${"Balance de Comprobación"}"/>

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
        font-size: 11px;
    }

    .centro{
        text-align: center;

    }

    .letra{
        font-size: 11px;
    }

    </style>

</head>

<body>

<rep:headerFooter title="${'Balance de Comprobación'}" subtitulo="${'Datos'}" empresa="${empresa}"/>

<h2>
    PERÍODO: ${periodo}
</h2>


<div>

    <table border="1">
        <thead>
        <tr>
            <th class="centro" style="width: 290px" colspan="2">Cuenta</th>
            <th class="centro" style="width: 160px" colspan="2">Sumas</th>
            <th class="centro" style="width: 160px" colspan="2">Saldos</th>
        </tr>
        <tr style="font-size: 11px">
            <th align="center" style="width: 70px">Código</th>
            <th align="center" style="width: 260px">Descripción</th>
            <th align="center" style="width: 70px;">Debe</th>
            <th align="center" style="width: 70px;">Haber</th>
            <th align="center" style="width: 70px">Debe</th>
            <th align="center" style="width: 70px">Haber</th>
        </tr>
        </thead>

        <tbody>

        <g:set var="totalDebe1" value="${0.0}"/>
        <g:set var="totalDebe2" value="${0.0}"/>
        <g:set var="totalHaber1" value="${0.0}"/>
        <g:set var="totalHaber2" value="${0.0}"/>
        <g:set var="saldo" value="${0.0}"/>
        <g:set var="mayor" value='false'/>

        <g:each in="${cuentas}" var="cuenta">

            <g:set var="totalDebe1" value="${totalDebe1 += cuenta.slmsdebe.toDouble()}"/>
            <g:set var="totalHaber1" value="${totalHaber1 += cuenta.slmshber.toDouble()}"/>

            <g:set var="saldo" value="${cuenta.slmsdebe.toDouble() + cuenta.slmshber.toDouble()}"/>
            <g:set var="mayor" value="${cuenta.slmsdebe.toDouble() > cuenta.slmshber.toDouble()}"/>

            <g:set var="totalDebe2" value="${mayor ? (totalDebe2 += saldo.toDouble()) : (totalDebe2 += 0) }"/>
            <g:set var="totalHaber2" value="${!mayor ? (totalHaber2 += (saldo.toDouble() >= 0 ? saldo.toDouble() : saldo.toDouble() * -1)) : (totalHaber2 += 0)}"/>

            <tr>
                <td style="font-size: 11px">${cuenta.cntanmro}</td>
                <td class="letra">${cuenta.cntadscr}</td>
                <td class="derecha"><g:formatNumber number="${cuenta.slmsdebe}" maxFractionDigits="2" minFractionDigits="2" format="##,##0" locale="en_US"/></td>
                <td class="derecha"><g:formatNumber number="${cuenta.slmshber}" maxFractionDigits="2" minFractionDigits="2" format="##,##0" locale="en_US"/></td>
                <td class="derecha"><g:formatNumber number="${mayor ? saldo.toDouble() : 0}" maxFractionDigits="2" minFractionDigits="2" format="##,##0" locale="en_US"/></td>
                <td class="derecha"><g:formatNumber number="${!mayor ? (saldo.toDouble() >= 0 ? saldo.toDouble() : saldo.toDouble() * -1) : 0}" maxFractionDigits="2" minFractionDigits="2" format="##,##0" locale="en_US"/></td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <table>
        <thead>
        <tr>
            <th style="width: 330px" colspan="2" class="derecha">Total: </th>
            <th style="width: 70px" class="derecha"><g:formatNumber number="${totalDebe1}" maxFractionDigits="2" minFractionDigits="2" format="##,##0" locale="en_US"/></th>
            <th style="width: 70px" class="derecha"><g:formatNumber number="${totalHaber1}" maxFractionDigits="2" minFractionDigits="2" format="##,##0" locale="en_US"/></th>
            <th style="width: 70px" class="derecha"><g:formatNumber number="${totalDebe2}" maxFractionDigits="2" minFractionDigits="2" format="##,##0" locale="en_US"/></th>
            <th style="width: 70px" class="derecha"><g:formatNumber number="${totalHaber2}" maxFractionDigits="2" minFractionDigits="2" format="##,##0" locale="en_US"/></th>
        </tr>
        </thead>
    </table>

</div>

</body>
</html>