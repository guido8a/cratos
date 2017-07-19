
<%@ page import="cratos.DocumentoEmpresa" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Libretines de Facturas</title>
        <style type="text/css">
            .centrado{
                text-align: center;
            }
            .derecha{
                text-align: right;
            }
        </style>
    </head>
    <body>

        <elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

    <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link action="form" class="btn btn-info btnCrear">
                    <i class="fa fa-file-o"></i> Nuevo
                </g:link>
            </div>
            %{--<div class="btn-group pull-right col-md-3">--}%
                %{--<div class="input-group">--}%
                    %{--<input type="text" class="form-control" placeholder="Buscar" value="${params.search}">--}%
                    %{--<span class="input-group-btn">--}%
                        %{--<g:link action="list" class="btn btn-default btn-search" type="button">--}%
                            %{--<i class="fa fa-search"></i>&nbsp;--}%
                        %{--</g:link>--}%
                    %{--</span>--}%
                %{--</div><!-- /input-group -->--}%
            %{--</div>--}%
        </div>

        <table class="table table-condensed table-bordered table-striped">
            <thead>
                <tr>
                    <th>Tipo</th>
                    <th>Autorización</th>
                    <th>Número Desde</th>
                    <th>Número Hasta</th>
                    <th>Fecha Autorización</th>
                    <th>Válido Desde</th>
                    <th>Válido Hasta</th>
                </tr>
            </thead>
            <tbody>
            <g:if test="${session.perfil.nombre == 'Administrador'}">
                <g:each in="${documentoEmpresaInstanceList}" status="i" var="documentoEmpresaInstance">
                    <g:if test="${documentoEmpresaInstance.empresa.id == session.empresa.id}">
                        <tr data-id="${documentoEmpresaInstance.id}">
                            <td>${documentoEmpresaInstance?.tipo == 'F'? 'Factura' : (documentoEmpresaInstance?.tipo == 'R'? 'Retención' : (documentoEmpresaInstance?.tipo == 'ND'? 'Nota de Débito' : 'Nota de Cŕedito'))}</td>
                            <td>${fieldValue(bean: documentoEmpresaInstance, field: "autorizacion")}</td>
                            <td class="derecha">${fieldValue(bean: documentoEmpresaInstance, field: "numeroDesde")}</td>
                            <td class="derecha">${fieldValue(bean: documentoEmpresaInstance, field: "numeroHasta")}</td>
                            <td class="centrado"><g:formatDate date="${documentoEmpresaInstance.fechaAutorizacion}" format="dd-MM-yyyy" /></td>
                            <td class="centrado"><g:formatDate date="${documentoEmpresaInstance.fechaInicio}" format="dd-MM-yyyy" /></td>
                            <td class="centrado"><g:formatDate date="${documentoEmpresaInstance.fechaFin}" format="dd-MM-yyyy" /></td>
                        </tr>
                    </g:if>
                </g:each>
            </g:if>
            <g:else>
                <g:each in="${documentoEmpresaInstanceList}" status="i" var="documentoEmpresaInstance">
                    <tr data-id="${documentoEmpresaInstance.id}">
                        <td>${documentoEmpresaInstance?.tipo == 'F'? 'Factura' : (documentoEmpresaInstance?.tipo == 'R'? 'Retención' : (documentoEmpresaInstance?.tipo == 'ND'? 'Nota de Débito' : 'Nota de Cŕedito'))}</td>
                        <td>${fieldValue(bean: documentoEmpresaInstance, field: "autorizacion")}</td>
                        <td class="derecha">${fieldValue(bean: documentoEmpresaInstance, field: "numeroDesde")}</td>
                        <td class="derecha">${fieldValue(bean: documentoEmpresaInstance, field: "numeroHasta")}</td>
                        <td class="centrado"><g:formatDate date="${documentoEmpresaInstance.fechaAutorizacion}" format="dd-MM-yyyy" /></td>
                        <td class="centrado"><g:formatDate date="${documentoEmpresaInstance.fechaInicio}" format="dd-MM-yyyy" /></td>
                        <td class="centrado"><g:formatDate date="${documentoEmpresaInstance.fechaFin}" format="dd-MM-yyyy" /></td>
                    </tr>
                </g:each>
            </g:else>
            </tbody>
        </table>

        %{--<elm:pagination total="${documentoEmpresaInstanceCount}" params="${params}"/>--}%

        <script type="text/javascript">
            var id = null;
            function submitForm() {
                var $form = $("#frmDocumentoEmpresa");
                var $btn = $("#dlgCreateEdit").find("#btnSave");
                if ($form.valid()) {
                $btn.replaceWith(spinner);
                    $.ajax({
                        type    : "POST",
                        url     : '${createLink(action:'save_ajax')}',
                        data    : $form.serialize(),
                         success : function (msg) {
                        var parts = msg.split("_");
                        if (parts[0] == "OK") {
                            log(parts[1], 'success');
                            setTimeout(function () {
                                location.reload(true);
                            }, 1500);

                        } else {
                            if(parts[1] == '2'){
                                bootbox.alert(parts[2]);
                            }else{
                                log(parts[2],'error');
                            }
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
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el libretín seleccionado? Esta acción no se puede deshacer.</p>",
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
                                    url     : '${createLink(action:'delete_ajax')}',
                                    data    : {
                                        id : itemId
                                    },
                                    success : function (msg) {
                                        var parts = msg.split("_");
                                        log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                        if (parts[0] == "OK") {
                                            location.reload(true);
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
                            title   : title + " Libretín de Facturas",
                            class: 'long',
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

            function verificar (id){
             var jqXHR =   $.ajax({
                   type: 'POST',
                    async: false,
                    url: '${createLink(controller: 'documentoEmpresa', action: 'verificar_ajax')}',
                    data:{
                        id: id
                    },
                    success: function (msg) {
                        return msg
                    }
                });

             return jqXHR.responseText
            }

            $(function () {

                $(".btnCrear").click(function() {
                    createEditRow();
                    return false;
                });

                $("tr").contextMenu({
                    items  : createContextMenu,
                    onShow : function ($element) {
                        $element.addClass("trHighlight");
                    },
                    onHide : function ($element) {
                        $(".trHighlight").removeClass("trHighlight");
                    }
                });


                function createContextMenu(node) {
                    var $tr = $(node);
                    var id = $tr.data("id");

                    var items = {
                        header : {
                            label  : "Acciones",
                            header : true
                        }
                    };

                    var ver = {
                        label   : 'Ver',
                        icon   : "fa fa-search",
                        action : function () {
                            $.ajax({
                                type    : "POST",
                                url     : "${createLink(action:'show_ajax')}",
                                data    : {
                                    id : id
                                },
                                success : function (msg) {
                                    bootbox.dialog({
                                        title   : "Ver Libretín de Facturas",
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
                        }
                    };

                    var editar = {
                        label   : 'Editar',
                        icon   : "fa fa-pencil",
                        action : function () {
                            createEditRow(id);
                        }
                    };

                    var eliminar = {
                        label  : 'Eliminar',
                        icon   : "fa fa-trash-o",
                        action: function () {
                            deleteRow(id);
                        }
                    };

                    items.ver = ver;

                    if(verificar(id) == 'false'){
                        items.editar = editar;
                        items.eliminar = eliminar;
                    }

                return items

                }


            });
        </script>

    </body>
</html>
