<%@ page import="cratos.Nivel" %>

<g:if test="${!nivelInstance}">
    <elm:notFound elem="Nivel" genero="o"/>
</g:if>
<g:else>

    <g:if test="${nivelInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${nivelInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>