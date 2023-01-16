
<%@ page import="cratos.Anio" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Años</title>
</head>
<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="inicio" action="parametros" class="btn btn-warning btnRegresar">
            <i class="fa fa-chevron-left"></i> Parámetros
        </g:link>
        <g:link action="form" class="btn btn-info btnCrear">
            <i class="fa fa-file-o"></i> Nuevo
        </g:link>
    </div>
</div>

<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <g:sortableColumn property="anio" title="Año" />
        <th>Sueldo</th>
        <th width="110">Acciones</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${anioInstanceList}" status="i" var="anioInstance">
        <tr data-id="${anioInstance.id}" style="text-align: center">
            <td>${fieldValue(bean: anioInstance, field: "anio")}</td>
            <td><g:formatNumber number="${anioInstance?.sueldoBasico}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            <td>
                <a href="#" data-id="${anioInstance.id}" class="btn btn-info btn-sm btn-show btn-ajax" title="Ver">
                    <i class="fa fa-laptop"></i>
                </a>
                <a href="#" data-id="${anioInstance.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                    <i class="fa fa-pencil"></i>
                </a>
                <a href="#" data-id="${anioInstance.id}" class="btn btn-danger btn-sm btn-delete btn-ajax" title="Eliminar">
                    <i class="fa fa-trash-o"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<elm:pagination total="${anioInstanceCount}" params="${params}"/>

<script type="text/javascript">
    var id = null;
    function submitForm() {
        var $form = $("#frmAnio");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(action:'save')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == "OK") {
                        log(parts[1], "success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 800);
                    } else {
                        log(parts[1], "error")
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
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Año seleccionado? Esta acción no se puede deshacer.</p>",
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
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(action:'delete')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
//                                var parts = msg.split("_");
                                if (msg == "OK") {
                                    log("Año borrado correctamente", "success");
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 800);
                                }else{
                                    log("Error al borrar el año", "error")
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
                    title   : title + " Año",
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
                    b.find(".form-control").first().focus()
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
                        title   : "Ver",
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

    %{--$(function () {--}%

        %{--$(".btnCrear").click(function() {--}%
            %{--createEditRow();--}%
            %{--return false;--}%
        %{--});--}%

        %{--context.settings({--}%
            %{--onShow : function (e) {--}%
                %{--$("tr.success").removeClass("success");--}%
                %{--var $tr = $(e.target).parent();--}%
                %{--$tr.addClass("success");--}%
                %{--id = $tr.data("id");--}%
            %{--}--}%
        %{--});--}%
        %{--context.attach('tbody>tr', [--}%
            %{--{--}%
                %{--header : 'Acciones'--}%
            %{--},--}%
            %{--{--}%
                %{--text   : 'Ver',--}%
                %{--icon   : "<i class='fa fa-search'></i>",--}%
                %{--action : function (e) {--}%
                    %{--$("tr.success").removeClass("success");--}%
                    %{--e.preventDefault();--}%
                    %{--$.ajax({--}%
                        %{--type    : "POST",--}%
                        %{--url     : "${createLink(action:'show_ajax')}",--}%
                        %{--data    : {--}%
                            %{--id : id--}%
                        %{--},--}%
                        %{--success : function (msg) {--}%
                            %{--bootbox.dialog({--}%
                                %{--title   : "Ver Año",--}%
                                %{--message : msg,--}%
                                %{--buttons : {--}%
                                    %{--ok : {--}%
                                        %{--label     : "Aceptar",--}%
                                        %{--className : "btn-primary",--}%
                                        %{--callback  : function () {--}%
                                        %{--}--}%
                                    %{--}--}%
                                %{--}--}%
                            %{--});--}%
                        %{--}--}%
                    %{--});--}%
                %{--}--}%
            %{--},--}%
            %{--{--}%
                %{--text   : 'Editar',--}%
                %{--icon   : "<i class='fa fa-pencil'></i>",--}%
                %{--action : function (e) {--}%
                    %{--$("tr.success").removeClass("success");--}%
                    %{--e.preventDefault();--}%
                    %{--createEditRow(id);--}%
                %{--}--}%
            %{--},--}%
            %{--{divider : true},--}%
            %{--{--}%
                %{--text   : 'Eliminar',--}%
                %{--icon   : "<i class='fa fa-trash-o'></i>",--}%
                %{--action : function (e) {--}%
                    %{--$("tr.success").removeClass("success");--}%
                    %{--e.preventDefault();--}%
                    %{--deleteRow(id);--}%
                %{--}--}%
            %{--}--}%
        %{--]);--}%
    %{--});--}%
</script>

</body>
</html>
