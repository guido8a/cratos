<%@ page import="cratos.inventario.SubgrupoItems" %>

<div style="padding: 20px">
<form class="form-horizontal">
    <h3 style="text-align: center">${subgrupoItemsInstance.descripcion}</h3>
    <br>
    <g:if test="${subgrupoItemsInstance?.codigo}">
        <div class="row">
            <div class="col-md-4 text-info">
                Código
            </div>

            <div class="col-md-8">
                <g:fieldValue bean="${subgrupoItemsInstance}" field="codigo"/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 text-info">
                Nombre del grupo
            </div>

            <div class="col-md-8">
                <g:fieldValue bean="${subgrupoItemsInstance}" field="descripcion"/>
            </div>
        </div>
    </g:if>
</form>
</div>