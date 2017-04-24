<%@ page import="cratos.Cuenta" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!cuentaInstance}">
    <elm:notFound elem="Cuenta" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmCuenta" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${cuentaInstance?.id}"/>
        <g:hiddenField name="padre.id" value="${cuentaInstance?.padreId}"/>
        <g:hiddenField name="nivel.id" value="${cuentaInstance?.nivelId}"/>

        <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'padre', 'error')} ">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Padre
                </label>

                <div class="col-md-6">
                    <p class="form-control-static">${cuentaInstance?.padre}</p>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'nivel', 'error')} required">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Nivel
                </label>

                <div class="col-md-6">
                    <p class="form-control-static">${cuentaInstance?.nivelId}</p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'numero', 'error')} required">
            <span class="grupo">
                <label for="numero" class="col-md-2 control-label text-info">
                    Número
                </label>

                <div class="col-md-6">
                    <g:textField onfocus="this.value = this.value;" name="numero" maxlength="20" required="" class="allCaps form-control required" value="${cuentaInstance?.numero ?: cuentaInstance?.padre?.numero}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textArea name="descripcion" maxlength="127" required="" class="allCaps form-control required" value="${cuentaInstance?.descripcion}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'auxiliar', 'error')} ${hasErrors(bean: cuentaInstance, field: 'movimiento', 'error')}">
            <span class="grupo">
                <label for="auxiliar" class="col-md-2 control-label text-info">
                    Auxiliar
                </label>

                <div class="col-md-2">
                    <g:if test="${hijos == 0}">
                        <g:select name="auxiliar" from="${cuentaInstance.constraints.auxiliar.inList}" class="form-control" value="${cuentaInstance?.auxiliar ?: 'N'}"
                                  valueMessagePrefix="cuenta.auxiliar"/>
                    </g:if>
                    <g:else>
                        <g:message code="cuenta.auxiliar.${cuentaInstance.auxiliar}"/>
                    </g:else>
                </div>
            </span>

            <span class="grupo">
                <label for="movimiento" class="col-md-2 control-label text-info">
                    Movimiento
                </label>

                <div class="col-md-2">
                    <g:if test="${hijos == 0}">
                        <g:select name="movimiento" from="${cuentaInstance.constraints.movimiento.inList}" class="form-control" value="${cuentaInstance?.movimiento ?: '0'}"
                                  valueMessagePrefix="cuenta.movimiento"/>
                    </g:if>
                    <g:else>
                        <g:message code="cuenta.movimiento.${cuentaInstance.movimiento}"/>
                    </g:else>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'retencion', 'error')} ">
            <span class="grupo">
                <label for="retencion" class="col-md-2 control-label text-info">
                    Genera Retención
                </label>

                <div class="col-md-2">
                    <g:select name="retencion" from="${cuentaInstance.constraints.retencion.inList}" class="form-control" value="${cuentaInstance?.retencion ?: 'N'}"
                              valueMessagePrefix="cuenta.retencion"/>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'cuentaBanco', 'error')} ">
            <span class="grupo">
                <label for="cuentaBanco" class="col-md-2 control-label text-info">
                    Cuenta Banco
                </label>

                <div class="col-md-6">
                    <g:select id="cuentaBanco" name="cuentaBanco.id" from="${cratos.CuentaBanco.list()}" optionKey="id" value="${cuentaInstance?.cuentaBanco?.id}"
                              class="many-to-one form-control" noSelection="['': '']"/>
                </div>

            </span>
        </div>

        <g:if test="${hijos == 0}">
            <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'impuesto', 'error')} ">
                <span class="grupo">
                    <label for="impuesto" class="col-md-2 control-label text-info">
                        Impuesto
                    </label>

                    <div class="col-md-6">
                        <g:select id="impuesto" name="impuesto.id" from="${cratos.Impuesto.list([sort: 'codigo'])}"
                                  optionKey="id" value="${cuentaInstance?.impuesto?.id}" class="many-to-one form-control" noSelection="['': '']"
                                  optionValue="${{
                                      it.nombre + ' (' + it.porcentaje + '%, ret. ' + it.retencion + '%' + (it.sri == 'BNS' ? ', bienes' : it.sri == 'SRV' ? ', servicios' : '') + ')'
                                  }}"/>
                    </div>
                </span>
            </div>
        </g:if>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmCuenta").validate({
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
            },
            rules          : {
                numero : {
                    remote : {
                        url  : "${createLink(action: 'validarNumero_ajax')}",
                        type : "post",
                        data : {
                            id : "${cuentaInstance.id}"
                        }
                    }
                }
            },
            messages       : {
                numero : {
                    remote : "Número de cuenta ya ingresado"
                }
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