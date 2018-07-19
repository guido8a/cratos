
<%@ page import="cratos.RolPagos" %>

<g:if test="${!rolPagosInstance}">
    <elm:notFound elem="RolPagos" genero="o" />
</g:if>
<g:else>

    <g:if test="${rolPagosInstance?.anio}">
        <div class="row">
            <div class="col-md-2 text-info">
                Año
            </div>

            <div class="col-md-3">
                ${rolPagosInstance?.anio?.anio?.encodeAsHTML()}
            </div>

        </div>
    </g:if>

    <g:if test="${rolPagosInstance?.mess}">
        <div class="row">
            <div class="col-md-2 text-info">
                Mes
            </div>
            
            <div class="col-md-3">
                ${rolPagosInstance?.mess?.descripcion?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    

    
    <g:if test="${rolPagosInstance?.fecha}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${rolPagosInstance?.fecha}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rolPagosInstance?.pagado}">
        <div class="row">
            <div class="col-md-2 text-info">
                Pagado
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${rolPagosInstance}" field="pagado"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rolPagosInstance?.estado}">
        <div class="row">
            <div class="col-md-2 text-info">
                Estado
            </div>
            
            <div class="col-md-3">
                ${rolPagosInstance?.estado == 'N' ? 'No aprobado' : 'Aprobado'}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rolPagosInstance?.empresa}">
        <div class="row">
            <div class="col-md-2 text-info">
                Empresa
            </div>
            
            <div class="col-md-3">
                ${rolPagosInstance?.empresa?.nombre?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>