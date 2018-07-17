<%@ page import="cratos.Anio" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!anioInstance}">
    <elm:notFound elem="Anio" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmAnio" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${anioInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: anioInstance, field: 'anio', 'error')} ">
            <span class="grupo">
                <label for="anio" class="col-md-2 control-label text-info">
                    Anio
                </label>
                <div class="col-md-6">
                    <g:textField name="anio" required="" class="allCaps form-control required" value="${anioInstance?.anio}"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmAnio").validate({
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