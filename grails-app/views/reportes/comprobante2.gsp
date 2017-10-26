<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 25/10/17
  Time: 12:21
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

    .item {
        border-bottom: solid 2px #555;
    }

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

    .table, .table td, .table th {
        border : solid 1px #444;
    }

    .table td, .table th {
        padding : 3px;
    }

    .odd{
        background: #ffecd2;
    }
    .even{
        background: #e7e6ea;
    }
    .letra{
        font-weight: bold;
    }

    .derecha{
        text-align: right;
    }

    </style>
</head>

<body>


<rep:headerFooter title="${'Comprobante de ' + (proceso?.tipoProceso?.codigo?.trim() == 'P' ? 'Egreso' : proceso?.tipoProceso?.codigo?.trim() == 'I' ? 'Ingreso' : '') }" subtitulo="${'Datos'}" empresa="${empresa?.id}"/>

<div style="text-align: center;">
    <strong style="font-size: 18px; color: #17375E"> N°: ${comprobante?.prefijo + " " + comprobante?.numero} </strong>
</div>



<div class="hoja">
    <table style="width: 600px;">
        <tr style="height: 20px">
            <td width="100px">
                <b>A ORDEN DE:</b>
            </td>
            <td width="350px">
                ${comprobante?.proceso?.proveedor?.nombre}
            </td>
            <td>
                <b>FECHA: </b>
            </td>
            <td>
                ${comprobante?.proceso?.fechaIngresoSistema?.format("yyyy-MM-dd")}
            </td>
        </tr>
        <tr style="height: 20px">
            <td width="100px">
                <b>CONCEPTO:</b>
            </td>
            <td width="350px">
                ${comprobante?.proceso?.descripcion}
            </td>
            <td>
                <b>VALOR $:</b>
            </td>
            <td>
                <g:formatNumber number="${comprobante?.proceso?.valor}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/>
            </td>
        </tr>
    </table>

    <table border="1" style="width: 600px; margin-top: 20px">
        <tr>
            <th style="width: 100px" align="center" class="ui-state-focus">
                Cuenta
            </th>
            <th style="width: 300px" align="center" class="ui-state-focus">
                Concepto
            </th>
            <th style="width: 70px" align="center" class="ui-state-focus">
                CC
            </th>
            <th style="width: 70px" align="center" class="ui-state-focus">
                Débito
            </th>
            <th style="width: 70px" align="center" class="ui-state-focus">
                Crédito
            </th>
        </tr>

        <g:each in="${cratos.Asiento.findAllByComprobante(comprobante).sort{it.cuenta.numero}}" var="asiento">
            <tr class="letra">
                <td>${asiento?.cuenta?.numero}</td>
                <td>${asiento?.cuenta?.descripcion}</td>
                <td>${cratos.AsientoCentro.findByAsiento(asiento)?.centroCosto?.nombre}</td>
                <td class="derecha"><g:formatNumber number="${asiento?.debe}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha"><g:formatNumber number="${asiento?.haber}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            </tr>
            <g:each in="${cratos.Auxiliar.findAllByAsiento(asiento).sort{it.proveedor.nombre}}" var="auxiliar">
            <tr>
                <td></td>
                <td>Documento: ${auxiliar?.documento}</td>
                <td></td>
                <td class="derecha"><g:formatNumber number="${auxiliar?.debe}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha"><g:formatNumber number="${auxiliar?.haber}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            </tr>
            </g:each>
        </g:each>

        <tr>
            <td>Contabilizado:</td>
            <td>
                <tr>
                <td>1</td>
                <td>2</td>
                </tr>

            </td>
            <td>Autorizado</td>
            <td></td>
            <td></td>
            <td>T1</td>
            <td>T2</td>
        </tr>

    </table>


    %{--<g:each in="${comp}" var="item">--}%
    %{--<g:set var="val" value="${item.value}"/>--}%
    %{--<table style="width: 600px;">--}%
    %{--<tr>--}%
    %{--<td width="400px" height="50px" >--}%
    %{--<b>Número:</b> ${item.key} ${(comprobante.registrado=="B")?" Anulado":""}--}%
    %{--</td>--}%

    %{--<td>--}%
    %{--<b>Fecha:</b>--}%
    %{--${val.fecha?.format("dd/MM/yyyy")}--}%
    %{--</td>--}%
    %{--</tr>--}%
    %{--<tr>--}%
    %{--<td height="50px">--}%
    %{--<b>Descripción:</b> ${val.descripcion}--}%
    %{--</td>--}%
    %{--<td>--}%
    %{--<b>Tipo: </b>${val.tipo}--}%
    %{--</td>--}%
    %{--</tr>--}%
    %{--</table>--}%

    %{--<table border="1" style="width: 600px;">--}%
    %{--<tr>--}%
    %{--<th style="width: 140px" align="center" class="ui-state-focus">--}%
    %{--Número--}%
    %{--</th>--}%
    %{--<th style="width: 360px" align="center" class="ui-state-focus">--}%
    %{--Cuenta--}%
    %{--</th>--}%
    %{--<th style="width: 60px" align="center" class="ui-state-focus">--}%
    %{--Debe--}%
    %{--</th>--}%
    %{--<th style="width: 60px" align="center" class="ui-state-focus">--}%
    %{--Haber--}%
    %{--</th>--}%
    %{--</tr>--}%

    %{--<g:set var="totalDebe"  value="${0}"/>--}%
    %{--<g:set var="totalHaber" value="${0}"/>--}%

    %{--<g:each in="${val.items}" var="i" status="j" >--}%
    %{--<g:if test="${i.debe+i.haber>0}">--}%
    %{--<tr>--}%
    %{--<td>--}%
    %{--${i.cuenta}--}%
    %{--</td>--}%
    %{--<td>--}%
    %{--${i.descripcion}--}%
    %{--</td>--}%
    %{--<td align="right">--}%
    %{--${i.debe}--}%
    %{--</td>--}%
    %{--<td align="right">--}%
    %{--${i.haber}--}%
    %{--</td>--}%
    %{--<g:set var="totalDebe" value="${totalDebe + i.debe}"/>--}%
    %{--<g:set var="totalHaber" value="${totalHaber +i.haber}"/>--}%
    %{--</tr>--}%
    %{--</g:if>--}%
    %{--</g:each>--}%

    %{--<tr>--}%
    %{--<td>--}%
    %{--</td>--}%
    %{--<td align="center">--}%
    %{--TOTAL:--}%

    %{--</td>--}%
    %{--<td align="right">--}%
    %{--${totalHaber.toDouble().round(2)}--}%
    %{--</td>--}%
    %{--<td align="right">--}%
    %{--${totalDebe.toDouble().round(2)}--}%
    %{--</td>--}%
    %{--</tr>--}%
    %{--</table>--}%
    %{--</g:each>--}%

    %{--<g:each in="${tipoComprobante}" var="i">--}%
    %{--<g:if test="${i == 'D'}">--}%
    %{--<table style="width: 600px; margin-top: 50px">--}%
    %{--<tr>--}%
    %{--<td width="400px" style="text-align: center" >--}%
    %{--<b>___________________</b>--}%
    %{--</td>--}%
    %{--</tr>--}%
    %{--<tr>--}%
    %{--<td width="400px" height="50px" style="text-align: center" >--}%
    %{--Autoriza--}%
    %{--</td>--}%
    %{--</tr>--}%
    %{--</table>--}%
    %{--</g:if>--}%
    %{--<g:else>--}%
    %{--<table style="width: 600px; margin-top: 50px">--}%
    %{--<tr>--}%
    %{--<td width="400px" style="text-align: center" >--}%
    %{--<b>___________________</b>--}%
    %{--</td>--}%

    %{--<td width="400px" style="text-align: center" >--}%
    %{--<b>____________________</b>--}%
    %{--</td>--}%
    %{--</tr>--}%
    %{--<tr>--}%
    %{--<td width="400px" height="50px" style="text-align: center" >--}%
    %{--Autoriza--}%
    %{--</td>--}%

    %{--<td width="400px" height="50px" style="text-align: center" >--}%
    %{--Recibí Conforme--}%
    %{--</td>--}%
    %{--</tr>--}%
    %{--</table>--}%
    %{--</g:else>--}%
    %{--</g:each>--}%
</div>






</body>
</html>