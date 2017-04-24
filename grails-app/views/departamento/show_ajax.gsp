<%@ page import="cratos.Departamento" %>

<g:if test="${!departamentoInstance}">
    <elm:notFound elem="Departamento" genero="o"/>
</g:if>
<g:else>

    %{--<g:if test="${departamentoInstance?.empresa}">--}%
        %{--<div class="row">--}%
            %{--<div class="col-md-2 text-info">--}%
                %{--Empresa--}%
            %{--</div>--}%

            %{--<div class="col-md-3">--}%
                %{--${departamentoInstance?.empresa?.encodeAsHTML()}--}%
            %{--</div>--}%

        %{--</div>--}%
    %{--</g:if>--}%

    <g:if test="${departamentoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${departamentoInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

</g:else>