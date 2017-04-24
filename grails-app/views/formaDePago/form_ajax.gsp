<%@ page import="cratos.FormaDePago" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!formaDePagoInstance}">
    <elm:notFound elem="FormaDePago" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmFormaDePago" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${formaDePagoInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: formaDePagoInstance, field: 'codigo', 'error')} required">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>

                <div class="col-md-2">
                    <g:textField name="codigo" maxlength="4" minlength="4" required="" class="allCaps form-control required" value="${formaDePagoInstance?.codigo}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: formaDePagoInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="31" class="allCaps form-control" value="${formaDePagoInstance?.descripcion}"/>
                </div>

            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmFormaDePago").validate({
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