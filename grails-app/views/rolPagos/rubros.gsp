<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 20/08/18
  Time: 12:51
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 20/08/18
  Time: 14:47
--%>


<%@ page import="cratos.RolPagos" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Detalle de Pagos por Rubro</title>

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
        <g:link controller="rolPagos" action="list" class="btn btn-warning btnRegresar">
            <i class="fa fa-chevron-left"></i> Regresar
        </g:link>
    </div>
</div>



<div class="alert alert-info" style="text-align: center; margin-top: 5px">
    <label>Rol de Pagos: ${rol?.mess?.descripcion + " " + rol?.anio?.anio}
        </label></br>
    <label>${"Rubro: " + rubro?.descripcion + " - Tipo Contrato: " + rubro?.tipoContrato?.descripcion}</label>
</div>



<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <th style="width: 50%">Empleado</th>
        <th style="width: 25%">Valor</th>
    </tr>
    </thead>
</table>

<div class="row-fluid"  style="width: 99.7%;height: 450px;overflow-y: auto;float: right;">
    <div class="span12">
        <div id="divTablaR" style="width: 100%; height: 250px;"></div>
    </div>
</div>

<script type="text/javascript">

    cargarTablaRubros('${rubro?.id}', ${rol?.id});

    function cargarTablaRubros(rubro, rol) {

        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'rolPagos', action: 'tablaRubros_ajax')}',
            data:{
                id: rubro,
                rol: rol
            },
            success: function (msg) {
                $("#divTablaR").html(msg)
            }
        });

    }


    function createContextMenu(node) {
        var $tr = $(node);
        $tr.addClass("success");
        var id = $tr.data("id");

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
                createEditRow(id)
            }
        };

        items.editar = editar;

        return items
    }

    function submitForm() {
        var $form = $("#frmDetallePago");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'detallePago', action:'save')}',
                data    : $form.serialize(),
                success : function (msg) {
                    if (msg == "ok") {
                        log("Datos guardados correctamente","success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 800);
                    } else {
                        log("Error al guardar los datos","error");
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function createEditRow(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'detallePago', action:'form_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : "Editar Detalle de Pago",
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




</script>

</body>
</html>
