<%@ page import="cratos.Rubro" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!rubroInstance}">
    <elm:notFound elem="Rubro" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmRubro" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${rubroInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: rubroInstance, field: 'tipoRubro', 'error')} required">
            <span class="grupo">
                <label for="tipoRubro" class="col-md-3 control-label text-info">
                    Tipo Rubro
                </label>

                <div class="col-md-6">
                    <g:select id="tipoRubro" name="tipoRubro.id" from="${cratos.TipoRubro.list()}" optionKey="id"
                              required="" value="${rubroInstance?.tipoRubro?.id}" class="many-to-one form-control"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: rubroInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-3 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="63" required="" class="allCaps form-control required"
                                 value="${rubroInstance?.descripcion}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: rubroInstance, field: 'valor', 'error')} required">
            <span class="grupo">
                <label for="valor" class="col-md-3 control-label text-info">
                    Valor
                </label>

                <div class="col-md-5">
                    <g:field name="valor" type="number" value="${fieldValue(bean: rubroInstance, field: 'valor')}"
                             class="number form-control  required" required=""/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: rubroInstance, field: 'porcentaje', 'error')} required">
            <span class="grupo">
                <label for="porcentaje" class="col-md-3 control-label text-info">
                    Porcentaje
                </label>

                <div class="col-md-5">
                    <g:field name="porcentaje" type="number"
                             value="${fieldValue(bean: rubroInstance, field: 'porcentaje')}"
                             class="number form-control  required" required=""/>
                </div>
                *
            </span>
        </div>





        <div class="form-group ${hasErrors(bean: rubroInstance, field: 'decimo', 'error')} required">
            <span class="grupo">
                <label for="decimo" class="col-md-3 control-label text-info">
                    Décimo
                </label>

                <div class="col-md-2">
                    %{--<g:textField name="decimo" maxlength="1" required="" class="allCaps form-control required"--}%
                                 %{--value="${rubroInstance?.decimo}"/>--}%
                    <g:select name="decimo" from="${['1': 'SI', '0': 'NO']}" optionValue="value" optionKey="key" class="form-control required"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: rubroInstance, field: 'iess', 'error')} required">
            <span class="grupo">
                <label for="iess" class="col-md-3 control-label text-info">
                    IESS
                </label>

                <div class="col-md-2">
                    %{--<g:textField name="iess" maxlength="1" required="" class="allCaps form-control required"--}%
                                 %{--value="${rubroInstance?.iess}"/>--}%

                    <g:select name="iess" from="${['1': 'SI', '0': 'NO']}" optionValue="value" optionKey="key" class="form-control required"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: rubroInstance, field: 'gravable', 'error')} required">
            <span class="grupo">
                <label for="gravable" class="col-md-3 control-label text-info">
                    Gravable
                </label>

                <div class="col-md-2">
                    %{--<g:textField name="gravable" maxlength="1" required="" class="allCaps form-control required"--}%
                                 %{--value="${rubroInstance?.gravable}"/>--}%
                    <g:select name="gravable" from="${['1': 'SI', '0': 'NO']}" optionValue="value" optionKey="key" class="form-control required"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: rubroInstance, field: 'editable', 'error')} required">
            <span class="grupo">
                <label for="editable" class="col-md-3 control-label text-info">
                    Editable
                </label>

                <div class="col-md-2">
                    %{--<g:textField name="editable" maxlength="1" required="" class="allCaps form-control required"--}%
                                 %{--value="${rubroInstance?.editable}"/>--}%

                    <g:select name="editable" from="${['1': 'SI', '0': 'NO']}" optionValue="value" optionKey="key" class="form-control required"/>
                </div>
                *
            </span>
        </div>


    </g:form>

    <script type="text/javascript">
        var validator = $("#frmRubro").validate({
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