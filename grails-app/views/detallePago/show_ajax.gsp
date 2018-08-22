
<%@ page import="cratos.DetallePago" %>

<g:if test="${!detallePagoInstance}">
    <elm:notFound elem="DetallePago" genero="o" />
</g:if>
<g:else>

    <g:if test="${detallePagoInstance?.rubroTipoContrato}">
        <div class="row">
            <div class="col-md-2 text-info">
                Rubro Tipo Contrato
            </div>
            
            <div class="col-md-3">
                ${detallePagoInstance?.rubroTipoContrato?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detallePagoInstance?.empleado}">
        <div class="row">
            <div class="col-md-2 text-info">
                Empleado
            </div>
            
            <div class="col-md-3">
                ${detallePagoInstance?.empleado?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detallePagoInstance?.rolPagos}">
        <div class="row">
            <div class="col-md-2 text-info">
                Rol Pagos
            </div>
            
            <div class="col-md-3">
                ${detallePagoInstance?.rolPagos?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detallePagoInstance?.valor}">
        <div class="row">
            <div class="col-md-2 text-info">
                Valor
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${detallePagoInstance}" field="valor"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detallePagoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${detallePagoInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>