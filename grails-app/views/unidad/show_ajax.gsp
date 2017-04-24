<%@ page import="cratos.Unidad" %>

<g:if test="${!unidadInstance}">
    <elm:notFound elem="Unidad" genero="o"/>
</g:if>
<g:else>

    <g:if test="${unidadInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>

            <div class="col-md-4">
                <g:fieldValue bean="${unidadInstance}" field="codigo"/>
            </div>

        </div>
    </g:if>

    <g:if test="${unidadInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-8">
                <g:fieldValue bean="${unidadInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>