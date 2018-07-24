<%@ page import="cratos.seguridad.Persona; cratos.Empleado" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

%{--<g:if test="${!empleadoInstance}">--}%
%{--<elm:notFound elem="Empleado" genero="o"/>--}%
%{--</g:if>--}%
%{--<g:else>--}%
<g:form class="" name="frmEmpleado" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="empleado.id" value="${empleadoInstance?.id}"/>
    <g:hiddenField name="persona.id" value="${persona?.id}"/>
    <div class="col2">

        <!-------------------------------------------------- EMPLEADO DESDE AQUI -------------------------------------------------------------------->


        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'estado', 'error')} ">
            <span class="grupo">
                <label for="empleado.departamento.id" class="col-md-4 control-label text-info">
                    Departamento
                </label>

                <div class="col-md-8">
                    <g:select name="empleado.departamento.id" class="form-control"
                              from="${cratos.Departamento.findAllByEmpresa(session.empresa)}" optionKey="id" optionValue="descripcion" value="${empleadoInstance?.departamento?.id}" />
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'tipoContrato', 'error')} ">
            <span class="grupo">
                <label for="empleado.tipoContrato" class="col-md-4 control-label text-info">
                    Tipo Contrato
                </label>

                <div class="col-md-8">
                    <g:select id="empleado.tipoContrato" name="empleado.tipoContrato.id" from="${cratos.TipoContrato.list()}" optionKey="id" optionValue="descripcion"
                              value="${empleadoInstance?.tipoContrato?.id}" class="many-to-one form-control" />
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'estado', 'error')} ">
            <span class="grupo">
                <label for="empleado.estado" class="col-md-4 control-label text-info">
                    Estado
                </label>
                <div class="col-md-4">
                    <g:select name="empleado.estado" class="form-control"
                              from="['A': 'ACTIVO', 'I': 'INACTIVO']" optionKey="key" optionValue="value" value="${empleadoInstance?.estado}"/>
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'fechaInicio', 'error')} ">
            <span class="grupo">
                <label for="empleado.fechaInicio" class="col-md-4 control-label text-info">
                    Fecha Inicio
                </label>

                <div class="col-md-4">
                    <elm:datepicker id="fechaInicio" name="empleado.fechaInicio" title="fechaInicio" class="datepicker form-control" value="${empleadoInstance?.fechaInicio}"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'fechaFin', 'error')} ">
            <span class="grupo">
                <label for="empleado.fechaFin" class="col-md-4 control-label text-info">
                    Fecha Fin
                </label>

                <div class="col-md-4">
                    <elm:datepicker id="fechaFin" name="empleado.fechaFin" title="fechaFin" class="datepicker form-control" value="${empleadoInstance?.fechaFin}"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'sueldo', 'error')} required">
            <span class="grupo">
                <label for="empleado.sueldo" class="col-md-4 control-label text-info">
                    Sueldo
                </label>

                <div class="col-md-4">
                    <g:textField name="empleado.sueldo" value="${empleadoInstance?.sueldo ?: 0}" class="number form-control  required" required=""/>
                </div>
                *
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'porcentajeComision', 'error')} required">
            <span class="grupo">
                <label for="empleado.porcentajeComision" class="col-md-4 control-label text-info">
                    Porcentaje Comisión
                </label>

                <div class="col-md-4">
                    <g:textField name="empleado.porcentajeComision" value="${empleadoInstance?.porcentajeComision ?: 0}" class="number form-control required" required=""/>
                </div>
                *
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'hijo', 'error')} required">
            <span class="grupo">
                <label for="empleado.hijo" class="col-md-4 control-label text-info">
                    Hijos
                </label>

                <div class="col-md-3">
                    <g:textField name="empleado.hijo" value="${empleadoInstance?.hijo ?: 0}" class="digits form-control required" required="" maxlength="2"/>
                </div>
                <div class="col-md-3">
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'cuenta', 'error')} ">
            <span class="grupo">
                <label for="empleado.cuenta" class="col-md-4 control-label text-info">
                    Cuenta Bancaria
                </label>

                <div class="col-md-8">
                    <g:textField name="empleado.cuenta" maxlength="12" class="form-control" value="${empleadoInstance?.cuenta}"/>
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'iess', 'error')} ">
            <span class="grupo">
                <label for="empleado.iess" class="col-md-4 control-label text-info">
                    IESS
                </label>

                <div class="col-md-8">
                    <g:textField name="empleado.iess" maxlength="13" class="allCaps form-control" value="${empleadoInstance?.iess}"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'numero', 'error')} ">
            <span class="grupo">
                <label for="empleado.numero" class="col-md-4 control-label text-info">
                    Número Empleado
                </label>

                <div class="col-md-8">
                    <g:textField name="empleado.numero" maxlength="10" class="allCaps form-control" value="${empleadoInstance?.numero}"/>
                </div>

            </span>
        </div>



        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'cargo', 'error')} ">
            <span class="grupo">
                <label for="empleado.cargo" class="col-md-4 control-label text-info">
                    Cargo
                </label>

                <div class="col-md-8">
                    <g:textField name="empleado.cargo" class="form-control" value="${empleadoInstance?.cargo}"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'telefono', 'error')} ">
            <span class="grupo">
                <label for="empleado.telefono" class="col-md-4 control-label text-info">
                    Teléfono
                </label>

                <div class="col-md-8">
                    <g:textField name="empleado.telefono" class="digits form-control" value="${empleadoInstance?.telefono}"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'mail', 'error')} ">
            <span class="grupo">
                <label for="empleado.mail" class="col-md-4 control-label text-info">
                    Mail
                </label>

                <div class="col-md-8">
                    <g:textField name="empleado.mail" class="email form-control" value="${empleadoInstance?.mail}"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'observaciones', 'error')} ">
            <span class="grupo">
                <label for="empleado.observaciones" class="col-md-4 control-label text-info">
                    Observaciones
                </label>

                <div class="col-md-8">
                    <g:textArea name="empleado.observaciones" maxlength="127" class="allCaps form-control" value="${empleadoInstance?.observaciones}" style="resize: none"/>
                </div>

            </span>
        </div>

    </div>
</g:form>

<script type="text/javascript">
    %{--var validator = $("#frmEmpleado").validate({--}%
    %{--errorClass     : "help-block",--}%
    %{--errorPlacement : function (error, element) {--}%
    %{--if (element.parent().hasClass("input-group")) {--}%
    %{--error.insertAfter(element.parent());--}%
    %{--} else {--}%
    %{--error.insertAfter(element);--}%
    %{--}--}%
    %{--element.parents(".grupo").addClass('has-error');--}%
    %{--},--}%
    %{--success        : function (label) {--}%
    %{--label.parents(".grupo").removeClass('has-error');--}%
    %{--},--}%
    %{--rules          : {--}%
    %{--"persona.cedula" : {--}%
    %{--remote : {--}%
    %{--url  : "${createLink(action: 'validarCedula_ajax')}",--}%
    %{--type : "post",--}%
    %{--data : {--}%
    %{--id : "${empleadoInstance.id}"--}%
    %{--}--}%
    %{--}--}%
    %{--}--}%
    %{--},--}%
    %{--messages       : {--}%
    %{--"persona.cedula" : {--}%
    %{--remote : "Cédula ya ingresada"--}%
    %{--}--}%
    %{--}--}%
    %{--});--}%

    %{--$("#persona\\.cedula").blur(function () {--}%
    %{--var ci = $(this).val();--}%
    %{--setTimeout(function () {--}%
    %{--if (validator.element("#persona\\.cedula")) {--}%
    %{--$.ajax({--}%
    %{--type     : "POST",--}%
    %{--dataType : "json",--}%
    %{--url      : "${createLink(action: 'loadPersona')}",--}%
    %{--data     : {--}%
    %{--ci : ci--}%
    %{--},--}%
    %{--success  : function (msg) {--}%
    %{--if ($.isEmptyObject(msg)) {--}%
    %{--$(".persona").not("#persona\\.cedula").val("");--}%
    %{--} else {--}%
    %{--$.each(msg, function (i, obj) {--}%
    %{--$("#persona\\." + i).val(obj);--}%
    %{--});--}%
    %{--$("#empleado\\.porcentajeComision").focus();--}%
    %{--}--}%
    %{--}--}%
    %{--});--}%
    %{--}--}%
    %{--}, 500);--}%

    %{--});--}%

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode == 13) {
            submitForm();
            return false;
        }
        return true;
    });
</script>

%{--</g:else>--}%