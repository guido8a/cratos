<%@ page import="cratos.ParametrosAuxiliares" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!parametrosAuxiliaresInstance}">
    <elm:notFound elem="ParametrosAuxiliares" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmParametrosAuxiliares" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${parametrosAuxiliaresInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: parametrosAuxiliaresInstance, field: 'iva', 'error')} required">
            <span class="grupo">
                <label for="iva" class="col-md-2 control-label text-info">
                    Iva
                </label>
                <div class="col-md-2">
                    <g:field name="iva" type="number" value="${fieldValue(bean: parametrosAuxiliaresInstance, field: 'iva')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmParametrosAuxiliares").validate({
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