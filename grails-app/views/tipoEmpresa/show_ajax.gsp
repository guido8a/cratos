<%@ page import="cratos.TipoEmpresa" %>

<g:if test="${!tipoEmpresaInstance}">
    <elm:notFound elem="TipoEmpresa" genero="o"/>
</g:if>
<g:else>

    <g:if test="${tipoEmpresaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoEmpresaInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>