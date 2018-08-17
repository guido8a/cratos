
<%@ page import="cratos.Empleado" %>

<g:if test="${!empleadoInstance}">
    <elm:notFound elem="Empleado" genero="o" />
</g:if>
<g:else>


    <g:if test="${empleadoInstance?.persona}">
        <div class="row">
            <div class="col-md-3 text-info">
                Empleado
            </div>

            <div class="col-md-8">
                ${empleadoInstance?.persona?.nombre?.encodeAsHTML() + " " + empleadoInstance?.persona?.apellido?.encodeAsHTML()}
            </div>

        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.estado}">
        <div class="row">
            <div class="col-md-3 text-info">
                Estado
            </div>
            <div class="col-md-8">
                <b style="color: ${empleadoInstance?.estado == 'A' ? 'rgba(83,207,109,0.9)' : 'rgba(112,27,25,0.9)'}">${empleadoInstance?.estado == 'A' ? 'ACTIVO' : 'INACTIVO'}</b>
            </div>
        </div>
    </g:if>

    <g:if test="${empleadoInstance?.fechaInicio}">
        <div class="row">
            <div class="col-md-3 text-info">
                Fecha Inicio
            </div>

            <div class="col-md-8">
                <g:formatDate date="${empleadoInstance?.fechaInicio}" format="dd-MM-yyyy" />
            </div>

        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.fechaFin}">
        <div class="row">
            <div class="col-md-3 text-info">
                Fecha Fin
            </div>
            
            <div class="col-md-8">
                <g:formatDate date="${empleadoInstance?.fechaFin}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    

    
    <g:if test="${empleadoInstance?.sueldo}">
        <div class="row">
            <div class="col-md-3 text-info">
                Sueldo
            </div>
            
            <div class="col-md-8">
                <td><g:formatNumber number="${empleadoInstance?.sueldo}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            </div>
            
        </div>
    </g:if>

    <g:if test="${empleadoInstance?.porcentajeComision}">
        <div class="row">
            <div class="col-md-3 text-info">
                Porcentaje Comisión
            </div>
            <div class="col-md-8">
                <td><g:formatNumber number="${empleadoInstance?.porcentajeComision}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            </div>
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.cuenta}">
        <div class="row">
            <div class="col-md-3 text-info">
                Cuenta
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${empleadoInstance}" field="cuenta"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.hijo}">
        <div class="row">
            <div class="col-md-3 text-info">
                Hijo(s)
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${empleadoInstance}" field="hijo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.iess}">
        <div class="row">
            <div class="col-md-3 text-info">
                Iess
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${empleadoInstance}" field="iess"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.numero}">
        <div class="row">
            <div class="col-md-3 text-info">
                Numero
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${empleadoInstance}" field="numero"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.tipoContrato}">
        <div class="row">
            <div class="col-md-3 text-info">
                Tipo Contrato
            </div>
            
            <div class="col-md-8">
                ${empleadoInstance?.tipoContrato?.descripcion?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${empleadoInstance?.cargo}">
        <div class="row">
            <div class="col-md-3 text-info">
                Cargo
            </div>
            
            <div class="col-md-8">
                ${empleadoInstance?.cargo?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>


    <g:if test="${empleadoInstance?.observaciones}">
        <div class="row">
            <div class="col-md-3 text-info">
                Observaciones
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${empleadoInstance}" field="observaciones"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>