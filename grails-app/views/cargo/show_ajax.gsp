
<%@ page import="cratos.Cargo" %>

<g:if test="${!cargoInstance}">
    <elm:notFound elem="Cargo" genero="o" />
</g:if>
<g:else>

    <g:if test="${cargoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${cargoInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>

    <g:if test="${cargoInstance?.departamento}">
        <div class="row">
            <div class="col-md-2 text-info">
                Departamento
            </div>
            
            <div class="col-md-3">
                ${cargoInstance?.departamento?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${cargoInstance?.sueldo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Sueldo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${cargoInstance}" field="sueldo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>