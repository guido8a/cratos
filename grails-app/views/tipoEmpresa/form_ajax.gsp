<%@ page import="cratos.TipoEmpresa" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!tipoEmpresaInstance}">
    <elm:notFound elem="TipoEmpresa" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmTipoEmpresa" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${tipoEmpresaInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: tipoEmpresaInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" class="allCaps form-control required"
                                 value="${tipoEmpresaInstance?.descripcion}"/>
                </div>
                *
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTipoEmpresa").validate({
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