<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 13/12/17
  Time: 12:37
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

    <title>Retenciones por Código</title>

    <rep:estilos orientacion="p" pagTitle="${"Retenciones por Codigo"}"/>

    <style type="text/css">

    html {
        font-family: Verdana, Arial, sans-serif;
        /*font-size: 15px;*/
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
        font-size: 10px; !important;
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

<rep:headerFooter title="${'Retenciones por Código'}" subtitulo="${'Datos'}" empresa="${empresa}"/>

<h2>
    PERÍODO DEL <g:formatDate date="${desde}" format="dd-MM-yyyy"/>

    AL <g:formatDate date="${hasta}" format="dd-MM-yyyy"/>
</h2>


<div>

    <g:set var="actual" value="${''}"/>

    <g:set var="bandera" value="${0}"/>

    <g:each in="${retenciones}" var="rete">

        <g:set var="nuevo" value="${rete?.conceptoRIRBienes?.codigo}"/>

        <g:if test="${actual == nuevo}">

        </g:if>
        <g:else>
            <g:each in="${lista}" var="lis">

                <g:if test="${rete?.conceptoRIRBienes?.codigo == lis?.codigo}">

                    <h3> ${lis?.codigo} <util:clean str="${lis?.descripcion?.replaceAll("\\/","")}"/> </h3>
                    <g:set var="actual" value="${rete?.conceptoRIRBienes?.codigo}"/>

                    <table border="1">
                        <thead>
                        <tr style="width: 810px">
                            <th align="center" style="width: 60px">Fecha</th>
                            <th align="center" style="width: 200px;">Retención</th>
                            <th align="center" style="width: 270px;">Proveedor</th>
                            <th align="center" style="width: 120px">Documento</th>
                            %{--<th align="center" style="width: 330px">Beneficiario</th>--}%
                            <th align="center" style="width: 100px">Base</th>
                            <th align="center" style="width: 80px">COD</th>
                            <th align="center" style="width: 50px">%</th>
                            <th align="center" style="width: 100px">Valor</th>
                        </tr>
                        </thead>

                        <tbody>

                        <g:set var="total" value="${0}"/>
                        <g:set var="total2" value="${0}"/>

                        <g:each in="${retenciones}" var="retencion" status="j">

                            <g:set var="codigoActual" value="${retencion?.conceptoRIRBienes?.codigo}"/>

                            <g:set var="renta" value="${retencion?.renta}"/>
                            <g:set var="servicios" value="${retencion?.rentaServicios}"/>
                            <g:set var="rentaIVA" value="${retencion?.ivaBienes}"/>
                            <g:set var="serviciosIVA" value="${retencion?.ivaServicios}"/>
                            <g:set var="secuencial" value="${retencion?.numeroComprobante?.split("-")[2]}"/>
                            <g:set var="secuencial2" value="${'0' * (9 - retencion?.numeroComprobante?.split("-")[2].size()) + secuencial}"/>

                            <g:if test="${codigoActual == actual}">
                                <tr style="width: 810px;">
                                    <td style="width: 60px"><g:formatDate date="${retencion?.fechaEmision}" format="dd-MM-yyyy" /></td>
                                    <td style="width: 200px;" class="centro">${retencion?.numeroComprobante?.split("-")[0] + " - " + retencion?.numeroComprobante?.split("-")[1] + " - " + secuencial2}</td>
                                    <td style="width: 270px">${retencion?.proceso?.proveedor?.nombre}</td>
                                    <td style="width: 120px">${retencion?.proceso?.documento}</td>
                                    %{--<td style="width: 330px">${retencion?.persona}</td>--}%
                                    <td class="derecha" style="width: 100px"><g:formatNumber number="${retencion?.baseRenta}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                                    <td class="centro" style="width: 80px">${retencion?.conceptoRIRBienes?.codigo}</td>
                                    <td class="derecha" style="width: 50px"><g:formatNumber number="${retencion?.conceptoRIRBienes?.porcentaje}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                                    %{--<td class="derecha" style="width: 100px"><g:formatNumber number="${renta + servicios + rentaIVA + serviciosIVA}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>--}%
                                    <td class="derecha" style="width: 100px"><g:formatNumber number="${renta}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                                    <g:set var="total" value="${total += (retencion?.baseRenta ?: 0)}"/>
                                    <g:set var="total2" value="${total2 += (renta ?: 0)}"/>
                                </tr>
                            </g:if>


                        </g:each>

                        <tr style="width: 100%">
                            <td colspan="4" class="derecha" style="background: #bbb; font-weight: bold">TOTAL:</td>
                            <td class="derecha"><g:formatNumber number="${total}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                            <td class="derecha" colspan="2" style="background: #bbb"></td>
                            <td class="derecha"><g:formatNumber number="${total2}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                        </tr>
                        </tbody>
                    </table>

                </g:if>
            </g:each>
        </g:else>
    </g:each>

</div>

</body>
</html>