<%@ page import="cratos.sri.TipoComprobanteSri" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!tipoComprobanteSriInstance}">
    <elm:notFound elem="TipoComprobanteSri" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmTipoComprobanteSri" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${tipoComprobanteSriInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: tipoComprobanteSriInstance, field: 'codigo', 'error')} ">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>
                <div class="col-md-2">
                    <g:textField name="codigo" maxlength="4" required="" class="allCaps form-control required" value="${tipoComprobanteSriInstance?.codigo}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: tipoComprobanteSriInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-10">
                    <g:textField name="descripcion" maxlength="127" required="" class="form-control required" value="${tipoComprobanteSriInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTipoComprobanteSri").validate({
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