<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 19/10/17
  Time: 10:38
--%>

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

    <title>Kardex por item</title>

    <rep:estilos orientacion="l" pagTitle="${"Kardex 2"}"/>

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

<rep:headerFooter title="${'Kardex por item'}" subtitulo="${'Datos'}" empresa="${empresa}"/>

<h1>
   %{--ITEM: ${(res != [] ? res?.first()?.itemcdgo : '') + " - " + (res != [] ? res?.first()?.itemnmbr : '')}--}%
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
            <th colspan="1" rowspan="2" class="centro">Fecha</th>
            <th colspan="1" rowspan="2" class="centro">Documento</th>
            <th colspan="1" rowspan="2" class="centro">Detalle</th>
            <th colspan="2" class="centro">INGRESOS</th>
            <th colspan="2" class="centro">EGRESOS</th>
            <th colspan="3" class="centro">SALDOS</th>
        </tr>
        <tr style="font-size: 11px; width: 100%">
            %{--<th align="center" style="width: 80px">Código</th>--}%
            %{--<th align="center" style="width: 370px">Item</th>--}%
            %{--<th align="center" style="width: 50px;">Cantidad</th>--}%
            %{--<th align="center" style="width: 100px">P. Unitario</th>--}%
            %{--<th align="center" style="width: 100px">Total</th>--}%
            %{--<th align="center" style="width: 7%">Fecha</th>--}%
            %{--<th rowspan="2" align="center" style="width: 13%">Documento</th>--}%
            %{--<th rowspan="2" align="center" style="width: 24%">Detalle</th>--}%
            <th align="center" style="width: 8%">Cant.</th>
            <th align="center" style="width: 8%">Valor</th>
            <th align="center" style="width: 8%">Cant.</th>
            <th align="center" style="width: 8%">Valor</th>
            <th align="center" style="width: 8%">Cant.</th>
            <th align="center" style="width: 8%">P. Unitario</th>
            <th align="center" style="width: 8%">Total</th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${res}" var="kardex" status="j">
            <tr style="width: 100%">
                %{--<td style="width: 80px">${kardex?.itemcdgo}</td>--}%
                %{--<td style="width: 370px">${kardex?.itemnmbr}</td>--}%
                %{--<td class="derecha" style="width: 50px"><g:formatNumber number="${kardex?.exst}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>--}%
                %{--<td class="derecha" style="width: 100px">${kardex?.pcun}</td>--}%
                %{--<td class="derecha" style="width: 100px">${kardex?.totl}</td>--}%
                <td class="izquierda" style="width: 7%"><g:formatDate date="${kardex?.krdxfcha}" format="dd-MM-yyyy"/></td>
                <td class="izquierda" style="width: 13%">${kardex?.prcsdcmt}</td>
                <td class="izquierda" style="width: 24%; font-size: 10px">${kardex?.prcsdscr}</td>
                <td class="derecha" style="width: 8%">${kardex?.ingrcntd}</td>
                <td class="derecha" style="width: 8%">${kardex?.ingrvlor}</td>
                <td class="derecha" style="width: 8%">${kardex?.egrscntd}</td>
                <td class="derecha" style="width: 8%">${kardex?.egrsvlor}</td>
                <td class="derecha" style="width: 8%">${kardex?.exstcntd}</td>
                <td class="derecha" style="width: 8%">${kardex?.exstpcun}</td>
                <td class="derecha" style="width: 8%">${kardex?.exstvlor}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

</body>
</html>