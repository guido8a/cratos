<%@ page import="cratos.TipoFactura" %>

<g:if test="${!tipoFacturaInstance}">
    <elm:notFound elem="TipoFactura" genero="o"/>
</g:if>
<g:else>

    <g:if test="${tipoFacturaInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoFacturaInstance}" field="codigo"/>
            </div>

        </div>
    </g:if>

    <g:if test="${tipoFacturaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoFacturaInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>