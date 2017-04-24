<%@ page import="cratos.Cuenta" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Plan de Cuentas</title>

        <script type="text/javascript" src="${resource(dir: 'js/plugins/jstree', file: 'jstree.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/plugins/jstree/themes/default', file: 'style.css')}"/>
        <link rel="stylesheet" href="${resource(dir: 'css/custom', file: 'tree_context.css')}"/>

        <style type="text/css">
        #tree {
            background : #DEDEDE;
            overflow-y : auto;
            width      : 950px;
            height     : 700px;
        }
        </style>

    </head>

    <body>
        <div id="list-cuenta">

            <g:if test="${hh > 0}">

                <!-- botones -->
                <div class="btn-toolbar toolbar">
                    <div class="btn-group">
                        <g:link action="cuentaResultados" class="btn btn-default">
                            <i class="fa fa-money"></i> Cuentas de resultados
                        </g:link>
                    </div>
                </div>

                <div id="loading" class="text-center">
                    <p>
                        Cargando el árbol del plan de cuentas
                    </p>

                    <p>
                        <img src="${resource(dir: 'images/spinners', file: 'loading_new.GIF')}" alt='Cargando...'/>
                    </p>

                    <p>
                        Por favor espere
                    </p>
                </div>

                <div id="tree" class="hide">

                </div>
            </g:if>
            <g:else>
                <div class="alert alert-danger">
                    <i class="fa icon-ghost fa-4x pull-left"></i>

                    <h3>Alerta</h3>

                    <p>
                        Su empresa no tiene un plan de cuentas configurado.
                    </p>

                    <p>
                        Puede crear uno manualmente creando una cuenta ahora, o copiar el plan de cuentas por defecto.
                    </p>

                    <p>
                        <a href="#" id="btnCreate" class="btn btn-success"><i class="fa fa-file-o"></i> Crear cuenta</a>
                        <g:link action="copiarCuentas" class="btn btn-primary btnCopiar"><i class="fa fa-copy"></i> Copiar plan de cuentas</g:link>
                    </p>
                </div>
            </g:else>
        </div>

        <script type="text/javascript">

            var $btnCloseModal = $('<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>');
            var $btnSave = $('<button type="button" class="btn btn-success"><i class="fa fa-save"></i> Guardar</button>');

            function submitForm() {
                var $form = $("#frmCuenta");
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

            function createEditRow(id, lvl, tipo) {
                var data = tipo == "Crear" ? { padre : id, lvl : lvl } : {id : id, lvl : lvl};
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgCreateEdit",
//                            class   : "long",
                            title   : tipo + " Cuenta",
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
                            var $input = b.find(".form-control").not(".datepicker").first();
                            var val = $input.val();
                            $input.focus();
                            $input.val("");
                            $input.val(val);
                        }, 500);
                    } //success
                }); //ajax
            } //createEdit

            function createContextMenu(node) {
                var nodeStrId = node.id;
                var $node = $("#" + nodeStrId);
                var nodeId = nodeStrId.split("_")[1];
                var nodeLvl = $node.attr("level");

                var parentStrId = node.parent;
                var $parent = $("#" + parentStrId);
                var parentId = parentStrId.split("_")[1];

                var nodeHasChildren = $node.hasClass("hasChildren");
                var nodeOcupado = $node.hasClass("ocupado");
                var nodeConGestores = $node.hasClass("conGestores");
                var nodeConAsientos = $node.hasClass("conAsientos");

                var items = {
                    crear  : {
                        label  : "Nueva cuenta hija",
                        icon   : "fa fa-plus-circle text-success",
                        action : function (obj) {
                            createEditRow(nodeId, nodeLvl, "Crear");
                        }
                    },
                    editar : {
                        label  : "Editar cuenta",
                        icon   : "fa fa-pencil text-info",
                        action : function (obj) {
                            createEditRow(nodeId, nodeLvl, "Editar");
                        }
                    },
                    ver    : {
                        label  : "Ver cuenta",
                        icon   : "fa fa-laptop text-info",
                        action : function (obj) {
                            $.ajax({
                                type    : "POST",
                                url     : "${createLink(action:'show_ajax')}",
                                data    : {
                                    id : nodeId
                                },
                                success : function (msg) {
                                    bootbox.dialog({
                                        title   : "Ver Cuenta",
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
                    }
                };

                if (!nodeHasChildren && !nodeOcupado) {
                    items.eliminar = {
                        label            : "Eliminar cuenta",
                        separator_before : true,
                        icon             : "fa fa-trash-o text-danger",
                        action           : function (obj) {
                            bootbox.dialog({
                                title   : "Alerta",
                                message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar la Cuenta seleccionada? Esta acción no se puede deshacer.</p>",
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
                                                    id : nodeId
                                                },
                                                success : function (msg) {
                                                    var parts = msg.split("_");
                                                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                                    if (parts[0] == "OK") {
                                                        $('#tree').jstree('delete_node', $('#' + nodeStrId));
                                                    } else {
                                                        closeLoader();
                                                        return false;
                                                    }
                                                }
                                            });
                                        }
                                    }
                                }
                            });
                            %{--bootbox.dialog({--}%
                            %{--title   : "Alerta",--}%
                            %{--message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar la cuenta seleccionada? Esta acción no se puede deshacer.</p>",--}%
                            %{--buttons : {--}%
                            %{--cancelar : {--}%
                            %{--label     : "Cancelar",--}%
                            %{--className : "btn-default",--}%
                            %{--callback  : function () {--}%
                            %{--}--}%
                            %{--},--}%
                            %{--eliminar : {--}%
                            %{--label     : "<i class='fa fa-trash-o'></i> Eliminar",--}%
                            %{--className : "btn-danger",--}%
                            %{--callback  : function () {--}%
                            %{--openLoader("Eliminando");--}%
                            %{--$.ajax({--}%
                            %{--type    : "POST",--}%
                            %{--url     : "${createLink(action: 'deleteCuenta')}",--}%
                            %{--data    : {--}%
                            %{--id : nodeId--}%
                            %{--},--}%
                            %{--success : function (msg) {--}%
                            %{--var parts = msg.split("_");--}%
                            %{--log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)--}%
                            %{--if (parts[0] == "OK") {--}%
                            %{--$("#tree").jstree("remove", "#" + nodeStrId);--}%
                            %{--} else {--}%
                            %{--closeLoader();--}%
                            %{--return false;--}%
                            %{--}--}%
                            %{--}--}%
                            %{--});--}%
                            %{--}--}%
                            %{--}--}%
                            %{--}--}%
                            %{--});--}%
                        }
                    };
                }

                return items;
            }

            $(function () {

                $(".btnCopiar").click(function () {
                    openLoader("Copiando");
                });

                $("#btnCreate").click(function () {
                    createEditRow(null, 0, "Crear");
                });

                $('#tree').on("loaded.jstree",function () {
                    $("#loading").hide();
                    $("#tree").removeClass("hide").show();
                }).on("select_node.jstree",function (node, selected, event) {
                    $('#tree').jstree('toggle_node', selected.selected[0]);
                }).jstree({
                            plugins     : [ "types", "state", "contextmenu", "wholerow" ],
                            core        : {
                                multiple       : false,
                                check_callback : true,
                                themes         : {
                                    variant : "small"
                                },
                                data           : {
                                    url  : '${createLink(action:"loadTreePart")}',
                                    data : function (node) {
                                        return { 'id' : node.id };
                                    }
                                }
                            },
                            contextmenu : {
                                show_at_node : false,
                                items        : createContextMenu
                            },
                            state       : {
                                key : "cuentas"
                            },
                            types       : {
                                root  : {
                                    icon : "fa fa-folder text-info"
                                },
                                padre : {
                                    icon : "glyphicon glyphicon-briefcase text-warning"
                                },
                                hijo  : {
                                    icon : "fa fa-money text-success"
                                }
                            }
                        });
            });
        </script>

    </body>
</html>
