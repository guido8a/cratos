<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 22/12/17
  Time: 12:44
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

    <title>Existencias por item</title>

    <rep:estilos orientacion="l" pagTitle="${"Kardex 4"}"/>

    <style type="text/css">

    html {
        font-family: Verdana, Arial, sans-serif;
        font-size: 15px;
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
    .izquierda{
        text-align: left;
    }

    </style>

</head>

<body>

<rep:headerFooter title="${'Existencias por item'}" subtitulo="${'Datos'}" empresa="${empresa}"/>

<h1>
    ITEM: ${item?.codigo + " - " + item?.nombre}
</h1>

<h2>
    PERÍODO DEL <g:formatDate date="${desde}" format="dd-MM-yyyy"/>
    AL <g:formatDate date="${hasta}" format="dd-MM-yyyy"/>
</h2>

<div>
    <table border="1">
        <thead>
        <tr>
            <th colspan="1" class="centro">Fecha</th>
            <th colspan="1" class="centro">Documento</th>
            <th colspan="1" class="centro">Detalle</th>
            <th colspan="1" class="centro">Cantidad</th>
            <th colspan="1" class="centro">Precio U.</th>
            <th colspan="1" class="centro">INGRESOS</th>
            <th colspan="1" class="centro">EGRESOS</th>
            <th colspan="1" class="centro">SALDOS</th>
        </tr>
        </thead>

        <tbody>

        <g:set var="total" value="${0}"/>

        <g:each in="${res}" var="kardex" status="j">
            <tr style="width: 100%">
                <td class="izquierda" style="width: 7%"><g:formatDate date="${kardex?.krdxfcha}" format="dd-MM-yyyy"/></td>
                <td class="izquierda" style="width: 13%">${kardex?.prcsdcmt}</td>
                <td class="izquierda" style="width: 24%; font-size: 10px">${kardex?.prcsdscr}</td>
                <td class="derecha" style="width: 8%;">${kardex?.ingrvlor != 0 ? kardex?.ingrcntd : kardex?.egrscntd}</td>
                <td class="derecha" style="width: 8%;">${kardex?.exstpcun}</td>
                <td class="derecha" style="width: 8%">${kardex?.ingrvlor}</td>
                <td class="derecha" style="width: 8%">${kardex?.ingrvlor == 0 ? Math.round((kardex?.exstpcun * kardex?.egrscntd)*100)/100 : 0}</td>
                <g:if test="${kardex?.ingrvlor}">
                    <g:set var="total" value="${total += (kardex?.ingrvlor ?: 0)}"/>
                </g:if>
                <g:else>
                    <g:set var="total" value="${total -= ( Math.round((kardex?.exstpcun * kardex?.egrscntd)*100)/100 ?: 0)}"/>
                </g:else>
                <td class="derecha" style="width: 8%">${total}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

</body>
</html>