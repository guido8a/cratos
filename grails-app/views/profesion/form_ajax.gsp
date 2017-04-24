<%@ page import="cratos.Profesion" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!profesionInstance}">
    <elm:notFound elem="Profesion" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmProfesion" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${profesionInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: profesionInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="63" required="" class="allCaps form-control required"
                                 value="${profesionInstance?.descripcion}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: profesionInstance, field: 'sigla', 'error')} required">
            <span class="grupo">
                <label for="sigla" class="col-md-2 control-label text-info">
                    Sigla
                </label>

                <div class="col-md-6">
                    <g:textField name="sigla" maxlength="7" required="" class="allCaps form-control required"
                                 value="${profesionInstance?.sigla}"/>
                </div>
                *
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmProfesion").validate({
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