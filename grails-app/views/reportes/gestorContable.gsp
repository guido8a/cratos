<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 4/13/12
  Time: 12:40 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Gestor Contable</title>
    <style type="text/css">
    @page {
        size: 21cm 29.7cm ; /* width height */
        margin: 2cm;
    }

    .hoja {
        width: 25.7cm;
        /*background: #d8f0fa;*/
    }

    .even {
        background: #B7C4F7;
    }

    .odd {
        background: #FCFDFF
    }

    table {
        border-collapse: collapse;
    }

    .item {
        /*background: #e6e6fa;*/
        border-bottom: solid 2px #555;

    }

    .tamano{
        font-size: 10px;
    }

    .tamano12{
        font-size: 12px;
    }

    th{
            font-size: 12px;
    }

    td{
            font-size: 12px;
    }

    </style>

</head>

<body>
<div class="hoja">
    <div  style="width: 500px" align="center"><strong>GESTOR CONTABLE</strong></div>

    <g:each in="${res}" var="item">
        <g:set var="val" value="${item.value}"/>
        %{--<table style="margin-top: 20px; margin-bottom: 10px">--}%
        <table class="table table-bordered table-hover table-condensed" style="margin-top: 20px; margin-bottom: 10px">
            <tr>
                <td width="500px">
                    <strong>Nombre:</strong>   <util:clean str="${item.key}"></util:clean>
                </td>

                <td style="width: 100px">
                    <strong>Fecha:</strong>
                    %{--<g:formatDate format="dd/MM/yyyy"  type="datetime" date="${val.fecha}"> </g:formatDate>--}%
                    <g:formatDate format="dd/MM/yyyy"  date="${val.fecha}"> </g:formatDate>
                </td>
            </tr>

            %{--<tr>--}%
                %{--<td height="50px">--}%
                    %{--Descripción:  <util:clean str="${val.descripcion}"></util:clean>--}%
                %{--</td>--}%

            %{--</tr>--}%

        </table>

        <table border="1" width="600px">

            <tr>
                <th style="width: 70px" align="center">
                    Número
                </th>
                <th style="width: 320px" align="center">
                    Descripción
                </th>
                <th style="width: 40px" align="center">
                    Porcentaje
                </th>
                <th style="width: 40px" align="center">
                    Impuestos
                </th>
                <th style="width: 40px" align="center">
                    Valor
                </th>
                <th style="width: 40px" align="center">
                    D/H
                </th>
            </tr>

            <g:each in="${val.items}" var="i">

                <tr>
                    <td>
                        ${i.numero}
                    </td>
                    <td>
                        <util:clean str="${i.descripcion}"></util:clean>
                    </td>
                    <td align="right">
                        ${i.porcentaje}
                    </td>
                    <td align="right">
                        ${i.porcentajeImpuestos}
                    </td>
                    <td align="right">
                        ${i.valor}
                    </td>
                    <td align="center">
                        ${i.debeHaber}
                    </td>
                </tr>
            </g:each>
        </table>
    </g:each>
</div>
</body>
</html>