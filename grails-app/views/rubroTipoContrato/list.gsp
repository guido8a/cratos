
<%@ page import="cratos.RubroTipoContrato" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Rubros por Contrato</title>
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
</div>

<table class="table table-condensed table-bordered">
    <thead>
    <tr>
        <th>Tipo de Contrato</th>
        <th>Tipo</th>
        <th>Rubro</th>
        <th>Valor</th>
        <th>Porcentaje</th>
        <th>Editable</th>
        <th>Décimo</th>
        <th>IESS</th>
        <th>Gravable</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${rubroTipoContratoInstanceList}" status="i" var="rubroTipoContratoInstance">
        <tr data-id="${rubroTipoContratoInstance.id}" data-etdo="${rubroTipoContratoInstance?.activo}" style="background-color: ${rubroTipoContratoInstance?.activo != '1' ? '#bf2523' : '#99e998'};">

            %{--<td>${rubroTipoContratoInstance?.tipoContrato?.descripcion}</td>--}%
            <td>${rubroTipoContratoInstance?.tipoContrato}</td>
            <td>${rubroTipoContratoInstance?.tipoRubro}</td>

            <td>${rubroTipoContratoInstance.descripcion}</td>

            <td>${rubroTipoContratoInstance.valor}</td>
            <td>${rubroTipoContratoInstance.porcentaje}</td>

            <td>${rubroTipoContratoInstance?.editable == '1' ? 'SI' : 'NO'}</td>

            <td>${rubroTipoContratoInstance?.decimo == '1' ? 'SI' : 'NO'}</td>

            <td>${rubroTipoContratoInstance?.iess == '1' ? 'SI' : 'NO'}</td>
            <td>${rubroTipoContratoInstance?.gravable == '1' ? 'SI' : 'NO'}</td>

        </tr>
    </g:each>
    </tbody>
</table>

<elm:pagination total="${rubroTipoContratoInstanceCount}" params="${params}"/>

<script type="text/javascript">
    var id = null;
    function submitForm() {
        var $form = $("#frmRubroTipoContrato");
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
                        log(parts[1],"success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 800);
                    } else {
                        log("Error al guardar el Rubro del Tipo de Contrato")
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
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Rubro seleccionado? Esta acción no se puede deshacer.</p>",
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
                                    log("Rubro borrado correctamente","success");
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 800);
                                }else{
                                    log("Error al borrar el rubro", "error");
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
                    title   : title + " Rubro por Tipo de Contrato",
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

        function createContextMenu(node) {
            var $tr = $(node);

            var items = {
                header: {
                    label: "Acciones",
                    header: true
                }
            };

            var etdo = $tr.data("etdo");
            var id = $tr.data("id");

            var editar = {
                label: "Editar",
                icon: "fa fa-pencil",
                action: function () {
                    createEditRow(id);                        }
            };


            var ver = {
                label: "Ver",
                icon: "fa fa-search",
                action: function () {
                    verRubro(id);
                }

            };

            var borrar = {
                label: "Eliminar",
                icon: "fa fa-trash-o",
                action: function () {
                    deleteRow(id);
                }
            };

            var activar = {
                label: "Activar",
                icon: "fa fa-check",
                action: function () {
                    cambiarEstado(id,1);
                }
            };

            var desactivar = {
                label: "Desactivar",
                icon: "fa fa-refresh",
                action: function () {
                    cambiarEstado(id,2);
                }
            };


            items.ver = ver;
            items.editar = editar;
            items.eliminar = borrar;

            if(etdo == '1'){
                items.desactivar = desactivar
            }else{
                items.activar = activar
            }

            return items
        }


        $("tr").contextMenu({
            items  : createContextMenu,
            onShow : function ($element) {
//                $element.addClass("trHighlight");
                var $tr = $($element.target).parent();
                $("tr.success").addClass("success");
            },
            onHide : function ($element) {
                var $tr = $($element.target).parent();
//                $(".trHighlight").removeClass("trHighlight");
                $("tr.success").removeClass("success");
            }
        });

//
//        context.settings({
//            onShow : function (e) {
//                $("tr.success").removeClass("success");
//                var $tr = $(e.target).parent();
//                $tr.addClass("success");
//                id = $tr.data("id");
//            }
//        });
        %{--context.attach('tbody>tr', [--}%
        %{--{--}%
        %{--header : 'Acciones'--}%
        %{--},--}%
        %{--{--}%
        %{--text   : 'Ver',--}%
        %{--icon   : "<i class='fa fa-search'></i>",--}%
        %{--action : function (e) {--}%
        %{--$("tr.success").removeClass("success");--}%
        %{--e.preventDefault();--}%
        %{--$.ajax({--}%
        %{--type    : "POST",--}%
        %{--url     : "${createLink(action:'show_ajax')}",--}%
        %{--data    : {--}%
        %{--id : id--}%
        %{--},--}%
        %{--success : function (msg) {--}%
        %{--bootbox.dialog({--}%
        %{--title   : "Ver Rubro por Tipo de Contrato",--}%
        %{--message : msg,--}%
        %{--buttons : {--}%
        %{--ok : {--}%
        %{--label     : "Aceptar",--}%
        %{--className : "btn-primary",--}%
        %{--callback  : function () {--}%
        %{--}--}%
        %{--}--}%
        %{--}--}%
        %{--});--}%
        %{--}--}%
        %{--});--}%
        %{--}--}%
        %{--},--}%
        %{--{--}%
        %{--text   : 'Editar',--}%
        %{--icon   : "<i class='fa fa-pencil'></i>",--}%
        %{--action : function (e) {--}%
        %{--$("tr.success").removeClass("success");--}%
        %{--e.preventDefault();--}%
        %{--createEditRow(id);--}%
        %{--}--}%
        %{--},--}%
        %{--{divider : true},--}%
        %{--{--}%
        %{--text   : 'Eliminar',--}%
        %{--icon   : "<i class='fa fa-trash-o'></i>",--}%
        %{--action : function (e) {--}%
        %{--$("tr.success").removeClass("success");--}%
        %{--e.preventDefault();--}%
        %{--deleteRow(id);--}%
        %{--}--}%
        %{--}--}%
        %{--]);--}%
    });


    function verRubro (id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'show_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                bootbox.dialog({
                    title   : "Ver Rubro por Tipo de Contrato",
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

    function cambiarEstado(id,tipo){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'rubroTipoContrato', action: 'cambiarEstado_ajax')}',
            data:{
                id: id,
                tipo: tipo
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Estado cambiado correctamente","success");
                    setTimeout(function () {
                        location.reload(true);
                    }, 800);
                }else{
                    log("Error al cambiar el estado","error")
                }
            }
        });
    }

</script>

</body>
</html>
