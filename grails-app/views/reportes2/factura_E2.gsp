<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 27/10/17
  Time: 16:34
--%>
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
<div class="cabeceraIzquierda" style="margin-top: 0.40cm; margin-left: 100px">
    ${proceso?.proveedor?.nombre}
</div>
<div class="cabeceraIzquierda" style="margin-top: 0.30cm">
    ${proceso?.proveedor?.ruc} <span class="centro" style="margin-left: 240px">${proceso?.proveedor?.telefono}</span>
</div>
<div class="cabeceraIzquierda" style="margin-top: 0.30cm; margin-bottom: 1cm">
    ${proceso?.proveedor?.direccion}
</div>


<div style="height: 9.4cm">
    <table border="0">
        <tbody>
        <g:each in="${detalles}" var="detalle">
            <tr style="width: 540px">
                <td class="centro" style="width: 60px">
                    ${detalle?.cantidad}
                </td>
                <td style="width: 330px">
                    ${detalle?.item?.nombre}
                </td>
                <td class="derecha" style="width: 75px">
                    <g:formatNumber number="${detalle?.precioUnitario}" maxFractionDigits="2" minFractionDigits="2" locale="en_US" format="##,##0"/>
                </td>
                <td class="derecha" style="width: 75px;">
                    <g:formatNumber number="${detalle?.cantidad * detalle?.precioUnitario}" maxFractionDigits="2" minFractionDigits="2" locale="en_US" format="##,##0"/>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<div>
    <table border="0">
        <tbody>
        <tr>
            <td style="width: 380px">
                <g:if test="${pago?.codigo == '01'}">
                    <div style="margin-left: 1cm">
                        ${'X'}

                    </div>
                </g:if>
                <g:else>
                    <g:if test="${pago?.codigo == '17'}">
                        <div style="margin-left: 3.5cm">
                            ${'X'}
                        </div>
                    </g:if>
                    <g:else>
                        <g:if test="${pago?.codigo == '19' || pago?.codigo == '16'}">
                            <div style="margin-left: 6.5cm">
                                ${'X'}
                            </div>
                        </g:if>
                        <g:else>
                            <div style="margin-left: 8.2cm">
                                ${'X'}
                            </div>
                        </g:else>
                    </g:else>
                </g:else>
            </td>
            <td style="width: 80px">
            </td>
            <td style="width: 80px" class="derecha">
                <g:formatNumber number="${totl?.base__nz}" maxFractionDigits="2" minFractionDigits="2" locale="en_US" format="##,##0"/>
            </td>
        </tr>
        <tr style="margin-top: 0.50cm">
            <td style="width: 380px"></td>
            <td style="width: 80px"></td>
            <td style="width: 80px" class="derecha">
                <g:formatNumber number="${0}" maxFractionDigits="2" minFractionDigits="2" locale="en_US" format="##,##0"/>
            </td>
        </tr>
        <tr style="margin-top: 0.50cm">
            <td style="width: 380px"></td>
            <td style="width: 80px"></td>
            <td style="width: 80px" class="derecha">
                <g:formatNumber number="${totl?.iva}" maxFractionDigits="2" minFractionDigits="2" locale="en_US" format="##,##0"/>
            </td>
        </tr>
        <tr style="margin-top: 0.50cm">
            <td style="width: 380px"></td>
            <td style="width: 80px"></td>
            <td style="width: 80px" class="derecha">
                <g:formatNumber number="${totl?.totl}" maxFractionDigits="2" minFractionDigits="2" locale="en_US" format="##,##0"/>
            </td>
        </tr>
        </tbody>
    </table>
</div>

</body>
</html>