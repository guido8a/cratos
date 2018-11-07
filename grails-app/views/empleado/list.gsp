<%@ page import="cratos.Empleado" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Empleados</title>
</head>

<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <a href="#" id="btnEditarRol" class="btn btn-success">
            <i class="fa fa-book"></i>
            Rol de pagos
        </a>
        <a href="#" id="btnCrearEmpleado" class="btn btn-info">
            <i class="fa fa-user"></i>
            Nuevo Empleado
        </a>
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
    <p class="css-vertical-text">Lista de Empleados</p>

    <div class="linea"></div>
    <table class="table table-condensed table-bordered table-striped table-hover">
        <thead>
        <tr>
            <th>Cédula</th>
            <th>Nombres</th>
            <th>Cargo</th>
            <th>Contrato</th>
            <g:sortableColumn property="estado" title="Estado"/>
            <g:sortableColumn property="sueldo" title="Sueldo"/>
        </tr>
        </thead>
        <tbody>
        <g:each in="${empleadoInstanceList}" status="i" var="empleadoInstance">
            <tr data-id="${empleadoInstance.id}" data-act="${empleadoInstance.estado}">
                <td>${empleadoInstance.persona?.cedula}</td>
                <td>${empleadoInstance.persona?.apellido} ${empleadoInstance.persona?.nombre}</td>
                <td>${empleadoInstance.cargo}</td>
                <td>${empleadoInstance.tipoContrato?.descripcion}</td>
                <td style="text-align: center; color: ${empleadoInstance?.estado == 'A' ? 'rgba(83,207,109,0.9)' : 'rgba(112,27,25,0.9)'}"><g:formatBoolean boolean="${empleadoInstance.estado == 'A'}" true="Activo" false="Inactivo"/></td>
                <td><g:formatNumber number="${empleadoInstance?.sueldo}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>

            </tr>
        </g:each>
        </tbody>
    </table>
</div>
<div class="modal fade" id="dlg-rol" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Rol de Pagos</h4>
            </div>
            <div class="modal-body">

                <div class="row">
                    <div class="col-xs-5" style="text-align: right">
                        Año:
                    </div>
                    <div class="col-xs-3 negrilla">
                        <g:select name="anio" class="form-control" from="${cratos.Anio.list()}" id="anio" optionKey="id" optionValue="anio" />
                    </div>

                </div>


                <div class="row">
                    <div class="col-xs-5" style="text-align: right">
                        Mes:
                    </div>
                    <div class="col-xs-5 negrilla">
                        <g:select name="mes" class="form-control" from="${mes}" optionKey="id" optionValue="descripcion"/>
                    </div>

                </div>


%{--
                <div class="row">
                    <div class="col-xs-5" style="text-align: right">
                        Fecha:
                    </div>
                    <div class="col-xs-5 negrilla">

                        <elm:datepicker name="fecha" title="Fecha" id="fecha" class="datepicker form-control fechaDe"
                                        maxDate="new Date()" value="${new java.util.Date()}"/>
                    </div>
                </div>
--}%
            </div>
            <div class="modal-footer">
                <a href="#" id="generar" class="btn btn-success">Generar</a>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<elm:pagination total="${empleadoInstanceCount}" params="${params}"/>

<script type="text/javascript">


    $("#btnCrearEmpleado").click(function () {
        createEditPersona();
        return false;
    });

    function submitFormPersona() {
        var $form = $("#frmPersona");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Grabando");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {
                    closeLoader();
                     if (msg == 'ok') {
                         log("Empleado guardado correctamente", "success");
                         setTimeout(function () {
                             location.reload(true);
                         }, 800);
                    } else {
                         log("Error al guardar empleado", "error")
                    }
                }
            });
        } else {
            return false;
        } //else
    }
    function createEditPersona(id) {
        var title = id ? "Editar" : "Nuevo";
        var data = id ? { id : id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'empleado_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    class   : "long",
                    title   : title + " Empleado",
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
                                return submitFormPersona();
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



    $("#btnEditarRol").click(function () {
       location.href="${createLink(controller: 'rolPagos', action: 'list')}";
    });


    function createContextMenu(node) {
        var $tr = $(node);
//        var $tr = $(e.target).parent();
        $tr.addClass("success");
        id = $tr.data("id");
        var activo = $tr.data("act");

        var items = {
            header: {
                label: "Acciones",
                header: true
            }
        };

        var editar = {
            label  : 'Editar',
            icon   : "fa fa-search",
            action : function (e) {
                createEditRow(id);
            }
        };

        var ver = {
            label  : 'Ver',
            icon   : "fa fa-pencil",
            action : function (e) {
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'show_ajax')}",
                    data    : {
                        id : id
                    },
                    success : function (msg) {
                        bootbox.dialog({
                            title   : "Ver Empleado",
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

        var desactivar = {
            label  : 'Desactivar',
            icon   : "fa fa-times",
            action : function (e) {
                desactivarUsuario(id, 'D')
            }
        };

        var activar = {
            label  : 'Activar',
            icon   : "fa fa-check",
            action : function (e) {
                desactivarUsuario(id, 'A')
            }
        };

        items.ver = ver;
        items.editar = editar;

       if(activo == 'A'){
           items.desactivar = desactivar;
       }else{
           items.activar = activar;
       }


        return items
    }


    $(function () {
        $("tr").contextMenu({
            items  : createContextMenu,
            onShow : function ($element) {
                $element.addClass("trHighlight");
            },
            onHide : function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });
    });


    function desactivarUsuario(id, tipo) {
        bootbox.dialog({
            title   : "Alerta",
            message :  (tipo == 'D' ? "<i class='fa fa-warning fa-3x pull-left text-danger text-shadow'></i><p>" +
            "¿Está seguro que desea <b style='color: rgba(112,27,25,0.9)'>desactivar</b> al empleado?</p>" :
                    "<i class='fa fa-warning fa-3x pull-left text-danger text-shadow'></i><p>" +
                    "¿Está seguro que desea <b style='color: rgba(83,207,109,0.9)'>activar</b> al usuario?</p>"),
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                cambiar  : {
                    label     : "<i class='fa fa-refresh'></i> Aceptar",
                    className : "btn-success",
                    callback  : function () {
                        openLoader("Desactivando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller: 'empleado', action:'cambiarEstado_ajax')}',
                            data    : {
                                id : id,
                                tipo: tipo
                            },
                            success : function (msg) {
                                closeLoader();
                                var parts = msg.split("_");
                                if (parts[0] == "OK") {
                                    log(parts[1], "success");
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 800);
                                } else {
                                    log("Error al cambiar el estado del empleado","error");
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    var id = null;
    function submitForm() {
        var $form = $("#frmEmpleado");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "OK") {
                        location.reload(true);
                    } else {
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
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                "¿Está seguro que desea eliminar el Empleado seleccionado? Esta acción no se puede deshacer.</p>",
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
//        var data = id ? { id : id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            data    : {
                id: id,
                tipo : 1
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Empleado",
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
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    $(function () {

        $("#generar_rol").click(function(){
            $("#dlg-rol").modal("show")
        });

        $("#generar").click(function(){
            bootbox.confirm("Está a punto de generar el rol del pago para el mes de <span style='color:blue'>"+
                    $("#mes :selected").text()+" </span> del año <span style='color:blue'>"+
                    $("#anio :selected").text()+".</span><br><br>Si es correcto, presione Aceptar para generar el rol",
                    function(result){
                if(result){
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${g.createLink(controller:'rubro', action:'generarRol')}",
                        data    : "mes="+$("#mes").val()+
                            "&anio="+$("#anio").val(), //+
//                            "&fecha="+$("#fecha_input").val(),
                        success : function (msg) {
                            location.reload()
                        }
                    });
                }
            })

        });

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
                        title   : "Ver Empleado",
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
