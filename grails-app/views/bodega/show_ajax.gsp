
<%@ page import="cratos.inventario.Bodega" %>

<g:if test="${!bodegaInstance}">
    <elm:notFound elem="Bodega" genero="o" />
</g:if>
<g:else>

    <g:if test="${bodegaInstance?.empresa}">
        <div class="row">
            <div class="col-md-2 text-info">
                Empresa
            </div>
            
            <div class="col-md-3">
                ${bodegaInstance?.empresa?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${bodegaInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Codigo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${bodegaInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${bodegaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${bodegaInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>