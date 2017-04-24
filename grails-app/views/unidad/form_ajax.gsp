<%@ page import="cratos.Unidad" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!unidadInstance}">
    <elm:notFound elem="Unidad" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmUnidad" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${unidadInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: unidadInstance, field: 'codigo', 'error')} required">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>

                <div class="col-md-4">
                    <g:textField name="codigo" maxlength="8" required="" class="allCaps form-control required"
                                 value="${unidadInstance?.codigo}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: unidadInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-8">
                    <g:textField name="descripcion" maxlength="31" class="form-control"
                                 value="${unidadInstance?.descripcion}"/>
                </div>

            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmUnidad").validate({
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