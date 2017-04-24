
<%@ page import="cratos.TipoRubro" %>

<g:if test="${!tipoRubroInstance}">
    <elm:notFound elem="TipoRubro" genero="o" />
</g:if>
<g:else>

    <g:if test="${tipoRubroInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${tipoRubroInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${tipoRubroInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${tipoRubroInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>