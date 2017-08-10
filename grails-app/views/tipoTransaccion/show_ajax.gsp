
<%@ page import="cratos.sri.TipoTransaccion" %>

<g:if test="${!tipoTransaccionInstance}">
    <elm:notFound elem="TipoTransaccion" genero="o" />
</g:if>
<g:else>

    <g:if test="${tipoTransaccionInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${tipoTransaccionInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${tipoTransaccionInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-6">
                <g:fieldValue bean="${tipoTransaccionInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>