<%@ page import="cratos.TipoSoporte" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!tipoSoporteInstance}">
    <elm:notFound elem="TipoSoporte" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmTipoSoporte" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${tipoSoporteInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: tipoSoporteInstance, field: 'codigo', 'error')} required">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>

                <div class="col-md-2">
                    <g:textField name="codigo" maxlength="2" required="" class="allCaps form-control required"
                                 value="${tipoSoporteInstance?.codigo}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: tipoSoporteInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-8">
                    %{--<g:textField name="descripcion" maxlength="127" required="" class="allCaps form-control required"--}%
                                 %{--value="${tipoSoporteInstance?.descripcion}"/>--}%
                    <g:textArea name="descripcion" maxlength="127" required="" class="allCaps form-control required" value="${tipoSoporteInstance?.descripcion}"
                    style="resize: none"/>

                </div>
                *
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTipoSoporte").validate({
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