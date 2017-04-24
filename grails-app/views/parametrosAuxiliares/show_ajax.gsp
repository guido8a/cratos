
<%@ page import="cratos.ParametrosAuxiliares" %>

<g:if test="${!parametrosAuxiliaresInstance}">
    <elm:notFound elem="ParametrosAuxiliares" genero="o" />
</g:if>
<g:else>

    <g:if test="${parametrosAuxiliaresInstance?.iva}">
        <div class="row">
            <div class="col-md-2 text-info">
                Iva
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${parametrosAuxiliaresInstance}" field="iva"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>