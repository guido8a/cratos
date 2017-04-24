<%@ page import="cratos.TipoRelacion" %>

<g:if test="${!tipoRelacionInstance}">
    <elm:notFound elem="TipoRelacion" genero="o"/>
</g:if>
<g:else>

    <g:if test="${tipoRelacionInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>

            <div class="col-md-5">
                <g:fieldValue bean="${tipoRelacionInstance}" field="codigo"/>
            </div>

        </div>
    </g:if>

    <g:if test="${tipoRelacionInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-5">
                <g:fieldValue bean="${tipoRelacionInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>