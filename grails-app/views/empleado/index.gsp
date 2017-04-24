<%@ page import="cratos.Empleado" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'empleado.label', default: 'Empleado')}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
    </head>

    <body>
        <a href="#list-empleado" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></li>
            </ul>
        </div>

        <div id="list-empleado" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]"/></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table>
                <thead>
                    <tr>

                        <g:sortableColumn property="porcentajeComision" title="${message(code: 'empleado.porcentajeComision.label', default: 'Porcentaje Comision')}"/>

                        <g:sortableColumn property="foto" title="${message(code: 'empleado.foto.label', default: 'Foto')}"/>

                        <g:sortableColumn property="estado" title="${message(code: 'empleado.estado.label', default: 'Estado')}"/>

                        <g:sortableColumn property="fechaFin" title="${message(code: 'empleado.fechaFin.label', default: 'Fecha Fin')}"/>

                        <g:sortableColumn property="fechaInicio" title="${message(code: 'empleado.fechaInicio.label', default: 'Fecha Inicio')}"/>

                        <g:sortableColumn property="sueldo" title="${message(code: 'empleado.sueldo.label', default: 'Sueldo')}"/>

                    </tr>
                </thead>
                <tbody>
                    <g:each in="${empleadoInstanceList}" status="i" var="empleadoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show" id="${empleadoInstance.id}">${fieldValue(bean: empleadoInstance, field: "porcentajeComision")}</g:link></td>

                            <td>${fieldValue(bean: empleadoInstance, field: "foto")}</td>

                            <td>${fieldValue(bean: empleadoInstance, field: "estado")}</td>

                            <td><g:formatDate date="${empleadoInstance.fechaFin}"/></td>

                            <td><g:formatDate date="${empleadoInstance.fechaInicio}"/></td>

                            <td>${fieldValue(bean: empleadoInstance, field: "sueldo")}</td>

                        </tr>
                    </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${empleadoInstanceCount ?: 0}"/>
            </div>
        </div>
    </body>
</html>
