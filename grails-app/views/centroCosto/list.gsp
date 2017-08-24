
<%@ page import="cratos.inventario.CentroCosto" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Centro de Costos</title>
</head>
<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="inicio" action="parametrosEmpresa" class="btn btn-warning btnRegresar">
            <i class="fa fa-chevron-left"></i> Parámetros
        </g:link>
        <g:link action="form" class="btn btn-info btnCrear">
            <i class="fa fa-file-o"></i> Crear
        </g:link>
    </div>
</div>

<div class="vertical-container vertical-container-list">
    <p class="css-vertical-text">Lista de Centro de Costos</p>

    <div class="linea"></div>
    <table class="table table-condensed table-bordered table-striped table-hover">
        <thead>
        <tr>

            <th style="width: 100px">Código</th>
            <th style="width: 500px">Nombre</th>
            <th style="width: 100px">Acciones</th>
        </tr>
        </thead>
        <tbody>
        <g:if test="${session.perfil.nombre == 'Administrador'}">
            <g:each in="${centroCostoInstanceList}" status="i" var="centroCostoInstance">
                <g:if test="${centroCostoInstance.empresa.id == session.empresa.id}">
                    <tr data-id="${centroCostoInstance.id}">
                        <td>${fieldValue(bean: centroCostoInstance, field: "codigo")}</td>
                        <td>${fieldValue(bean: centroCostoInstance, field: "nombre")}</td>
                        <td style="text-align: center">
                            <a href="#" data-id="${centroCostoInstance.id}" class="btn btn-info btn-sm btn-show btn-ajax" title="Ver">
                                <i class="fa fa-laptop"></i>
                            </a>
                            <a href="#" data-id="${centroCostoInstance.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                                <i class="fa fa-pencil"></i>
                            </a>
                            <a href="#" data-id="${centroCostoInstance.id}" class="btn btn-danger btn-sm btn-delete btn-ajax" title="Eliminar">
                                <i class="fa fa-trash-o"></i>
                            </a>
                        </td>
                    </tr>
                </g:if>
            </g:each>
        </g:if>
        <g:else>
            <g:each in="${centroCostoInstanceList}" status="i" var="centroCostoInstance">
                <tr data-id="${centroCostoInstance.id}">
                    <td>${fieldValue(bean: centroCostoInstance, field: "codigo")}</td>
                    <td>${fieldValue(bean: centroCostoInstance, field: "nombre")}</td>
                    <td style="text-align: center">
                        <a href="#" data-id="${centroCostoInstance.id}" class="btn btn-info btn-sm btn-show btn-ajax" title="Ver">
                            <i class="fa fa-laptop"></i>
                        </a>
                        <a href="#" data-id="${centroCostoInstance.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                            <i class="fa fa-pencil"></i>
                        </a>
                        <a href="#" data-id="${centroCostoInstance.id}" class="btn btn-danger btn-sm btn-delete btn-ajax" title="Eliminar">
                            <i class="fa fa-trash-o"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:else>
        </tbody>
    </table>
</div>
<elm:pagination total="${centroCostoInstanceCount}" params="${params}"/>

<script type="text/javascript">
    var id = null;
    function submitForm() {
        var $form = $("#frmCentroCosto");
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
                        setTimeout(function () {
                            location.reload(true);
                        }, 1000);
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
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Centro de Costos seleccionado? Esta acción no se puede deshacer.</p>",
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
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 1000);
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
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Centro de Costos",
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

        $(".btnCrear").click(function() {
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
                        title   : "Ver Centro de Costos",
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
