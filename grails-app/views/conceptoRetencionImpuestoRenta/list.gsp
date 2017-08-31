
<%@ page import="cratos.ConceptoRetencionImpuestoRenta" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Concepto de Retención IR</title>
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
                    
                    <th>Código</th>
                    <th>Descripción</th>
                    <th>Modalidad de Pago</th>
                    <th>%</th>
                    <th>Tipo</th>

                </tr>
            </thead>
            <tbody>
                <g:each in="${conceptoRetencionImpuestoRentaInstanceList}" status="i" var="conceptoRetencionImpuestoRentaInstance">
                    <tr data-id="${conceptoRetencionImpuestoRentaInstance.id}">
                        
                        <td>${conceptoRetencionImpuestoRentaInstance?.codigo}</td>
                        <td style="font-size: 13px">${conceptoRetencionImpuestoRentaInstance?.descripcion}</td>
                        <td>${conceptoRetencionImpuestoRentaInstance?.modalidadPago?.descripcion}</td>
                        <td style="text-align: right">${conceptoRetencionImpuestoRentaInstance?.porcentaje}</td>
                        <td style="text-align: center">${conceptoRetencionImpuestoRentaInstance?.tipo}</td>

                    </tr>
                </g:each>
            </tbody>
        </table>

        <elm:pagination total="${conceptoRetencionImpuestoRentaInstanceCount}" params="${params}"/>

        <script type="text/javascript">
            var id = null;
            function submitForm() {
                var $form = $("#frmConceptoRetencionImpuestoRenta");
                var $btn = $("#dlgCreateEdit").find("#btnSave");
                if ($form.valid()) {
                $btn.replaceWith(spinner);
                    $.ajax({
                        type    : "POST",
                        url     : '${createLink(action:'save')}',
                        data    : $form.serialize(),
                            success : function (msg) {
                        if (msg== "OK") {
                            log("Concepto de Retención IR guardado correctamente","success");
                            setTimeout(function () {
                                location.reload(true);
                            }, 1000);
                        } else {
                            log("Error al guardar la información!", "error");
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
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Concepto de Retencion IR seleccionado? Esta acción no se puede deshacer.</p>",
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
                                        if (msg == "ok") {
                                            log("Concepto IR borrado correctamente","success");
                                            setTimeout(function () {
                                                location.reload(true);
                                            }, 1000);
                                        }else{
                                            log("Error al borrar el concepto IR","error");
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
                            title   : title + " Concepto de Retencion IR",
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

                context.settings({
                    onShow : function (e) {
                        $("tr.success").removeClass("success");
                        var $tr = $(e.target).parent();
                        $tr.addClass("success");
                        id = $tr.data("id");
                    }
                });
                context.attach('tbody>tr', [
                    {
                        header : 'Acciones'
                    },
                    {
                        text   : 'Ver',
                        icon   : "<i class='fa fa-search'></i>",
                        action : function (e) {
                            $("tr.success").removeClass("success");
                            e.preventDefault();
                            $.ajax({
                                type    : "POST",
                                url     : "${createLink(action:'show_ajax')}",
                                data    : {
                                    id : id
                                },
                                success : function (msg) {
                                    bootbox.dialog({
                                        title   : "Ver Concepto de Retencion IR",
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
                    },
                    {
                        text   : 'Editar',
                        icon   : "<i class='fa fa-pencil'></i>",
                        action : function (e) {
                            $("tr.success").removeClass("success");
                            e.preventDefault();
                            createEditRow(id);
                        }
                    },
                    {divider : true},
                    {
                        text   : 'Eliminar',
                        icon   : "<i class='fa fa-trash-o'></i>",
                        action : function (e) {
                            $("tr.success").removeClass("success");
                            e.preventDefault();
                            deleteRow(id);
                        }
                    }
                ]);
            });
        </script>

    </body>
</html>
