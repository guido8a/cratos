<%@ page import="cratos.Base" %>

<g:if test="${!baseInstance}">
    <elm:notFound elem="Base" genero="o"/>
</g:if>
<g:else>

    <g:if test="${baseInstance?.periodo}">
        <div class="row">
            <div class="col-md-4 text-info">
                Período
            </div>

            <div class="col-md-8">
                ${baseInstance?.periodo?.encodeAsHTML()}
            </div>

        </div>
    </g:if>

    <g:if test="${baseInstance?.fraccionBasica}">
        <div class="row">
            <div class="col-md-4 text-info">
                Fracción Básica
            </div>

            <div class="col-md-8">
                <g:fieldValue bean="${baseInstance}" field="fraccionBasica"/>
            </div>

        </div>
    </g:if>

    <g:if test="${baseInstance?.excesoHasta}">
        <div class="row">
            <div class="col-md-4 text-info">
                Exceso Hasta
            </div>

            <div class="col-md-8">
                <g:fieldValue bean="${baseInstance}" field="excesoHasta"/>
            </div>

        </div>
    </g:if>

    <g:if test="${baseInstance?.impuestosFraccion}">
        <div class="row">
            <div class="col-md-4 text-info">
                Impuestos Fracción
            </div>

            <div class="col-md-8">
                <g:fieldValue bean="${baseInstance}" field="impuestosFraccion"/>
            </div>

        </div>
    </g:if>

    <g:if test="${baseInstance?.porcentaje}">
        <div class="row">
            <div class="col-md-4 text-info">
                Porcentaje
            </div>

            <div class="col-md-8">
                <g:fieldValue bean="${baseInstance}" field="porcentaje"/>
            </div>

        </div>
    </g:if>

</g:else>