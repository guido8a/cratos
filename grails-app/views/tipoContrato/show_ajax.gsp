
<%@ page import="cratos.TipoContrato" %>

<g:if test="${!tipoContratoInstance}">
    <elm:notFound elem="TipoContrato" genero="o" />
</g:if>
<g:else>

    <g:if test="${tipoContratoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${tipoContratoInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>