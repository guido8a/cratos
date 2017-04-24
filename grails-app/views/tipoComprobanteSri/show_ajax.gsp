<%@ page import="cratos.TipoComprobanteSri" %>

<g:if test="${!tipoComprobanteSriInstance}">
    <elm:notFound elem="TipoComprobanteSri" genero="o"/>
</g:if>
<g:else>

    <g:if test="${tipoComprobanteSriInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoComprobanteSriInstance}" field="codigo"/>
            </div>

        </div>
    </g:if>

    <g:if test="${tipoComprobanteSriInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoComprobanteSriInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

    <g:if test="${tipoComprobanteSriInstance?.secuenciales}">
        <div class="row">
            <div class="col-md-2 text-info">
                Secuenciales
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoComprobanteSriInstance}" field="secuenciales"/>
            </div>

        </div>
    </g:if>

    <g:if test="${tipoComprobanteSriInstance?.sustento}">
        <div class="row">
            <div class="col-md-2 text-info">
                Sustento
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoComprobanteSriInstance}" field="sustento"/>
            </div>

        </div>
    </g:if>

</g:else>