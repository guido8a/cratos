<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 26/06/17
  Time: 11:49
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Parámetros de la Empresa</title>

    <style type="text/css">

    .tab-content, .left, .right {
        height : 600px;
    }

    .tab-content {
        /*background  : #EFE4D1;*/
        background    : #EEEEEE;
        border-left   : solid 1px #DDDDDD;
        border-bottom : solid 1px #DDDDDD;
        border-right  : solid 1px #DDDDDD;
        padding-top   : 10px;
    }

    .descripcion {
        /*margin-left : 20px;*/
        font-size : 12px;
        border    : solid 2px cadetblue;
        padding   : 0 10px;
        margin    : 0 10px 0 0;
    }

    .info {
        font-style : italic;
        color      : navy;
    }

    .descripcion h4 {
        color      : cadetblue;
        text-align : center;
    }

    .left {
        width : 600px;
        text-align: justify;
        /*background : red;*/
    }

    .right {
        width       : 300px;
        margin-left : 20px;
        padding: 20px;
        /*background  : blue;*/
    }

    .fa-ul li {
        margin-bottom : 10px;
    }

    </style>

</head>

<body>
<g:set var="iconEmpr" value="fa fa-building-o"/>

<ul class="nav nav-tabs">
    <li class="active"><a href="#parametros" data-toggle="tab">Parámetros</a></li>
</ul>




<div class="tab-content ui-corner-bottom">
<div class="tab-pane active" id="empresa">
    <div class="left pull-left">
        <ul class="fa-ul">
            <li>
                <i class="fa-li ${iconEmpr}"></i>
                <span id="paramsEmp">
                    <g:link action="form" class="btnEmpresa">Parámetros de la Empresa</g:link> datos pertenecientes a la empresa.
                </span>

                <div class="descripcion hide">
                    <h4>Parámetros de la Empresa</h4>

                    <p>Parámetros de funcionamiento de la contabilidad, control de costos y valores del IVA, en la Empresa,</p>
                </div>
            </li>
            <li>
                <i class="fa-li ${iconEmpr}"></i>
                <span id="centroCostos">
                    <g:link controller="centroCosto" action="list">Centro de Costos</g:link> de la empresa de acuerdo a
                    los cuales se llevará el control de bodegas, inventarios y existencias.
                </span>

                <div class="descripcion hide">
                    <h4>Centro de Costos</h4>

                    <p>Centro de costos para el control de adquisiciones, ventas, inventario y bodegas.</p>

                    <p>Si la empresa no lleva el control de varios centros de costos, se debe definir uno general a la
                    cual pretenecerán todas las bodegas.</p>
                </div>
            </li>
            <li>
                <i class="fa-li ${iconEmpr}"></i>
                <span id="banco">
                    <g:link controller="banco" action="list">Bancos</g:link> en los cuales posee cuentas asociadas a la
                    contabilidad
                </span>

                <div class="descripcion hide">
                    <h4>Bancos</h4>

                    <p>Registro de los bancos relacionados con la empresa, ya sea por cuentas de ahorro o corrientes.</p>
                </div>
            </li>
            <li>
                <i class="fa-li ${iconEmpr}"></i>
                <span id="departamento">
                    <g:link controller="departamento" action="list">Departamento</g:link> de la empresa que poseen
                    personal
                </span>

                <div class="descripcion hide">
                    <h4>Departamentos de Personal</h4>

                    <p>Departamentos de personal de la empresa para el control de la nómina. Cada empleado será vinculado a un
                    departamento y un cargo.</p>
                </div>
            </li>
            <li>
                <i class="fa-li ${iconEmpr}"></i>
                <span id="libretin">
                    <g:link controller="documentoEmpresa" action="list">Libretínes de Facturas, Retenciones, NC y otros</g:link>
                    documentos autorizados por el SRI
                </span>
                <div class="descripcion hide">
                    <h4>Libretínes de Facturas, Retenciones, NC y otros</h4>
                    <p>Todos los libretines de facturas para ser usados digitalmente.</p>
                </div>
            </li>
            <li>
                <i class="fa-li ${iconEmpr}"></i>
                <span id="subgrupoItems">
                    <g:link controller="subgrupoItems" action="list" data="123">Subgrupo de Items</g:link> de la empresa
                </span>
                <div class="descripcion hide">
                    <h4>Subgrupo de Items</h4>
                    <p>Subgrupos.</p>
                </div>
            </li>
            <li>
                <i class="fa-li ${iconEmpr}"></i>
                <span id="proveedores">
                    <g:link controller="proveedor" action="list">Proveedores</g:link> de la empresa
                </span>
                <div class="descripcion hide">
                    <h4>Proveedores</h4>
                    <p>Proveedores.</p>
                </div>
            </li>
            <li>
                <i class="fa-li ${iconEmpr}"></i>
                <span id="reporteContable">
                    <g:link controller="reporteCuenta" action="list">Reportes Contables</g:link> Reportes contables
                    especiales del sistema conforme a las normas NIIF
                </span>

                <div class="descripcion hide">
                    <h4>Reportes de la Contabilidad</h4>

                    <p>Sirve para definir reportes especiales por empresa.</p>

                    <p>Por lo general siempre se definirán los mismo reportes para cada empresa, conforme las normas NIIF.</p>
                </div>
            </li>
            <li>
                <i class="fa-li ${iconEmpr}"></i>
                <span id="bodegas">
                    <g:link controller="bodega" action="list">Bodegas</g:link> para el control de existencias e inventarios
                    por centros de costos o en forma general.
                </span>

                <div class="descripcion hide">
                    <h4>Bodegas</h4>

                    <p>Son los sitios donde se almacenan los artículos de inventario.</p>

                    <p>Cada bodega debe estar relacionada a un centro de costos, pudiendo haber varias bodegas dentro de un
                    mismo centro de costos.</p>
                </div>
            </li>
            <li>
                <i class="fa-li ${iconEmpr}"></i>
                <span id="canton">
                    <g:link controller="canton" action="list">Cantón</g:link>
                </span>

                <div class="descripcion hide">
                    <h4>Cantón</h4>

                    <p>Cantón</p>
                </div>
            </li>
            <li>
                <i class="fa-li ${iconEmpr}"></i>
                <span id="Unidad">
                    <g:link controller="unidad" action="list">Unidad</g:link> de conteo o control de los los items.
                </span>

                <div class="descripcion hide">
                    <h4>Unidad de Medida</h4>

                    <p>Unidad de control o conteo de obras para el plan anual de adquisiciones (PAC) y para fijar las metas.</p>

                    <p>Pueden ser: kil&oacute;metros, metros, escuelas, unidades, etc.</p>
                </div>
            </li>
            <li>
                <i class="fa-li ${iconEmpr}"></i>
                <span id="Marca">
                    <g:link controller="marca" action="list">Marca</g:link> de los distintos items que se posee como
                    inventarios o como activos fijos.
                </span>

                <div class="descripcion hide">
                    <h4>Marcas</h4>

                    <p>Marca de los artículos d einventario y de los activos fijos de la Empresa.</p>

                    <p>Se de be crear un "Sin Marca" para aquellos bienes que no tienen marca</p>
                </div>
            </li>
            <li>
                <i class="fa-li ${iconEmpr}"></i>
                <span id="rolPagos">
                    <g:link controller="rolPagos" action="list">Rol de Pagos</g:link>

                </span>

                <div class="descripcion hide">
                    <h4>Rol de Pagos</h4>

                    <p>Rol de Pagos</p>
                </div>
            </li>
        </ul>
    </div>

    <div class="empresa right pull-right">
    </div>
</div>
</div>

<script type="text/javascript">

    function prepare() {
        $(".fa-ul li span").each(function () {
            var id = $(this).parents(".tab-pane").attr("id");
            var thisId = $(this).attr("id");
            $(this).siblings(".descripcion").addClass(thisId).addClass("ui-corner-all").appendTo($(".right." + id));
        });
    }

    $(function () {
        prepare();
        $(".fa-ul li span").hover(function () {
            var thisId = $(this).attr("id");
            $("." + thisId).removeClass("hide");
        }, function () {
            var thisId = $(this).attr("id");
            $("." + thisId).addClass("hide");
        });
    });



    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id : id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'empresa', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Empresa",
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
                                var comas = $("#establecimientos").val().indexOf(",,");
                                if(comas == -1){
                                    return submitForm();
                                }else{
                                   bootbox.alert("<i class='fa fa-warning fa-3x pull-left text-warning text-shadow'></i> Error al ingresar el número de establecimiento <br> Doble Coma (,,)")
                                    return false;
                                }


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

    $(".btnEmpresa").click(function () {
        createEditRow(${empresa});
        return false;
    });

    function submitForm() {
        var $form = $("#frmEmpresa");
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


</script>



</body>
</html>