<%@ page import="cratos.Banco" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!bancoInstance}">
    <elm:notFound elem="Banco" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmBanco" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${bancoInstance?.id}"/>

        %{--<div class="form-group ${hasErrors(bean: bancoInstance, field: 'empresa', 'error')} ">--}%
            %{--<span class="grupo">--}%
                %{--<label for="empresa" class="col-md-2 control-label text-info">--}%
                    %{--Empresa--}%
                %{--</label>--}%

                %{--<div class="col-md-6">--}%
                    %{--<g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id"--}%
                              %{--value="${bancoInstance?.empresa?.id}" class="many-to-one form-control"--}%
                              %{--noSelection="['null': '']"/>--}%
                    %{--<g:textField name="empresa" value="${session.empresa}" class="form-control" readonly="true"/>--}%

                %{--</div>--}%

            %{--</span>--}%
        %{--</div>--}%


        <div class="form-group ${hasErrors(bean: bancoInstance, field: 'codigo', 'error')} required">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>

                <div class="col-md-6">
                    <g:textField name="codigo" maxlength="4" required="" class="allCaps form-control required"
                                 value="${bancoInstance?.codigo}"/>
                </div>
                *
            </span>
        </div>



        <div class="form-group ${hasErrors(bean: bancoInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="40" required="" class="form-control required"
                                 value="${bancoInstance?.descripcion}"/>
                </div>
                *
            </span>
        </div>





    </g:form>

    <script type="text/javascript">
        var validator = $("#frmBanco").validate({
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