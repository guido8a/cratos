<%@ page import="cratos.TipoDocumentoProveedor" %>

<g:if test="${!tipoDocumentoProveedorInstance}">
    <elm:notFound elem="TipoDocumentoProveedor" genero="o"/>
</g:if>
<g:else>

    <g:if test="${tipoDocumentoProveedorInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoDocumentoProveedorInstance}" field="codigo"/>
            </div>

        </div>
    </g:if>

    <g:if test="${tipoDocumentoProveedorInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoDocumentoProveedorInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>