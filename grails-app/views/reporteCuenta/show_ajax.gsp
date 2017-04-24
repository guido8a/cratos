<%@ page import="cratos.ReporteCuenta" %>

<g:if test="${!reporteCuentaInstance}">
    <elm:notFound elem="ReporteCuenta" genero="o"/>
</g:if>
<g:else>

    %{--<g:if test="${reporteCuentaInstance?.empresa}">--}%
        %{--<div class="row">--}%
            %{--<div class="col-md-2 text-info">--}%
                %{--Empresa--}%
            %{--</div>--}%

            %{--<div class="col-md-3">--}%
                %{--${reporteCuentaInstance?.empresa?.encodeAsHTML()}--}%
            %{--</div>--}%

        %{--</div>--}%
    %{--</g:if>--}%

    <g:if test="${reporteCuentaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-6">
                <g:fieldValue bean="${reporteCuentaInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>