
<%@ page import="cratos.RubroTipoContrato" %>

<g:if test="${!rubroTipoContratoInstance}">
    <elm:notFound elem="RubroTipoContrato" genero="o" />
</g:if>
<g:else>

    <g:if test="${rubroTipoContratoInstance?.tipoContrato}">
        <div class="row">
            <div class="col-md-3 text-info">
                Tipo Contrato
            </div>
            
            <div class="col-md-6">
                ${rubroTipoContratoInstance?.tipoContrato?.descripcion?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.rubro}">
        <div class="row">
            <div class="col-md-3 text-info">
                Rubro
            </div>
            
            <div class="col-md-6">
                ${rubroTipoContratoInstance?.rubro?.descripcion?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.porcentaje}">
        <div class="row">
            <div class="col-md-3 text-info">
                Porcentaje
            </div>
            
            <div class="col-md-6">
                <g:fieldValue bean="${rubroTipoContratoInstance}" field="porcentaje"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.editable}">
        <div class="row">
            <div class="col-md-3 text-info">
                Editable
            </div>
            
            <div class="col-md-3">
                ${rubroTipoContratoInstance?.editable == '1' ? 'SI' : 'NO'}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.decimo}">
        <div class="row">
            <div class="col-md-3 text-info">
                Décimo
            </div>
            
            <div class="col-md-3">
                ${rubroTipoContratoInstance?.decimo == '1' ? 'SI' : 'NO'}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.iess}">
        <div class="row">
            <div class="col-md-3 text-info">
                Iess
            </div>
            
            <div class="col-md-3">
                ${rubroTipoContratoInstance?.iess == '1' ? 'SI' : 'NO'}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.gravable}">
        <div class="row">
            <div class="col-md-3 text-info">
                Gravable
            </div>
            
            <div class="col-md-3">
                ${rubroTipoContratoInstance?.gravable == '1' ? 'SI' : 'NO'}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.valor}">
        <div class="row">
            <div class="col-md-3 text-info">
                Valor
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${rubroTipoContratoInstance}" field="valor"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.observaciones}">
        <div class="row">
            <div class="col-md-3 text-info">
                Observaciones
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${rubroTipoContratoInstance}" field="observaciones"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>