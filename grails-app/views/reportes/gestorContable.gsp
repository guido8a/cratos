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
    <title>Gestores Contables</title>
    <rep:estilos orientacion="p" pagTitle="${"Gestores Contables"}"/>

    <style type="text/css">
    /*@page {*/
        /*size: 21cm 29.7cm ; !* width height *!*/
        /*margin: 2cm;*/
    /*}*/

    /*.hoja {*/
        /*width: 25.7cm;*/
        /*!*background: #d8f0fa;*!*/
    /*}*/

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
        border-bottom: solid 1px #555;

    }

    .tamano{
        font-size: 10px;
    }

    .tamano12{
        font-size: 12px;
    }

    th{
            font-size: 11px;
    }

    td{
            font-size: 11px;
    }

    table {
        border-collapse: collapse;
    }

    table, th, td {
        border: 1px solid black;
    }

    .table th {
        /*background     : #326090;*/
        background     : #5d6263;
        /*color          : #fff;*/
        text-align     : center;
        text-transform : uppercase;
    }

    .table {
        margin-top      : 0.5cm;
        width           : 100%;
        border-collapse : collapse;
    }

    .table, .table td, .table th {
        border : solid 1px #444;
    }

    .table td, .table th {
        padding : 3px;
    }

    </style>

</head>

<body>

<rep:headerFooter title="${'Gestores Contables'}" subtitulo="${'Datos'}" empresa="${empresa}"/>


<div class="hoja">
    %{--<div style="width: 500px" align="center"><strong>GESTOR CONTABLE</strong></div>--}%

    <g:each in="${res}" var="item">
        <g:set var="val" value="${item.value}"/>

        %{--<table style="margin-top: 20px; margin-bottom: 10px">--}%
            %{--<tr>--}%
                %{--<td width="500px">--}%
                    %{--<strong>Nombre:</strong>   <util:clean str="${item.key}"></util:clean>--}%
                %{--</td>--}%

                %{--<td style="width: 100px">--}%
                    %{--<strong>Fecha:</strong>--}%
                    %{--<g:formatDate format="dd/MM/yyyy"  date="${val.fecha}"> </g:formatDate>--}%
                %{--</td>--}%
            %{--</tr>--}%
        %{--</table>--}%

            <div style="width: 600px; font-size: 11px; margin-bottom: 10px; margin-top: 20px;">
                <strong>Nombre:</strong><util:clean str="${item.key}"></util:clean>
                <div style="width: 100px; float: right">
                <strong>Fecha:</strong><g:formatDate format="dd/MM/yyyy"  date="${val.fecha}"> </g:formatDate>
                </div>
            </div>

        <table width="600px" class="table table-bordered table-hover table-condensed table-bordered">

            <tr>
                <th style="width: 70px" align="center">
                    Código
                </th>
                <th style="width: 320px" align="center">
                    Cuenta
                </th>
                <th style="width: 40px" align="center">
                    %B. Imponible
                </th>
                <th style="width: 40px" align="center">
                    %B.I. Sin Iva
                </th>
                <th style="width: 40px" align="center">
                    Impuestos
                </th>
                <th style="width: 40px" align="center">
                    ICE
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
                        ${i.base}
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