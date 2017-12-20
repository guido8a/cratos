<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 12/10/17
  Time: 10:18
--%>

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

    <title>Kardex</title>

    <rep:estilos orientacion="p" pagTitle="${"Kardex"}"/>

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

<rep:headerFooter title="${'Kardex'}" subtitulo="${'Datos'}" empresa="${empresa}"/>

<h2>
    PERÍODO DEL <g:formatDate date="${desde}" format="dd-MM-yyyy"/>
    AL <g:formatDate date="${hasta}" format="dd-MM-yyyy"/>
</h2>


<div>
    <table border="1">
        <thead>
        <tr style="font-size: 11px; width: 700px">
            <th align="center" style="width: 300px">Item</th>
            <th align="center" style="width: 100px;">Proceso</th>
            <th align="center" style="width: 100px">Fecha</th>
            <th align="center" style="width: 100px;">Cantidad</th>
            <th align="center" style="width: 100px">Existencias</th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${res}" var="kardex" status="j">
            <tr style="width: 700px">
                <td style="width: 300px">${kardex?.item?.nombre}</td>
                <td class="centro" style="width: 100px">${kardex?.proceso?.tipoProceso?.descripcion}</td>
                <td class="centro" style="width: 100px"><g:formatDate date="${kardex?.fecha}" format="dd-MM-yyyy" /></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${kardex?.cantidad}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px"><g:formatNumber number="${kardex?.existencias}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

</body>
</html>