
<%@ page import="cratos.sri.SustentoTributario" %>

<g:if test="${!sustentoTributarioInstance}">
    <elm:notFound elem="SustentoTributario" genero="o" />
</g:if>
<g:else>

    <g:if test="${sustentoTributarioInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${sustentoTributarioInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${sustentoTributarioInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Codigo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${sustentoTributarioInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>