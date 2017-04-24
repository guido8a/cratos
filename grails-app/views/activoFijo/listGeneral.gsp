<%@ page import="cratos.ActivoFijo" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Activos Fijos</title>
    </head>

    <body>

        <elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

        <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <a href="#" id="btnDepreciar" class="btn btn-azul">
                    <i class="fa fa-minus-square"></i>
                    Depreciar
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

        <div class="alert alert-info">
            <g:if test="${params.id}">
                <p>
                    Haga click
                    <g:link controller="proceso" action="show" id="${params.id}">
                        AQUI
                    </g:link>
                    para ver el proceso generado de la depreciación y registrarlo
                </p>
            </g:if>

            <g:if test="${params.fechaUltimaDepreciacion}">
                <p>
                    Última depreciación realizada el <b><util:fechaConFormato fecha="${params.fechaUltimaDepreciacion}" formato="dd-MM-yyyy"/></b>
                </p>
            </g:if>
            <g:else>
                <p>
                    No se ha realizado ninguna depreciación de los activos fijos
                </p>
            </g:else>
        </div>

        <div class="row">
            <div class="col-md-3">Ver depreciación aproximada a la fecha</div>

            <div class="col-md-2">
                <elm:datepicker name="fecha" class="form-control" value="${params.fecha}" minDate="new Date()"/>
            </div>

            <div class="col-md-1">
                <a href="#" id="btnCambiarFecha" class="btn btn-default">Cambiar</a>
            </div>
        </div>

        <div class="vertical-container vertical-container-list">
            <p class="css-vertical-text">Lista de Activos Fijos</p>

            <div class="linea"></div>

            <table class="table table-condensed table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <g:sortableColumn property="codigo" title="Código"/>
                        <g:sortableColumn property="grupo" title="Grupo"/>
                        <g:sortableColumn property="nombre" title="Descripción"/>
                        <g:sortableColumn property="precio" title="Precio"/>
                        <g:sortableColumn property="depreciacionAcumulada" title="Dep. contabilizada"/>
                        <th>Valor actual</th>
                        <th>Dep. aprox. al ${params.fecha.format('dd-MM-yyyy')}</th>
                        <th>Valor aprox. al ${params.fecha.format('dd-MM-yyyy')}</th>
                        <th>Vida útil</th>
                        <th width="35"></th>
                    </tr>
                </thead>
                <tbody>
                    <g:set var="total" value="${0}"/>
                    <g:set var="depCon" value="${0}"/>
                    <g:set var="valCon" value="${0}"/>
                    <g:set var="depFec" value="${0}"/>
                    <g:set var="valFec" value="${0}"/>
                    <g:each in="${activoFijoInstanceList}" status="i" var="activoFijoInstance">
                        <tr data-id="${activoFijoInstance.id}">
                            <g:set var="dc" value="${activoFijoInstance.getDepreciacionFecha(params.fecha)}"/>
                            <td>${fieldValue(bean: activoFijoInstance, field: "codigo")}</td>
                            <td>${activoFijoInstance.grupo?.descripcion}</td>
                            <td>
                                ${activoFijoInstance.nombre} ${activoFijoInstance.modelo} ${activoFijoInstance.marca?.descripcion} ${activoFijoInstance.color?.descripcion}
                            </td>
                            <td class="text-right">
                                <util:numero number="${activoFijoInstance.precio}" decimales="2"/>
                            </td>
                            <td class="text-right">
                                <util:numero number="${activoFijoInstance.depreciacionAcumulada}" decimales="2"/>
                            </td>
                            <td class="text-right">
                                <util:numero number="${activoFijoInstance.precio - activoFijoInstance.depreciacionAcumulada}" decimales="2"/>
                            </td>
                            <td class="text-right">
                                <util:numero number="${dc}" decimales="2"/>
                            </td>
                            <td class="text-right">
                                <util:numero number="${activoFijoInstance.precio - dc}" decimales="2"/>
                            </td>
                            <td>
                                Desde <span class="text-info"><util:fechaConFormato fecha="${activoFijoInstance.fechaInicioDepreciacion}" formato="dd-MM-yyyy"/></span>
                                por <span class="text-info">${activoFijoInstance.aniosVidaUtil} años</span>, hasta
                                <span class="text-info"><util:fechaConFormato fecha="${activoFijoInstance.finVidaUtil}" formato="dd-MM-yyyy"/></span>
                            </td>
                            <td>
                                <a href="#" data-id="${activoFijoInstance.id}" class="btn btn-info btn-sm btn-show btn-ajax" title="Ver">
                                    <i class="fa fa-laptop"></i>
                                </a>
                            </td>
                        </tr>
                        <g:set var="total" value="${total + activoFijoInstance.precio}"/>
                        <g:set var="depCon" value="${depCon + activoFijoInstance.depreciacionAcumulada}"/>
                        <g:set var="valCon" value="${valCon + (activoFijoInstance.precio - activoFijoInstance.depreciacionAcumulada)}"/>
                        <g:set var="depFec" value="${depFec + dc}"/>
                        <g:set var="valFec" value="${valFec + (activoFijoInstance.precio - dc)}"/>
                    </g:each>
                </tbody>
                <tfoot>
                    <tr>
                        <th colspan="3">TOTAL</th>
                        <th class="text-right">
                            <util:numero number="${total}" decimales="2"/>
                        </th>
                        <th class="text-right">
                            <util:numero number="${depCon}" decimales="2"/>
                        </th>
                        <th class="text-right">
                            <util:numero number="${valCon}" decimales="2"/>
                        </th>
                        <th class="text-right">
                            <util:numero number="${depFec}" decimales="2"/>
                        </th>
                        <th class="text-right">
                            <util:numero number="${valFec}" decimales="2"/>
                        </th>
                    </tr>
                </tfoot>
            </table>
        </div>
        <elm:pagination total="${activoFijoInstanceCount}" params="${params}"/>

        <script type="text/javascript">
            var id = null;
            function submitForm() {
                var $form = $("#frmActivoFijo");
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
            function deleteRow(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el ActivoFijo seleccionado? Esta acción no se puede deshacer.</p>",
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
                %{--var data = id ? { id : id, 'proceso.id' :${params.proceso.id} } : {'proceso.id' :${params.proceso.id}};--}%
                var data = id ? { id : id${params.proceso?', \'proceso.id\': '+params.proceso.id:''} } : {${params.proceso?' \'proceso.id\': '+params.proceso.id:''}};
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgCreateEdit",
                            class   : "long",
                            title   : title + " ActivoFijo",
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
                            id      : id,
                            proceso : true
                        },
                        success : function (msg) {
                            bootbox.dialog({
                                title   : "Ver ActivoFijo",
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

                $("#btnCambiarFecha").click(function () {
                    openLoader("Calculando");
                    var fecha = $("#fecha_input").val();
                    var params = {};
                    <g:each in="${params}" var="p">
                    params["${p.key}"] = "${p.value}";
                    </g:each>
                    params.fecha = fecha;
                    var p = "";
                    $.each(params, function (k, v) {
                        p += k + "=" + v + "&"
                    });
                    location.href = "${createLink(action: 'listGeneral')}?" + p;
                    return false;
                });

                $("#btnDepreciar").click(function () {
                    var data = {};
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'depreciarForm_ajax')}",
                        data    : data,
                        success : function (msg) {
                            var b = bootbox.dialog({
                                id      : "dlgDepreciar",
                                title   : "Depreciar",
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
                                        label     : "<i class='fa fa-minus-square'></i> Depreciar",
                                        className : "btn-success",
                                        callback  : function () {
                                            var $btn = $("#dlgDepreciar").find("#btnSave");
                                            $btn.replaceWith(spinner);
                                            openLoader("Depreciando");
                                            $.ajax({
                                                type    : "POST",
                                                url     : "${createLink(action: 'depreciar')}",
                                                data    : {
                                                    per : $("#periodoDep").val()
                                                },
                                                success : function (msg) {
                                                    var parts = msg.split("_");
                                                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                                    if (parts[0] == "OK") {
                                                        location.href = "${createLink(action:'listGeneral')}/" + parts[2];
                                                    } else {
                                                        closeLoader();
                                                        spinner.replaceWith($btn);
                                                        return false;
                                                    }
                                                }
                                            });
                                        } //callback
                                    } //guardar
                                } //buttons
                            }); //dialog
                            setTimeout(function () {
                                b.find(".form-control").not(".datepicker").first().focus()
                            }, 500);
                        } //success
                    }); //ajax
                    return false;
                });

            });
        </script>

    </body>
</html>
