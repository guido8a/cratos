
<%@ page import="cratos.Empleado" %>

<g:if test="${!empleadoInstance}">
    <elm:notFound elem="Empleado" genero="o" />
</g:if>
<g:else>

    <g:if test="${empleadoInstance?.porcentajeComision}">
        <div class="row">
            <div class="col-md-2 text-info">
                Porcentaje Comision
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${empleadoInstance}" field="porcentajeComision"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.foto}">
        <div class="row">
            <div class="col-md-2 text-info">
                Foto
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.estado}">
        <div class="row">
            <div class="col-md-2 text-info">
                Estado
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${empleadoInstance}" field="estado"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.fechaFin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Fin
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${empleadoInstance?.fechaFin}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.fechaInicio}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Inicio
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${empleadoInstance?.fechaInicio}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.sueldo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Sueldo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${empleadoInstance}" field="sueldo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.cuenta}">
        <div class="row">
            <div class="col-md-2 text-info">
                Cuenta
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${empleadoInstance}" field="cuenta"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.hijo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Hijo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${empleadoInstance}" field="hijo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.iess}">
        <div class="row">
            <div class="col-md-2 text-info">
                Iess
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${empleadoInstance}" field="iess"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.numero}">
        <div class="row">
            <div class="col-md-2 text-info">
                Numero
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${empleadoInstance}" field="numero"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.tipoContrato}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tipo Contrato
            </div>
            
            <div class="col-md-3">
                ${empleadoInstance?.tipoContrato?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.cargo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Cargo
            </div>
            
            <div class="col-md-3">
                ${empleadoInstance?.cargo?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.persona}">
        <div class="row">
            <div class="col-md-2 text-info">
                Persona
            </div>
            
            <div class="col-md-3">
                ${empleadoInstance?.persona?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.canton}">
        <div class="row">
            <div class="col-md-2 text-info">
                Canton
            </div>
            
            <div class="col-md-3">
                ${empleadoInstance?.canton?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.observaciones}">
        <div class="row">
            <div class="col-md-2 text-info">
                Observaciones
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${empleadoInstance}" field="observaciones"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>