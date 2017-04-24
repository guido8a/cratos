<%@ page import="cratos.Empresa" %>

<div class="col2">
    <g:if test="${!empresaInstance}">
        <elm:notFound elem="Empresa" genero="a"/>
    </g:if>
    <g:else>
        <div class="keeptogether">
            <g:if test="${empresaInstance?.nombre}">
                <div class="row">
                    <div class="col-md-3 text-info">
                        Nombre
                    </div>

                    <div class="col-md-6">
                        <g:fieldValue bean="${empresaInstance}" field="nombre"/>
                    </div>

                </div>
            </g:if>

            <g:if test="${empresaInstance?.ruc}">
                <div class="row">
                    <div class="col-md-3 text-info">
                        R.U.C.
                    </div>

                    <div class="col-md-6">
                        <g:fieldValue bean="${empresaInstance}" field="ruc"/>
                    </div>

                </div>
            </g:if>

            <g:if test="${empresaInstance?.tipoEmpresa}">
                <div class="row">
                    <div class="col-md-3 text-info">
                        Tipo Empresa
                    </div>

                    <div class="col-md-6">
                        ${empresaInstance?.tipoEmpresa?.encodeAsHTML()}
                    </div>

                </div>
            </g:if>

            <g:if test="${empresaInstance?.direccion}">
                <div class="row">
                    <div class="col-md-3 text-info">
                        Dirección
                    </div>

                    <div class="col-md-6">
                        <g:fieldValue bean="${empresaInstance}" field="direccion"/>
                    </div>

                </div>
            </g:if>

            <g:if test="${empresaInstance?.telefono}">
                <div class="row">
                    <div class="col-md-3 text-info">
                        Teléfono
                    </div>

                    <div class="col-md-6">
                        <g:fieldValue bean="${empresaInstance}" field="telefono"/>
                    </div>

                </div>
            </g:if>

            <g:if test="${empresaInstance?.email}">
                <div class="row">
                    <div class="col-md-3 text-info">
                        E-mail
                    </div>

                    <div class="col-md-6">
                        <g:fieldValue bean="${empresaInstance}" field="email"/>
                    </div>

                </div>
            </g:if>

            <g:if test="${empresaInstance?.fechaInicio}">
                <div class="row">
                    <div class="col-md-3 text-info">
                        Fecha Inicio
                    </div>

                    <div class="col-md-6">
                        <g:formatDate date="${empresaInstance?.fechaInicio}" format="dd-MM-yyyy"/>
                    </div>

                </div>
            </g:if>

            <g:if test="${empresaInstance?.fechaFin}">
                <div class="row">
                    <div class="col-md-3 text-info">
                        Fecha Fin
                    </div>

                    <div class="col-md-6">
                        <g:formatDate date="${empresaInstance?.fechaFin}" format="dd-MM-yyyy"/>
                    </div>

                </div>
            </g:if>
        </div>

        <g:if test="${empresaInstance?.numeroComprobanteDiario}">
            <div class="row">
                <div class="col-md-5 text-info">
                    Número Comprobante Diario
                </div>

                <div class="col-md-2">
                    <g:fieldValue bean="${empresaInstance}" field="numeroComprobanteDiario"/>
                </div>

            </div>
        </g:if>

        <g:if test="${empresaInstance?.numeroComprobanteIngreso}">
            <div class="row">
                <div class="col-md-5 text-info">
                    Número Comprobante Ingreso
                </div>

                <div class="col-md-2">
                    <g:fieldValue bean="${empresaInstance}" field="numeroComprobanteIngreso"/>
                </div>

            </div>
        </g:if>

        <g:if test="${empresaInstance?.numeroComprobanteEgreso}">
            <div class="row">
                <div class="col-md-5 text-info">
                    Número Comprobante Egreso
                </div>

                <div class="col-md-2">
                    <g:fieldValue bean="${empresaInstance}" field="numeroComprobanteEgreso"/>
                </div>

            </div>
        </g:if>

        <g:if test="${empresaInstance?.prefijoDiario}">
            <div class="row">
                <div class="col-md-5 text-info">
                    Prefijo Diario
                </div>

                <div class="col-md-2">
                    <g:fieldValue bean="${empresaInstance}" field="prefijoDiario"/>
                </div>

            </div>
        </g:if>

        <g:if test="${empresaInstance?.prefijoEgreso}">
            <div class="row">
                <div class="col-md-5 text-info">
                    Prefijo Egreso
                </div>

                <div class="col-md-2">
                    <g:fieldValue bean="${empresaInstance}" field="prefijoEgreso"/>
                </div>

            </div>
        </g:if>

        <g:if test="${empresaInstance?.prefijoIngreso}">
            <div class="row">
                <div class="col-md-5 text-info">
                    Prefijo Ingreso
                </div>

                <div class="col-md-2">
                    <g:fieldValue bean="${empresaInstance}" field="prefijoIngreso"/>
                </div>

            </div>
        </g:if>

        <g:if test="${empresaInstance?.ordenCompra}">
            <div class="row">
                <div class="col-md-5 text-info">
                    Orden Compra
                </div>

                <div class="col-md-2">
                    <g:fieldValue bean="${empresaInstance}" field="ordenCompra"/>
                </div>

            </div>
        </g:if>

    </g:else>
</div>