<%@ page import="cratos.sri.SustentoTributario" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!sustentoTributarioInstance}">
    <elm:notFound elem="SustentoTributario" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmSustentoTributario" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${sustentoTributarioInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: sustentoTributarioInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripcion
                </label>
                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="127" class="allCaps form-control" value="${sustentoTributarioInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: sustentoTributarioInstance, field: 'codigo', 'error')} ">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Codigo
                </label>
                <div class="col-md-6">
                    <g:textField name="codigo" class="allCaps form-control" value="${sustentoTributarioInstance?.codigo}"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmSustentoTributario").validate({
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