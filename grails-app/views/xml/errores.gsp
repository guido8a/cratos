<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 12/23/13
  Time: 12:31 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Errores</title>
    </head>

    <body>
        <g:if test="${params.tipo == '1'}">
            <div class="alert alert-danger">
                <i class="fa fa-warning fa-4x pull-left"></i>
                <h3>Atención</h3>
                Ya existe un archivo XML para el periodo ${params.periodo}.<br/>
                Si desea sobreescribir el archivo existente, haga click en el botón 'Sobreescribir'<br/>
                Si desea descargar un archivo previamente generado, haga cilck en el botón 'Descargas'<br/><br/>
                <g:link class="btn btn-default btnBack" action="xml">
                    <i class="fa fa-arrow-left"></i> Regresar</g:link>
                <g:link class="btn btn-warning btnOverride" action="printXml" params="[mes: params.mes, anio: params.anio, override: 1]" style="margin-left:15px;">
                    <i class="fa fa-pencil"></i> Sobreescribir</g:link>
                <g:link class="btn btn-success btnDownload" action="downloads" style="margin-left:15px;">
                    <i class="fa fa-download"></i> Descargas</g:link>
            </div>
        </g:if>
        <g:elseif test="${params.tipo == '2'}">
            <div class="alert alert-danger">
                <i class="fa icon-ghost fa-4x pull-left"></i>
                <h3>Error</h3>
                No se encontró el archivo XML solicitado.<br/>
                Si desea descargar un archivo previamente generado, haga cilck en el botón 'Descargas'<br/><br/>

                <g:link class="btn btn-default btnBack" action="xml">
                    <i class="fa fa-arrow-left"></i> Regresar</g:link>
                <g:link class="btn btn-success btnDownload" action="downloads" style="margin-left:15px;">
                    <i class="fa fa-download"></i> Descargas</g:link>
            </div>
        </g:elseif>
        <g:else>
            <g:if test="${flash.message}">
                <elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>
            </g:if>
        </g:else>

    </body>
</html>