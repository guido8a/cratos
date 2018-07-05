<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Resultado Integral</title>
    <rep:estilos orientacion="p" pagTitle="${"Resultado Integral"}"/>

    <style type="text/css">

    .nivel0{
        float: left;
        font-weight: bold;
    }
    .nivel1{
        width: 10%;
        float: left;
        font-weight: bold;
        text-align: right;
    }
    .nivel2{
        width: 10%;
        float: left;
        text-align: right;
        margin-left: 30px;
        color: #1a7031;
    }
    .nivel3{
        width: 10%;
        float: left;
        text-align: right;
        margin-left: 60px;
        color: #702213;
    }
    .nivel4{
        width: 10%;
        float: left;
        text-align: right;
        margin-left: 90px;
        color: #136670;
    }
    .nivel5{
        width: 10%;
        float: left;
        text-align: right;
        margin-left: 120px;
        color: #702e4c;
    }
    .nivel6{
        width: 10%;
        float: left;
        text-align: right;
        margin-left: 150px;
        color: #606060;
    }

    .colorS{
        color: #702e4c;
    }

    .colorS{
        color: #53cf6d;
    }


</style>

</head>

<body>

<rep:headerFooter title="${"Estado de Situación " + periodo}" subtitulo="${'Datos'}" empresa="${empresa?.id}"/>

<div style="margin-top: 20px; font-size: 18px; font-weight: bold"> INGRESOS </div>

<g:each in="${cuenta4}" var="cuenta" status="i">
    <div style="width: 100%; display: inline-block">

        <g:if test="${cuenta.nivel.id.toString() == '1'}">
            <div style="height: 20px;"></div>
            <div style="width: 12%" class="nivel0">${cuenta.numero}</div>
            <div style="width: 55%" class="nivel0">${cuenta.descripcion}</div>
            <div class="nivel1">${saldo4[i]}</div>
        </g:if>
        <g:elseif test="${cuenta.nivel.id.toString() == '2'}">
            <div style="width: 12%; float: left" >${cuenta.numero}</div>
            <div style="width: 55%; float: left" >${cuenta.descripcion}</div>
            <div class="nivel2">${saldo4[i]}</div>
        </g:elseif>
        <g:elseif test="${cuenta.nivel.id.toString() == '3'}">
            <div style="width: 12%; float: left" >${cuenta.numero}</div>
            <div style="width: 55%; float: left" >${cuenta.descripcion}</div>
            <div class="nivel3">${saldo4[i]}</div>
        </g:elseif>
        <g:elseif test="${cuenta.nivel.id.toString() == '4'}">
            <div style="width: 12%; float: left" >${cuenta.numero}</div>
            <div style="width: 55%; float: left" >${cuenta.descripcion}</div>
            <div class="nivel4">${saldo4[i]}</div>
        </g:elseif>
        <g:elseif test="${cuenta.nivel.id.toString() == '5'}">
            <div style="width: 12%; float: left" >${cuenta.numero}</div>
            <div style="width: 55%; float: left" >${cuenta.descripcion}</div>
            <div class="nivel5">${saldo4[i]}</div>
        </g:elseif>
        <g:elseif test="${cuenta.nivel.id.toString() == '6'}">
            <div style="width: 12%; float: left" >${cuenta.numero}</div>
            <div style="width: 55%; float: left" >${cuenta.descripcion}</div>
            <div class="nivel6">${saldo4[i]}</div>
        </g:elseif>
        <g:else>
            <div style="width: 12%; float: left" >${cuenta.numero}</div>
            <div style="width: 55%; float: left" >${cuenta.descripcion}</div>
            <div class="nivel0">${saldo4[i]}</div>
        </g:else>

    </div>
</g:each>

<p style="margin-top: 20px; font-weight: bold">TOTAL INGRESOS: <div style="float: right">${total4}</div> </p>

<div style="margin-top: 40px; font-size: 18px; font-weight: bold"> EGRESOS </div>

<g:each in="${cuenta5}" var="cuenta51" status="i">
    <div style="width: 100%; display: inline-block">

        <g:if test="${cuenta51.nivel.id.toString() == '1'}">
            <div style="height: 20px;"></div>
            <div style="width: 12%" class="nivel0">${cuenta51.numero}</div>
            <div style="width: 55%" class="nivel0">${cuenta51.descripcion}</div>
            <div class="nivel1">${saldo5[i]}</div>
        </g:if>
        <g:elseif test="${cuenta51.nivel.id.toString() == '2'}">
            <div style="width: 12%; float: left" >${cuenta51.numero}</div>
            <div style="width: 55%; float: left" >${cuenta51.descripcion}</div>
            <div class="nivel2">${saldo5[i]}</div>
        </g:elseif>
        <g:elseif test="${cuenta51.nivel.id.toString() == '3'}">
            <div style="width: 12%; float: left" >${cuenta51.numero}</div>
            <div style="width: 55%; float: left" >${cuenta51.descripcion}</div>
            <div class="nivel3">${saldo5[i]}</div>
        </g:elseif>
        <g:elseif test="${cuenta51.nivel.id.toString() == '4'}">
            <div style="width: 12%; float: left" >${cuenta51.numero}</div>
            <div style="width: 55%; float: left" >${cuenta51.descripcion}</div>
            <div class="nivel4">${saldo5[i]}</div>
        </g:elseif>
        <g:elseif test="${cuenta51.nivel.id.toString() == '5'}">
            <div style="width: 12%; float: left" >${cuenta51.numero}</div>
            <div style="width: 55%; float: left" >${cuenta51.descripcion}</div>
            <div class="nivel5">${saldo5[i]}</div>
        </g:elseif>
        <g:elseif test="${cuenta51.nivel.id.toString() == '6'}">
            <div style="width: 12%; float: left" >${cuenta51.numero}</div>
            <div style="width: 55%; float: left" >${cuenta51.descripcion}</div>
            <div class="nivel6">${saldo5[i]}</div>
        </g:elseif>
        <g:else>
            <div style="width: 12%; float: left" >${cuenta51.numero}</div>
            <div style="width: 55%; float: left" >${cuenta51.descripcion}</div>
            <div class="nivel0">${saldo5[i]}</div>
        </g:else>

    </div>
</g:each>

<p style="margin-top: 20px; font-weight: bold">TOTAL EGRESOS: <div style="float: right">${total5}</div> </p>

<div style="margin-top: 40px; font-size: 18px; font-weight: bold"> GASTOS </div>

<g:each in="${cuenta6}" var="cuenta61" status="i">
    <div style="width: 100%; display: inline-block">

        <g:if test="${cuenta61.nivel.id.toString() == '1'}">
            <div style="height: 20px;"></div>
            <div style="width: 12%" class="nivel0">${cuenta61.numero}</div>
            <div style="width: 55%" class="nivel0">${cuenta61.descripcion}</div>
            <div class="nivel1">${saldo6[i]}</div>
        </g:if>
        <g:elseif test="${cuenta61.nivel.id.toString() == '2'}">
            <div style="width: 12%; float: left" >${cuenta61.numero}</div>
            <div style="width: 55%; float: left" >${cuenta61.descripcion}</div>
            <div class="nivel2">${saldo6[i]}</div>
        </g:elseif>
        <g:elseif test="${cuenta61.nivel.id.toString() == '3'}">
            <div style="width: 12%; float: left" >${cuenta61.numero}</div>
            <div style="width: 55%; float: left" >${cuenta61.descripcion}</div>
            <div class="nivel3">${saldo6[i]}</div>
        </g:elseif>
        <g:elseif test="${cuenta61.nivel.id.toString() == '4'}">
            <div style="width: 12%; float: left" >${cuenta61.numero}</div>
            <div style="width: 55%; float: left" >${cuenta61.descripcion}</div>
            <div class="nivel4">${saldo6[i]}</div>
        </g:elseif>
        <g:elseif test="${cuenta61.nivel.id.toString() == '5'}">
            <div style="width: 12%; float: left" >${cuenta61.numero}</div>
            <div style="width: 55%; float: left" >${cuenta61.descripcion}</div>
            <div class="nivel5">${saldo6[i]}</div>
        </g:elseif>
        <g:elseif test="${cuenta61.nivel.id.toString() == '6'}">
            <div style="width: 12%; float: left" >${cuenta61.numero}</div>
            <div style="width: 55%; float: left" >${cuenta61.descripcion}</div>
            <div class="nivel6">${saldo6[i]}</div>
        </g:elseif>
        <g:else>
            <div style="width: 12%; float: left" >${cuenta61.numero}</div>
            <div style="width: 55%; float: left" >${cuenta61.descripcion}</div>
            <div class="nivel0">${saldo6[i]}</div>
        </g:else>

    </div>
</g:each>

<p style="margin-top: 20px; font-weight: bold">TOTAL GASTOS: <div style="float: right">${total6}</div> </p>

<div style="margin-top: 30px;">
    <g:if test="${(total4 + total5) > 0}">
        RESULTADO DEL EJERCICIO:  <b class="colorS">DEFICIT <g:formatNumber number="${Math.abs(total4 + total5 + total6)}" type="number" minFractionDigits="2" maxFractionDigits="2"/></b>
    </g:if>
    <g:else>
         RESULTADO DEL EJERCICIO:  <b class="colorS">SUPERAVIT <g:formatNumber number="${Math.abs(total4 + total5 + total6)}" type="number" minFractionDigits="2" maxFractionDigits="2"/></b>
    </g:else>
</div>

</body>
</html>