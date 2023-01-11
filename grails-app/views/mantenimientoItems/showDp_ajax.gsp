<%@ page import="cratos.inventario.DepartamentoItem" %>

<div style="padding-left: 20px; padding-right: 20px">
    <form class="form-horizontal">
        <br>
        <div class="alert alert-info">
            <h4 class="alert-heading">${departamentoItemInstance.descripcion}</h4>
        </div>
        <div class="col-md-12" style="margin-bottom: 10px">
            <div class="col-md-4 text-info">
                Código
            </div>

            <div class="col-md-8">
                ${departamentoItemInstance?.subgrupo?.codigo?.toString()?.padLeft(3,'0')}.${departamentoItemInstance?.codigo?.toString()?.padLeft(3,'0')}
            </div>
        </div>
        <div class="col-md-12" style="margin-bottom: 10px">
            <div class="col-md-4 text-info">
                Nombre del grupo
            </div>

            <div class="col-md-8">
                <g:fieldValue bean="${departamentoItemInstance}" field="descripcion"/>
            </div>
        </div>
    </form>
</div>