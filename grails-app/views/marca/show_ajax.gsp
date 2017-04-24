
<%@ page import="cratos.Marca" %>

<g:if test="${!marcaInstance}">
    <elm:notFound elem="Marca" genero="o" />
</g:if>
<g:else>

    <g:if test="${marcaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${marcaInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>