<%@ page import="cratos.TipoPago" %>

<g:if test="${!tipoPagoInstance}">
    <elm:notFound elem="TipoPago" genero="o"/>
</g:if>
<g:else>

    <g:if test="${tipoPagoInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Codigo
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoPagoInstance}" field="codigo"/>
            </div>

        </div>
    </g:if>

    <g:if test="${tipoPagoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoPagoInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>