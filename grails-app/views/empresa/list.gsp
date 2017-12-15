<%@ page import="cratos.Empresa" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Empresas</title>
    </head>

    <body>

        <elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

        <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link controller="inicio" action="parametros" class="btn btn-warning btnRegresar">
                    <i class="fa fa-chevron-left"></i> Parámetros
                </g:link>
                <g:if test="${session.perfil.id == 1}">
                    <g:link action="form" class="btn btn-info btnCrear">
                        <i class="fa fa-file-o"></i> Crear
                    </g:link>
                </g:if>
            </div>
        </div>

        <div class="vertical-container vertical-container-list">
            <p class="css-vertical-text">Parámetros de la Empresa</p>

            <div class="linea"></div>
            <table class="table table-condensed table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Tipo</th>
                        <th>Dirección</th>
                        <th>Teléfono</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${empresa}" status="i" var="empr">
                        <tr data-id="${empr.id}" style="width: 100%">
                            <td style="width: 29%">${fieldValue(bean: empr, field: "nombre")}</td>
                            <td style="width: 10%">${empr?.tipoEmpresa?.descripcion}</td>
                            <td style="width: 30%">${fieldValue(bean: empr, field: "direccion")}</td>
                            <td style="width: 13%">${fieldValue(bean: empr, field: "telefono")}</td>
                            <td style="width: 18%">

                                <g:if test="${empresaLogin?.id == empr?.id}">
                                    <a href="#" data-id="${empr.id}" class="btn btn-primary btn-sm btn-firma btn-ajax" title="Firma Digital">
                                        <i class="fa fa-credit-card"></i>
                                    </a>
                                </g:if>

                                <a href="#" data-id="${empr.id}" class="btn btn-success btn-sm btn-sucursales btn-ajax" title="Sucursales">
                                    <i class="fa fa-building-o"></i>
                                </a>
                                <a href="#" data-id="${empr.id}" class="btn btn-info btn-sm btn-show btn-ajax" title="Ver Empresa">
                                    <i class="fa fa-laptop"></i>
                                </a>
                                <a href="#" data-id="${empr.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                                    <i class="fa fa-pencil"></i>
                                </a>
                                <a href="#" data-id="${empr.id}" class="btn btn-danger btn-sm btn-delete btn-ajax" title="Eliminar">
                                    <i class="fa fa-trash-o"></i>
                                </a>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
        %{--<elm:pagination total="${empresaInstanceCount}" params="${params}"/>--}%

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
                                setTimeout(function () {
                                    location.reload(true);
                                }, 800);

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
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar la Empresa seleccionada? Esta acción no se puede deshacer.</p>",
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
                    url     : "${createLink(action:'form_ajax')}",
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
                        url     : "${createLink(action:'show_ajax')}",
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

                $(".btn-firma").click(function () {
                    var id = $(this).data("id");
                    firma(id);
                });

                $(".btn-sucursales").click(function () {
                    var id = $(this).data("id");
                    sucursales(id);
                });

            });

            function firma(id) {
                $.ajax({
                   type: 'POST',
                    url:'${createLink(controller: 'empresa', action: 'firma_ajax')}',
                    data: {
                        id: id
                    },
                    success: function (msg){
                        bootbox.dialog({
                            title   : "Archivo de Firma Digital",
                            class   : "long",
                            message : msg,
                            buttons : {
                                no : {
                                    label     : "<i class='fa fa-times'></i> Cancelar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                },
                                ok : {
                                    label     : "<i class='fa fa-save'></i> Guardar",
                                    className : "btn-success",
                                    callback  : function () {
                                        openLoader("Guardando...")
                                        $.ajax({
                                           type: 'POST',
                                            url: '${createLink(controller: 'empresa', action:'guardarFirma_ajax')}',
                                            data:{
                                                id: id,
                                                clave: $("#claveFirma").val()
                                            },
                                            success: function (msg){
                                                closeLoader();
                                                if(msg == 'ok'){
                                                    log("Clave guardada correctamente","success")
                                                }else{
                                                    log("Error al guardar la clave", "error")
                                                }
                                            }
                                        });
                                    }
                                }
                             }
                        });
                    }
                });
            }

            function sucursales (id) {
                $.ajax({
                    type: 'POST',
                    url:'${createLink(controller: 'empresa', action: 'sucursales_ajax')}',
                    data: {
                        id: id
                    },
                    success: function (msg){
                        bootbox.dialog({
                            title   : "Sucursales",
                            class   : "long",
                            message : msg,
                            buttons : {
                                no : {
                                    label     : "<i class='fa fa-times'></i> Cancelar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                }
                            }
                        });
                    }
                });
            }
        </script>

    </body>
</html>
