<%@ page import="cratos.seguridad.Persona" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

<div class="col2">
    <g:if test="${!personaInstance}">
        <elm:notFound elem="Persona" genero="a"/>
    </g:if>
    <g:else>
        <g:form class="form-horizontal" name="frmPersona" role="form" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${personaInstance?.id}"/>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'cedula', 'error')} required">
                <span class="grupo">
                    <label for="cedula" class="col-md-3 control-label text-info">
                        Cédula
                    </label>

                    <div class="col-md-6">
                        <g:textField name="cedula" maxlength="10" required="" cedula="true" class="form-control required" value="${personaInstance?.cedula}"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'nombre', 'error')} required">
                <span class="grupo">
                    <label for="nombre" class="col-md-3 control-label text-info">
                        Nombre
                    </label>

                    <div class="col-md-6">
                        <g:textField name="nombre" maxlength="31" required="" class="form-control required allCaps" value="${personaInstance?.nombre}"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'apellido', 'error')} required">
                <span class="grupo">
                    <label for="apellido" class="col-md-3 control-label text-info">
                        Apellido
                    </label>

                    <div class="col-md-6">
                        <g:textField name="apellido" maxlength="31" required="" class="form-control required allCaps" value="${personaInstance?.apellido}"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'sigla', 'error')} ">
                <span class="grupo">
                    <label for="sigla" class="col-md-3 control-label text-info">
                        Sigla
                    </label>

                    <div class="col-md-6">
                        <g:textField name="sigla" maxlength="4" class="form-control allCaps" value="${personaInstance?.sigla}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'fechaNacimiento', 'error')} ">
                <span class="grupo">
                    <label for="fechaNacimiento" class="col-md-3 control-label text-info">
                        Fecha Nacimiento
                    </label>

                    <div class="col-md-4">
                        <elm:datepicker name="fechaNacimiento" title="fechaNacimiento" class="datepicker form-control" maxDate="-15y"
                                        value="${personaInstance?.fechaNacimiento}" default="none" noSelection="['': '']"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'email', 'error')} ">
                <span class="grupo">
                    <label for="email" class="col-md-3 control-label text-info">
                        E-mail
                    </label>

                    <div class="col-md-6">
                        <g:textField name="email" maxlength="63" email="true" class="form-control allCaps" value="${personaInstance?.email}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'telefono', 'error')} ">
                <span class="grupo">
                    <label for="telefono" class="col-md-3 control-label text-info">
                        Teléfono
                    </label>

                    <div class="col-md-6">
                        <g:textField name="telefono" maxlength="15" telefono="true" class="form-control" value="${personaInstance?.telefono}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'empresa', 'error')} ">
                <span class="grupo">
                    <label for="empresa" class="col-md-3 control-label text-info">
                        Empresa
                    </label>

                    <div class="col-md-6">
                        <g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}"
                                  optionKey="id" optionValue="nombre"
                                  value="${personaInstance?.empresa?.id}" class="many-to-one form-control"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'fechaInicio', 'error')} ">
                <span class="grupo">
                    <label for="login" class="col-md-3 control-label text-info">
                        Login
                    </label>

                    <div class="col-md-4">
                        <g:textField name="login" maxlength="15" class="form-control allCaps" value="${personaInstance?.login}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'activo', 'error')} required">
                <span class="grupo">
                    <label for="activo" class="col-md-3 control-label text-info">
                        Activo
                    </label>

                    <div class="col-md-3">
                        %{--<g:field name="activo" type="number" value="${personaInstance.activo}" class="digits form-control required" required=""/>--}%
                        <g:select name="activo" from="[0: 'NO', 1: 'SI']" value="${personaInstance.activo}" class="form-control required" required=""
                                  optionKey="key" optionValue="value"/>
                    </div>
                    *
                </span>
            </div>
        </g:form>

        <script type="text/javascript">
            var validator = $("#frmPersona").validate({
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
                    cedula : {
                        remote : {
                            url  : "${createLink(action: 'validarCedula_ajax')}",
                            type : "post",
                            data : {
                                id : "${personaInstance.id}"
                            }
                        }
                    }
                },
                messages       : {
                    cedula : {
                        remote : "Cédula ya ingresada"
                    }
                }
            });
            $(".form-control").keydown(function (ev) {
                if (ev.keyCode == 13) {
                    submitForm();
                    return false;
                }
                return true;
            });

            $("#apellido, #nombre").blur(function () {
                var nombre = $("#nombre").val();
                var apellido = $("#apellido").val();
                var sigla = (nombre + " " + apellido).acronym().toUpperCase();
                var user = nombre.acronym().toUpperCase() + apellido;
                $("#sigla").val(sigla);
                $("#login").val(user);
            });

        </script>

    </g:else>
</div>