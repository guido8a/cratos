<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 13/10/17
  Time: 15:40
--%>


<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>Factura</title>

    <rep:estilosFactura orientacion="p" pagTitle="${"Factura"}"/>

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

    .cabeceraIzquierda {
        margin-left: 2cm;
    }

    </style>

</head>

<body>

<div class="cabeceraIzquierda">
    <g:formatDate date="${proceso?.fechaEmision}" format="dd-MM-yyyy"/>
</div>
<div class="cabeceraIzquierda" style="margin-top: 0.60cm">
    ${proceso?.proveedor?.nombre}
</div>
<div class="cabeceraIzquierda" style="margin-top: 0.60cm">
    ${proceso?.proveedor?.ruc} <span class="centro" style="margin-left: 240px">${proceso?.proveedor?.telefono}</span>
</div>
<div class="cabeceraIzquierda" style="margin-top: 0.60cm; margin-bottom: 1cm">
    ${proceso?.proveedor?.direccion}
</div>


<div style="height: 9cm">
    <table border="0">
        <tbody>
            <g:each in="${detalles}" var="detalle">
                <tr>
                    <td class="centro" style="width: 80px">
                        ${detalle?.cantidad}
                    </td>
                    <td style="width: 270px">
                        ${detalle?.item?.nombre}
                    </td>
                    <td class="derecha" style="width: 80px">
                        <g:formatNumber number="${detalle?.precioUnitario}" maxFractionDigits="2" minFractionDigits="2" locale="en_US" format="##,##0"/>
                    </td>
                    <td class="derecha" style="width: 80px;">
                        <g:formatNumber number="${detalle?.cantidad * detalle?.precioUnitario}" maxFractionDigits="2" minFractionDigits="2" locale="en_US" format="##,##0"/>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
</div>

<g:if test="${pago?.codigo == '01'}">
    <div style="margin-top: 0.60cm; margin-left: 2.5cm">
        ${'X'}
    </div>
</g:if>
<g:else>
    <g:if test="${pago?.codigo == '17'}">
        <div style="margin-top: 0.60cm; margin-left: 5cm">
            ${'X'}
        </div>
    </g:if>
    <g:else>
        <g:if test="${pago?.codigo == '19' || pago?.codigo == '16'}">
            <div style="margin-top: 0.60cm; margin-left: 8cm">
                ${'X'}
            </div>
        </g:if>
        <g:else>
            <div style="margin-top: 0.60cm; margin-left: 9.7cm">
                ${'X'}
            </div>
        </g:else>
    </g:else>
</g:else>

<div class="derecha" style="margin-right: 0.1cm">
    <g:formatNumber number="${totl?.base__nz}" maxFractionDigits="2" minFractionDigits="2" locale="en_US" format="##,##0"/>
</div>

<div class="derecha" style="margin-top: 0.5cm; margin-right: 0.1cm">
    <g:formatNumber number="${0}" maxFractionDigits="2" minFractionDigits="2" locale="en_US" format="##,##0"/>
</div>

<div class="derecha" style="margin-top: 0.5cm; margin-right: 0.1cm">
    <g:formatNumber number="${totl?.iva}" maxFractionDigits="2" minFractionDigits="2" locale="en_US" format="##,##0"/>
</div>

<div class="derecha" style="margin-top: 0.5cm; margin-right: 0.1cm">
    <g:formatNumber number="${totl?.totl}" maxFractionDigits="2" minFractionDigits="2" locale="en_US" format="##,##0"/>
</div>



</body>
</html>