<%@ page import="cratos.inventario.SubgrupoItems" %>

<div style="padding-left: 20px; padding-right: 20px">
    <form class="form-horizontal">
        <br>
        <div class="alert alert-warning text-info">
            <h4 class="alert-heading">${subgrupoItemsInstance.descripcion}</h4>
        </div>
        <div class="col-md-12" style="margin-bottom: 10px">
            <div class="col-md-4">
                Código
            </div>
            <div class="col-md-8">
                <g:fieldValue bean="${subgrupoItemsInstance}" field="codigo"/>
            </div>
        </div>
        <div class="col-md-12">
            <div class="col-md-4 text-info">
                Nombre del grupo
            </div>
            <div class="col-md-8">
                <g:fieldValue bean="${subgrupoItemsInstance}" field="descripcion"/>
            </div>
        </div>
    </form>
</div>