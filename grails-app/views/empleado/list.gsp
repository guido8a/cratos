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
        <g:link action="form" class="btn btn-default btnCrear">
            <i class="fa fa-file-o"></i> Nuevo empleado
        </g:link>
        <a href="#" id="generar_rol" class="btn btn-azul ">
            <i class="fa fa-bars"></i>
            Generar rol de pagos
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
            <th width="110">Acciones</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${empleadoInstanceList}" status="i" var="empleadoInstance">
            <tr data-id="${empleadoInstance.id}">
                <td>${empleadoInstance.persona?.cedula}</td>
                <td>${empleadoInstance.persona?.apellido} ${empleadoInstance.persona?.nombre}</td>
                <td>${empleadoInstance.cargo}</td>
                <td>${empleadoInstance.tipoContrato?.descripcion}</td>
                <td><g:formatBoolean boolean="${empleadoInstance.estado == 'A'}" true="Activo" false="Inactivo"/></td>

                <td>${fieldValue(bean: empleadoInstance, field: "sueldo")}</td>
                <td>
                    <a href="#" data-id="${empleadoInstance.id}" class="btn btn-info btn-sm btn-show btn-ajax" title="Ver">
                        <i class="fa fa-laptop"></i>
                    </a>
                    <a href="#" data-id="${empleadoInstance.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                        <i class="fa fa-pencil"></i>
                    </a>
                    <a href="#" data-id="${empleadoInstance.id}" class="btn btn-danger btn-sm btn-delete btn-ajax" title="Eliminar">
                        <i class="fa fa-trash-o"></i>
                    </a>
                </td>
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
                <h4 class="modal-title" id="myModalLabel">Rolo de pago</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-2 negrilla" style="width: 140px">
                        Mes:
                    </div>
                    <div class="col-xs-7 negrilla" style="margin-left: -20px" >
                        <g:select name="mes" class="form-control" from="${mes}" optionKey="id" optionValue="descripcion"></g:select>
                    </div>

                </div>
                <div class="row">
                    <div class="col-xs-2 negrilla" style="width: 140px">
                        Periodo:
                    </div>
                    <div class="col-xs-7 negrilla" style="margin-left: -20px" >
                        <g:select name="periodo" class="form-control" from="${periodos}" id="periodos" optionKey="id" ></g:select>
                    </div>

                </div>

            </div>
            <div class="modal-footer">
                <a href="#" id="generar" class="btn btn-success">Generar</a>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<elm:pagination total="${empleadoInstanceCount}" params="${params}"/>

<script type="text/javascript">
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
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Empleado seleccionado? Esta acción no se puede deshacer.</p>",
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
        var data = id ? { id : id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            data    : data,
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
        })

        $("#generar").click(function(){
            bootbox.confirm("Está a punto de generar el rol del pago para el mes de <span style='color:red'>"+$("#mes :selected").text()+" </span> en el periodo contable: <span style='color:red'>"+$("#periodos :selected").text()+"</span>. Estos datos son correctos?",function(result){
                if(result){
                    openLoader()
                    $.ajax({
                        type    : "POST",
                        url     : "${g.createLink(controller: 'rubro',action: 'generarRol')}",
                        data    : "mes="+$("#mes").val()+"&periodo="+$("#periodos").val(),
                        success : function (msg) {
                            console.log("msg")
                            if(msg=="ok"){
                                location.href="${g.createLink(controller: 'rubro',action: 'verRol')}/?mes="+$("#mes").val()+"&periodo="+$("#periodos").val()
                            }else{
                                alert(msg)
                            }
                        }
                    });
                }
            })

        })

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
