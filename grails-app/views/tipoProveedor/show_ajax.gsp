
<%@ page import="cratos.TipoProveedor" %>

<g:if test="${!tipoProveedorInstance}">
    <elm:notFound elem="TipoProveedor" genero="o" />
</g:if>
<g:else>

    <g:if test="${tipoProveedorInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>
            
            <div class="col-md-5">
                <g:fieldValue bean="${tipoProveedorInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${tipoProveedorInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-5">
                <g:fieldValue bean="${tipoProveedorInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>