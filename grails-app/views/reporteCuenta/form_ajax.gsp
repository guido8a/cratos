<%@ page import="cratos.ReporteCuenta" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!reporteCuentaInstance}">
    <elm:notFound elem="ReporteCuenta" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmReporteCuenta" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${reporteCuentaInstance?.id}"/>

        %{--<div class="form-group ${hasErrors(bean: reporteCuentaInstance, field: 'empresa', 'error')} ">--}%
            %{--<span class="grupo">--}%
                %{--<label for="empresa" class="col-md-2 control-label text-info">--}%
                    %{--Empresa--}%
                %{--</label>--}%

                %{--<div class="col-md-6">--}%
                    %{--<g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id"--}%
                              %{--value="${reporteCuentaInstance?.empresa?.id}" class="many-to-one form-control"--}%
                              %{--noSelection="['null': '']"/>--}%
                %{--</div>--}%

            %{--</span>--}%
        %{--</div>--}%

        <div class="form-group ${hasErrors(bean: reporteCuentaInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" required="" class="form-control required"
                                 value="${reporteCuentaInstance?.descripcion}"/>
                </div>
                *
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmReporteCuenta").validate({
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