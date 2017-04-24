
<%@ page import="cratos.Estado" %>

<g:if test="${!estadoInstance}">
    <elm:notFound elem="Estado" genero="o" />
</g:if>
<g:else>

    <g:if test="${estadoInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estadoInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${estadoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estadoInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>