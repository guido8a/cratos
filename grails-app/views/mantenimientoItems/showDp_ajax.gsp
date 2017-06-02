<%@ page import="cratos.inventario.DepartamentoItem" %>

<div style="padding: 20px">
    <form class="form-horizontal">
        <h3 style="text-align: center">${departamentoItemInstance.descripcion}</h3>
        <br>
        <g:if test="${departamentoItemInstance?.codigo}">
            <div class="row">
                <div class="col-md-4 text-info">
                    Código
                </div>

                <div class="col-md-8">
                    ${departamentoItemInstance?.subgrupo?.codigo.toString().padLeft(3,'0')}.${departamentoItemInstance?.codigo.toString().padLeft(3,'0')}
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 text-info">
                    Nombre del grupo
                </div>

                <div class="col-md-8">
                    <g:fieldValue bean="${departamentoItemInstance}" field="descripcion"/>
                </div>
            </div>
        </g:if>
    </form>
</div>