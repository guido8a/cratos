
<%@ page import="cratos.DocumentoEmpresa" %>

<g:if test="${!documentoEmpresaInstance}">
    <elm:notFound elem="DocumentoEmpresa" genero="o" />
</g:if>
<g:else>

    <g:if test="${documentoEmpresaInstance?.empresa}">
        <div class="row">
            <div class="col-md-2 text-info">
                Empresa
            </div>
            
            <div class="col-md-3">
                ${documentoEmpresaInstance?.empresa?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${documentoEmpresaInstance?.fechaIngreso}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Ingreso
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${documentoEmpresaInstance?.fechaIngreso}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${documentoEmpresaInstance?.autorizacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Autorizacion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${documentoEmpresaInstance}" field="autorizacion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${documentoEmpresaInstance?.numeroDesde}">
        <div class="row">
            <div class="col-md-2 text-info">
                Numero Desde
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${documentoEmpresaInstance}" field="numeroDesde"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${documentoEmpresaInstance?.numeroHasta}">
        <div class="row">
            <div class="col-md-2 text-info">
                Numero Hasta
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${documentoEmpresaInstance}" field="numeroHasta"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${documentoEmpresaInstance?.fechaAutorizacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Autorizacion
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${documentoEmpresaInstance?.fechaAutorizacion}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${documentoEmpresaInstance?.tipo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tipo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${documentoEmpresaInstance}" field="tipo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${documentoEmpresaInstance?.numeroEstablecimiento}">
        <div class="row">
            <div class="col-md-2 text-info">
                Numero Establecimiento
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${documentoEmpresaInstance}" field="numeroEstablecimiento"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${documentoEmpresaInstance?.numeroEmision}">
        <div class="row">
            <div class="col-md-2 text-info">
                Numero Emision
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${documentoEmpresaInstance}" field="numeroEmision"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${documentoEmpresaInstance?.digitosEnSecuencial}">
        <div class="row">
            <div class="col-md-2 text-info">
                Digitos En Secuencial
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${documentoEmpresaInstance}" field="digitosEnSecuencial"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${documentoEmpresaInstance?.fechaInicio}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Inicio
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${documentoEmpresaInstance?.fechaInicio}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${documentoEmpresaInstance?.fechaFin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Fin
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${documentoEmpresaInstance?.fechaFin}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
</g:else>