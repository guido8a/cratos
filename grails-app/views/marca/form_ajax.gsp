<%@ page import="cratos.Marca" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!marcaInstance}">
    <elm:notFound elem="Marca" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmMarca" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${marcaInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: marcaInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-8">
                    <g:textField name="descripcion" maxlength="31" class="allCaps form-control required"
                                 value="${marcaInstance?.descripcion}"/>
                </div>
               *
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmMarca").validate({
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