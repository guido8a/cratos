<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Artículos de Inventario</title>

    <script type="text/javascript" src="${resource(dir: 'js/plugins/jstree', file: 'jstree.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/plugins/jstree/themes/default', file: 'style.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css/custom', file: 'tree_context.css')}"/>

    <style type="text/css">
    #tree {
        background: #DEDEDE;
        overflow-y: auto;
        width: 50%;
        height: 700px;
        float: left;
        border: solid 2px #6AA8BA;
    }

    #info {
        background: #E4E4DC;
        float: left;
        margin-left: 5px;
        width: 49%;
        height: 700px;
        border: solid 2px #5A98AA;
    }


    </style>

</head>

<body>
<div id="list-cuenta">

    <g:if test="${hh > 0}">

        <!-- botones -->
        <div class="span12 btn-group" data-toggle="buttons-radio">
            <a href="#" id="item_1" class="btn btn-info toggle active">
                <i class="icon-folder-open-alt"></i>
                Materiales <!--grpo--><!--sbgr -> Grupo--><!--dprt -> Subgrupo--><!--item-->
            </a>
            <a href="#" id="item_2" class="btn btn-info toggle">
                <i class="icon-user"></i>
                Mano de obra
            </a>
            <a href="#" id="item_3" class="btn btn-info toggle">
                <i class="icon-truck"></i>
                Equipos
            </a>
            <input type="button" class="btn " value="Cerrar todo" onclick="$('#tree').jstree('close_all');">

            <form class="form-search" style="float: left; margin-left: 50px;">
                <div class="input-append">
                    <input type="text" class="input-medium search-query" id="search"/>
                    <a href='#' class='btn btn-info' id="btnSearch"><i class='icon-zoom-in'></i> Buscar</a>
                </div>
            </form>
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

        <div id="treeArea" class="hide">

            <div id="tree" class="ui-corner-all"></div>

            <div id="info" class="ui-corner-all"></div>
        </div>
    %{--
            <div id="tree" class="hide">
            </div>
    --}%
    </g:if>
    <g:else>
        <div class="alert alert-danger">
            <i class="fa icon-ghost fa-4x pull-left"></i>

            <h3>Alerta</h3>

            <p>Se debe crear los grupos</p>
        </div>
    </g:else>
</div>

<script type="text/javascript">

    var $btnCloseModal = $('<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>');
    var $btnSave = $('<button type="button" class="btn btn-success"><i class="fa fa-save"></i> Guardar</button>');


    var btn = $("<a href='#' class='btn' id='btnSearch'><i class='icon-zoom-in'></i> Buscar</a>");
    var urlSp = "${resource(dir: 'images', file: 'spinner.gif')}";
    var sp = $('<span class="add-on" id="btnSearch"><img src="' + urlSp + '"/></span>');



    function submitForm() {
        var $form = $("#frmItem");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Grabando");
            $.ajax({
                type: "POST",
                url: $form.attr("action"),
                data: $form.serialize(),
                success: function (msg) {
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

    function createEditRow(id, nodo, padre, url, tipo) {
//        console.log("id:", id, "nodo:", nodo, "padre:", padre, "tipo", tipo);
        var data = tipo == "Crear" ? {'padre': id, 'nodo': nodo} : {'id': id, 'nodo': nodo, 'padre': padre};
        if(nodo == "Artículo" && tipo == "Crear") {
            data = {'padre': padre, 'nodo': nodo};
        }
//        console.log("data:", data);
        $.ajax({
            type: "POST",
            url: url,
            data: data,
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgCreateEdit",
//                            class   : "long",
                    title: tipo + " " + nodo,
                    message: msg,

                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        guardar: {
                            id: "btnSave",
                            label: "<i class='fa fa-save'></i> Guardar",
                            className: "btn-success",
                            callback: function () {
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
        var tipo = nodeStrId.split("_")[0];
        var nodeId = nodeStrId.split("_")[1];

        var padre = node.parent;
        var padreId = padre.split("_")[1];

        var nodeHasChildren = $node.hasClass("hasChildren");
        var nodeOcupado = $node.hasClass("ocupado");
        var url = "";
        var nodo = "";
        var urlHijo = "";
        var nodoHijo = "";

//        console.log('nodeStrId:', nodeStrId, 'tipo:', tipo, 'nodeHasChildren:', nodeHasChildren, 'nodeOcupado', nodeOcupado);
//        console.log('padre:', padreId, 'id:', nodeId);

        switch (tipo) {
            case "sg":
                url = "${createLink(action:'formSg_ajax')}";
                urlHijo = "${createLink(action:'formDp_ajax')}";
                nodo = "Grupo";
                nodoHijo = "Subgrupo";
                break;
            case "dp":
                url = "${createLink(action:'formDp_ajax')}";
                urlHijo = "${createLink(action:'formIt_ajax')}";
                nodo = "Subgrupo";
                nodoHijo = "Artículo";
                break;
            case "it":
                nodo = "Artículo";
                nodoHijo = "";
                url = "${createLink(action:'formIt_ajax')}";
                break;
        }

        var crearHijo = {
            label: "Nuevo " + nodoHijo,
            icon: "fa fa-plus-circle text-success",
            action: function (obj) {
                createEditRow(nodeId, nodo, padreId, urlHijo, "Crear");
            }
        };

        var editar = {
            label: "Editar " + nodo,
                    icon: "fa fa-pencil text-info",
                    action: function (obj) {
                createEditRow(nodeId, nodo, padreId, url, "Editar");
            }
        };

        var items = {
            crear: {
                label: "Nuevo " + nodo,
                icon: "fa fa-plus-circle text-success",
                action: function (obj) {
                    createEditRow(nodeId, nodo, padreId, url, "Crear");
                }
            }
        };


        if(tipo != 'it'){
            items.crearHijo = crearHijo;
            items.editar = editar;
        } else {
            items.editar = editar;
        }


        if (!nodeHasChildren && !nodeOcupado) {
            items.eliminar = {
                label: "Eliminar " + nodo,
                separator_before: true,
                icon: "fa fa-trash-o text-danger",
                action: function (obj) {
                    bootbox.dialog({
                        title: "Alerta",
                        message: "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar? Esta acción no se puede deshacer.</p>",
                        buttons: {
                            cancelar: {
                                label: "Cancelar",
                                className: "btn-primary",
                                callback: function () {
                                }
                            },
                            eliminar: {
                                label: "<i class='fa fa-trash-o'></i> Eliminar",
                                className: "btn-danger",
                                callback: function () {
                                    $.ajax({
                                        type: "POST",
                                        url: '${createLink(action:'delete_ajax')}',
                                        data: {
                                            id: nodeId
                                        },
                                        success: function (msg) {
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
                }
            };
        }

        return items;
    }


    $(function () {

        function doSearch() {
            var val = $.trim($("#search").val());
//            console.log("a buscar:", val);
            if (val != "") {
//                $("#btnSearch").replaceWith(sp);
//                console.log("buscando...", val);
                $('#tree').jstree('search', val);
            }
        }

        $("#btnSearch").click(function () {
            doSearch();
        });


        var current = "1";

        $(".btnCopiar").click(function () {
            openLoader("Copiando");
        });

        /*
         $("#btnCreate").click(function () {
         createEditRow(null, 0, "Crear");
         });
         */

        function iniciaNodo() {
            var rel = "grupo_" + current;
            return rel;
        }

        function poneTipo(tipo) {
            var grpo = tipo.split('_')[0];
            var tp;
//            console.log('init....', tipo, "grupo:", grpo);
            switch (grpo) {
                case "sg":
                    tp = "subgrupo_material";
                    break;
                case "dp":
                    tp = "departamento_material";
                    break;
                case "it":
                    tp = "item_material";
                    break;
            }
//            console.log('--->', id);
            return tp;
        }

        $(".toggle").click(function () {
            var tipo = $(this).attr("id").split('_')[1];
//            console.log("click", $(this).attr("id"), 'tipo:', tipo);
            if (tipo != current) {
//                console.log('pone current a:', tipo);
                current = tipo;
                $('#tree').jstree(true).refresh();
            }
        });

        $('#tree').on("loaded.jstree", function () {
            $("#loading").hide();
            $("#treeArea").removeClass("hide").show();
        }).on("select_node.jstree", function (node, selected, event) {
            $('#tree').jstree('toggle_node', selected.selected[0]);
//            console.log('nodo:', selected.node.id);
            showInfo(selected.node.id);
        }).jstree({
            plugins: ["types", "state", "contextmenu", "wholerow", "search"],
            core: {
                multiple: false,
                check_callback: true,
                themes: {
                    variant: "small"
                },
                data: {
                    url: '${createLink(action:"loadTreePart")}',
                    data: function (node) {
                        var tp;
                        if ((node.id != "#") && (node.id != 'root')) {
                            tp = poneTipo(node.id);
                        } else {
                            tp = iniciaNodo()
                        }
//                        console.log("retorna", tp);
                        return {'id': node.id, tipo: tp};
//                                        return { 'id' : 1, tipo: 'grupo_material' };
                    }
                }
            },
            contextmenu: {
                show_at_node: false,
                items: createContextMenu
            },
            state: {
                key: "cuentas"
            },
            types: {
                root: {
                    icon: "fa fa-folder text-info"
                },
                "grupo": {
                    %{--icon: "${resource(dir: 'images', file: 'grupo_material.png')}"--}%
                    icon: "glyphicon glyphicon-briefcase text-warning"
                },
                "subgrupo_material": {
                    %{--icon: "${resource(dir: 'images', file: 'boxes.png')}"--}%
                    icon: "${resource(dir: 'images', file: 'grupo_material.png')}"
                },
                default: {
                    icon: "${resource(dir: 'images', file: 'item_material.png')}"
                }
            },
            search : {
                case_insensitive : true,
                show_only_matches : false

            },
        });



        function showInfo(nodoId) {
            var parts = nodoId.split("_");
            var tipo = parts[0];
            var id = parts[1];
//            console.log('nodo', nodoId, 'tipo', tipo, 'id', id);

            switch (tipo) {
                case "sg":
                    url = "${createLink(action:'showSg_ajax')}";
                    break;
                case "dp":
                    url = "${createLink(action:'showDp_ajax')}";
                    break;
                case "it":
                    url = "${createLink(action:'showIt_ajax')}";
                    break;
            }
            $.ajax({
                type: "POST",
                url: url,
                data: {
                    id: id
                },
                success: function (msg) {
                    $("#info").html(msg);
                }
            });
        };


    });
</script>

</body>
</html>
