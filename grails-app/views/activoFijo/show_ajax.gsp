<%@ page import="cratos.ActivoFijo" %>

<g:if test="${!activoFijoInstance}">
    <elm:notFound elem="ActivoFijo" genero="o"/>
</g:if>
<g:else>
    <div class="col2">
        <g:if test="${activoFijoInstance?.proceso && params.proceso}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Proceso
                </div>

                <div class="col-md-6">
                    <g:link controller="proceso" action="show" id="${activoFijoInstance.procesoId}">
                        ${activoFijoInstance.proceso.descripcion}
                    </g:link>
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.codigo}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Código
                </div>

                <div class="col-md-6">
                    <g:fieldValue bean="${activoFijoInstance}" field="codigo"/>
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.grupo}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Grupo
                </div>

                <div class="col-md-6">
                    ${activoFijoInstance?.grupo?.descripcion}
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.estado}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Estado
                </div>

                <div class="col-md-6">
                    ${activoFijoInstance.estado == 'A' ? 'Activo' : activoFijoInstance.estado == 'B' ? 'Dado de baja' : '?'}
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.nombre}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Nombre
                </div>

                <div class="col-md-6">
                    <g:fieldValue bean="${activoFijoInstance}" field="nombre"/>
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.marca}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Marca
                </div>

                <div class="col-md-6">
                    ${activoFijoInstance?.marca?.descripcion}
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.custodio}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Custodio
                </div>

                <div class="col-md-6">
                    ${activoFijoInstance?.custodio?.nombre} ${activoFijoInstance?.custodio?.apellido}
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.proveedor}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Proveedor
                </div>

                <div class="col-md-6">
                    ${activoFijoInstance?.proveedor?.nombre}
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.precio}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Precio
                </div>

                <div class="col-md-6">
                    $ <util:numero decimales="2" number="${activoFijoInstance.precio}"/>
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.fechaRegistro}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Registro
                </div>

                <div class="col-md-6">
                    <g:formatDate date="${activoFijoInstance?.fechaRegistro}" format="dd-MM-yyyy"/>
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.aniosVidaUtil}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Vida útil
                </div>

                <div class="col-md-6">
                    <g:fieldValue bean="${activoFijoInstance}" field="aniosVidaUtil"/> años
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.numeroSerie}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Número Serie
                </div>

                <div class="col-md-6">
                    <g:fieldValue bean="${activoFijoInstance}" field="numeroSerie"/>
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.modelo}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Modelo
                </div>

                <div class="col-md-6">
                    <g:fieldValue bean="${activoFijoInstance}" field="modelo"/>
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.color}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Color
                </div>

                <div class="col-md-6">
                    ${activoFijoInstance?.color?.descripcion}
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.fechaInicioDepreciacion}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Inicio Depreciación
                </div>

                <div class="col-md-6">
                    <g:formatDate date="${activoFijoInstance?.fechaInicioDepreciacion}" format="dd-MM-yyyy"/>
                </div>

            </div>
        </g:if>

        <g:if test="${activoFijoInstance?.observaciones}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Observaciones
                </div>

                <div class="col-md-6">
                    <g:fieldValue bean="${activoFijoInstance}" field="observaciones"/>
                </div>

            </div>
        </g:if>
    </div>
</g:else>