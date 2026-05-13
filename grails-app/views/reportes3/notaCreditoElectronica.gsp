<%@ page import="cratos.TipoPago; cratos.FormaDePago" %>

<html>
<head>
    <title></title>

    <style type="text/css">

    @page {
        size   : 21cm 29.7cm;/*  width height*/
        margin : 1.8cm;
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
        border-radius: 8px !important;
        border:1px solid black !important;
        border-collapse: separate !important;
        border: 0.3px solid grey !important;
        padding: 1px;
    }

    .borde2{
        border: 1px solid;
    }

    .pos{
        position: relative;
        top: 125px;
    }

    .letra{
        font-size: 11px;
    }

    .letra2{
        font-size: 11px;
    }

    .letra3{
        font-size: 11px;
    }

    .tam{
        /*width: 70%;*/
        padding: 3px;
    }

    .tam2{
        width: 90%;
    }

    .tam3{
        width: 40%;
    }

    .mar1{
        margin-top: 9px;
        font-size: 12pt;
    }

    .mar{
        margin-top: 9px;
        /*font-size: 12pt;*/
    }

    .mar2{
        margin-top: 7px;
    }

    </style>
</head>

<body style="font-family: Helvetica Neue, Helvetica, Arial, sans-serif;">

<div class="hoja">
    <div style="height: 100px; width: 330px;" class="left">
        <div><g:img dir="images" file="logoTedein.png" width="300" height="100"/></div>
    </div>

    <div style="height: 260px; width: 300px;" class="right borde" >
        <div style="font-size: 12px; margin-left: 5px">
            <div class="mar2"><strong>R.U.C.:</strong> ${empresa?.ruc ?: ''}</div>
            <div class="mar1"><strong>NOTA DE CRÉDITO</strong></div>
            <div class="mar1"><strong>N°.</strong> ${proceso?.documento ?: ''}</div>
            <div class="mar2 letra2"><strong>NÚMERO DE AUTORIZACIÓN:</strong></div>
            <div class="mar2 letra3"><strong>${proceso?.claveAcceso ?: ''}</strong></div>
            <div class="mar2 letra2">FECHA Y HORA DE AUTORIZACIÓN: ${proceso?.fechaAutorizacion?.format('dd/MM/yyyy HH:mm')}  </div>
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
    <div style="height: 135px; width: 320px;" class="borde pos">
        <div class="left" style="margin-left: 5px; margin-top: 5px; font-size: 11px">
            <div class="mar" style="font-size: 13px !important;"><strong>${empresa?.nombre}</strong></div>
            <div class="mar"><strong>Dirección Matriz:</strong> ${empresa?.direccion ?: ''}</div>
            <div class="mar"><strong>Dirección Sucursal:</strong> ${empresa?.direccion ?: ''}</div>
            <div class="mar"><strong>Contribuyente Régimen RIMPE</strong></div>
            <div class="mar"><strong>OBLIGADO A LLEVAR CONTABILIDAD:</strong> ${empresa?.obligadaContabilidad == '0' ? 'NO' : 'SI'}</div>
        </div>
    </div>
    <div style="height: 100px; width: 640px; margin-top: 140px" class="borde2">
        <div class="left">
            <table style="margin-left: 10px; margin-top: 10px">
                <tr class="" style="height: 20px;">
                    <td class="tl letra3" style="width: 350px"><strong>Razón Social / Nombres y Apellidos:</strong> ${proceso?.proveedor?.nombre ?: ''}</td>
                    <td class="tl" style="width: 50px"></td>
                    <td class="tl letra3" style="width: 200px"><b>Identificación:</b> ${proceso?.proveedor?.ruc ?: ''}</td>
                </tr>
                <tr class="" style="height: 20px; width: 600px">
                    <td class="tl letra3" style="width: 350px"><strong>Comprobante que se modifica:  </strong> ${proceso?.comprobante?.proceso?.documento} </td>
                    <td class="tl" style="width: 50px"></td>
                    <td class="tl letra3" style="width: 200px"><strong>Fecha de Emisión:</strong> <g:formatDate date="${proceso?.fechaEmision}" format="dd/MM/yyyy"/></td>
                </tr>
%{--                <tr class="" style="height: 20px; width: 600px">--}%
%{--                    <td class="tl letra3" style="width: 350px"><strong>Comprobante que se modifica: </strong></td>--}%
%{--                    <td class="tl" style="width: 50px"></td>--}%
%{--                    <td class="tl letra3" style="width: 200px"><strong> </strong> </td>--}%
%{--                </tr>--}%
                <tr class="" style="height: 20px; width: 600px">
                    <td class="tl letra3" style="width: 350px"><strong>Razón de modificación: </strong> ${proceso?.descripcion}</td>
                    <td class="tl" style="width: 50px"></td>
                    <td class="tl letra3" style="width: 200px"></td>
                </tr>
                <tr class="" style="height: 20px; width: 600px">
                    <td class="tl letra3" style="width: 350px"><strong>Fecha de Emisión (comprobante a modificar): </strong> <g:formatDate date="${proceso?.comprobante?.proceso?.fecha}" format="dd/MM/yyyy"/></td>
                    <td class="tl" style="width: 50px"></td>
                    <td class="tl" style="width: 200px"><strong></strong> </td>
                </tr>
            </table>
        </div>
    </div>


%{--    <div style="height: 200px; width: 640px; margin-top: 140px" class="borde2">--}%
%{--        <div class="left">--}%
%{--            <table style="margin-left: 5px; margin-top: 10px">--}%
%{--                <thead style="width: 600px">--}%
%{--                <tr class="" style="height: 10px;">--}%
%{--                    <th class="tl letra3" style="width: 350px"><strong>Razón Social/Nombres y Apellidos:</strong> ${proceso?.proveedor?.nombre ?: ''}</th>--}%
%{--                    <th class="tl" style="width: 50px"></th>--}%
%{--                    <th class="tl letra3" style="width: 200px"><b>Identificación:</b> ${proceso?.proveedor?.ruc ?: ''}</th>--}%
%{--                </tr>--}%
%{--                </thead>--}%
%{--            </table>--}%
%{--            <table style="margin-left: 5px; margin-top: 20px;">--}%
%{--                <thead>--}%
%{--                <tr class="" style="height: 10px; width: 600px">--}%
%{--                    <th class="tl letra3" style="width: 350px"><strong>Fecha de Emisión:</strong> <g:formatDate date="${proceso?.fechaEmision}" format="dd/MM/yyyy"/></th>--}%
%{--                    <th class="tl" style="width: 50px"></th>--}%
%{--                    <th class="tl letra3" style="width: 200px"></th>--}%
%{--                </tr>--}%
%{--                </thead>--}%
%{--            </table>--}%
%{--            <table style="margin-left: 5px; margin-top: 5px;">--}%
%{--                <thead>--}%
%{--                <tr class="" style="height: 10px; width: 600px">--}%
%{--                    <th class="tl letra3" style="width: 50px"></th>--}%
%{--                    <th class="tl" style="width: 450px"><strong>_____________________________________________________________________________________</strong></th>--}%
%{--                    <th class="tl letra3" style="width: 100px"></th>--}%
%{--                </tr>--}%
%{--                </thead>--}%
%{--            </table>--}%
%{--            <table style="margin-left: 5px; margin-top: 10px;">--}%
%{--                <thead>--}%
%{--                <tr class="" style="height: 10px; width: 600px">--}%
%{--                    <th class="tl letra3" style="width: 350px"><strong>Comprobante que se modifica </strong></th>--}%
%{--                    <th class="tl" style="width: 50px"></th>--}%
%{--                    <th class="tl" style="width: 200px"><strong></strong></th>--}%
%{--                </tr>--}%
%{--                </thead>--}%
%{--            </table>--}%
%{--            <table style="margin-left: 5px; margin-top: 20px;">--}%
%{--                <thead>--}%
%{--                <tr class="" style="height: 10px; width: 600px">--}%
%{--                    <th class="tl letra3" style="width: 350px"><strong>Fecha de Emisión (comprobante a modificar)</strong></th>--}%
%{--                    <th class="tl" style="width: 50px"></th>--}%
%{--                    <th class="tl" style="width: 200px"><strong></strong></th>--}%
%{--                </tr>--}%
%{--                </thead>--}%
%{--            </table>--}%
%{--            <table style="margin-left: 5px; margin-top: 20px;">--}%
%{--                <thead>--}%
%{--                <tr class="" style="height: 10px; width: 600px">--}%
%{--                    <th class="tl letra3" style="width: 350px"><strong>Razón de modificación:</strong></th>--}%
%{--                    <th class="tl" style="width: 50px"></th>--}%
%{--                    <th class="tl" style="width: 200px"><strong></strong></th>--}%
%{--                </tr>--}%
%{--                </thead>--}%
%{--            </table>--}%
%{--        </div>--}%
%{--    </div>--}%


    <div style="margin-top: 15px;">
        <table>
            <thead>
            <tr>
                <th class="tc letra borde">Código</th>
%{--                <th class="tc letra">Código Auxiliar</th>--}%
                <th class="tc letra borde">Cant.</th>
                <th class="tc letra borde">Descripción</th>
                <th class="tc letra borde">Precio Unitario</th>
                <th class="tc letra borde">Descuento</th>
                <th class="tc letra borde">Precio Total</th>
            </tr>
            </thead>
            <tbody>
            <g:set value="${0}" var="total"/>
            <g:each in="${detalles}" var="detalle">
                <tr class="tc letra" style="width: 100%">
                    <td class="borde tc tl" style="width: 10%">${detalle?.item?.codigo ?: ''}</td>
%{--                    <td class="tl" style="width: 6.3%"></td>--}%
                    <td class="borde tc" style="width: 4%">${detalle?.cantidad?.toInteger() ?: 0}</td>
                    <td class="borde tl" style="width: 56%">${detalle?.item?.nombre ?: ''}</td>
                    <td class="borde tr" style="width: 10%"><g:formatNumber number="${detalle?.precioUnitario ?: 0}" maxFractionDigits="2" minFractionDigits="2"/></td>
                    <td class="borde tr" style="width: 10%"><g:formatNumber number="${detalle?.descuento ?: 0}" maxFractionDigits="2" minFractionDigits="2"/></td>
                    <td class="borde tr" style="width: 10%"><g:formatNumber number="${(detalle?.cantidad?.toInteger() ?: 0) * (detalle?.precioUnitario?.toDouble() ?: 0)}" maxFractionDigits="2" minFractionDigits="2"/></td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div style="height: 139px; width: 400px; margin-top: 10px" class="left borde2">
        <div style="margin-top: 10px; margin-left: 5px; font-size: 11px"><strong>Información Adicional</strong></div>
            <table class="letra2" style="margin-left: 5px; margin-top: 10px; width: 100%">
                <tbody>
                <tr style="height: 20px">
                    <td class="mar" style="width: 30%">Cliente</td>
                    <td class="" style="width: 70%">${proceso?.proveedor?.nombre ?: ''}</td>
                </tr>
                <tr style="height: 20px">
                    <td class="mar" style="width: 30%">Dirección</td>
                    <td class="" style="width: 70%">${proceso?.proveedor?.direccion ?: ''}</td>
                </tr>
                <tr style="height: 20px">
                    <td class="mar" style="width: 30%">Teléfono</td>
                    <td class="" style="width: 70%">${proceso?.proveedor?.telefono ?: ''}</td>
                </tr>
%{--                <tr class="letra2" style="height: 10px">--}%
%{--                    <th class="tl tam3">Email</th>--}%
%{--                    <th class="tr">${proceso?.proveedor?.email ?: ''}</th>--}%
%{--                </tr>--}%
                <tr style="height: 20px">
                    <td class="mar" style="width: 30%">Documento modificado</td>
                    <td class="" style="width: 70%">${proceso?.comprobante?.proceso?.documento}</td>
                </tr>
                </tbody>
            </table>
    </div>

    <table border="1" style="height: 100px; width: 230px; margin-top: 10px" class="right borde2">
        <thead>
        <tr>
            <th class="tl tam">SUBTOTAL 15%</th>
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
%{--        <tr>--}%
%{--            <th class="tl tam">ICE</th>--}%
%{--            <th class="tr"><g:formatNumber number="${proceso?.iceGenerado ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>--}%
%{--        </tr>--}%
        <tr>
            <th class="tl tam">IVA 15%</th>
            <th class="tr"><g:formatNumber number="${proceso?.ivaGenerado ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
        </tr>
%{--        <tr>--}%
%{--            <th class="tl tam">IRBPNR</th>--}%
%{--            <th class="tr"><g:formatNumber number="${0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>--}%
%{--        </tr>--}%
        <tr>
            <th class="tl tam">VALOR TOTAL</th>
            <th class="tr"><g:formatNumber number="${proceso?.valor ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></th>
        </tr>

        </thead>
    </table>




</div>
</body>
</html>