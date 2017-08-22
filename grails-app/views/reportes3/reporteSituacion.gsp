<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 21/07/17
  Time: 10:09
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 29/06/17
  Time: 14:59
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 29/06/17
  Time: 10:34

--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Situación</title>
    <rep:estilos orientacion="p" pagTitle="${"Estado de Situación al " + periodo}"/>

    <style type="text/css">

    td{
        font-size: 11px;
    }

    .verde{
        color: #1a7031;
    }

    .azul{
        color: #702213;
    }

    .naranja{
        color: #254897;
    }
    .color4{
        color: #136670;
    }

    .color5{
        color: #70642b;
    }

    .color6
    {
        color: #702e4c;
    }

    .margen {
        margin-top: 100px !important;
    }

    .derecha {
    text-align: right; !important;
    }


    </style>

</head>

<body>

<rep:headerFooter title="${"Estado de Situación al " + periodo}" subtitulo="${'Datos'}" empresa="${empresa}"/>


<table style="margin-top: 20px">
    <tbody>
    <g:each in="${cuentas}" var="cuenta" status="i">
        <tr>
            <td style="width: 100px;">
                <g:if test="${cuenta.nvel == 1}">
                    <b><p>${cuenta.cntanmro}</p></b>
                </g:if>
                <g:else>
                    ${cuenta.cntanmro}
                </g:else>
            </td>
            <td style="width: 370px">
                <g:if test="${cuenta.nvel == 1}">
                    <b>${cuenta.cntadscr}</b>
                </g:if>
                <g:else>
                    ${cuenta.cntadscr}
                </g:else>
            </td>
            %{--<td style="width: 400px">--}%
            <td style="max-width: 50%;">
                <g:if test="${cuenta.nvel == 1}">
                    <b class="naranja">${cuenta.sldo}</b>
                </g:if>
                <g:if test="${cuenta.nvel == 2}">
                    <b style="margin-left: 60px" class="verde">${cuenta.sldo}</b>
                </g:if>
                <g:if test="${cuenta.nvel == 3}">
                    <b style="margin-left: 110px" class="azul">${cuenta.sldo}</b>
                </g:if>
                <g:if test="${cuenta.nvel == 4}">
                    <b class="color4" style="margin-left: 160px;">${cuenta.sldo}</b>
                </g:if>
                <g:if test="${cuenta.nvel == 5}">
                    <b class="color5" style="margin-left: 210px;">${cuenta.sldo}</b>
                </g:if>
                <g:if test="${cuenta.nvel == 6}">
                    <b class="color6 " style="margin-left: 260px;">${cuenta.sldo}</b>
                </g:if>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

</body>
</html>