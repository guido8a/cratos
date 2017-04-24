<%@ page import="cratos.Bodega" %>

<g:if test="${!bodegaInstance}">
    <elm:notFound elem="Bodega" genero="o"/>
</g:if>
<g:else>
    <g:if test="${bodegaInstance?.codigo}">
        <div class="row">
            <div class="col-md-3 text-info">
                Código
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${bodegaInstance}" field="codigo"/>
            </div>

        </div>
    </g:if>

    <g:if test="${bodegaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-3 text-info">
                Descripción
            </div>

            <div class="col-md-6">
                <g:fieldValue bean="${bodegaInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>


    <g:if test="${bodegaInstance?.centroCosto}">
        <div class="row">
            <div class="col-md-3 text-info">
                Centro Costo
            </div>

            <div class="col-md-3">
                ${bodegaInstance?.centroCosto?.nombre?.encodeAsHTML()}
            </div>

        </div>
    </g:if>


</g:else>