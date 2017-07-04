<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 30/06/17
  Time: 16:00
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
    <title>Libro Diario</title>
    <rep:estilos orientacion="l" pagTitle="${"Libro Diario"}"/>

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
        border: 0.5px  solid black;
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

    /*.table, .table td, .table th {*/
        /*border : solid 1px #444;*/
    /*}*/

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

    </style>

</head>

<body>

<rep:headerFooter title="${'Libro Diario'}" subtitulo="${'Datos'}" empresa="${empresa}"/>


<g:each in="${comprobantes}" var="comprobante">


    <div style="width: 800px; font-size: 11px; margin-bottom: 10px; margin-top: 20px;">
        <strong>Número: </strong>${comprobante?.prefijo + " " + comprobante?.numero}
        <div style="width: 200px; float: right">
            <strong>Fecha:</strong><g:formatDate format="yyyy/MM/dd"  date="${comprobante?.fecha}"> </g:formatDate>
        </div>
    </div>
    <div  style="width: 800px; font-size: 11px; margin-bottom: 10px;">
        <strong>Concepto: </strong><util:clean str="${comprobante?.descripcion}"/>
        <div style="width: 200px; float: right">
            <strong>Tipo:</strong> ${comprobante?.proceso?.tipoTransaccion?.descripcion}
        </div>
    </div>

    <div  style="width: 800px; font-size: 11px; margin-bottom: 10px;">
        <strong>${comprobante?.proceso?.tipoProceso == 'V' ? 'Cliente:' : 'Proveedor:' } </strong><util:clean str="${comprobante?.proceso?.proveedor?.nombre}"/>
        <g:if test="${comprobante?.proceso?.documento}">
            <div style="width: 200px; float: right">
                <strong>Documento:</strong> ${comprobante?.proceso?.documento}
            </div>
        </g:if>
    </div>

    <div class="hoja" style="margin-top: 20px">

        <table class="table table-bordered table-hover table-condensed table-bordered">
            <thead>

            <th style="width: 100px" align="center">
                Cuenta
            </th>
            <th style="width: 400px" align="center">
                Concepto
            </th>
            <th style="width: 100px" align="center">
                Centro Costos
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
            <g:each in="${cratos.Asiento.findAllByComprobante(comprobante).sort{it?.numero}}" var="asiento" status="i">
            %{--<tr class="${i%2 == 0 ? 'even': 'odd'}">--}%
                <tr>
                    <td style="width: 100px">
                        ${asiento?.cuenta?.numero}
                    </td>
                    <td style="width: 400px">
                        ${asiento?.cuenta?.descripcion} , ${comprobante?.descripcion}
                    </td>
                    <td style="width: 100px">

                    </td>
                    <td align="right" style="width: 100px">
                        ${asiento?.debe}
                    </td>
                    <td align="right" style="width: 100px">
                        ${asiento?.haber}
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
                <th style="width: 498px" class="menos">Total</th>
                <th class="menos" style="width: 80px" ><g:formatNumber number="${totalDebe}" format='##,##0' minFractionDigits="2" maxFractionDigits="2" locale="ec" /></th>
                <th class="menos" style="width: 80px" ><g:formatNumber number="${totalHaber}" format='##,##0' minFractionDigits="2" maxFractionDigits="2" locale="ec"/></th>
            </tr>
            </thead>

        </table>

    </div>


</g:each>



</body>
</html>