
<%@ page import="cratos.Grupo" %>

<g:if test="${!grupoInstance}">
    <elm:notFound elem="Grupo" genero="o" />
</g:if>
<g:else>

    <g:if test="${grupoInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Codigo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${grupoInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${grupoInstance?.cuenta}">
        <div class="row">
            <div class="col-md-2 text-info">
                Cuenta
            </div>
            
            <div class="col-md-3">
                ${grupoInstance?.cuenta?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${grupoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${grupoInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>