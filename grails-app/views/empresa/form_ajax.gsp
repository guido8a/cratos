<%@ page import="cratos.Empresa" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

<div class="col2">
    <g:if test="${!empresaInstance}">
        <elm:notFound elem="Empresa" genero="o"/>
    </g:if>
    <g:else>
        <g:form class="form-horizontal" name="frmEmpresa" role="form" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${empresaInstance?.id}"/>
            <div class="keeptogether">
                <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'nombre', 'error')} ">
                    <span class="grupo">
                        <label for="nombre" class="col-md-3 control-label text-info">
                            Nombre
                        </label>

                        <div class="col-md-6">
                            <g:textField name="nombre" maxlength="63" class="form-control" value="${empresaInstance?.nombre}"/>
                        </div>

                    </span>
                </div>

                <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'ruc', 'error')} ">
                    <span class="grupo">
                        <label for="ruc" class="col-md-3 control-label text-info">
                            R.U.C.
                        </label>

                        <div class="col-md-6">
                            <g:textField name="ruc" maxlength="13" class="form-control" value="${empresaInstance?.ruc}"/>
                        </div>

                    </span>
                </div>

                <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'tipoEmpresa', 'error')} ">
                    <span class="grupo">
                        <label for="tipoEmpresa" class="col-md-3 control-label text-info">
                            Tipo Empresa
                        </label>

                        <div class="col-md-6">
                            <g:select id="tipoEmpresa" name="tipoEmpresa.id" from="${cratos.TipoEmpresa.list()}" optionKey="id" value="${empresaInstance?.tipoEmpresa?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                        </div>

                    </span>
                </div>

                <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'direccion', 'error')} ">
                    <span class="grupo">
                        <label for="direccion" class="col-md-3 control-label text-info">
                            Dirección
                        </label>

                        <div class="col-md-6">
                            <g:textArea name="direccion" maxlength="127" class="form-control" value="${empresaInstance?.direccion}"/>
                        </div>

                    </span>
                </div>

                <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'telefono', 'error')} ">
                    <span class="grupo">
                        <label for="telefono" class="col-md-3 control-label text-info">
                            Teléfono
                        </label>

                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                                <g:textField name="telefono" maxlength="63" class="form-control" value="${empresaInstance?.telefono}"/>
                            </div>
                        </div>

                    </span>
                </div>

                <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'email', 'error')} ">
                    <span class="grupo">
                        <label for="email" class="col-md-3 control-label text-info">
                            E-mail
                        </label>

                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                                <g:field type="email" name="email" maxlength="63" class="form-control" value="${empresaInstance?.email}"/>
                            </div>
                        </div>

                    </span>
                </div>


                <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'fechaInicio', 'error')} ">
                    <span class="grupo">
                        <label for="fechaInicio" class="col-md-3 control-label text-info">
                            Fecha Inicio
                        </label>

                        <div class="col-md-4">
                            <elm:datepicker name="fechaInicio" title="Fecha de inicio" class="datepicker form-control" value="${empresaInstance?.fechaInicio}"/>
                        </div>

                    </span>
                </div>

                <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'fechaFin', 'error')} ">
                    <span class="grupo">
                        <label for="fechaFin" class="col-md-3 control-label text-info">
                            Fecha Fin
                        </label>

                        <div class="col-md-4">
                            <elm:datepicker name="fechaFin" title="Fecha de fin" class="datepicker form-control" value="${empresaInstance?.fechaFin}"/>
                        </div>

                    </span>
                </div>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'numeroComprobanteDiario', 'error')} ">
                <span class="grupo">
                    <label for="numeroComprobanteDiario" class="col-md-6 control-label text-info">
                        Número Comprobante Diario
                    </label>

                    <div class="col-md-2">
                        <g:textField name="numeroComprobanteDiario" maxlength="20" class="form-control" value="${empresaInstance?.numeroComprobanteDiario}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'numeroComprobanteIngreso', 'error')} ">
                <span class="grupo">
                    <label for="numeroComprobanteIngreso" class="col-md-6 control-label text-info">
                        Número Comprobante Ingreso
                    </label>

                    <div class="col-md-2">
                        <g:textField name="numeroComprobanteIngreso" maxlength="20" class="form-control" value="${empresaInstance?.numeroComprobanteIngreso}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'numeroComprobanteEgreso', 'error')} ">
                <span class="grupo">
                    <label for="numeroComprobanteEgreso" class="col-md-6 control-label text-info">
                        Número Comprobante Egreso
                    </label>

                    <div class="col-md-2">
                        <g:textField name="numeroComprobanteEgreso" maxlength="20" class="form-control" value="${empresaInstance?.numeroComprobanteEgreso}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'prefijoDiario', 'error')} ">
                <span class="grupo">
                    <label for="prefijoDiario" class="col-md-6 control-label text-info">
                        Prefijo Diario
                    </label>

                    <div class="col-md-2">
                        <g:textField name="prefijoDiario" maxlength="20" class="form-control" value="${empresaInstance?.prefijoDiario}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'prefijoEgreso', 'error')} ">
                <span class="grupo">
                    <label for="prefijoEgreso" class="col-md-6 control-label text-info">
                        Prefijo Egreso
                    </label>

                    <div class="col-md-2">
                        <g:textField name="prefijoEgreso" maxlength="20" class="form-control" value="${empresaInstance?.prefijoEgreso}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'prefijoIngreso', 'error')} ">
                <span class="grupo">
                    <label for="prefijoIngreso" class="col-md-6 control-label text-info">
                        Prefijo Ingreso
                    </label>

                    <div class="col-md-2">
                        <g:textField name="prefijoIngreso" maxlength="20" class="form-control" value="${empresaInstance?.prefijoIngreso}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'ordenCompra', 'error')} ">
                <span class="grupo">
                    <label for="ordenCompra" class="col-md-6 control-label text-info">
                        Orden Compra
                    </label>

                    <div class="col-md-2">
                        <g:textField name="ordenCompra" maxlength="1" class="form-control" value="${empresaInstance?.ordenCompra}"/>
                    </div>

                </span>
            </div>

        </g:form>

        <script type="text/javascript">
            var validator = $("#frmEmpresa").validate({
                errorClass     : "help-block",
                errorPlacement : function (error, element) {
                    if (element.parent().hasClass("input-group")) {
                        error.insertAfter(element.parent());
                    } else {
                        error.insertAfter(element);
                    }
                    element.parents(".grupo").addClass('has-error');
                },
                success        : function (label) {
                    label.parents(".grupo").removeClass('has-error');
                }
            });
            $(".form-control").keydown(function (ev) {
                if (ev.keyCode == 13) {
                    submitForm();
                    return false;
                }
                return true;
            });
        </script>

    </g:else>
</div>