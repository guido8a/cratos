<%@ page import="cratos.TipoSoporte" %>

<g:if test="${!tipoSoporteInstance}">
    <elm:notFound elem="TipoSoporte" genero="o"/>
</g:if>
<g:else>

    <g:if test="${tipoSoporteInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoSoporteInstance}" field="codigo"/>
            </div>

        </div>
    </g:if>

    <g:if test="${tipoSoporteInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-8">
                <g:fieldValue bean="${tipoSoporteInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>