<%@ page import="cratos.Empresa" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Empresa</title>
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
            <p class="css-vertical-text">Lista de Empresas</p>

            <div class="linea"></div>
            <table class="table table-condensed table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <g:sortableColumn property="nombre" title="Nombre"/>
                        <g:sortableColumn property="email" title="Email"/>
                        <g:sortableColumn property="fechaInicio" title="Fecha Inicio"/>
                        <g:sortableColumn property="fechaFin" title="Fecha Fin"/>
                        <g:sortableColumn property="direccion" title="Dirección"/>
                        <g:sortableColumn property="telefono" title="Teléfono"/>
                        <th width="110">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${empresaInstanceList}" status="i" var="empresaInstance">
                        <tr data-id="${empresaInstance.id}">
                            <td>${fieldValue(bean: empresaInstance, field: "nombre")}</td>
                            <td>${fieldValue(bean: empresaInstance, field: "email")}</td>
                            <td><g:formatDate date="${empresaInstance.fechaInicio}" format="dd-MM-yyyy"/></td>
                            <td><g:formatDate date="${empresaInstance.fechaFin}" format="dd-MM-yyyy"/></td>
                            <td>${fieldValue(bean: empresaInstance, field: "direccion")}</td>
                            <td>${fieldValue(bean: empresaInstance, field: "telefono")}</td>
                            <td>
                                <a href="#" data-id="${empresaInstance.id}" class="btn btn-info btn-sm btn-show btn-ajax" title="Ver">
                                    <i class="fa fa-laptop"></i>
                                </a>
                                <a href="#" data-id="${empresaInstance.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                                    <i class="fa fa-pencil"></i>
                                </a>
                                <a href="#" data-id="${empresaInstance.id}" class="btn btn-danger btn-sm btn-delete btn-ajax" title="Eliminar">
                                    <i class="fa fa-trash-o"></i>
                                </a>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
        <elm:pagination total="${empresaInstanceCount}" params="${params}"/>

        <script type="text/javascript">
            var id = null;
            function submitForm() {
                var $form = $("#frmEmpresa");
                var $btn = $("#dlgCreateEdit").find("#btnSave");
                if ($form.valid()) {
                    $btn.replaceWith(spinner);
                    openLoader("Grabando");
                    $.ajax({
                        type    : "POST",
                        url     : $form.attr("action"),
                        data    : $form.serialize(),
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
                } else {
                    return false;
                } //else
            }
            function deleteRow(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Empresa seleccionado? Esta acción no se puede deshacer.</p>",
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
                            title   : title + " Empresa",
                            class   : "long",
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
                        url     : "${createLink(action:'showAdmin_ajax')}",
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            bootbox.dialog({
                                title   : "Ver Empresa",
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
                $(".btn-delete").click(function () {
                    var id = $(this).data("id");
                    deleteRow(id);
                });

            });
        </script>

    </body>
</html>
