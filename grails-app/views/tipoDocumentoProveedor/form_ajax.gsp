<%@ page import="cratos.TipoDocumentoProveedor" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!tipoDocumentoProveedorInstance}">
    <elm:notFound elem="TipoDocumentoProveedor" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmTipoDocumentoProveedor" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${tipoDocumentoProveedorInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: tipoDocumentoProveedorInstance, field: 'codigo', 'error')} required">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>

                <div class="col-md-6">
                    <g:textField name="codigo" maxlength="1" required="" class="allCaps form-control required"
                                 value="${tipoDocumentoProveedorInstance?.codigo}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: tipoDocumentoProveedorInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="31" required="" class="allCaps form-control required"
                                 value="${tipoDocumentoProveedorInstance?.descripcion}"/>
                </div>
                *
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTipoDocumentoProveedor").validate({
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