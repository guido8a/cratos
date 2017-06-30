<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 29/06/17
  Time: 10:34
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Comprobante</title>
    <rep:estilos orientacion="p" pagTitle="${"Comprobante"}"/>

    <style type="text/css">

    .even {
        background: #B7C4F7;
    }

    .odd {
        background: #FCFDFF
    }

    table {
        border-collapse: collapse;
    }

    th{
        font-size: 11px;
    }

    td{
        font-size: 11px;
    }

    /*table {*/
    /*border-collapse: collapse;*/
    /*}*/

    /*table, th, td {*/
    /*border: 1px solid black;*/
    /*}*/

    .table th {
        background     : #5d6263;
        text-align     : center;
        text-transform : uppercase;
    }

    .table {
        margin-top      : 0.5cm;
        width           : 100%;
        border-collapse : collapse;
    }

    /*.table, .table td, .table th {*/
    /*border : solid 1px #444;*/
    /*}*/

    .table td, .table th {
        padding : 3px;
    }

    .negrita{
        font-weight: bold;
    }

    </style>

</head>

<body>

<rep:headerFooter title="${'Comprobante'}" subtitulo="${'Datos'}" empresa="${empresa}"/>


<div style="float: right">
    <strong style="font-size: 11px">${proceso?.tipoTransaccion?.descripcion.toUpperCase()} N° ${comprobante?.prefijo + "-" + comprobante?.numero}</strong>
</div>

<div class="hoja" style="margin-top: 20px">

    <table >
        <tbody>
        <tr>
            <td style="width: 100px" class="negrita">Proveedor: </td>
            <td style="width: 400px"><util:clean str="${proceso?.proveedor?.nombre}"></util:clean></td>
            <td style="width: 100px" class="negrita">Fecha: </td>
            <td style="width: 200px"><g:formatDate format="dd/MM/yyyy"  date="${comprobante?.fecha}"> </g:formatDate></td>
        </tr>
        <tr>
            <td style="width: 100px" class="negrita">Dirección: </td>
            <td style="width: 400px"><util:clean str="${proceso?.proveedor?.direccion}"></util:clean></td>
            <td style="width: 100px" class="negrita">Condiciones: </td>
            <td style="width: 200px"></td>
        </tr>
        <tr>
            <td style="width: 100px" class="negrita">R.U.C.: </td>
            <td style="width: 400px">${proceso?.proveedor?.ruc}</td>
            <td style="width: 100px" class="negrita">Teléfono:</td>
            <td style="width: 200px">${proceso?.proveedor?.telefono}</td>
        </tr>
        <tr>
            <td style="width: 100px" class="negrita">Documento: </td>
            <td style="width: 400px">${comprobante?.factura}</td>
        </tr>

        </tbody>
    </table>

    <table>
        <thead>
        <tr>
            <th></th>
        </tr>
        </thead>
    </table>



    %{--<g:each in="${res}" var="item">--}%
    %{--<g:set var="val" value="${item.value}"/>--}%


    %{--<div style="width: 600px; font-size: 11px; margin-bottom: 10px; margin-top: 20px;">--}%
    %{--<strong>Nombre:</strong><util:clean str="${item.key}"></util:clean>--}%
    %{--<div style="width: 100px; float: right">--}%
    %{--<strong>Fecha:</strong><g:formatDate format="dd/MM/yyyy"  date="${val.fecha}"> </g:formatDate>--}%
    %{--</div>--}%
    %{--</div>--}%

    %{--<table width="600px" class="table table-bordered table-hover table-condensed table-bordered">--}%

    %{--<tr>--}%
    %{--<th style="width: 70px" align="center">--}%
    %{--Código--}%
    %{--</th>--}%
    %{--<th style="width: 320px" align="center">--}%
    %{--Cuenta--}%
    %{--</th>--}%
    %{--<th style="width: 40px" align="center">--}%
    %{--%B. Imponible--}%
    %{--</th>--}%
    %{--<th style="width: 40px" align="center">--}%
    %{--%B.I. Sin Iva--}%
    %{--</th>--}%
    %{--<th style="width: 40px" align="center">--}%
    %{--Impuestos--}%
    %{--</th>--}%
    %{--<th style="width: 40px" align="center">--}%
    %{--ICE--}%
    %{--</th>--}%
    %{--<th style="width: 40px" align="center">--}%
    %{--D/H--}%
    %{--</th>--}%
    %{--</tr>--}%

    %{--<g:each in="${val.items}" var="i">--}%

    %{--<tr>--}%
    %{--<td>--}%
    %{--${i.numero}--}%
    %{--</td>--}%
    %{--<td>--}%
    %{--<util:clean str="${i.descripcion}"></util:clean>--}%
    %{--</td>--}%
    %{--<td align="right">--}%
    %{--${i.porcentaje}--}%
    %{--</td>--}%
    %{--<td align="right">--}%
    %{--${i.base}--}%
    %{--</td>--}%
    %{--<td align="right">--}%
    %{--${i.porcentajeImpuestos}--}%
    %{--</td>--}%
    %{--<td align="right">--}%
    %{--${i.valor}--}%
    %{--</td>--}%
    %{--<td align="center">--}%
    %{--${i.debeHaber}--}%
    %{--</td>--}%
    %{--</tr>--}%
    %{--</g:each>--}%
    %{--</table>--}%
    %{--</g:each>--}%
</div>
</body>
</html>