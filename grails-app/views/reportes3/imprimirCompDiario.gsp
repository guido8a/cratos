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
    <title>Comprobante</title>
    <rep:estilos orientacion="l" pagTitle="${"Comprobante " + (comprobante?.proceso?.tipoProceso?.codigo?.trim() == 'P' ? 'de Egreso' : comprobante?.proceso?.tipoProceso?.codigo?.trim() == 'I' ? 'de Ingreso' : '')}"/>

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

    table {
        border-collapse: collapse;
    }

    table, th, td {
        border: 1px solid black;
    }

    .table th {
        background     : #6d7070;
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

    .negrita{
        font-weight: bold;
    }

    .menos{
        background-color: transparent !important;
        text-align     : right !important;
    }

    .remove-all-styles {
        all: revert;
    }

    .noEstilo{
        border: none !important;
    }

    </style>

</head>

<body>

<rep:headerFooter title="${"Comprobante " + (comprobante?.proceso?.tipoProceso?.codigo?.trim() == 'P' ? 'de Egreso' : comprobante?.proceso?.tipoProceso?.codigo?.trim() == 'I' ? 'de Ingreso' : '')}" subtitulo="${'Datos'}" empresa="${empresa}"/>

<div style="text-align: center;">
    <strong style="font-size: 18px; color: #17375E"> N°: ${comprobante?.prefijo + " " + comprobante?.numero} </strong>
</div>




<table style="width: 950px; margin-top: 20px" class="noEstilo">
    <tr style="height: 20px" class="noEstilo">
        <td width="100px" class="noEstilo">
            <g:if test="${comprobante?.proceso?.tipoProceso?.codigo?.trim() in ['P','I']}">
                <b>${comprobante?.proceso?.tipoProceso?.codigo?.trim() == 'P' ? 'A ORDEN DE:' : comprobante?.proceso?.tipoProceso?.codigo?.trim() == 'I' ? 'RECIBIRÁ DE:' : ''}</b>
            </g:if>
        </td>
        <td width="300px" class="noEstilo">
            <g:if test="${comprobante?.proceso?.tipoProceso?.codigo?.trim() in ['P','I']}">
                ${comprobante?.proceso?.proveedor?.nombre}
            </g:if>
        </td>
        <td width="100px" class="noEstilo">
            <b>FECHA: </b>
        </td>
        <td width="150px" class="noEstilo">
            ${comprobante?.proceso?.fechaIngresoSistema?.format("yyyy-MM-dd")}
        </td>
    </tr>
    <tr style="height: 20px">
        <td width="100px" class="noEstilo">
            <b>CONCEPTO:</b>
        </td>
        <td width="300px" class="noEstilo">
            ${comprobante?.proceso?.descripcion}
        </td>
        <td class="noEstilo">
            <b>VALOR $:</b>
        </td>
        <td class="noEstilo">
            <g:formatNumber number="${comprobante?.proceso?.valor}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/>
        </td>
    </tr>
</table>



<div class="hoja" style="margin-top: 20px">

    <table class="table table-bordered table-hover table-condensed table-bordered">
        <thead>

        <th style="width: 100px" align="center">
            Cuenta
        </th>
        <th style="width: 400px" align="center">
            Concepto
        </th>
        <th style="width:100px" align="center">
            Débito
        </th>
        <th style="width: 100px" align="center">
            Crédito
        </th>

        </thead>
        <tbody>
        <g:set var="totalDebe" value="${0}"/>
        <g:set var="totalHaber" value="${0}"/>
        <g:each in="${asientos}" var="asiento" status="i">
            %{--<tr class="${i%2 == 0 ? 'even': 'odd'}">--}%
            <tr>
                <td style="width: 100px">
                    ${asiento?.cuenta?.numero}
                </td>
                <td style="width: 400px">
                    ${asiento?.cuenta?.descripcion} , ${comprobante?.descripcion}
                </td>
                <td align="right" style="width: 100px">
                    <g:formatNumber number="${asiento?.debe}" format='##,##0' minFractionDigits="2" maxFractionDigits="2" locale="ec" />
                </td>
                <td align="right" style="width: 100px">
                    <g:formatNumber number="${asiento?.haber}" format='##,##0' minFractionDigits="2" maxFractionDigits="2" locale="ec" />
                </td>
            </tr>

            <g:hiddenField name="totalDebe_name" value="${totalDebe += asiento.debe}"/>
            <g:hiddenField name="totalHaber_name" value="${totalHaber += asiento.haber}"/>

        </g:each>
        </tbody>
    </table>

    <table class="table table-bordered table-hover table-condensed table-bordered" style="margin-top: -1px">
        <thead>
        <tr>
            <th style="width: 125px">Elaborado</th>
            <th style="width: 125px">Presidente</th>
            <th style="width: 125px">Gerente</th>
            <th style="width: 121px">Contabilizado</th>
            <th class="menos" style="width: 102px" ><g:formatNumber number="${totalDebe}" format='##,##0' minFractionDigits="2" maxFractionDigits="2" locale="ec" /></th>
            <th class="menos" style="width: 102px" ><g:formatNumber number="${totalHaber}" format='##,##0' minFractionDigits="2" maxFractionDigits="2" locale="ec"/></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td style="width: 125px; height: 70px"></td>
            <td style="width: 125px; height: 70px"></td>
            <td style="width: 125px; height: 70px"></td>
            <td style="width: 121px; height: 70px"></td>
            <td style="width: 102px; height: 70px"></td>
            <td style="width: 102px; height: 70px"></td>
        </tr>
        </tbody>
    </table>

    <table>
        <tbody>
        <tr>
            <td style="width: 672px; height: 25px" align="right">R.U.C. / C.I.</td>
            <td style="width: 278px; height: 25px"></td>
        </tr>
        </tbody>
    </table>

</div>
</body>
</html>
