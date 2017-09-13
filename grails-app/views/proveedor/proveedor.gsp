<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 12/09/17
  Time: 15:09
--%>

<html>
<head>
    <meta name="layout" content="main">
    <title>Proveedores y Clientes</title>
</head>
<body>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="inicio" action="parametrosEmpresa" class="btn btn-warning btnRegresar">
            <i class="fa fa-chevron-left"></i> Parámetros
        </g:link>
        <g:link action="form" class="btn btn-info btnCrear">
            <i class="fa fa-file-o"></i> Nuevo Proveedor
        </g:link>
    </div>
</div>

<div style="margin-top: 25px;" class="vertical-container">
    <p class="css-icono" style="margin-bottom: -10px"><i class="fa fa-truck"></i></p>

    <div class="linea45"></div>

    <div class="row" style="margin-bottom: 10px;">

        <div class="col-md-3" style="text-align: center">
            <div class="col-md-2">
                <b>Tipo:</b>
            </div>
            <div class="col-md-3" style="width: 200px">
                <g:select name="tipoIden_name" class="form-control" optionKey="key" optionValue="value"
                          from="${[0:'Todos', 1 : "Proveedores", 2 : "Clientes", 3: "Proveedor y Cliente"]}" id="tipoIdentificacion"/>
            </div>
        </div>

        <div class="col-md-3" style="text-align: center">
            <div class="col-md-2">
                <b>RUC:</b>
            </div>
            <div class="col-md-3">
                <g:textField name="ruc_name" id="rucProveedor" class="form-control" value="" style="width: 150px"/>
            </div>
        </div>

        <div class="col-md-3" style="margin-left: -70px">
            <div class="col-md-3">
                <b>Nombre:</b>
            </div>
            <div class="col-md-3">
                <g:textField name="nombre_name" id="nombreProveedor" class="form-control" value="" style="width: 300px"/>
            </div>
        </div>

        <div class="btn-group col-md-2" style="margin-left: 140px">
            <a href="#" name="busqueda" class="btn btn-info btnBusquedaP btn-ajax">
                <i class="fa fa-check-square-o"></i> Buscar</a>

            <a href="#" name="limpiarBus" class="btn btn-warning btnLimpiarBusquedaP btn-ajax" title="Borrar criterios de búsqueda" style="height: 34px">
                <i class="fa fa-eraser"></i></a>
        </div>



    </div>
</div>

<div style="margin-top: 30px; min-height: 650px" class="vertical-container">
    <p class="css-vertical-text">Proveedores y Clientes</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 1070px">
        <thead>
        <tr>
            <th style="width: 110px">Ruc</th>
            <th style="width: 230px">Nombre</th>
            <th style="width: 80px">Tipo</th>
            <th style="width: 70px">Identificación</th>
            <th style="width: 130px">Dirección</th>
            <th width="90px">Acciones</th>
        </tr>
        </thead>
    </table>

    <div id="divProveedores">
    </div>
</div>


<script type="text/javascript">

    cargarProveedores($("#tipoIdentificacion").val());

    $(".btnBusquedaP").click(function () {
            cargarProveedores($("#tipoIdentificacion").val());
    });

    function cargarProveedores(rel){
        var ruc = $("#rucProveedor").val();
        var nombre = $("#nombreProveedor").val();
        $.ajax({
           type: 'POST',
            url:'${createLink(controller: 'proveedor', action: 'tablaProveedor_ajax')}',
            data:{
                ruc: ruc,
                nombre: nombre,
                tipo: rel
            },
            success: function (msg){
                $("#divProveedores").html(msg)
            }
        });
    }

    $(".btnLimpiarBusquedaP").click(function (msg) {
        $("#nombreProveedor").val('');
        $("#rucProveedor").val('');
        cargarProveedores($("#tipoIdentificacion").val());
    });


    function submitForm() {
        var $form = $("#frmProveedor");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Grabando");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {

                    if (msg == "ok") {
                        log("Proveedor guardado correctamente","success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 1000);
                    } else {
                        log("Error al guardar el proveedor","error")
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
                    title   : title + " Proveedor",
                    class: "long",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cancelar",
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

    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Proveedor seleccionado? Esta acción no se puede deshacer.</p>",
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
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 1000);
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

    $(function () {

        $(".btnCrear").click(function() {
            createEditRow();
            return false;
        });

    });


</script>

</body>
</html>


