<%@ page import="cratos.seguridad.Persona; cratos.Empleado" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

<g:if test="${!empleadoInstance}">
    <elm:notFound elem="Empleado" genero="o"/>
</g:if>
<g:else>
    <g:form class="" name="frmEmpleado" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="empleado.id" value="${empleadoInstance?.id}"/>
        <g:hiddenField name="persona.id" value="${empleadoInstance?.persona?.id}"/>
        <div class="col3">
            <!-------------------------------------------------- PERSONA  DESDE AQUI -------------------------------------------------------------------->
            <div class="form-group keeptogether   ${hasErrors(bean: empleadoInstance.persona, field: 'cedula', 'error')} required">
                <span class="grupo">
                    <label for="persona.cedula" class="col-md-3 control-label text-info">
                        Cédula
                    </label>

                    <div class="col-md-8">
                        <g:textField name="persona.cedula" maxlength="10" cedula="true" required="" class="persona form-control required" value="${empleadoInstance.persona?.cedula}"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether   ${hasErrors(bean: empleadoInstance.persona, field: 'nombre', 'error')} required">
                <span class="grupo">
                    <label for="persona.nombre" class="col-md-3 control-label text-info">
                        Nombre
                    </label>

                    <div class="col-md-8">
                        <g:textField name="persona.nombre" maxlength="31" required="" class="persona form-control required" value="${empleadoInstance.persona?.nombre}"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether   ${hasErrors(bean: empleadoInstance.persona, field: 'apellido', 'error')} required">
                <span class="grupo">
                    <label for="persona.apellido" class="col-md-3 control-label text-info">
                        Apellido
                    </label>

                    <div class="col-md-8">
                        <g:textField name="persona.apellido" maxlength="31" required="" class="persona form-control required" value="${empleadoInstance.persona?.apellido}"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether keeptogether  ${hasErrors(bean: empleadoInstance.persona, field: 'sigla', 'error')} required">
                <span class="grupo">
                    <label for="persona.sigla" class="col-md-3 control-label text-info">
                        Sigla
                    </label>

                    <div class="col-md-8">
                        <g:textField name="persona.sigla" maxlength="8" required="" class="persona form-control required" value="${empleadoInstance.persona?.sigla}"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether keeptogether  ${hasErrors(bean: empleadoInstance.persona, field: 'fechaNacimiento', 'error')} ">
                <span class="grupo">
                    <label for="persona.fechaNacimiento" class="col-md-3 control-label text-info">
                        Fecha Nacimiento
                    </label>

                    <div class="col-md-8">
                        <elm:datepicker id="fechaNacimiento" name="persona.fechaNacimiento" title="Fecha de Nacimiento" class="persona datepicker form-control" maxDate="-15y"
                                        value="${empleadoInstance.persona?.fechaNacimiento}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether keeptogether  ${hasErrors(bean: empleadoInstance.persona, field: 'email', 'error')} ">
                <span class="grupo">
                    <label for="persona.email" class="col-md-3 control-label text-info">
                        E-mail
                    </label>

                    <div class="col-md-8">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                            <g:textField name="persona.email" maxlength="63" class="persona form-control email" value="${empleadoInstance.persona?.email}"/>
                        </div>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether keeptogether  ${hasErrors(bean: empleadoInstance.persona, field: 'telefono', 'error')} ">
                <span class="grupo">
                    <label for="persona.telefono" class="col-md-3 control-label text-info">
                        Teléfono
                    </label>

                    <div class="col-md-8">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                            <g:textField name="persona.telefono" maxlength="63" class="persona form-control digits" value="${empleadoInstance.persona?.telefono}"/>
                        </div>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether keeptogether  ${hasErrors(bean: empleadoInstance.persona, field: 'barrio', 'error')} ">
                <span class="grupo">
                    <label for="persona.barrio" class="col-md-3 control-label text-info">
                        Barrio
                    </label>

                    <div class="col-md-8">
                        <g:textField name="persona.barrio" maxlength="127" class="persona form-control" value="${empleadoInstance.persona?.barrio}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether keeptogether  ${hasErrors(bean: empleadoInstance.persona, field: 'direccion', 'error')} ">
                <span class="grupo">
                    <label for="persona.direccion" class="col-md-3 control-label text-info">
                        Dirección
                    </label>

                    <div class="col-md-8">
                        <g:textArea name="persona.direccion" maxlength="127" class="persona form-control" value="${empleadoInstance.persona?.direccion}" style="resize: none"/>
                    </div>

                </span>
            </div>


            <div class="form-group keeptogether keeptogether  ${hasErrors(bean: empleadoInstance.persona, field: 'discapacitado', 'error')} ">
                <span class="grupo">
                    <label for="persona.discapacitado" class="col-md-4 control-label text-info">
                        Discapacitado
                    </label>

                    <div class="col-md-6">
                        <g:select name="persona.discapacitado" from="${new Persona().constraints.discapacitado.inList}"
                                  class="persona form-control" value="${empleadoInstance.persona?.discapacitado ?: 'N'}" valueMessagePrefix="persona.discapacitado"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether keeptogether  ${hasErrors(bean: empleadoInstance.persona, field: 'sexo', 'error')} required">
                <span class="grupo">
                    <label for="persona.sexo" class="col-md-4 control-label text-info">
                        Sexo
                    </label>

                    <div class="col-md-6">
                        <g:select name="persona.sexo" from="${new Persona().constraints.sexo.inList}" required="" class="persona form-control required"
                                  value="${empleadoInstance.persona?.sexo}" valueMessagePrefix="persona.sexo"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether keeptogether  ${hasErrors(bean: empleadoInstance.persona, field: 'nacionalidad', 'error')} required">
                <span class="grupo">
                    <label for="persona.nacionalidad" class="col-md-4 control-label text-info">
                        Nacionalidad
                    </label>

                    <div class="col-md-6">
                        <g:select id="persona.nacionalidad" name="persona.nacionalidad.id" from="${cratos.Nacionalidad.list()}"
                                  optionKey="id" required="" value="${empleadoInstance.persona?.nacionalidad?.id}" class="persona many-to-one form-control"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether keeptogether  ${hasErrors(bean: empleadoInstance.persona, field: 'profesion', 'error')} ">
                <span class="grupo">
                    <label for="persona.profesion.id" class="col-md-4 control-label text-info">
                        Profesión
                    </label>

                    <div class="col-md-6">
                        <g:select id="persona.profesion" name="persona.profesion.id" from="${cratos.Profesion.list()}" optionKey="id" value="${empleadoInstance.persona?.profesion?.id}"
                                  class="persona many-to-one form-control" noSelection="['': '']"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether keeptogether  ${hasErrors(bean: empleadoInstance.persona, field: 'estadoCivil', 'error')} ">
                <span class="grupo">
                    <label for="persona.estadoCivil" class="col-md-4 control-label text-info">
                        Estado Civil
                    </label>

                    <div class="col-md-6">
                        <g:select id="persona.estadoCivil" name="persona.estadoCivil.id" from="${cratos.EstadoCivil.list()}" optionKey="id" optionValue="descripcion"
                                  value="${empleadoInstance.persona?.estadoCivil?.id}" class="persona many-to-one form-control" noSelection="['': '']"/>
                    </div>

                </span>
            </div>

            <!-------------------------------------------------- EMPLEADO DESDE AQUI -------------------------------------------------------------------->


            <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'estado', 'error')} ">
                <span class="grupo">
                    <label for="empleado.estado" class="col-md-4 control-label text-info">
                        Estado
                    </label>

                    <div class="col-md-6">
                        <g:select name="empleado.estado" maxlength="1" class="allCaps form-control"
                                  from="['A': 'ACTIVO', 'I': 'INACTIVO']" optionKey="key" optionValue="value" value="${empleadoInstance?.estado}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'fechaInicio', 'error')} ">
                <span class="grupo">
                    <label for="empleado.fechaInicio" class="col-md-4 control-label text-info">
                        Fecha Inicio
                    </label>

                    <div class="col-md-6">
                        <elm:datepicker id="fechaInicio" name="empleado.fechaInicio" title="fechaInicio" class="datepicker form-control" value="${empleadoInstance?.fechaInicio}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'fechaFin', 'error')} ">
                <span class="grupo">
                    <label for="empleado.fechaFin" class="col-md-4 control-label text-info">
                        Fecha Fin
                    </label>

                    <div class="col-md-6">
                        <elm:datepicker id="fechaFin" name="empleado.fechaFin" title="fechaFin" class="datepicker form-control" value="${empleadoInstance?.fechaFin}"/>
                    </div>

                </span>
            </div>


            <div class="form-group keeptogether keeptogether  ${hasErrors(bean: empleadoInstance.persona, field: 'direccionReferencia', 'error')} ">
                <span class="grupo">
                    <label for="persona.direccionReferencia" class="col-md-4 control-label text-info">
                        Referencias dirección
                    </label>

                    <div class="col-md-6">
                        <g:textArea name="persona.direccionReferencia" maxlength="127" class="persona form-control" value="${empleadoInstance.persona?.direccionReferencia}" style="resize: none"/>
                    </div>

                </span>
            </div>


            <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'sueldo', 'error')} required">
                <span class="grupo">
                    <label for="empleado.sueldo" class="col-md-4 control-label text-info">
                        Sueldo
                    </label>

                    <div class="col-md-6">
                        <g:field name="empleado.sueldo" type="number" value="${fieldValue(bean: empleadoInstance, field: 'sueldo')}" class="number form-control  required" required=""/>
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
                        <g:select name="empleado.porcentajeComision" type="number" value="${empleadoInstance.porcentajeComision ?: 0}"
                                  from="${0..100}" class="number form-control  required" required=""/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'cuenta', 'error')} ">
                <span class="grupo">
                    <label for="empleado.cuenta" class="col-md-4 control-label text-info">
                        Cuenta
                    </label>

                    <div class="col-md-6">
                        <g:textField name="empleado.cuenta" maxlength="12" class="allCaps form-control" value="${empleadoInstance?.cuenta}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'hijo', 'error')} required">
                <span class="grupo">
                    <label for="empleado.hijo" class="col-md-4 control-label text-info">
                        Hijos
                    </label>

                    <div class="col-md-3">
                        <g:field name="empleado.hijo" type="number" value="${empleadoInstance.hijo}" class="digits form-control required" required="" maxlength="2"/>
                    </div>

                    <div class="col-md-3">
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'iess', 'error')} ">
                <span class="grupo">
                    <label for="empleado.iess" class="col-md-4 control-label text-info">
                        IESS
                    </label>

                    <div class="col-md-6">
                        <g:textField name="empleado.iess" maxlength="13" class="allCaps form-control" value="${empleadoInstance?.iess}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'numero', 'error')} ">
                <span class="grupo">
                    <label for="empleado.numero" class="col-md-4 control-label text-info">
                        Número
                    </label>

                    <div class="col-md-6">
                        <g:textField name="empleado.numero" maxlength="10" class="allCaps form-control" value="${empleadoInstance?.numero}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'tipoContrato', 'error')} ">
                <span class="grupo">
                    <label for="empleado.tipoContrato" class="col-md-4 control-label text-info">
                        Tipo Contrato
                    </label>

                    <div class="col-md-6">
                        <g:select id="empleado.tipoContrato" name="empleado.tipoContrato.id" from="${cratos.TipoContrato.list()}" optionKey="id" optionValue="descripcion"
                                  value="${empleadoInstance?.tipoContrato?.id}" class="many-to-one form-control" noSelection="['': '']"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'cargo', 'error')} ">
                <span class="grupo">
                    <label for="empleado.cargo.id" class="col-md-4 control-label text-info">
                        Cargo
                    </label>

                    <div class="col-md-6">
                        <g:select id="cargo" name="empleado.cargo.id" from="${cratos.Cargo.list()}" optionKey="id" value="${empleadoInstance?.cargo?.id}"
                                  class="many-to-one form-control" noSelection="['': '']"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: empleadoInstance, field: 'observaciones', 'error')} ">
                <span class="grupo">
                    <label for="empleado.observaciones" class="col-md-4 control-label text-info">
                        Observaciones
                    </label>

                    <div class="col-md-6">
                        <g:textArea name="empleado.observaciones" maxlength="127" class="allCaps form-control" value="${empleadoInstance?.observaciones}" style="resize: none"/>
                    </div>

                </span>
            </div>

        </div>
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmEmpleado").validate({
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
            },
            rules          : {
                "persona.cedula" : {
                    remote : {
                        url  : "${createLink(action: 'validarCedula_ajax')}",
                        type : "post",
                        data : {
                            id : "${empleadoInstance.id}"
                        }
                    }
                }
            },
            messages       : {
                "persona.cedula" : {
                    remote : "Cédula ya ingresada"
                }
            }
        });

        $("#persona\\.cedula").blur(function () {
            var ci = $(this).val();
//            console.log("1");
            setTimeout(function () {
//                console.log("2");
                if (validator.element("#persona\\.cedula")) {
//                    console.log("3");
                    $.ajax({
                        type     : "POST",
                        dataType : "json",
                        url      : "${createLink(action: 'loadPersona')}",
                        data     : {
                            ci : ci
                        },
                        success  : function (msg) {
//                            console.log("4");
                            if ($.isEmptyObject(msg)) {
                                $(".persona").not("#persona\\.cedula").val("");
                            } else {
                                $.each(msg, function (i, obj) {
                                    $("#persona\\." + i).val(obj);
                                });
                                $("#empleado\\.porcentajeComision").focus();
                            }
                        }
                    });
                }
            }, 500);

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