
<%@ page import="cratos.TipoDocumentoPago" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Forma de Pago</title>
</head>
<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar" style="margin-top: 20px">
    <div class="btn-group">
        <g:link controller="inicio" action="parametros" class="btn btn-warning btnRegresar">
            <i class="fa fa-chevron-left"></i> Parámetros
        </g:link>
        <g:link action="form" class="btn btn-info btnCrear">
            <i class="fa fa-file-o"></i> Crear
        </g:link>
    </div>
</div>

<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <g:sortableColumn property="descripcion" title="Descripcion" />
        <th width="110">Acciones</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${tipoDocumentoPagoInstanceList}" status="i" var="tipoDocumentoPagoInstance">
        <tr data-id="${tipoDocumentoPagoInstance.id}">

            <td>${fieldValue(bean: tipoDocumentoPagoInstance, field: "descripcion")}</td>

            <td>
                <a href="#" data-id="${tipoDocumentoPagoInstance.id}" class="btn btn-info btn-sm btn-show btn-ajax" title="Ver">
                    <i class="fa fa-laptop"></i>
                </a>
                <a href="#" data-id="${tipoDocumentoPagoInstance.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                    <i class="fa fa-pencil"></i>
                </a>
                <a href="#" data-id="${tipoDocumentoPagoInstance.id}" class="btn btn-danger btn-sm btn-delete btn-ajax" title="Eliminar">
                    <i class="fa fa-trash-o"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<elm:pagination total="${tipoDocumentoPagoInstanceCount}" params="${params}"/>

<script type="text/javascript">
    var id = null;
    function submitForm() {
        var $form = $("#frmTipoDocumentoPago");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(action:'save')}',
                data    : $form.serialize(),
                success : function (msg) {
                    if(msg == 'OK'){
                        log("Documento de Pago guardado correctamente","success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 800);
                    }else{
                        log("Error al guardar el Documento de Pago guardado","error");
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
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el TipoDocumentoPago seleccionado? Esta acción no se puede deshacer.</p>",
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
                                if(msg == 'ok'){
                                    log("Documento de Pago eliminado correctamente","success");
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 800);
                                }else{
                                    log("Error al eliminar el Documento de Pago guardado","error");
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
                    title   : title + " Documento de Pago",
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

</script>

</body>
</html>
