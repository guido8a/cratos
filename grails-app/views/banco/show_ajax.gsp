
<%@ page import="cratos.Banco" %>

<g:if test="${!bancoInstance}">
    <elm:notFound elem="Banco" genero="o" />
</g:if>
<g:else>

    %{--<g:if test="${bancoInstance?.empresa}">--}%
        %{--<div class="row">--}%
            %{--<div class="col-md-2 text-info">--}%
                %{--Empresa--}%
            %{--</div>--}%

            %{--<div class="col-md-3">--}%
                %{--${bancoInstance?.empresa?.encodeAsHTML()}--}%
            %{--</div>--}%

        %{--</div>--}%
    %{--</g:if>--}%

    <g:if test="${bancoInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${bancoInstance}" field="codigo"/>
            </div>

        </div>
    </g:if>
    <g:if test="${bancoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-6">
                <g:fieldValue bean="${bancoInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>

    

    
</g:else>