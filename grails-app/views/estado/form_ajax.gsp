<%@ page import="cratos.Estado" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!estadoInstance}">
    <elm:notFound elem="Estado" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmEstado" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${estadoInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: estadoInstance, field: 'codigo', 'error')} ">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>

                <div class="col-md-2">
                    <g:textField name="codigo" maxlength="1" class="allCaps form-control" value="${estadoInstance?.codigo}"/>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: estadoInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="63" class="allCaps form-control" value="${estadoInstance?.descripcion}"/>
                </div>

            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmEstado").validate({
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