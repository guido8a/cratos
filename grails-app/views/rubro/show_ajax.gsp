<%@ page import="cratos.Rubro" %>

<g:if test="${!rubroInstance}">
    <elm:notFound elem="Rubro" genero="o"/>
</g:if>
<g:else>

    <g:if test="${rubroInstance?.tipoRubro}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tipo Rubro
            </div>

            <div class="col-md-3">
                ${rubroInstance?.tipoRubro?.encodeAsHTML()}
            </div>

        </div>
    </g:if>

    <g:if test="${rubroInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${rubroInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

    <g:if test="${rubroInstance?.porcentaje}">
        <div class="row">
            <div class="col-md-2 text-info">
                Porcentaje
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${rubroInstance}" field="porcentaje"/>
            </div>

        </div>
    </g:if>

    <g:if test="${rubroInstance?.editable}">
        <div class="row">
            <div class="col-md-2 text-info">
                Editable
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${rubroInstance}" field="editable"/>
            </div>

        </div>
    </g:if>

    <g:if test="${rubroInstance?.decimo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Decimo
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${rubroInstance}" field="decimo"/>
            </div>

        </div>
    </g:if>

    <g:if test="${rubroInstance?.iess}">
        <div class="row">
            <div class="col-md-2 text-info">
                Iess
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${rubroInstance}" field="iess"/>
            </div>

        </div>
    </g:if>

    <g:if test="${rubroInstance?.gravable}">
        <div class="row">
            <div class="col-md-2 text-info">
                Gravable
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${rubroInstance}" field="gravable"/>
            </div>

        </div>
    </g:if>

    <g:if test="${rubroInstance?.valor}">
        <div class="row">
            <div class="col-md-2 text-info">
                Valor
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${rubroInstance}" field="valor"/>
            </div>

        </div>
    </g:if>

</g:else>