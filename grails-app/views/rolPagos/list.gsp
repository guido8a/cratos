
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
        <a href="#" id="generar_rol" class="btn btn-azul ">
            <i class="fa fa-bars"></i>
            Generar rol de pagos
        </a>

        <a href="#" id="generar_rol" class="btn btn-azul ">
            <i class="fa fa-bars"></i>
            Generar 13° sueldo
        </a>
    </div>
</div>


<div style="margin-top: 15px;" class="vertical-container">
    <p class="css-icono" style="margin-bottom: -15px"><i class="fa fa-folder-open-o"></i></p>

    <div class="linea45"></div>

    <div class="row" style="margin-bottom: 10px;">

        <div class="row-fluid">
            <div style="margin-left: 20px;">

                <div class="col-xs-2" style="margin-left: -20px; width: 160px;">
                    Año:
                    <g:select from="${cratos.Anio.list([sort: 'anio'])}" optionValue="anio" optionKey="id" name="anioB_name" noSelection="${['null': 'Seleccione...']}" class="form-control"/>
                </div>

                <div class="col-xs-2" style="margin-left: -20px; width: 160px;">
                    Mes:
                    <g:select from="${cratos.Mes.list(sort: 'numero')}" optionValue="descripcion" optionKey="id" name="mesB_name" noSelection="${['null': 'Seleccione...']}" class="form-control"/>
                </div>

                <div class="col-xs-2" style="margin-left: -20px;">
                    Desde:
                    <elm:datepicker name="fechaDesde" title="Fecha desde" id="fd" class="datepicker form-control fechaD"
                                    maxDate="new Date()"/>
                </div>

                <div class="col-xs-2" style="margin-left: -20px;">
                    Hasta:
                    <elm:datepicker name="fechaHasta" title="Fecha hasta" class="datepicker form-control fechaH"
                                    maxDate="new Date()"/>
                </div>

                <div class="col-xs-2" style="margin-left: -20px; width: 160px;">
                    Estado:
                    <g:select from="${['A': 'Aprobado', 'N' : 'No Aprobado']}" optionValue="value" optionKey="key" name="estado_name" class="form-control" noSelection="${['null': 'Seleccione...']}"/>
                </div>

                <div class="btn-group col-xs-4" style="margin-top: 20px; width: 210px;">

                    <a href="#" name="busqueda" class="btn btn-info" id="btnBusqueda" title="Buscar"
                       style="height: 34px; padding: 9px; width: 86px">
                        <i class="fa fa-search"></i> Buscar</a>

                    <a href="#" name="limpiar" class="btn btn-warning" id="btnLimpiarBusqueda"
                       title="Borrar criterios" style="height: 34px; padding: 9px; width: 34px">
                        <i class="fa fa-eraser"></i></a>
                </div>

            </div>

        </div>
    </div>
</div>


<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <th style="width: 15%">Año</th>
        <th style="width: 15%">Mes</th>
        <th style="width: 15%">Fecha</th>
        <th style="width: 20%">Modificación</th>
        <th style="width: 20%">Pagado</th>
        <th style="width: 15%">Estado</th>
    </tr>
    </thead>
    %{--<tbody>--}%
    %{--<g:each in="${rolPagosInstanceList}" status="i" var="rolPagosInstance">--}%
    %{--<tr data-id="${rolPagosInstance.id}" data-estado="${rolPagosInstance?.estado}" data-mes="${rolPagosInstance?.mess__id}" data-anio="${rolPagosInstance?.anio__id}" data-mes1="${rolPagosInstance?.mess}" data-anio2="${rolPagosInstance?.anio}">--}%
    %{--<td class="centrado">${rolPagosInstance?.anio}</td>--}%
    %{--<td class="centrado">${rolPagosInstance?.mess}</td>--}%
    %{--<td class="centrado"><g:formatDate date="${rolPagosInstance.fecha}" format="dd-MM-yyyy" /></td>--}%
    %{--<td class="centrado"><g:formatDate date="${rolPagosInstance.fechaModificacion}" format="dd-MM-yyyy" /></td>--}%
    %{--<td style="text-align: right"><g:formatNumber number="${rolPagosInstance?.pagado}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/></td>--}%
    %{--<td class="centrado">${rolPagosInstance?.empresa}</td>--}%
    %{--<td class="centrado" style="text-align: center; color: ${rolPagosInstance?.estado == 'N' ? 'rgba(112,27,25,0.9)': 'rgba(83,207,109,0.9)'}">${rolPagosInstance?.estado == 'N' ? 'No Aprobado' : 'Aprobado'}</td>--}%
    %{--</tr>--}%
    %{--</g:each>--}%
    %{--</tbody>--}%
</table>

<div class="row-fluid"  style="width: 99.7%;height: 250px;overflow-y: auto;float: right;">
    <div class="span12">
        <div id="divTablaRol" style="width: 100%; height: 250px;"></div>
    </div>
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
                    <div class="col-xs-5 negrilla" id="divMeses">
                        %{--<g:select name="mes" class="form-control" from="${cratos.Mes.list(sort: 'numero')}" optionKey="id" optionValue="descripcion"/>--}%
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <a href="#" id="generar" class="btn btn-success">Generar</a>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


%{--<elm:pagination total="${rolPagosInstanceCount}" params="${params}"/>--}%

<script type="text/javascript">


    function cargarMeses() {
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'rolPagos', action: 'meses_ajax')}',
                data:{
                 meses: '${meses}'
                },
                success: function (msg){
                    $("#divMeses").html(msg)
                }
            })
    }


    $("#btnLimpiarBusqueda").click(function () {
        cargarTablaRol('1');
        $("#anioB_name").val('');
        $("#mesB_name").val('');
        $(".fechaD").val('');
        $(".fechaH").val('');
        $("#estado_name").val('');
    });

    $("#btnBusqueda").click(function () {
        cargarTablaRol('2');
    });

    cargarTablaRol('1');

    function cargarTablaRol (tipo) {


        var anioB = $("#anioB_name").val();
        var mesB = $("#mesB_name").val();
        var fechaD = $(".fechaD").val();
        var fechaH = $(".fechaH").val();
        var estado = $("#estado_name").val();


        openLoader("Buscando");
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'rolPagos', action: 'tablaRolPagos_ajax')}',
            data:{
                anio: anioB,
                mes: mesB,
                desde: fechaD,
                hasta: fechaH,
                estado: estado,
                tipo: tipo
            },
            success: function (msg) {
                closeLoader();
                $("#divTablaRol").html(msg)
            }
        })
    }

    $("#generar_rol").click(function(){
        cargarMeses();
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
                        success : function (msg) {
                            location.reload()
                        }
                    });
                }
            })

    });


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

    function cambiarEstado (id, params) {
        $.ajax({
            type :'POST',
            url: '${createLink(controller: 'rolPagos', action: 'cambiarEstado_ajax')}',
            data:{
                id: id
            },
            success: function (msg){
//                closeLoader();
                if(msg == 'ok'){
                    log("Estado cambiado correctamente","success");
                    cargarTablaRol('3', params);
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
    });
</script>

</body>
</html>
