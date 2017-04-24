<%@ page import="cratos.TipoRelacion" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!tipoRelacionInstance}">
    <elm:notFound elem="TipoRelacion" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmTipoRelacion" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${tipoRelacionInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: tipoRelacionInstance, field: 'codigo', 'error')} required">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>

                <div class="col-md-6">
                    <g:textField name="codigo" maxlength="1" required="" class="allCaps form-control required"
                                 value="${tipoRelacionInstance?.codigo}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: tipoRelacionInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="31" required="" class="allCaps form-control required"
                                 value="${tipoRelacionInstance?.descripcion}"/>
                </div>
                *
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTipoRelacion").validate({
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