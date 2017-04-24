<%@ page import="cratos.Mes" %>

<g:if test="${!mesInstance}">
    <elm:notFound elem="Mes" genero="o"/>
</g:if>
<g:else>

    <g:if test="${mesInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${mesInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>