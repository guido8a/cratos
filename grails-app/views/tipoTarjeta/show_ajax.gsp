<%@ page import="cratos.TipoTarjeta" %>

<g:if test="${!tipoTarjetaInstance}">
    <elm:notFound elem="TipoTarjeta" genero="o"/>
</g:if>
<g:else>

    <g:if test="${tipoTarjetaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoTarjetaInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>