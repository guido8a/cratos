<%@ page import="cratos.TipoPago; cratos.FormaDePago" %>
<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 11/12/17
  Time: 10:29
--%>

<html>
<head>
    <title>Retención</title>
    <style type="text/css">
    @page {
        size   : 21cm 29.7cm;/*  width height*/
        margin : 1.5cm;
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

    .tr {
        text-align : right;
    }

    .tc {
        text-align : center;
    }

    .tl {
        text-align : left;
    }

    .borde{
        border: 1px solid;
        border-radius: 5px !important;
    }

    .borde2{
        border: 1px solid;
    }

    .pos{
        position: relative;
        top: 125px;
    }

    .letra{
        font-size: 8px;
    }

    .letra2{
        font-size: 10px;
    }

    .letra3{
        font-size: 9px;
    }

    .tam{
        width: 70%;
    }

    .tam2{
        width: 90%;
    }

    .tam3{
        width: 40%;
    }

        .mar{
            margin-top: 10px;
        }

    </style>
</head>

<body>
<div class="hoja">
    <div style="height: 250px; width: 300px;" class="right borde" >
        <div style="font-size: 12px; margin-left: 5px">
            <div class="mar"><strong>R.U.C.:</strong> ${empresa?.ruc}</div>
            <div class="mar"><strong>FACTURA</strong></div>
            <div class="mar"><strong>N°.</strong> ${proceso?.documento}</div>
            <div class="mar letra2"><strong>NÚMERO DE AUTORIZACIÓN:</strong></div>
            <div class="mar letra3"><strong>1812201601208210000001507017908965449</strong></div>
            <div class="mar letra2">FECHA Y HORA DE AUTORIZACIÓN: </div>
            <div class="mar letra2"><strong>AMBIENTE :</strong> PRUEBAS</div>
            <div class="mar letra2"><strong>EMISIÓN :</strong> NORMAL</div>
            <div class="mar letra2">CLAVE DE ACCESO</div>
        </div>
    </div>

    <div style="height: 125px; width: 330px;" class="borde pos">
        <div class="left" style="margin-left: 5px; font-size: 11px">
            <div class="mar" style="font-size: 13px !important;"><strong>${empresa?.nombre}</strong></div>
            <div class="mar"><strong>Dirección Matriz:</strong> ${empresa?.direccion}</div>
            <div class="mar"><strong>Dirección Sucursal:</strong> ${empresa?.direccion}</div>
            <div class="mar"><strong>Contribuyente Especial N°:</strong></div>
            <div class="mar"><strong>Obligado a llevar contabilidad: </strong></div>
        </div>
    </div>

    <div style="height: 105px; width: 640px; margin-top: 140px" class="borde2">
        <div class="left">
            <table style="margin-left: 5px; margin-top: 10px">
                <thead style="width: 600px">
                <tr class="" style="height: 10px;">
                    <th class="tl letra3" style="width: 350px"><strong>Razón Social/Nombres y Apellidos:</strong> ${proceso?.proveedor?.nombre}</th>
                    <th class="tl" style="width: 50px"></th>
                    <th class="tl letra3" style="width: 200px"><b>Identificación:</b> ${proceso?.proveedor?.ruc}</th>
                </tr>
                </thead>
            </table>
            <table style="margin-left: 5px; margin-top: 20px;">
                <thead>
                <tr class="" style="height: 10px; width: 600px">
                    <th class="tl letra3" style="width: 350px"><strong>Fecha de Emisión:</strong> <g:formatDate date="${proceso?.fechaEmision}" format="dd/MM/yyyy"/></th>
                    <th class="tl" style="width: 50px"></th>
                    <th class="tl letra3" style="width: 200px"><strong>Guía de Remisión:</strong></th>
                </tr>
                </thead>
            </table>
            <table style="margin-left: 5px; margin-top: 20px;">
                <thead>
                <tr class="" style="height: 10px; width: 600px">
                    <th class="tl letra3" style="width: 350px"><strong>Dirección: </strong>${proceso?.proveedor?.direccion}</th>
                    <th class="tl" style="width: 50px"></th>
                    <th class="tl" style="width: 200px"><strong></strong></th>
                </tr>
                </thead>
            </table>
        </div>
    </div>

    <div style="margin-top: 15px;">
        <table border="1" style="width:100%;">
            <thead>
            <tr>
                <th class="tc letra">Cod. Principal</th>
                <th class="tc letra">Cod. Auxiliar</th>
                <th class="tc letra">Cant.</th>
                <th class="tc letra">Descripción</th>
                <th class="tc letra">Detalle Adicional</th>
                <th class="tc letra">Detalle Adicional</th>
                <th class="tc letra">Detalle Adicional</th>
                <th class="tc letra">Precio Unitario</th>
                <th class="tc letra">Subsidio</th>
                <th class="tc letra">Precio Sin Subsidio</th>
                <th class="tc letra">Descuento</th>
                <th class="tc letra">Precio Total</th>
            </tr>
            </thead>
            <tbody>
            <g:set value="${0}" var="total"/>
            <g:each in="${detalles}" var="detalle">
                <tr>
                    <td class="tl">${detalle?.item?.codigo}</td>
                    <td class="tl"></td>
                    <td class="tc">${detalle?.cantidad?.toInteger()}</td>
                    <td class="tl">${detalle?.item?.nombre}</td>
                    <td class="tl"></td>
                    <td class="tl"></td>
                    <td class="tl"></td>
                    <td class="tr"><g:formatNumber number="${detalle?.precioUnitario}" maxFractionDigits="2" minFractionDigits="2"/></td>
                    <td class="tr"></td>
                    <td class="tr"></td>
                    <td class="tr"></td>
                    <td class="tr"><g:formatNumber number="${detalle?.cantidad * detalle?.precioUnitario}" maxFractionDigits="2" minFractionDigits="2"/></td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>


    <div style="height: 175px; width: 400px; margin-top: 10px" class="left borde2" >
        <div style="margin-top: 10px; margin-left: 10px"><strong>Información Adicional</strong></div>
        <div style="margin-top: 10px">
            <table style="margin-left: 5px">
                <thead>
                <tr class="letra2" style="height: 20px">
                    <th class="tl tam3">Dirección</th>
                    <th class="tl">${proceso?.proveedor?.direccion}</th>
                </tr>
                <tr class="letra2" style="height: 10px">
                    <th class="tl tam3">Email</th>
                    <th class="tr">${proceso?.proveedor?.email}</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>

    <table border="1" style="height: 100px; width: 230px; margin-top: 10px" class="right borde2">
        <thead>
        <tr>
            <th class="tl tam">SUBTOTAL 12%</th>
            <th class="tr"><g:formatNumber number="${proceso?.baseImponibleIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
        </tr>
        <tr>
            <th class="tl tam">SUBTOTAL IVA 0%</th>
            <th class="tr"><g:formatNumber number="${proceso?.baseImponibleIva0 ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
        </tr>
        <tr>
            <th class="tl tam">SUBTOTAL NO OBJETO IVA</th>
            <th class="tr"><g:formatNumber number="${proceso?.baseImponibleNoIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
        </tr>
        <tr>
            <th class="tl tam">SUBTOTAL EXENTO IVA</th>
            <th class="tr"><g:formatNumber number="${proceso?.excentoIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
        </tr>
        <tr>
            <th class="tl tam">SUBTOTAL SIN IMPUESTOS</th>
            <th class="tr"><g:formatNumber number="${proceso?.baseImponibleIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
        </tr>
        <tr>
            <th class="tl tam">DESCUENTOS</th>
            <th class="tr"><g:formatNumber number="${0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
        </tr>
        <tr>
            <th class="tl tam">ICE</th>
            <th class="tr"><g:formatNumber number="${proceso?.iceGenerado ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
        </tr>
        <tr>
            <th class="tl tam">IVA 12%</th>
            <th class="tr"><g:formatNumber number="${proceso?.ivaGenerado ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
        </tr>
        <tr>
            <th class="tl tam">IRBPNR</th>
            <th class="tr"><g:formatNumber number="${0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
        </tr>
        <tr>
            <th class="tl tam">PROPINA</th>
            <th class="tr"><g:formatNumber number="${0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
        </tr>
        <tr>
            <th class="tl tam">VALOR TOTAL</th>
            <th class="tr"><g:formatNumber number="${proceso?.valor ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
        </tr>

        </thead>
    </table>


    <table border="1" style="height: 60px; width: 320px; margin-top: 10px" class="left borde2">
        <thead>
        <tr>
            <th class="tc tam">Forma de Pago</th>
            <th class="tc">Valor</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td class="tl tam letra2">${cratos.TipoPago.findByCodigo(proceso?.pago)?.descripcion?.toUpperCase()}</td>
            <td class="tc"><g:formatNumber number="${proceso?.valor ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        </tbody>
    </table>

    <div style="height: 60px; width: 230px;" class="right borde2">
        <div>
            <table>
                <thead>
                <tr class="letra2" style="height: 20px">
                    <th class="tl tam2">VALOR TOTAL SIN SUBSIDIO</th>
                    <th class="tr"><g:formatNumber number="${0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
                </tr>
                <tr class="letra2" style="height: 10px">
                    <th class="tl tam2">AHORRO POR SUBSIDIO</th>
                    <th class="tr"><g:formatNumber number="${0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
                </tr>
                <tr class="letra2">
                    <th class="tl tam2" style="font-size: 9px">(Incluye IVA cuando corresponda)</th>
                    <th class="tr"></th>
                </tr>
                </thead>
            </table>
        </div>
    </div>


</div>
</body>
</html>