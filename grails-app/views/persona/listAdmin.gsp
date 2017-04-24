<%@ page import="cratos.seguridad.Persona" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Usuarios</title>
    </head>

    <body>

        <elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

        <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link controller="admin" action="index" class="btn btn-default">
                    <i class="fa fa-arrow-left"></i> Administración
                </g:link>
                <g:link action="form" class="btn btn-default btnCrear">
                    <i class="fa fa-file-o"></i> Crear
                </g:link>
            </div>

            <div class="btn-group pull-right col-md-3">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Buscar">
                    <span class="input-group-btn">
                        <a href="#" class="btn btn-default" type="button">
                            <i class="fa fa-search"></i>&nbsp;
                        </a>
                    </span>
                </div><!-- /input-group -->
            </div>
        </div>

        <div class="vertical-container vertical-container-list">
            <p class="css-vertical-text">Lista de Usuarios</p>

            <div class="linea"></div>
            <table class="table table-condensed table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <g:sortableColumn property="empresa" title="Empresa"/>
                        <g:sortableColumn property="cedula" title="Cédula"/>
                        <g:sortableColumn property="nombre" title="Nombre"/>
                        <g:sortableColumn property="apellido" title="Apellido"/>
                        <g:sortableColumn property="login" title="Login"/>
                        <g:sortableColumn property="activo" title="Activo"/>
                        <g:sortableColumn property="observaciones" title="Observaciones"/>
                        <th width="190">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${personaInstanceList}" status="i" var="personaInstance">
                        <tr data-id="${personaInstance.id}">
                            <td>${fieldValue(bean: personaInstance, field: "empresa")}</td>
                            <td>${fieldValue(bean: personaInstance, field: "cedula")}</td>
                            <td>${fieldValue(bean: personaInstance, field: "nombre")}</td>
                            <td>${fieldValue(bean: personaInstance, field: "apellido")}</td>
                            <td>${fieldValue(bean: personaInstance, field: "login")}</td>
                            <td><g:formatBoolean boolean="${personaInstance.activo == 1}" true="SI" false="NO"/></td>
                            <td>${fieldValue(bean: personaInstance, field: "observaciones")}</td>
                            <td>
                                <a href="#" data-id="${personaInstance.id}" class="btn btn-info btn-sm btn-show btn-ajax" title="Ver">
                                    <i class="fa fa-laptop"></i>
                                </a>
                                <a href="#" data-id="${personaInstance.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                                    <i class="fa fa-pencil"></i>
                                </a>
                                <g:link action="perfiles" id="${personaInstance.id}" class="btn btn-primary btn-sm btn-ajax" title="Perfiles">
                                    <i class="fa fa-users"></i>
                                </g:link>
                                <a href="#" data-id="${personaInstance.id}" class="btn btn-warning btn-pass btn-sm" title="Reiniciar password">
                                    <i class="fa fa-refresh"></i>
                                </a>
                                <a href="#" data-id="${personaInstance.id}" class="btn btn-danger btn-delete btn-sm" title="Eliminar">
                                    <i class="fa fa-trash-o"></i>
                                </a>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
        <elm:pagination total="${personaInstanceCount}" params="${params}"/>

        <script type="text/javascript">

            function doSave($btn, $form, data) {
                $btn.replaceWith(spinner);
                openLoader("Grabando");
                $.ajax({
                    type    : "POST",
                    url     : $form.attr("action"),
                    data    : data,
                    success : function (msg) {
                        var parts = msg.split("_");
                        log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                        if (parts[0] == "OK") {
                            location.reload(true);
                        } else {
                            closeLoader();
                            spinner.replaceWith($btn);
                            return false;
                        }
                    }
                });
            }

            function submitForm() {
                var $form = $("#frmPersona");
                var $btn = $("#dlgCreateEdit").find("#btnSave");
                if ($form.valid()) {
                    var perfiles = getPerfiles();
                    if (perfiles == "") {
                        bootbox.confirm("<i class='fa fa-warning fa-3x pull-left text-warning text-shadow'></i><p>No ha seleccionado ningún perfil. El usuario no podrá ingresar al sistema. ¿Desea continuar?.</p>", function (result) {
                            if (result) {
                                doSave($btn, $form, $form.serialize() + perfiles);
                            }
                        })
                    } else {
                        doSave($btn, $form, $form.serialize() + perfiles);
                    }
                } else {
                    return false;
                } //else
            }
            function deleteRow(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Usuario seleccionado? Esta acción no se puede deshacer.</p>",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        eliminar : {
                            label     : "<i class='fa fa-trash-o'></i> Eliminar",
                            className : "btn-danger",
                            callback  : function () {
                                openLoader("Eliminando");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(action:'delete_ajax')}',
                                    data    : {
                                        id : itemId
                                    },
                                    success : function (msg) {
                                        var parts = msg.split("_");
                                        log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                        if (parts[0] == "OK") {
                                            location.reload(true);
                                        } else {
                                            closeLoader();
                                            spinner.replaceWith($btn);
                                            return false;
                                        }
                                    }
                                });
                            }
                        }
                    }
                });
            }
            function createEditRow(id) {
                var title = id ? "Editar" : "Crear";
                var data = id ? { id : id } : {};
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'formAdmin_ajax')}",
                    data    : data,
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgCreateEdit",
                            class   : "long",
                            title   : title + " Usuario",
                            message : msg,

                            buttons : {
                                cancelar : {
                                    label     : "Cancelar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                },
                                guardar  : {
                                    id        : "btnSave",
                                    label     : "<i class='fa fa-save'></i> Guardar",
                                    className : "btn-success",
                                    callback  : function () {
                                        return submitForm();
                                    } //callback
                                } //guardar
                            } //buttons
                        }); //dialog
                        setTimeout(function () {
                            b.find(".form-control").not(".datepicker").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            } //createEdit

            $(function () {

                $(".btnCrear").click(function () {
                    createEditRow();
                    return false;
                });

                $(".btn-show").click(function () {
                    var id = $(this).data("id");
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'show_ajax')}",
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            bootbox.dialog({
                                title   : "Ver Persona",
                                class   : "long",
                                message : msg,
                                buttons : {
                                    ok : {
                                        label     : "Aceptar",
                                        className : "btn-primary",
                                        callback  : function () {
                                        }
                                    }
                                }
                            });
                        }
                    });
                });
                $(".btn-edit").click(function () {
                    var id = $(this).data("id");
                    createEditRow(id);
                });
                $(".btn-pass").click(function () {
                    var id = $(this).data("id");
                    bootbox.dialog({
                        title   : "Alerta",
                        message : "<i class='fa fa-warning fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea reiniciar el password del usuario?<br/>El password será el número de cédula y no se puede deshacer.</p>",
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            },
                            cambiar  : {
                                label     : "<i class='fa fa-refresh'></i> Reiniciar",
                                className : "btn-warning",
                                callback  : function () {
                                    openLoader("Modificando");
                                    $.ajax({
                                        type    : "POST",
                                        url     : '${createLink(action:'reset_pass_ajax')}',
                                        data    : {
                                            id : id
                                        },
                                        success : function (msg) {
                                            var parts = msg.split("_");
                                            log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                            if (parts[0] == "OK") {
                                                location.reload(true);
                                            } else {
                                                closeLoader();
                                                spinner.replaceWith($btn);
                                                return false;
                                            }
                                        }
                                    });
                                }
                            }
                        }
                    });
                });
                $(".btn-delete").click(function () {
                    var id = $(this).data("id");
                    deleteRow(id);
                });

            });
        </script>

    </body>
</html>
