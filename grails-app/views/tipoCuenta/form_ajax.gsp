<%@ page import="cratos.TipoCuenta" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!tipoCuentaInstance}">
    <elm:notFound elem="TipoCuenta" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmTipoCuenta" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${tipoCuentaInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: tipoCuentaInstance, field: 'tipoCuenta', 'error')} required">
            <span class="grupo">
                <label for="tipoCuenta" class="col-md-3 control-label text-info">
                    Tipo de Cuenta
                </label>

                <div class="col-md-6">
                    <g:textField name="tipoCuenta" required="" class="allCaps form-control required"
                                 value="${tipoCuentaInstance?.tipoCuenta}"/>
                </div>
                *
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTipoCuenta").validate({
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