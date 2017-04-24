<%@ page import="cratos.Grupo" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!grupoInstance}">
    <elm:notFound elem="Grupo" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmGrupo" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${grupoInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: grupoInstance, field: 'codigo', 'error')} ">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>

                <div class="col-md-6">
                    <g:textField name="codigo" maxlength="4" class="allCaps form-control"
                                 value="${grupoInstance?.codigo}"/>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: grupoInstance, field: 'cuenta', 'error')} ">
            <span class="grupo">
                <label for="cuenta" class="col-md-2 control-label text-info">
                    Cuenta
                </label>

                <div class="col-md-6">
                    %{--<g:select id="cuenta" name="cuenta.id" from="${cratos.Cuenta.list()}" optionKey="id"--}%
                              %{--value="${grupoInstance?.cuenta?.id}" class="many-to-one form-control"--}%
                              %{--noSelection="['null': '']"/>--}%


                    <g:select id="cuenta" name="cuenta.id" from="${cuentas}" optionKey="id"
                              value="${grupoInstance?.cuenta?.id}" class="many-to-one form-control"
                              noSelection="['null': '']"/>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: grupoInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="63" class="allCaps form-control"
                                 value="${grupoInstance?.descripcion}"/>
                </div>

            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmGrupo").validate({
            errorClass: "help-block",
            errorPlacement: function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success: function (label) {
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