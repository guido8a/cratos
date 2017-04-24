<%@ page import="cratos.TipoCuenta" %>

<g:if test="${!tipoCuentaInstance}">
    <elm:notFound elem="TipoCuenta" genero="o"/>
</g:if>
<g:else>

    <g:if test="${tipoCuentaInstance?.tipoCuenta}">
        <div class="row">
            <div class="col-md-3 text-info">
                Tipo de Cuenta
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${tipoCuentaInstance}" field="tipoCuenta"/>
            </div>

        </div>
    </g:if>

</g:else>