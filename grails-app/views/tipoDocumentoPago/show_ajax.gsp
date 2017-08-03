
<%@ page import="cratos.TipoDocumentoPago" %>

<g:if test="${!tipoDocumentoPagoInstance}">
    <elm:notFound elem="TipoDocumentoPago" genero="o" />
</g:if>
<g:else>

    <g:if test="${tipoDocumentoPagoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${tipoDocumentoPagoInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>