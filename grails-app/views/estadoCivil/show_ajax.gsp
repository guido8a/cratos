
<%@ page import="cratos.EstadoCivil" %>

<g:if test="${!estadoCivilInstance}">
    <elm:notFound elem="EstadoCivil" genero="o" />
</g:if>
<g:else>

    <g:if test="${estadoCivilInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estadoCivilInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>