<%@ page import="cratos.ParametrosAuxiliares" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!parametrosAuxiliaresInstance}">
    <elm:notFound elem="ParametrosAuxiliares" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmParametrosAuxiliares" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${parametrosAuxiliaresInstance?.id}" />

        <div class="form-group keeptogether ${hasErrors(bean: parametrosAuxiliaresInstance, field: 'iva', 'error')} required">
            <span class="grupo">
                <label for="iva" class="col-md-3 control-label text-info">
                    Iva
                </label>
                <div class="col-md-3">
                    <g:textField name="iva" class="number form-control required" value="${fieldValue(bean: parametrosAuxiliaresInstance, field: 'iva')}" required="" maxlength="2"/>
                </div>
                *
            </span>
        </div>
        <div class="form-group keeptogether  ${hasErrors(bean: parametrosAuxiliaresInstance, field: 'fechaInicio', 'error')} ">
            <span class="grupo">
                <label for="fechaInicio" class="col-md-3 control-label text-info">
                    Fecha Desde
                </label>

                <div class="col-md-4">
                    <elm:datepicker name="fechaInicio" title="Fecha de Inicio" class="datepicker form-control required" maxDate="-5y"
                                    value="${parametrosAuxiliaresInstance?.fechaInicio}"/>
                </div>

            </span>
        </div>
        <div class="form-group keeptogether  ${hasErrors(bean: parametrosAuxiliaresInstance, field: 'fechaFin', 'error')} ">
            <span class="grupo">
                <label for="fechaFin" class="col-md-3 control-label text-info">
                    Fecha Hasta
                </label>

                <div class="col-md-4">
                    <elm:datepicker name="fechaFin" title="Fecha de Fin" class="datepicker form-control"
                                    value="${parametrosAuxiliaresInstance?.fechaFin}"/>
                </div>

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