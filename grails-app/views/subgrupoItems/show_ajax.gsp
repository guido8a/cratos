
<%@ page import="cratos.inventario.SubgrupoItems" %>

<g:if test="${!subgrupoItemsInstance}">
    <elm:notFound elem="SubgrupoItems" genero="o" />
</g:if>
<g:else>

    <g:if test="${subgrupoItemsInstance?.grupo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Grupo
            </div>
            
            <div class="col-md-3">
                ${subgrupoItemsInstance?.grupo?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${subgrupoItemsInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Codigo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${subgrupoItemsInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${subgrupoItemsInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${subgrupoItemsInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${subgrupoItemsInstance?.empresa}">
        <div class="row">
            <div class="col-md-2 text-info">
                Empresa
            </div>
            
            <div class="col-md-3">
                ${subgrupoItemsInstance?.empresa?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>