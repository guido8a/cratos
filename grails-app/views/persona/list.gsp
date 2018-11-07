<%@ page import="cratos.Empleado; cratos.seguridad.Persona" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Personas</title>
</head>

<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link action="form" class="btn btn-info btnCrear">
            <i class="fa fa-file-o"></i> Nuevo Usuario
        </g:link>
    </div>
    <g:if test="${session.usuario.login == 'admin'}">
        <h1 style="text-align: center">Usuarios</h1>
    </g:if>
    <g:else>
        <h1 style="text-align: center">${session.empresa.nombre}</h1>
    </g:else>
</div>

<div class="vertical-container vertical-container-list">
    <p class="css-vertical-text">Lista de Usuarios</p>

    <div class="linea"></div>
    <table class="table table-condensed table-bordered table-striped table-hover">
        <thead>
        <tr>
            <th>Empresa</th>
            <th>Cédula</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Login</th>
            <th><i class="fa fa-user"></i> Usuario</th>
            <th><i class="fa fa-users"></i> Empleado</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${personaInstanceList}" status="i" var="personaInstance">
            <tr data-id="${personaInstance.id}" data-emp="${cratos.Empleado.findByPersona(Persona.get(personaInstance?.id))}" data-act="${personaInstance?.activo == 1}">
                <td style="background-color: #dddddd">${personaInstance?.empresa}</td>
                <td style="text-align: center">${personaInstance.cedula}</td>
                <td>${personaInstance.nombre}</td>
                <td>${personaInstance.apellido}</td>
                <td style="color: #00b3ff">${personaInstance.login}</td>
                <td style="text-align: center; color: ${personaInstance.activo == 1 ? '#00aa00' : ' #ff0f24'}"><g:formatBoolean boolean="${personaInstance.activo == 1}" true="SI" false="NO"/></td>
                <td style="text-align: center;color: ${cratos.Empleado.findByPersona(Persona.get(personaInstance?.id)) ? '#00aa00' : ' #ff0f24'}">${cratos.Empleado.findByPersona(Persona.get(personaInstance?.id)) ? 'SI' : 'NO'}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
<elm:pagination total="${personaInstanceCount}" params="${params}"/>

<script type="text/javascript">
    var id = null;
    function submitForm() {
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
                        if(msg == 'ok'){
                            log("Usuario guardado correctamente","success");
                            setTimeout(function () {
                                location.reload(true);
                            }, 800);
                        }else{
                            log("Error al guardar el usuario","error")
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
            url     : "${createLink(action:'form_ajax')}",
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

    function createEditEmpleado(id) {
        var title = id ? "Editar" : "Crear";
//                var data = id ? { id : id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'empleado', action:'form_ajax')}",
//                    data    : data,
            data    : {
                id: id,
                tipo: 2
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
                                return submitFormEmpleado();
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

    function submitFormEmpleado() {
        var $form = $("#frmEmpleado");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'empleado', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == "OK") {
                        log(parts[1], "success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 800);
                    } else {
                        log("Error al crear empleado","error")
                    }
                }
            });
        } else {
            return false;
        } //else
    }

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
//                $(".btn-pass").click(function () {
        function cambiarPass (id){
//                        var id = $(this).data("id");

            bootbox.dialog({
                title   : "Alerta",
                message : "<i class='fa fa-warning fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea reiniciar el password del usuario?<br/>El password será el número de <strong>CÉDULA</strong> y no se puede deshacer.</p>",
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
                            openLoader("Modificando...");
                            $.ajax({
                                type    : "POST",
                                url     : '${createLink(action:'reset_pass_ajax')}',
                                data    : {
                                    id : id
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
                                        log("Error al cambiar el password","error");
                                    }
                                }
                            });
                        }
                    }
                }
            });
        }

        function crearEmpleado(id){

            bootbox.dialog({
                title   : "Alerta",
                message :  "<i class='fa fa-warning fa-3x pull-left text-warning text-shadow'></i><p>Está por crear un empleado a partir de este usuario del sistema, está seguro?</p>",
                buttons : {
                    cancelar : {
                        label     : "Cancelar",
                        className : "btn-primary",
                        callback  : function () {
                        }
                    },
                    cambiar  : {
                        label     : "<i class='fa fa-check'></i> Aceptar",
                        className : "btn-success",
                        callback  : function () {
                            openLoader("Generando empleado...");
                            $.ajax({
                                type: 'POST',
                                url: "${createLink(controller: 'empleado', action: 'crearEmpleado_ajax')}",
                                data:{
                                    id: id
                                },
                                success: function (msg){
                                    if(msg == 'ok'){
                                        closeLoader();
                                        log("Empleado creado correctamente","success");
                                        setTimeout(function () {
                                            location.reload(true);
                                        }, 800);
                                    }else{
                                        log("Error al crear el empleado","error")
                                    }
                                }
                            })
                        }
                    }
                }
            });






        }

        $(".btn-delete").click(function () {
            var id = $(this).data("id");
            deleteRow(id);
        });

        function createContextMenu(node) {
            var $tr = $(node);
            $tr.addClass("success");
            id = $tr.data("id");
            var activo = $tr.data("act");
            var empl = $tr.data("emp");

            var items = {
                header: {
                    label: "Acciones",
                    header: true
                }
            };

            var editar = {
                label  : 'Editar',
                icon   : "fa fa-pencil",
                action : function (e) {
                    createEditRow(id);
                }
            };

            var ver = {
                label  : 'Ver',
                icon   : "fa fa-search",
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

            var perfiles = {
                label   : 'Perfiles',
                icon   : "fa fa-briefcase",
                action : function (e) {
                    location.href="${createLink(controller: 'persona', action: 'perfiles')}?id=" + id
                }
            };

            var password = {
                label   : 'Reiniciar Password',
                icon   : "fa fa-barcode",
                action : function (e) {
                    cambiarPass(id)
                }
            };

            var empleado = {
                label   : '<b style="color: rgba(112,27,25,0.9)">Crear Empleado</b>',
                icon   : "fa fa-users",
                action : function (e) {
//                            createEditEmpleado(id)
                    crearEmpleado(id)
                }
            };

            var eliminar = {
                label   : 'Eliminar',
                icon   : "fa fa-trash-o",
                action : function (e) {
                    deleteRow(id);
                }
            };

            items.ver = ver;
            items.editar = editar;

            if(activo){
                items.perfiles = perfiles;
                items.password = password;
            }

            if(!empl){
                items.empleado = empleado;
            }

//                    items.eliminar = eliminar;

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
    });
</script>

</body>
</html>
