
<%@ page import="cratos.Anio" %>

<g:if test="${!anioInstance}">
    <elm:notFound elem="Anio" genero="o" />
</g:if>
<g:else>

    <g:if test="${anioInstance?.anio}">
        <div class="row">
            <div class="col-md-2 text-info">
                Año
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${anioInstance}" field="anio"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>