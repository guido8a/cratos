<%@ page import="cratos.inventario.CentroCosto" %>

<g:if test="${!centroCostoInstance}">
    <elm:notFound elem="CentroCosto" genero="o"/>
</g:if>
<g:else>

    <g:if test="${centroCostoInstance?.empresa}">
        <div class="row">
            <div class="col-md-2 text-info">
                Empresa
            </div>

            <div class="col-md-3">
                ${centroCostoInstance?.empresa?.encodeAsHTML()}
            </div>

        </div>
    </g:if>

    <g:if test="${centroCostoInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${centroCostoInstance}" field="nombre"/>
            </div>

        </div>
    </g:if>

</g:else>