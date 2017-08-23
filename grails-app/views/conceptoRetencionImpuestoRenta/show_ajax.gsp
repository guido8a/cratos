
<%@ page import="cratos.ConceptoRetencionImpuestoRenta" %>

<g:if test="${!conceptoRetencionImpuestoRentaInstance}">
    <elm:notFound elem="ConceptoRetencionImpuestoRenta" genero="o" />
</g:if>
<g:else>

    <g:if test="${conceptoRetencionImpuestoRentaInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Codigo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${conceptoRetencionImpuestoRentaInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${conceptoRetencionImpuestoRentaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${conceptoRetencionImpuestoRentaInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${conceptoRetencionImpuestoRentaInstance?.porcentaje}">
        <div class="row">
            <div class="col-md-2 text-info">
                Porcentaje
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${conceptoRetencionImpuestoRentaInstance}" field="porcentaje"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${conceptoRetencionImpuestoRentaInstance?.modalidadPago}">
        <div class="row">
            <div class="col-md-2 text-info">
                Modalidad Pago
            </div>
            
            <div class="col-md-3">
                ${conceptoRetencionImpuestoRentaInstance?.modalidadPago?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${conceptoRetencionImpuestoRentaInstance?.tipo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tipo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${conceptoRetencionImpuestoRentaInstance}" field="tipo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>