<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 14/12/17
  Time: 11:17
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 14/12/17
  Time: 11:01
--%>

<%@ page import="cratos.TipoPago; cratos.FormaDePago" %>
<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 11/12/17
  Time: 10:29
--%>

<html>
<head>
    <title></title>

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
        border:1px solid black !important;
        border-collapse: separate !important;
        border-radius: 4px !important;
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

    .mar2{
        margin-top: 9px;
    }

    </style>
</head>

<body>



<div class="hoja">

    <div style="height: 100px; width: 330px;" class="left">
        <div><g:img dir="images" file="logoEmp.jpg" width="220" height="100"/></div>
    </div>

    <div style="height: 250px; width: 300px;" class="right borde" >
        <div style="font-size: 12px; margin-left: 5px">
            <div class="mar2"><strong>R.U.C.:</strong> ${empresa?.ruc ?: ''}</div>
            <div class="mar2"><strong>NOTA DE DÉBITO</strong></div>
            <div class="mar2"><strong>N°.</strong> ${proceso?.documento ?: ''}</div>
            <div class="mar2 letra2"><strong>NÚMERO DE AUTORIZACIÓN:</strong></div>
            <div class="mar2 letra3"><strong>${proceso?.claveAcceso ?: ''}</strong></div>
            <div class="mar2 letra2">FECHA Y HORA DE AUTORIZACIÓN: </div>
            <div class="mar2 letra2"><strong>AMBIENTE :</strong> ${empresa?.ambiente == '0' ? 'PRUEBAS' : 'PRODUCCIÓN'}</div>
            <div class="mar2 letra2"><strong>EMISIÓN :</strong> NORMAL</div>
            <div class="mar2 letra2">CLAVE DE ACCESO</div>
            <g:if test="${proceso?.claveAcceso}">
                <div><g:img dir="reportes3" file="showBarcode?barcode=${proceso?.claveAcceso}" width="270" height="55"/></div>
            </g:if>
            <g:else>
                <div>No tiene clave de acceso</div>
            </g:else>
        </div>
    </div>

    <div style="height: 125px; width: 330px;" class="borde pos">
        <div class="left" style="margin-left: 5px; font-size: 11px">
            <div class="mar" style="font-size: 13px !important;"><strong>${empresa?.nombre}</strong></div>
            <div class="mar"><strong>Dirección Matriz:</strong> ${empresa?.direccion ?: ''}</div>
            <div class="mar"><strong>Dirección Sucursal:</strong> ${empresa?.direccion ?: ''}</div>
            <div class="mar"><strong>Contribuyente Especial N°:</strong> ${empresa?.contribuyenteEspecial ?: ''}</div>
            <div class="mar"><strong>OBLIGADO A LLEVAR CONTABILIDAD:</strong> ${empresa?.obligadaContabilidad == '0' ? 'NO' : 'SI'}</div>
        </div>
    </div>

    <div style="height: 150px; width: 640px; margin-top: 140px" class="borde2">
        <div class="left">
            <table style="margin-left: 5px; margin-top: 10px">
                <thead style="width: 600px">
                <tr class="" style="height: 10px;">
                    <th class="tl letra3" style="width: 350px"><strong>Razón Social/Nombres y Apellidos:</strong> ${proceso?.proveedor?.nombre ?: ''}</th>
                    <th class="tl" style="width: 50px"></th>
                    <th class="tl letra3" style="width: 200px"><b>Identificación:</b> ${proceso?.proveedor?.ruc ?: ''}</th>
                </tr>
                </thead>
            </table>
            <table style="margin-left: 5px; margin-top: 20px;">
                <thead>
                <tr class="" style="height: 10px; width: 600px">
                    <th class="tl letra3" style="width: 350px"><strong>Fecha de Emisión:</strong> <g:formatDate date="${proceso?.fechaEmision}" format="dd/MM/yyyy"/></th>
                    <th class="tl" style="width: 50px"></th>
                    <th class="tl letra3" style="width: 200px"></th>
                </tr>
                </thead>
            </table>
            <table style="margin-left: 5px; margin-top: 5px;">
                <thead>
                <tr class="" style="height: 10px; width: 600px">
                    <th class="tl letra3" style="width: 50px"></th>
                    <th class="tl" style="width: 450px"><strong>_____________________________________________________________________________________</strong></th>
                    <th class="tl letra3" style="width: 100px"></th>
                </tr>
                </thead>
            </table>
            <table style="margin-left: 5px; margin-top: 10px;">
                <thead>
                <tr class="" style="height: 10px; width: 600px">
                    <th class="tl letra3" style="width: 350px"><strong>Comprobante que se modifica </strong></th>
                    <th class="tl" style="width: 50px"></th>
                    <th class="tl" style="width: 200px"><strong></strong></th>
                </tr>
                </thead>
            </table>
            <table style="margin-left: 5px; margin-top: 20px;">
                <thead>
                <tr class="" style="height: 10px; width: 600px">
                    <th class="tl letra3" style="width: 350px"><strong>Fecha de Emisión (comprobante a modificar)</strong></th>
                    <th class="tl" style="width: 50px"></th>
                    <th class="tl" style="width: 200px"><strong></strong></th>
                </tr>
                </thead>
            </table>
        </div>
    </div>

    <table border="1" style="height: 60px; width: 100%; margin-top: 10px" class="borde2">
        <thead>
        <tr>
            <th class="tc">RAZÓN DE LA MODIFICACIÓN</th>
            <th class="tc">VALOR DE LA MODIFICACIÓN</th>
        </tr>
        </thead>
        <tbody>
        <tr style="width: 100%">
            <td class="tl" style="width: 50%"></td>
            <td class="tr" style="width: 50%"><g:formatNumber number="${0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        </tbody>
    </table>


    %{--<div style="margin-top: 15px;">--}%
        %{--<table border="1" style="width:100%;">--}%
            %{--<thead>--}%
            %{--<tr>--}%
                %{--<th class="tc letra">Código</th>--}%
                %{--<th class="tc letra">Código Auxiliar</th>--}%
                %{--<th class="tc letra">Cantidad</th>--}%
                %{--<th class="tc letra">Descripción</th>--}%
                %{--<th class="tc letra">Precio Unitario</th>--}%
                %{--<th class="tc letra">Descuento</th>--}%
                %{--<th class="tc letra">Precio Total</th>--}%
            %{--</tr>--}%
            %{--</thead>--}%
            %{--<tbody>--}%
            %{--<g:set value="${0}" var="total"/>--}%
            %{--<g:each in="${detalles}" var="detalle">--}%
                %{--<tr class="letra" style="width: 100%">--}%
                    %{--<td class="tl" style="width: 8.3%">${detalle?.item?.codigo ?: ''}</td>--}%
                    %{--<td class="tl" style="width: 6.3%"></td>--}%
                    %{--<td class="tc" style="width: 4.3%">${detalle?.cantidad?.toInteger() ?: 0}</td>--}%
                    %{--<td class="tl" style="width: 32.5%">${detalle?.item?.nombre ?: ''}</td>--}%
                    %{--<td class="tr" style="width: 8.3%"><g:formatNumber number="${detalle?.precioUnitario ?: 0}" maxFractionDigits="2" minFractionDigits="2"/></td>--}%
                    %{--<td class="tr" style="width: 6.3%"></td>--}%
                    %{--<td class="tr" style="width: 8.3%"><g:formatNumber number="${(detalle?.cantidad?.toInteger() ?: 0) * (detalle?.precioUnitario?.toDouble() ?: 0)}" maxFractionDigits="2" minFractionDigits="2"/></td>--}%
                %{--</tr>--}%
            %{--</g:each>--}%
            %{--</tbody>--}%
        %{--</table>--}%
    %{--</div>--}%

    <div style="height: 175px; width: 400px; margin-top: 10px" class="left borde2" >
        <div style="margin-top: 10px; margin-left: 10px"><strong>Información Adicional</strong></div>
        <div style="margin-top: 10px">
            <table style="margin-left: 5px">
                <thead>
                <tr class="letra2" style="height: 20px">
                    <th class="tl tam3">Dirección</th>
                    <th class="tl">${proceso?.proveedor?.direccion ?: ''}</th>
                </tr>
                <tr class="letra2" style="height: 10px">
                    <th class="tl tam3">Email</th>
                    <th class="tr">${proceso?.proveedor?.email ?: ''}</th>
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
            <td class="tl tam letra2">${cratos.TipoPago.findByCodigo(proceso?.pago)?.descripcion?.toUpperCase() ?: ''}</td>
            <td class="tc"><g:formatNumber number="${proceso?.valor ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        </tbody>
    </table>


</div>
</body>
</html>