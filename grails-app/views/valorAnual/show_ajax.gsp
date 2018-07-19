
<%@ page import="cratos.ValorAnual" %>

<g:if test="${!valorAnualInstance}">
    <elm:notFound elem="ValorAnual" genero="o" />
</g:if>
<g:else>

    <g:if test="${valorAnualInstance?.anio}">
        <div class="row">
            <div class="col-md-3 text-info">
                Año
            </div>
            
            <div class="col-md-3">
                ${valorAnualInstance?.anio?.anio?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${valorAnualInstance?.excesoHasta}">
        <div class="row">
            <div class="col-md-3 text-info">
                Exceso Hasta
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${valorAnualInstance}" field="excesoHasta"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${valorAnualInstance?.fraccionBasica}">
        <div class="row">
            <div class="col-md-3 text-info">
                Fracción Básica
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${valorAnualInstance}" field="fraccionBasica"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${valorAnualInstance?.impuesto}">
        <div class="row">
            <div class="col-md-3 text-info">
                Impuesto
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${valorAnualInstance}" field="impuesto"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${valorAnualInstance?.porcentaje}">
        <div class="row">
            <div class="col-md-3 text-info">
                Porcentaje
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${valorAnualInstance}" field="porcentaje"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>