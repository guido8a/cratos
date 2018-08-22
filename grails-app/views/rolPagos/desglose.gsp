<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 22/08/18
  Time: 10:21
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 20/08/18
  Time: 14:47
--%>


<%@ page import="cratos.RolPagos" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Desglose de Pagos</title>

    <style>

    .centrado{
        text-align: center;
    }

    .derecha {
        text-align: right;
    }

    </style>
</head>
<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <a href="#" class="btn btn-warning btnRegresarEmp">
            <i class="fa fa-chevron-left"></i> Regresar
        </a>
    </div>
</div>

<div class="alert alert-info" style="text-align: center; margin-top: 5px">
    <label>Empleado: ${empleado?.persona?.nombre + " " + empleado?.persona?.apellido}</label></br>
    <label>Rol de Pagos: ${rol?.mess?.descripcion + " - " + rol?.anio?.anio}</label>
</div>

<g:set var="totalIng" value="${0}"/>
<g:set var="totalDesc" value="${0}"/>
<g:set var="neto" value="${0}"/>

<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <th style="width: 70%">Concepto</th>
        <th style="width: 15%">Ingresos</th>
        <th style="width: 15%">Descuentos</th>
    </tr>
    </thead>
    <tbody>

    <g:each in="${detalles}" var="detalle">
        <tr>
            <td>${detalle?.rubroTipoContrato?.descripcion ?: ''}</td>
            <g:if test="${detalle?.rubroTipoContrato?.rubro?.tipoRubro?.codigo == 'I'}">
                <td class="derecha"><g:formatNumber number="${detalle?.valor}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/></td>
                <g:set var="totalIng" value="${totalIng += (detalle?.valor ?: 0)}"/>
                <td></td>
            </g:if>
            <g:else>
                <td></td>
                <td class="derecha"><g:formatNumber number="${detalle?.valor}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/></td>
                <g:set var="totalDesc" value="${totalDesc += (detalle?.valor ?: 0)}"/>
            </g:else>
        </tr>
    </g:each>
    </tbody>
</table>

<table class="table table-condensed table-bordered table-striped">
    <tbody>
    <tr style="width: 100%">
        <td style="width: 70%"></td>
        <td class="derecha" style="width: 15%"><g:formatNumber number="${totalIng}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/></td>
        <td class="derecha" style="width: 15%"><g:formatNumber number="${totalDesc}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/></td>
    </tr>
    <tr style="width: 100%">
        <td class="derecha" style="width: 70%"></td>
        <td class="derecha" style="width: 15%"><b>Neto a Pagar:</b></td>
        <td class="derecha" style="width: 15%"><g:formatNumber number="${totalIng + totalDesc}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/></td>
    </tr>
    </tbody>
</table>

<script type="text/javascript">

    $(".btnRegresarEmp").click(function () {
        location.href="${createLink(controller: 'rolPagos', action: 'empleados')}/?id=" + ${rol?.id};
    });


</script>

</body>
</html>
