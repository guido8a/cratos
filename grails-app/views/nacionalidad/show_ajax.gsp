<%@ page import="cratos.Nacionalidad" %>

<g:if test="${!nacionalidadInstance}">
    <elm:notFound elem="Nacionalidad" genero="o"/>
</g:if>
<g:else>

    <g:if test="${nacionalidadInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${nacionalidadInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>