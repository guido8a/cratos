
<%@ page import="cratos.RubroTipoContrato" %>

<g:if test="${!rubroTipoContratoInstance}">
    <elm:notFound elem="RubroTipoContrato" genero="o" />
</g:if>
<g:else>

    <g:if test="${rubroTipoContratoInstance?.tipoContrato}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tipo Contrato
            </div>
            
            <div class="col-md-3">
                ${rubroTipoContratoInstance?.tipoContrato?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.rubro}">
        <div class="row">
            <div class="col-md-2 text-info">
                Rubro
            </div>
            
            <div class="col-md-3">
                ${rubroTipoContratoInstance?.rubro?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.porcentaje}">
        <div class="row">
            <div class="col-md-2 text-info">
                Porcentaje
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${rubroTipoContratoInstance}" field="porcentaje"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.editable}">
        <div class="row">
            <div class="col-md-2 text-info">
                Editable
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${rubroTipoContratoInstance}" field="editable"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.decimo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Decimo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${rubroTipoContratoInstance}" field="decimo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.iess}">
        <div class="row">
            <div class="col-md-2 text-info">
                Iess
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${rubroTipoContratoInstance}" field="iess"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.gravable}">
        <div class="row">
            <div class="col-md-2 text-info">
                Gravable
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${rubroTipoContratoInstance}" field="gravable"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.valor}">
        <div class="row">
            <div class="col-md-2 text-info">
                Valor
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${rubroTipoContratoInstance}" field="valor"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.observaciones}">
        <div class="row">
            <div class="col-md-2 text-info">
                Observaciones
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${rubroTipoContratoInstance}" field="observaciones"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>