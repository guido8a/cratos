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


    /*table {*/
        /*border-collapse: collapse;*/
    /*}*/

    /*th{*/
        /*font-size: 11px;*/
    /*}*/

    td{
        font-size: 11px;
    }

    /*table {*/
        /*border-collapse: collapse;*/
    /*}*/

    /*table, th, td {*/
        /*border: 1px solid black;*/
    /*}*/

    /*.table th {*/
        /*background     : #6d7070;*/
        /*text-align     : center;*/
        /*text-transform : uppercase;*/
    /*}*/

    /*.table {*/
        /*margin-top      : 0.5cm;*/
        /*width           : 100%;*/
        /*border-collapse : collapse;*/
    /*}*/

    .verde{
        color: #1a7031;
    }

    .azul{
        color: #702213;
    }

    .naranja{
        color: #254897;
    }

    .tam {
        height: 20px !important;
    }

    </style>

</head>

<body>

<rep:headerFooter title="${"Estado de Situación al " + periodo}" subtitulo="${'Datos'}" empresa="${empresa}"/>

    <table class="table table-bordered table-hover table-condensed table-bordered">

        <tbody>
        %{--<g:set var="totalDebe" value="${0}"/>--}%
        %{--<g:set var="totalHaber" value="${0}"/>--}%
        <g:each in="${cuentas}" var="cuenta" status="i">
            <tr>
                <td style="width: 100px">
                    ${cuenta.cntanmro}
                </td>
                <td style="width: 270px">
                    ${cuenta.cntadscr}
                </td>
                <g:if test="${cuenta.nvel == 1}">
                    <p class="naranja">${cuenta.sldo}</p>
                </g:if>
                <g:if test="${cuenta.nvel == 2}">
                    <p style="margin-left: 60px" class="verde">${cuenta.sldo}</p>
                </g:if>
                <g:if test="${cuenta.nvel == 3}">
                    <p style="margin-left: 110px" class="azul">${cuenta.sldo}</p>
                </g:if>
                <g:if test="${cuenta.nvel == 4}">
                    <p style="margin-left: 160px">${cuenta.sldo}</p>
                </g:if>
                <g:if test="${cuenta.nvel == 5}">
                    <p style="margin-left: 210px">${cuenta.sldo}</p>
                </g:if>
                <g:if test="${cuenta.nvel == 6}">
                    <p style="margin-left: 260px">${cuenta.sldo}</p>
                </g:if>
            </tr>

            %{--<g:hiddenField name="totalDebe_name" value="${totalDebe += asiento.debe}"/>--}%
            %{--<g:hiddenField name="totalHaber_name" value="${totalHaber += asiento.haber}"/>--}%

        </g:each>
        </tbody>
    </table>

    %{--<table class="table table-bordered table-hover table-condensed table-bordered" style="margin-top: -1px">--}%
        %{--<thead>--}%
        %{--<tr>--}%
            %{--<th style="width: 125px">Elaborado</th>--}%
            %{--<th style="width: 125px">Presidente</th>--}%
            %{--<th style="width: 125px">Gerente</th>--}%
            %{--<th style="width: 121px">Contabilizado</th>--}%
            %{--<th class="menos" style="width: 102px" ><g:formatNumber number="${totalDebe}" format='##,##0' minFractionDigits="2" maxFractionDigits="2" locale="ec" /></th>--}%
            %{--<th class="menos" style="width: 102px" ><g:formatNumber number="${totalHaber}" format='##,##0' minFractionDigits="2" maxFractionDigits="2" locale="ec"/></th>--}%
        %{--</tr>--}%
        %{--</thead>--}%
        %{--<tbody>--}%
        %{--<tr>--}%
            %{--<td style="width: 125px; height: 70px"></td>--}%
            %{--<td style="width: 125px; height: 70px"></td>--}%
            %{--<td style="width: 125px; height: 70px"></td>--}%
            %{--<td style="width: 121px; height: 70px"></td>--}%
            %{--<td style="width: 102px; height: 70px"></td>--}%
            %{--<td style="width: 102px; height: 70px"></td>--}%
        %{--</tr>--}%
        %{--</tbody>--}%
    %{--</table>--}%

    %{--<table>--}%
        %{--<tbody>--}%
        %{--<tr>--}%
            %{--<td style="width: 672px; height: 25px" align="right">R.U.C. / C.I.</td>--}%
            %{--<td style="width: 278px; height: 25px"></td>--}%
        %{--</tr>--}%
        %{--</tbody>--}%
    %{--</table>--}%

%{--</div>--}%
</body>
</html>