<%@ page import="cratos.Profesion" %>

<g:if test="${!profesionInstance}">
    <elm:notFound elem="Profesion" genero="o"/>
</g:if>
<g:else>

    <g:if test="${profesionInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${profesionInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

    <g:if test="${profesionInstance?.sigla}">
        <div class="row">
            <div class="col-md-2 text-info">
                Sigla
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${profesionInstance}" field="sigla"/>
            </div>

        </div>
    </g:if>

</g:else>