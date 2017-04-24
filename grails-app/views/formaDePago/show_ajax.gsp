
<%@ page import="cratos.FormaDePago" %>

<g:if test="${!formaDePagoInstance}">
    <elm:notFound elem="FormaDePago" genero="o" />
</g:if>
<g:else>

    <g:if test="${formaDePagoInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${formaDePagoInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${formaDePagoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${formaDePagoInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>