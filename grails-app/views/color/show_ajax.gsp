<%@ page import="cratos.Color" %>

<g:if test="${!colorInstance}">
    <elm:notFound elem="Color" genero="o"/>
</g:if>
<g:else>

    <g:if test="${colorInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${colorInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>