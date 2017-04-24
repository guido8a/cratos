<%@ page import="cratos.Base" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!baseInstance}">
    <elm:notFound elem="Base" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmBase" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${baseInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: baseInstance, field: 'periodo', 'error')} required">
            <span class="grupo">
                <label for="periodo" class="col-md-4 control-label text-info">
                    Período
                </label>

                <div class="col-md-7">
                    <g:select id="periodo" name="periodo.id" from="${cratos.Contabilidad.list()}" optionKey="id"
                              required="" value="${baseInstance?.periodo?.id}" class="many-to-one form-control"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: baseInstance, field: 'fraccionBasica', 'error')} required">
            <span class="grupo">
                <label for="fraccionBasica" class="col-md-4 control-label text-info">
                    Fracción Básica
                </label>

                <div class="col-md-6">
                    <g:field name="fraccionBasica" type="number"
                             value="${fieldValue(bean: baseInstance, field: 'fraccionBasica')}"
                             class="number form-control  required" required=""/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: baseInstance, field: 'excesoHasta', 'error')} required">
            <span class="grupo">
                <label for="excesoHasta" class="col-md-4 control-label text-info">
                    Exceso Hasta
                </label>

                <div class="col-md-6">
                    <g:field name="excesoHasta" type="number"
                             value="${fieldValue(bean: baseInstance, field: 'excesoHasta')}"
                             class="number form-control  required" required=""/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: baseInstance, field: 'impuestosFraccion', 'error')} required">
            <span class="grupo">
                <label for="impuestosFraccion" class="col-md-4 control-label text-info">
                    Impuestos Fracción
                </label>

                <div class="col-md-6">
                    <g:field name="impuestosFraccion" type="number"
                             value="${fieldValue(bean: baseInstance, field: 'impuestosFraccion')}"
                             class="number form-control  required" required=""/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: baseInstance, field: 'porcentaje', 'error')} required">
            <span class="grupo">
                <label for="porcentaje" class="col-md-4 control-label text-info">
                    Porcentaje
                </label>

                <div class="col-md-6">
                    <g:field name="porcentaje" type="number"
                             value="${fieldValue(bean: baseInstance, field: 'porcentaje')}"
                             class="number form-control  required" required=""/>
                </div>
                *
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmBase").validate({
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