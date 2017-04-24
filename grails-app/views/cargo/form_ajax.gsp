<%@ page import="cratos.Cargo" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!cargoInstance}">
    <elm:notFound elem="Cargo" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmCargo" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${cargoInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: cargoInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="127" required="" class="allCaps form-control required" value="${cargoInstance?.descripcion}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: cargoInstance, field: 'departamento', 'error')} ">
            <span class="grupo">
                <label for="departamento" class="col-md-2 control-label text-info">
                    Departamento
                </label>

                <div class="col-md-6">
                    <g:select id="departamento" name="departamento.id" from="${cratos.Departamento.findAllByEmpresa(session.empresa)}" optionKey="id" optionValue="descripcion"
                              value="${cargoInstance?.departamento?.id}"
                              class="many-to-one form-control" noSelection="['': '']"/>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: cargoInstance, field: 'sueldo', 'error')} required">
            <span class="grupo">
                <label for="sueldo" class="col-md-2 control-label text-info">
                    Sueldo
                </label>

                <div class="col-md-2">
                    <g:field name="sueldo" type="number" value="${fieldValue(bean: cargoInstance, field: 'sueldo')}" class="number form-control  required" required=""/>
                </div>
                *
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmCargo").validate({
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