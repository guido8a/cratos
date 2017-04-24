<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 1/29/14
  Time: 12:35 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Admin</title>

        <style type="text/css">
        .perfil .fa-li, .perfil span, .permiso .fa-li, .permiso span {
            cursor : pointer;
        }
        </style>
    </head>

    <body>
        <%@ page import="cratos.seguridad.Persona" %>

        <elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

        <g:if test="${!personaInstance}">
            <elm:notFound elem="Persona" genero="a"/>
        </g:if>
        <g:else>
            <div class="col3">
                <g:form class="form-horizontal" name="frmPersona" role="form" action="save" method="POST">
                    <g:hiddenField name="id" value="${personaInstance?.id}"/>

                    <div class="keeptogether">
                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'empresa', 'error')} ">
                            <span class="grupo">
                                <label for="empresa" class="col-md-3 control-label text-info">
                                    Empresa
                                </label>

                                <div class="col-md-6">
                                    <g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id" value="${personaInstance?.empresa?.id}"
                                              class="required many-to-one form-control"/>
                                </div>
                                *
                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'cedula', 'error')} required">
                            <span class="grupo">
                                <label for="cedula" class="col-md-3 control-label text-info">
                                    Cédula
                                </label>

                                <div class="col-md-6">
                                    <g:textField name="cedula" maxlength="10" cedula="true" required="" class="form-control required" value="${personaInstance?.cedula}"/>
                                </div>
                                *
                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'nombre', 'error')} required">
                            <span class="grupo">
                                <label for="nombre" class="col-md-3 control-label text-info">
                                    Nombre
                                </label>

                                <div class="col-md-6">
                                    <g:textField name="nombre" maxlength="31" required="" class="form-control required" value="${personaInstance?.nombre}"/>
                                </div>
                                *
                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'apellido', 'error')} required">
                            <span class="grupo">
                                <label for="apellido" class="col-md-3 control-label text-info">
                                    Apellido
                                </label>

                                <div class="col-md-6">
                                    <g:textField name="apellido" maxlength="31" required="" class="form-control required" value="${personaInstance?.apellido}"/>
                                </div>
                                *
                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'sigla', 'error')} required">
                            <span class="grupo">
                                <label for="sigla" class="col-md-3 control-label text-info">
                                    Sigla
                                </label>

                                <div class="col-md-6">
                                    <g:textField name="sigla" maxlength="8" required="" class="form-control required" value="${personaInstance?.sigla}"/>
                                </div>
                                *
                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'fechaNacimiento', 'error')} ">
                            <span class="grupo">
                                <label for="fechaNacimiento" class="col-md-3 control-label text-info">
                                    Fecha Nacimiento
                                </label>

                                <div class="col-md-4">
                                    <elm:datepicker name="fechaNacimiento" title="Fecha de Nacimiento" class="datepicker form-control" maxDate="-15y"
                                                    value="${personaInstance?.fechaNacimiento}"/>
                                </div>

                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'email', 'error')} ">
                            <span class="grupo">
                                <label for="email" class="col-md-3 control-label text-info">
                                    E-mail
                                </label>

                                <div class="col-md-6">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                                        <g:textField name="email" maxlength="63" class="form-control" value="${personaInstance?.email}"/>
                                    </div>
                                </div>
                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'telefono', 'error')} ">
                            <span class="grupo">
                                <label for="telefono" class="col-md-3 control-label text-info">
                                    Teléfono
                                </label>

                                <div class="col-md-6">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                                        <g:textField name="telefono" maxlength="63" class="form-control" value="${personaInstance?.telefono}"/>
                                    </div>
                                </div>

                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'direccion', 'error')} ">
                            <span class="grupo">
                                <label for="direccion" class="col-md-3 control-label text-info">
                                    Dirección
                                </label>

                                <div class="col-md-6">
                                    <g:textArea name="direccion" maxlength="127" class="form-control" value="${personaInstance?.direccion}"/>
                                </div>

                            </span>
                        </div>
                    </div>

                    <div class="keeptogether">
                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'direccionReferencia', 'error')} ">
                            <span class="grupo">
                                <label for="direccionReferencia" class="col-md-3 control-label text-info">
                                    Referencias dirección
                                </label>

                                <div class="col-md-6">
                                    <g:textArea name="direccionReferencia" maxlength="127" class="form-control" value="${personaInstance?.direccionReferencia}"/>
                                </div>

                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'barrio', 'error')} ">
                            <span class="grupo">
                                <label for="barrio" class="col-md-3 control-label text-info">
                                    Barrio
                                </label>

                                <div class="col-md-6">
                                    <g:textField name="barrio" maxlength="127" class="form-control" value="${personaInstance?.barrio}"/>
                                </div>

                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'discapacitado', 'error')} ">
                            <span class="grupo">
                                <label for="discapacitado" class="col-md-3 control-label text-info">
                                    Discapacitado
                                </label>

                                <div class="col-md-6">
                                    <g:select name="discapacitado" from="${personaInstance.constraints.discapacitado.inList}"
                                              class="form-control" value="${personaInstance?.discapacitado ?: 'N'}" valueMessagePrefix="persona.discapacitado"/>
                                </div>

                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'sexo', 'error')} required">
                            <span class="grupo">
                                <label for="sexo" class="col-md-3 control-label text-info">
                                    Sexo
                                </label>

                                <div class="col-md-6">
                                    <g:select name="sexo" from="${personaInstance.constraints.sexo.inList}" required="" class="form-control required"
                                              value="${personaInstance?.sexo}" valueMessagePrefix="persona.sexo"/>
                                </div>
                                *
                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'nacionalidad', 'error')} required">
                            <span class="grupo">
                                <label for="nacionalidad" class="col-md-3 control-label text-info">
                                    Nacionalidad
                                </label>

                                <div class="col-md-6">
                                    <g:select id="nacionalidad" name="nacionalidad.id" from="${cratos.Nacionalidad.list()}" optionKey="id" required="" value="${personaInstance?.nacionalidad?.id}" class="many-to-one form-control"/>
                                </div>
                                *
                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'profesion', 'error')} ">
                            <span class="grupo">
                                <label for="profesion" class="col-md-3 control-label text-info">
                                    Profesión
                                </label>

                                <div class="col-md-6">
                                    <g:select id="profesion" name="profesion.id" from="${cratos.Profesion.list()}" optionKey="id" value="${personaInstance?.profesion?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                                </div>

                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'estadoCivil', 'error')} ">
                            <span class="grupo">
                                <label for="estadoCivil" class="col-md-3 control-label text-info">
                                    Estado Civil
                                </label>

                                <div class="col-md-6">
                                    <g:select id="estadoCivil" name="estadoCivil.id" from="${cratos.EstadoCivil.list()}" optionKey="id" optionValue="descripcion"
                                              value="${personaInstance?.estadoCivil?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                                </div>

                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'observaciones', 'error')} ">
                            <span class="grupo">
                                <label for="observaciones" class="col-md-3 control-label text-info">
                                    Observaciones
                                </label>

                                <div class="col-md-6">
                                    <g:textField name="observaciones" maxlength="127" class="form-control" value="${personaInstance?.observaciones}"/>
                                </div>

                            </span>
                        </div>

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'login', 'error')} required">
                            <span class="grupo">
                                <label for="login" class="col-md-3 control-label text-info">
                                    Login
                                </label>

                                <div class="col-md-6">
                                    <g:textField name="login" maxlength="15" required="" class="form-control required" value="${personaInstance?.login}"/>
                                </div>
                                *
                            </span>
                        </div>

                        %{--<div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'password', 'error')} required">--}%
                        %{--<span class="grupo">--}%
                        %{--<label for="password" class="col-md-3 control-label text-info">--}%
                        %{--Password--}%
                        %{--</label>--}%

                        %{--<div class="col-md-6">--}%
                        %{--<div class="input-group"><span class="input-group-addon"><i class="fa fa-lock"></i>--}%
                        %{--</span><g:field type="password" name="password" maxlength="64" required="" class="form-control required" value="${personaInstance?.password}"/>--}%
                        %{--</div>--}%
                        %{--</div>--}%
                        %{--*--}%
                        %{--</span>--}%
                        %{--</div>--}%

                        %{--<div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'autorizacion', 'error')} required">--}%
                        %{--<span class="grupo">--}%
                        %{--<label for="autorizacion" class="col-md-3 control-label text-info">--}%
                        %{--Autorizacion--}%
                        %{--</label>--}%

                        %{--<div class="col-md-6">--}%
                        %{--<div class="input-group"><span class="input-group-addon"><i class="fa fa-lock"></i>--}%
                        %{--</span><g:field type="password" name="autorizacion" maxlength="255" required="" class="form-control required" value="${personaInstance?.autorizacion}"/>--}%
                        %{--</div>--}%
                        %{--</div>--}%
                        %{--*--}%
                        %{--</span>--}%
                        %{--</div>--}%

                        <div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'activo', 'error')} required">
                            <span class="grupo">
                                <label for="activo" class="col-md-3 control-label text-info">
                                    Activo
                                </label>

                                <div class="col-md-3">
                                    %{--<g:field name="activo" type="number" value="${personaInstance.activo}" class="digits form-control required" required=""/>--}%
                                    <g:select name="activo" from="[1: 'SI', 0: 'NO']" optionKey="key" optionValue="value"
                                              class="form-control" value="${personaInstance?.activo ?: 'S'}"/>
                                </div>
                                *
                            </span>
                        </div>

                        %{--<div class="form-group keeptogether  ${hasErrors(bean: personaInstance, field: 'fechaPass', 'error')} ">--}%
                        %{--<span class="grupo">--}%
                        %{--<label for="fechaPass" class="col-md-3 control-label text-info">--}%
                        %{--Fecha Pass--}%
                        %{--</label>--}%

                        %{--<div class="col-md-4">--}%
                        %{--<elm:datepicker name="fechaPass" title="Fecha de cambio de contraseña" class="datepicker form-control" value="${personaInstance?.fechaPass}" default="none" noSelection="['': '']"/>--}%
                        %{--</div>--}%

                        %{--</span>--}%
                        %{--</div>--}%
                    </div>

                    <div class="keeptogether">
                        <p>
                            <a href="#" class="btn btn-default" id="allPerf">Asignar todos los perfiles</a><br/>
                            <a href="#" class="btn btn-default" id="nonePerf">Quitar todos los perfiles</a>
                        </p>
                        <g:form name="frmPerfiles" action="savePerfiles_ajax">
                            <ul class="fa-ul">
                                <g:each in="${cratos.seguridad.Prfl.list([sort: 'nombre'])}" var="perfil">
                                    <li class="perfil">
                                        %{--<input class="chkPerfil" type="checkbox" name="perfil" value="${perfil.id}" ${perfilesUsu.contains(perfil.id) ? "checked" : ""}/>--}%
                                        <i data-id="${perfil.id}" class="fa-li fa fa-square-o"></i>
                                        <span>${perfil.nombre}</span>
                                    </li>
                                </g:each>
                            </ul>
                        </g:form>
                    </div>
                </g:form>

            </div>

            <div class="row">
                <div class="col-md-12 text-center">
                    <a href="#" class="btn btn-success" id="btnSave"><i class="fa fa-save"></i> Guardar</a>
                </div>
            </div>

            <script type="text/javascript">
                function getPerfiles() {
                    var data = "";
                    $(".perfil .fa-li").each(function () {
                        var ico = $(this);
                        if (ico.hasClass("fa-check-square")) {
                            data += "&perfil=" + ico.data("id");
                        }
                    });
                    return data;
                }

                $(function () {
                    var $form = $("#frmPersona");
                    var $btnSave = $("#btnSave");

                    function doSave(data) {
                        $btnSave.hide().after(spinner);
                        openLoader("Grabando");
                        $.ajax({
                            type    : "POST",
                            url     : $form.attr("action"),
                            data    : data,
                            success : function (msg) {
                                closeLoader();
                                var parts = msg.split("_");
                                log(parts[1], parts[0] == "OK" ? "success" : "error");
                                spinner.remove();
                                $btnSave.show();
                            }
                        });
                    }

                    function submitForm() {
                        if ($form.valid()) {
                            var perfiles = getPerfiles();
                            if (perfiles == "") {
                                bootbox.confirm("<i class='fa fa-warning fa-3x pull-left text-warning text-shadow'></i><p>No ha seleccionado ningún perfil. El usuario no podrá ingresar al sistema. ¿Desea continuar?.</p>", function (result) {
                                    if (result) {
                                        doSave($form.serialize() + perfiles);
                                    }
                                })
                            } else {
                                doSave($form.serialize() + perfiles);
                            }
                        } else {
                            return false;
                        } //else
                    }

                    var validator = $form.validate({
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

                    $btnSave.click(function () {
                        submitForm();
                        return false;
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
                        var user = (nombre.acronym().toUpperCase() + (apellido.split(" ")[0])).toLowerCase();
                        $("#sigla").val(sigla);
                        $("#login").val(user);
                    });

                    $("#allPerf").click(function () {
                        $(".perfil .fa-li").removeClass("fa-square-o").addClass("fa-check-square");
                        return false;
                    });

                    $("#nonePerf").click(function () {
                        $(".perfil .fa-li").removeClass("fa-check-square").addClass("fa-square-o");
                        return false;
                    });

                    $(".perfil .fa-li, .perfil span").click(function () {
                        var ico = $(this).parent(".perfil").find(".fa-li");
                        if (ico.hasClass("fa-check-square")) { //descheckear
                            ico.removeClass("fa-check-square").addClass("fa-square-o");
                        } else { //checkear
                            ico.removeClass("fa-square-o").addClass("fa-check-square");
                        }
                    });
                });

            </script>

        </g:else>
    </body>
</html>