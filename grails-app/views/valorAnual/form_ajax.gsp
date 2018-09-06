<%@ page import="cratos.ValorAnual" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!valorAnualInstance}">
    <elm:notFound elem="ValorAnual" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmValorAnual" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${valorAnualInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: valorAnualInstance, field: 'anio', 'error')} ">
            <span class="grupo">
                <label for="anio" class="col-md-3 control-label text-info">
                    Año
                </label>
                <div class="col-md-5">
                    <g:select id="anio" name="anio.id" from="${cratos.Anio.list()}" optionKey="id" optionValue="anio" required="" value="${valorAnualInstance?.anio?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: valorAnualInstance, field: 'fraccionBasica', 'error')} ">
            <span class="grupo">
                <label for="fraccionBasica" class="col-md-3 control-label text-info">
                    Fracción Básica
                </label>
                <div class="col-md-5">
                    <g:textField name="fraccionBasica" value="${valorAnualInstance.fraccionBasica}" class="digits form-control required" required=""/>
                </div>

            </span>
        </div>
        <div class="form-group ${hasErrors(bean: valorAnualInstance, field: 'excesoHasta', 'error')} ">
            <span class="grupo">
                <label for="excesoHasta" class="col-md-3 control-label text-info">
                    Exceso Hasta
                </label>
                <div class="col-md-5">
                    <g:textField name="excesoHasta" value="${valorAnualInstance.excesoHasta}" class="digits form-control required" required=""/>
                </div>
                
            </span>
        </div>
        <div class="form-group ${hasErrors(bean: valorAnualInstance, field: 'impuesto', 'error')} ">
            <span class="grupo">
                <label for="impuesto" class="col-md-3 control-label text-info">
                    Impuesto
                </label>
                <div class="col-md-5">
                    <g:textField name="impuesto" value="${valorAnualInstance.impuesto}" class="number form-control  required" required=""/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: valorAnualInstance, field: 'porcentaje', 'error')} ">
            <span class="grupo">
                <label for="porcentaje" class="col-md-3 control-label text-info">
                    Porcentaje
                </label>
                <div class="col-md-5">
                    <g:textField name="porcentaje" value="${valorAnualInstance.porcentaje}" class="digits form-control required" required=""/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmValorAnual").validate({
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