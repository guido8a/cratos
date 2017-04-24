<%@ page import="cratos.Departamento" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!departamentoInstance}">
    <elm:notFound elem="Departamento" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmDepartamento" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${departamentoInstance?.id}"/>

        %{--<div class="form-group ${hasErrors(bean: departamentoInstance, field: 'empresa', 'error')} ">--}%
            %{--<span class="grupo">--}%
                %{--<label for="empresa" class="col-md-2 control-label text-info">--}%
                    %{--Empresa--}%
                %{--</label>--}%

                %{--<div class="col-md-6">--}%
                    %{--<g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id"--}%
                              %{--value="${departamentoInstance?.empresa?.id}" class="many-to-one form-control"--}%
                              %{--noSelection="['null': '']"/>--}%
                %{--</div>--}%

            %{--</span>--}%
        %{--</div>--}%

        <div class="form-group ${hasErrors(bean: departamentoInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-8">
                    <g:textField name="descripcion" class="form-control required"
                                 value="${departamentoInstance?.descripcion}" required="" maxlength="63"/>
                </div>
                *
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmDepartamento").validate({
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