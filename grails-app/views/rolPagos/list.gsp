
<%@ page import="cratos.RolPagos" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Rol de Pagos</title>

        <style>

            .centrado{
                text-align: center;
            }


        </style>
    </head>
    <body>

        <elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

    <div class="btn-toolbar toolbar">
        <div class="btn-group">
            <g:link controller="empleado" action="list" class="btn btn-warning btnRegresar">
                <i class="fa fa-chevron-left"></i> Regresar
            </g:link>
        </div>
    </div>

        <table class="table table-condensed table-bordered table-striped">
            <thead>
                <tr>
                    <th>Año</th>
                    <th>Mes</th>
                    <th>Fecha</th>
                    <th>Modificación</th>
                    <th>Pagado</th>
                    %{--<th>Empresa</th>--}%
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${rolPagosInstanceList}" status="i" var="rolPagosInstance">
                    <tr data-id="${rolPagosInstance.id}">
                        <td class="centrado">${rolPagosInstance?.anio}</td>
                        <td class="centrado">${rolPagosInstance?.mess}</td>
                        <td class="centrado"><g:formatDate date="${rolPagosInstance.fecha}" format="dd-MM-yyyy" /></td>
                        <td class="centrado"><g:formatDate date="${rolPagosInstance.fechaModificacion}" format="dd-MM-yyyy" /></td>
                        <td style="text-align: right"><g:formatNumber number="${rolPagosInstance?.pagado}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/></td>
                        %{--<td class="centrado">${rolPagosInstance?.empresa}</td>--}%
                        <td class="centrado" style="text-align: center; color: ${rolPagosInstance?.estado == 'N' ? 'rgba(112,27,25,0.9)': 'rgba(83,207,109,0.9)'}">${rolPagosInstance?.estado == 'N' ? 'No Aprobado' : 'Aprobado'}</td>
                    </tr>
                </g:each>
            </tbody>
        </table>

        <elm:pagination total="${rolPagosInstanceCount}" params="${params}"/>

        <script type="text/javascript">
            var id = null;
            function submitForm() {
                var $form = $("#frmRolPagos");
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
                            log(parts[1],"success")
                            setTimeout(function () {
                                location.reload(true);
                            }, 800);
                        } else {
                            log("Error al guardar el Rol de Pagos","error")
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
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Rol de Pagos seleccionado? Esta acción no se puede deshacer.</p>",
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
                                        if (msg == "OK") {
                                            log("Rol de Pagos borrado correctamente", "success");
                                            setTimeout(function () {
                                                location.reload(true);
                                            }, 800);
                                        }else{
                                            log("Error al borrar el rol de pagos", "error")
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
                            title   : title + " Rol de Pagos",
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



            function cambiarEstado (id) {
                openLoader("Cambiando...");
                $.ajax({
                   type :'POST',
                    url: '${createLink(controller: 'rolPagos', action: 'cambiarEstado_ajax')}',
                    data:{
                    id: id
                    },
                    success: function (msg){
                        closeLoader();
                        if(msg == 'ok'){
                            log("Estado cambiado correctamente","success");
                            setTimeout(function () {
                                location.reload(true)
                            }, 800);
                        }else{
                            log("Error al cambiar los estados", "error");
                        }
                    }
                });
            }

            function rubros (id){
                $.ajax({
                   type: 'POST',
                    url: '${createLink(controller: 'rolPagos', action: 'rubros_ajax')}',
                    data:{
                        id: id
                    },
                    success: function (msg){
                        var b = bootbox.dialog({
                            id      : "dlgRubros",
                            title   : "Rubros",
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
                                    label     : " Aceptar <i class='fa fa-angle-double-right'></i>",
                                    className : "btn-success",
                                    callback  : function () {
                                        cargarRubros(id, $("#rubroSel").val())
                                    } //callback
                                } //guardar
                            } //buttons
                        }); //dialog
                    }
                });
            }

            function cargarRubros(id, rubro){
                location.href="${createLink(controller: 'rolPagos', action: 'rubros')}/?id=" + id + "&rubro=" + rubro
            }

            function cargarEmpleados(id){
                location.href="${createLink(controller: 'rolPagos', action: 'empleados')}/?id=" + id
            }

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
                                        title   : "Ver Rol de Pagos",
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
                        text   : 'Cambiar estado',
                        icon   : "<i class='fa fa-undo'></i>",
                        action : function (e) {
                            $("tr.success").removeClass("success");
                            e.preventDefault();
                             cambiarEstado(id)
                        }
                    },
                    {divider : true},
                    {
                        text   : 'Detalle de Pago por Rubro',
                        icon   : "<i class='fa fa-list-ol'></i>",
                        action : function (e) {
                            $("tr.success").removeClass("success");
                            e.preventDefault();
                              rubros(id)
                        }
                    },
                    {
                        text   : 'Detalle de Pago por Empleado',
                        icon   : "<i class='fa fa-users'></i>",
                        action : function (e) {
                            $("tr.success").removeClass("success");
                            e.preventDefault();
                            cargarEmpleados(id)
                        }
                    },
                    {divider : true},
                    {
                        text   : 'Generar nuevamente',
                        icon   : "<i class='fa fa-check-square'></i>",
                        action : function (e) {
                            $("tr.success").removeClass("success");
                            e.preventDefault();

                        }
                    }
                ]);
            });
        </script>

    </body>
</html>
