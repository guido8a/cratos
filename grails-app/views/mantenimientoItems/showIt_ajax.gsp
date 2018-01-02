<%@ page import="cratos.inventario.Item" %>

<div style="padding: 20px">
        <h3 style="text-align: center">${itemInstance.nombre}</h3>
        <br>
        <g:if test="${itemInstance?.codigo}">
            <div class="row">
                <div class="col-md-4 text-info">
                    Código
                </div>

                <div class="col-md-8">
                    <g:fieldValue bean="${itemInstance}" field="codigo"/>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 text-info">
                    Nombre
                </div>

                <div class="col-md-8">
                    <g:fieldValue bean="${itemInstance}" field="nombre"/>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 text-info">
                    Unidad
                </div>

                <div class="col-md-8">
                    ${itemInstance?.unidad?.codigo}: ${itemInstance?.unidad?.descripcion}
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 text-info">
                    Marca
                </div>

                <div class="col-md-8">
                    ${itemInstance?.marca?.descripcion}
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 text-info">
                    Estado
                </div>

                <div class="col-md-8">
                    ${itemInstance.estado == 'A' ? 'ACTIVO' : itemInstance.estado == 'B' ? 'DADO DE BAJA' : ''}
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 text-info">
                    Fecha creación
                </div>

                <div class="col-md-8">
                    <g:formatDate date="${itemInstance?.fecha}" format="dd-MM-yyyy"/> (dd-mm-aaaa)
                </div>
            </div>

            <g:if test="${itemInstance?.precioVenta}">
                <div class="row">
                    <div class="col-md-4 text-info">
                        Precio de Venta
                    </div>

                    <div class="col-md-8">
                        ${itemInstance?.precioVenta}
                    </div>
                </div>
            </g:if>

            <g:if test="${itemInstance?.precioCosto}">
                <div class="row">
                    <div class="col-md-4 text-info">
                        Precio de Costo
                    </div>

                    <div class="col-md-8">
                        ${itemInstance?.precioCosto}
                    </div>
                </div>
            </g:if>

            <g:if test="${itemInstance?.tipoIVA}">
                <div class="row">
                    <div class="col-md-4 text-info">
                        Tipo de IVA
                    </div>

                    <div class="col-md-8">
                        ${itemInstance?.tipoIVA.descripcion}
                    </div>
                </div>
            </g:if>

            <g:if test="${itemInstance?.ice}">
                <div class="row">
                    <div class="col-md-4 text-info">
                        ICE (%)
                    </div>

                    <div class="col-md-8">
                        ${itemInstance?.ice}
                    </div>
                </div>
            </g:if>

            <g:if test="${itemInstance?.stockMinimo}">
                <div class="row">
                    <div class="col-md-4 text-info">
                        Existencias mínimas
                    </div>

                    <div class="col-md-8">
                        ${itemInstance?.stockMinimo}
                    </div>
                </div>
            </g:if>

            <g:if test="${itemInstance?.stockMaximo}">
                <div class="row">
                    <div class="col-md-4 text-info">
                        Existencias máximas
                    </div>

                    <div class="col-md-8">
                        ${itemInstance?.stockMaximo}
                    </div>
                </div>
            </g:if>

            <g:if test="${itemInstance?.peso}">
                <div class="row">
                    <div class="col-md-4 text-info">
                        Peso unitario en Kg
                    </div>

                    <div class="col-md-8">
                        ${itemInstance?.peso}
                    </div>
                </div>
            </g:if>

            <g:if test="${itemInstance?.fechaModificacion}">
                <div class="row">
                    <div class="col-md-4 text-info">
                        Fecha última modificación
                    </div>

                    <div class="col-md-8">
                        <g:formatDate date="${itemInstance?.fechaModificacion}" format="dd-MM-yyyy"/> (dd-mm-aaaa)
                    </div>
                </div>
            </g:if>

            <g:if test="${itemInstance?.observaciones}">
                <div class="row">
                    <div class="col-md-4 text-info">
                        Observaciones
                    </div>

                    <div class="col-md-8">
                        <g:fieldValue bean="${itemInstance}" field="observaciones"/>
                    </div>
                </div>
            </g:if>



        </g:if>

</div>

<form class="form-horizontal">



</form>
