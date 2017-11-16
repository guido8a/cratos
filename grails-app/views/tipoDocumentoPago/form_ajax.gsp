<%@ page import="cratos.TipoDocumentoPago" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!tipoDocumentoPagoInstance}">
    <elm:notFound elem="TipoDocumentoPago" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmTipoDocumentoPago" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${tipoDocumentoPagoInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: tipoDocumentoPagoInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripcion
                </label>
                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="63" required="" class="form-control required" value="${tipoDocumentoPagoInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTipoDocumentoPago").validate({
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