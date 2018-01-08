<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 1/8/14
  Time: 1:32 PM
--%>


<html>
<head>
    <title>Retención</title>
    <style type="text/css">
    @page {
        /*size   : 29.7cm 21cm;  *//*width height */
        size   : 21cm 29.7cm;/*  width height*/
        margin : 1.5cm;
    }

    html {
        font-family : Verdana, Arial, sans-serif;
        font-size   : 11px;
    }

    .hoja {
        width      : 17cm;
    }

    .left {
        float      : left;
        min-height : 30px;
    }

    .right {
        float      : right;
        min-height : 30px;
    }

    table {
        font-size       : 11px;
        border-collapse : collapse;
    }

    .info {
        padding : 2px 0;
    }

    .tr {
        text-align : right;
    }

    .tc {
        text-align : center;
    }

    .tl {
        text-align : left;
    }
    </style>
</head>

<body>
<div class="hoja">
    <div style="height: 150px;">
        <div class="left">
            <h1>
                ${empresa.nombre}
            </h1>

            <div class="info">Dirección: ${empresa.direccion}</div>
            <div class="info">Teléfonos: ${empresa.telefono}</div>
            <div class="info">${empresa?.canton?.nombre ?: ' '}  Ecuador</div>
            <div class="info">R.U.C.: ${empresa.ruc}</div>
        </div>

        <div class="right" style="margin-top: 20px;">
            <div class="info"><strong>Autorización del S.R.I.:</strong> ${proceso?.autorizacion ?: ''}</div>
            <div class="info"><strong>COMPROBANTE DE RETENCIÓN</strong> ${retencion?.documentoEmpresa?.numeroEstablecimiento}-${retencion.documentoEmpresa?.numeroEmision}</div>
            <h3>N. ${retencion?.numero ?: 0}</h3>
        </div>
    </div>

    <div style="height: 200px; margin-top: 15px">
        <div class="left">
            <div class="info"><strong>Sres.:</strong> ${proceso.proveedor.nombre}</div>
            <div class="info"><strong>R.U.C.:</strong> ${proceso.proveedor.ruc}</div>
            <div class="info"><strong>Dirección:</strong> ${proceso.proveedor.direccion}</div>
            <div class="info"><strong>Teléfono:</strong> ${proceso.proveedor.telefono}</div>
        </div>

        <div class="right">
            <div class="info"><strong>Lugar y fecha de emisión:</strong> Quito, ${retencion.fecha.format("dd")} de ${meses[retencion.fecha.format("MM").toInteger()]} del ${retencion.fecha.format("yyyy")}</div>
            <div class="info"><strong>Tipo de comprobante de venta:</strong> ${proceso.tipoCmprSustento?.tipoComprobanteSri?.descripcion}</div>
            <div class="info"><strong>No. de comprobante de venta:</strong> ${proceso?.documento}</div>
            <div class="info"><strong>Ejercicio fiscal:</strong> ${proceso?.contabilidad?.fechaInicio?.format("yyyy")}</div>
        </div>
    </div>

    <div style="margin-top: 15px;">
        <table border="1" style="width:100%;" cellpadding="4">
            <thead>
            <tr>
                <th class="tc">Documento</th>
                <th class="tc">Base Imponible</th>
                <th class="tc">Impuesto</th>
                <th class="tc">Cod Ret</th>
                <th class="tr">% Ret</th>
                <th class="tr">Valor Retenido</th>
            </tr>
            </thead>
            <tbody>
            <g:set value="${0}" var="total"/>

            <tr style="font-size: 10px !important;">
                <td>
                    ${proceso.tipoCmprSustento?.tipoComprobanteSri?.descripcion + " " + proceso?.documento}
                </td>
                <td class="tr">
                    <g:formatNumber number="${retencion?.baseRenta}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/>
                </td>
                <td>
                    ${retencion?.conceptoRIRBienes?.descripcion}
                </td>
                <td class="tc">
                    ${retencion?.conceptoRIRBienes?.codigo}
                </td>
                <td class="tr">
                    ${retencion?.conceptoRIRBienes?.porcentaje}
                </td>
                <td class="tr">
                    <g:formatNumber number="${retencion?.renta}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/>
                    <g:set value="${total += retencion?.renta}" var="total"/>
                </td>
            </tr>
            <tr>
                <td>
                    ${proceso.tipoCmprSustento?.tipoComprobanteSri?.descripcion + " " + proceso?.documento}
                </td>
                <td class="tr">
                    <g:formatNumber number="${retencion?.baseRentaServicios}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/>
                </td>
                <td>
                    ${retencion?.conceptoRIRServicios?.descripcion}
                </td>
                <td class="tc">
                    ${retencion?.conceptoRIRServicios?.codigo}
                </td>
                <td class="tr">
                    ${retencion?.conceptoRIRServicios?.porcentaje}
                </td>
                <td class="tr">
                    <g:formatNumber number="${retencion?.rentaServicios}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/>
                    <g:set value="${total += retencion?.rentaServicios}" var="total"/>
                </td>
            </tr>
            </tbody>
            <tfoot>
            <tr>
                <th colspan="3"></th>
                <th class="tr" colspan="2">TOTAL RETENIDO</th>
                <th class="tr">$ <g:formatNumber number="${total}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
            </tr>
            </tfoot>
        </table>
    </div>

</div>

</body>
</html>