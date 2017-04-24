<%@ page import="cratos.CentroCosto" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!centroCostoInstance}">
    <elm:notFound elem="CentroCosto" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmCentroCosto" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${centroCostoInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: centroCostoInstance, field: 'empresa', 'error')} required">
            <span class="grupo">
                <label for="empresa" class="col-md-2 control-label text-info">
                    Empresa
                </label>

                <div class="col-md-6">
                    %{--<g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id" required=""--}%
                              %{--value="${centroCostoInstance?.empresa?.id}" class="many-to-one form-control"/>--}%
                    <g:textField name="empresa" class="form-control" value="${session.empresa}" readonly="true"/>

                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: centroCostoInstance, field: 'nombre', 'error')} required">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>

                <div class="col-md-6">
                    <g:textField name="nombre" maxlength="127" required="" class="form-control required"
                                 value="${centroCostoInstance?.nombre}"/>
                </div>
                *
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmCentroCosto").validate({
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