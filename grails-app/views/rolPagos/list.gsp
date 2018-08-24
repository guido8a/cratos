
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
    </div>
</div>

        <table class="table table-condensed table-bordered table-striped">
            <thead>
                <tr>
                    <th>Año</th>
                    <th>Mes</th>
                    <th>Fecha</th>
                    <th>Modificación</th>
                    <th>Pagado</th>
                    %{--<th>Empresa</th>--}%
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${rolPagosInstanceList}" status="i" var="rolPagosInstance">
                    <tr data-id="${rolPagosInstance.id}" data-estado="${rolPagosInstance?.estado}" data-mes="${rolPagosInstance?.mess__id}" data-anio="${rolPagosInstance?.anio__id}" data-mes1="${rolPagosInstance?.mess}" data-anio2="${rolPagosInstance?.anio}">
                        <td class="centrado">${rolPagosInstance?.anio}</td>
                        <td class="centrado">${rolPagosInstance?.mess}</td>
                        <td class="centrado"><g:formatDate date="${rolPagosInstance.fecha}" format="dd-MM-yyyy" /></td>
                        <td class="centrado"><g:formatDate date="${rolPagosInstance.fechaModificacion}" format="dd-MM-yyyy" /></td>
                        <td style="text-align: right"><g:formatNumber number="${rolPagosInstance?.pagado}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/></td>
                        %{--<td class="centrado">${rolPagosInstance?.empresa}</td>--}%
                        <td class="centrado" style="text-align: center; color: ${rolPagosInstance?.estado == 'N' ? 'rgba(112,27,25,0.9)': 'rgba(83,207,109,0.9)'}">${rolPagosInstance?.estado == 'N' ? 'No Aprobado' : 'Aprobado'}</td>
                    </tr>
                </g:each>
            </tbody>
        </table>
%{--<table class="table table-condensed table-bordered table-striped">--}%
    %{--<thead>--}%
    %{--<tr>--}%
        %{--<th>Año</th>--}%
        %{--<th>Mes</th>--}%
        %{--<th>Fecha</th>--}%
        %{--<th>Pagado</th>--}%
        %{--<th>Empresa</th>--}%
        %{--<th>Estado</th>--}%
    %{--</tr>--}%
    %{--</thead>--}%
    %{--<tbody>--}%
    %{--<g:each in="${rolPagosInstanceList}" status="i" var="rolPagosInstance">--}%
        %{--<tr data-id="${rolPagosInstance.id}" data-estado="${rolPagosInstance?.estado}" data-mes="${rolPagosInstance?.mess__id}" data-anio="${rolPagosInstance?.anio__id}"--}%
        %{--data-mesN="${rolPagosInstance?.mess}" data-anioN=""${rolPagosInstance?.anio}>--}%
            %{--<td class="centrado">${rolPagosInstance?.anio}</td>--}%
            %{--<td class="centrado">${rolPagosInstance?.mess}</td>--}%
            %{--<td class="centrado"><g:formatDate date="${rolPagosInstance.fecha}" format="dd-MM-yyyy" /></td>--}%
            %{--<td style="text-align: right"><g:formatNumber number="${rolPagosInstance?.pagado}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/></td>--}%
            %{--<td class="centrado">${rolPagosInstance?.empresa}</td>--}%
            %{--<td class="centrado" style="text-align: center; color: ${rolPagosInstance?.estado == 'N' ? 'rgba(112,27,25,0.9)': 'rgba(83,207,109,0.9)'}">${rolPagosInstance?.estado == 'N' ? 'No Aprobado' : 'Aprobado'}</td>--}%
        %{--</tr>--}%
    %{--</g:each>--}%
    %{--</tbody>--}%
%{--</table>--}%

<elm:pagination total="${rolPagosInstanceCount}" params="${params}"/>

<script type="text/javascript">
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



    function cambiarEstado (id) {
        openLoader("Cambiando...");
        $.ajax({
            type :'POST',
            url: '${createLink(controller: 'rolPagos', action: 'cambiarEstado_ajax')}',
            data:{
                id: id
            },
            success: function (msg){
                closeLoader();
                if(msg == 'ok'){
                    log("Estado cambiado correctamente","success");
                    setTimeout(function () {
                        location.reload(true)
                    }, 800);
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


        function createContextMenu(node) {
            var $tr = $(node);
            $tr.addClass("success");
            var id = $tr.data("id");
            var est = $tr.data("estado");
            var mes = $tr.data("mes");
            var anio = $tr.data("anio");
            var mesN = $tr.data("mes1");
            var anioN = $tr.data("anio2");

            var items = {
                header: {
                    label: "Acciones",
                    header: true
                }
            };

            var ver = {
                label  : 'Ver',
                icon   : "fa fa-search",
                action : function (e) {
                    $("tr.success").removeClass("success");
//                    e.preventDefault();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'show_ajax')}",
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            bootbox.dialog({
                                title   : "Ver Rol de Pagos",
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

            var ce = {
                label  : 'Cambiar Estado',
                icon   : "fa fa-undo",
                action : function (e) {
                    cambiarEstado(id)
                }
            };


            var dpr = {
                label  : 'Detalle de Pago por Rubro',
                icon   : "fa fa-list-ol",
                action : function (e) {
                    rubros(id)
                }
            };


            var dpe = {
                label  : 'Detalle de Pago por Empleado',
                icon   : "fa fa-users",
                action : function (e) {
                    cargarEmpleados(id)
                }
            };

            var generar = {
                label  : 'Generar Rol Nuevamente',
                icon   : "fa fa-check-square",
                action : function (e) {
                    generarRol(mes, anio, mesN, anioN)
                }
            };

            var imprimir = {
                label  : 'Imprimir Rol de Pagos',
                icon   : "fa fa-print",
                action : function (e) {
                    location.href="${createLink(controller: 'reportes3', action: 'reporteRolPagosGeneral')}/?id=" + id
                }
            };

            items.ver = ver;
            items.ce = ce;
            items.dpr = dpr;
            items.dpe = dpe;
            items.imprimir = imprimir;
            if(est == 'N'){
                items.generar = generar;
            }

            return items
        }

        function generarRol (mes, anio, mesN, anioN) {
            console.log(" - " + mesN + " - " + anioN)
            bootbox.confirm("Está a punto de generar el rol del pago nuevamente para el mes de <span style='color:blue'>"+
               mesN +" </span> del año <span style='color:blue'>"+
                anioN +".</span><br><br>Si es correcto, presione Aceptar para generar el rol",
                function(result){
                    if(result){
                        openLoader();
                        $.ajax({
                            type    : "POST",
                            url     : "${g.createLink(controller:'rubro', action:'generarRol')}",
                            data    : "mes="+ mes + "&anio="+ anio, //+
                            success : function (msg) {
                                location.reload()
                            }
                        });
                    }
                })
        }




//                context.settings({
//                    onShow : function (e) {
//                        $("tr.success").removeClass("success");
//                        var $tr = $(e.target).parent();
//                        $tr.addClass("success");
//                        id = $tr.data("id");
//                    }
//                });
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
        %{--title   : "Ver Rol de Pagos",--}%
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
        %{--text   : 'Cambiar estado',--}%
        %{--icon   : "<i class='fa fa-undo'></i>",--}%
        %{--action : function (e) {--}%
        %{--$("tr.success").removeClass("success");--}%
        %{--e.preventDefault();--}%
        %{--cambiarEstado(id)--}%
        %{--}--}%
        %{--},--}%
        %{--{divider : true},--}%
        %{--{--}%
        %{--text   : 'Detalle de Pago por Rubro',--}%
        %{--icon   : "<i class='fa fa-list-ol'></i>",--}%
        %{--action : function (e) {--}%
        %{--$("tr.success").removeClass("success");--}%
        %{--e.preventDefault();--}%
        %{--rubros(id)--}%
        %{--}--}%
        %{--},--}%
        %{--{--}%
        %{--text   : 'Detalle de Pago por Empleado',--}%
        %{--icon   : "<i class='fa fa-users'></i>",--}%
        %{--action : function (e) {--}%
        %{--$("tr.success").removeClass("success");--}%
        %{--e.preventDefault();--}%
        %{--cargarEmpleados(id)--}%
        %{--}--}%
        %{--},--}%
        %{--{divider : true},--}%
        %{--{--}%
        %{--text   : 'Generar nuevamente',--}%
        %{--icon   : "<i class='fa fa-check-square'></i>",--}%
        %{--action : function (e) {--}%
        %{--$("tr.success").removeClass("success");--}%
        %{--e.preventDefault();--}%

        %{--}--}%
        %{--}--}%
        %{--]);--}%
    });
</script>

</body>
</html>
