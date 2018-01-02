<%@ page import="cratos.inventario.Item" %>

<div id="create" class="span" role="main">
%{--
<link href="${resource(dir: 'js/jquery/css/bw', file: 'jquery-ui-1.10.2.custom.min.css')}" rel="stylesheet"/>
<script src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.10.2.custom.min.js')}"></script>
--}%
<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

<style type="text/css">
.help-block {
    width : 100%;
}
</style>

<g:form class="form-horizontal" name="frmItem" role="form" action="saveIt_ajax" method="POST">
    <g:hiddenField name="padre" value="${departamento?.id}"/>
    <g:hiddenField name="id" value="${itemInstance?.id}"/>
    <h3 style="text-align: center">${departamento.descripcion}</h3>
    <br>

    <div class="form-group ${hasErrors(bean: departamentoItemInstance, field: 'codigo', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Código
            </label>

            <g:set var="cd1" value="${departamento.subgrupo.codigo.toString().padLeft(3, '0')}"/>
            <g:set var="cd2" value="${departamento.codigo.toString().padLeft(3, '0')}"/>
            <g:set var="cd" value="${itemInstance?.codigo}"/>

            <div class="col-md-5 grupo">

            <g:if test="${itemInstance.id && cd}">
                <g:set var="cd" value="${cd?.replace(cd1 + ".", '').replace(cd2 + ".", '')}"/>
            </g:if>
            <g:if test="${itemInstance.id}">
                <g:if test="${itemInstance?.departamento?.subgrupo?.grupoId != 2 && departamento.subgrupo.grupoId != 2}">
                    ${cd1}.</g:if>${cd2}.${cd}
            </g:if>
            <g:else>
                %{--<div class="input-prepend">--}%
                <div class="col-md-12 grupo">
                    <span class="col-md-6">
                    <g:if test="${itemInstance?.departamento?.subgrupo?.grupoId != 2 && departamento.subgrupo.grupoId != 2}">
                        <span class="add-on">${cd1}</span>
                    </g:if>
                    <span class="add-on">${cd2}</span>
                    </span>
                    <span class="col-md-6">
                    <g:textField name="codigo" maxlength="6" class="allCaps required form-control" value="${cd}"/>
                    <p class="help-block ui-helper-hidden"></p>
                    </span>
                </div>
            </g:else>
            </div>

        </span>
    </div>

    <div class="form-group ${hasErrors(bean: itemInstance, field: 'nombre', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Nombre
            </label>

            <div class="col-md-9">
                <g:textField name="nombre" class="form-control required"
                             value="${itemInstance?.nombre}" maxlength="160"
                             style="width: 400px;"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: itemInstance, field: 'unidad', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Unidad
            </label>

            <div class="col-md-3">
                <g:select id="unidad" name="unidad.id" from="${cratos.inventario.Unidad.findAllByEmpresa(session.empresa, [sort: 'descripcion'])}"
                          optionKey="id" optionValue="descripcion"
                          class="many-to-one " value="${itemInstance?.unidad?.id}" noSelection="['': '']"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label class="col-md-2 control-label text-info">
                Marca
            </label>

            <div class="col-md-4">
                <g:select id="marca" name="marca.id" from="${cratos.inventario.Marca.findAllByEmpresa(session.empresa,[sort: 'descripcion'])}"
                          optionKey="id" optionValue="descripcion"
                          class="many-to-one " value="${itemInstance?.marca?.id}" noSelection="['': '']"/>
                <p class="help-block ui-helper-hidden"></p>
                <a href="#" id="btnMarca" class="btn btn-success btn-sm" title="Crear una nueva marca">
                    <i class="fa fa-plus"></i>
                </a>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: itemInstance, field: 'unidad', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Estado
            </label>

            <div class="col-md-3">
                <g:select id="estado" name="estado" from="['A': 'Activo', 'B': 'Dado de baja']"
                          class="many-to-one " value="${itemInstance?.estado}" optionKey="key" optionValue="value"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>

    %{--<div class="form-group ${hasErrors(bean: itemInstance, field: 'fecha', 'error')} ">--}%
        <span class="grupo">
            <label class="col-md-2 control-label text-info">
                Fecha
            </label>

            <div class="col-md-4">
                <elm:datepicker name="fecha" title="Fecha de registro del item" class="datepicker form-control required"
                                value="${itemInstance?.fecha}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    %{--</div>--}%
    </div>

    <div class="form-group ${hasErrors(bean: itemInstance, field: 'precioVenta', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Precio de Venta
            </label>

            <div class="col-md-3">
                <g:textField class="form-control required number validacionNumero" title="Precio de Venta"
                             name="precioVenta" value="${itemInstance?.precioVenta}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
%{--
    </div>

    <div class="form-group ${hasErrors(bean: itemInstance, field: 'precioCosto', 'error')} ">
--}%
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Precio de Costo
            </label>

            <div class="col-md-3">
                <g:textField name="precioCosto" class="form-control required" value="${itemInstance?.precioCosto}"
                             title="Precio de Costo"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: itemInstance, field: 'tipoIVA', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Tipo de IVA:
            </label>

            <div class="col-md-9">
                <g:select id="tipoIVA" name="tipoIVA.id" from="${cratos.inventario.TipoIVA.list([sort: 'descripcion'])}"
                          optionKey="id" optionValue="descripcion"
                          class="many-to-one " value="${itemInstance?.tipoIVA?.id?:'2'}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

%{--
    <div class="form-group ${hasErrors(bean: itemInstance, field: 'tarifaIVA', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Tarifa IVA:
            </label>

            <div class="col-md-9">
                <g:select id="tarifaIVA" name="tarifaIVA.id" from="${cratos.sri.TarifaIVA.list([sort: 'descripcion'])}"
                          optionKey="id" optionValue="descripcion"
                          class="many-to-one " value="${itemInstance?.tipoIVA?.id?:'2'}" noSelection="['': '']"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
--}%


    <div class="form-group ${hasErrors(bean: itemInstance, field: 'stockMinimo', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Existencias mínimas
            </label>

            <div class="col-md-3">
                <g:textField name="stockMinimo" class="form-control required" value="${itemInstance?.stockMinimo}"
                             title="Existencias mínimas"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
%{--
    </div>

    <div class="form-group ${hasErrors(bean: itemInstance, field: 'stockMaximo', 'error')} ">
--}%
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Existencias máximas
            </label>

            <div class="col-md-3">
                <g:textField name="stockMaximo" class="form-control required" value="${itemInstance?.stockMaximo}"
                             title="Existencias máximas"/>
                <span>
                <p class="help-block ui-helper-hidden"></p>
            </span>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: itemInstance, field: 'peso', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Peso unitario en Kg
            </label>

            <div class="col-md-3">
                <g:textField name="peso" class="form-control required" value="${itemInstance?.peso}"
                             title="Peso unitario en Kg"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="col-sx-2">
            <label class="col-md-3 control-label text-info">
                % ICE
            </label>

            <div class="col-md-3">
                <g:textField name="ice" class="form-control required" value="${itemInstance?.ice}"
                             title="Porcentaje aplicado de ICE"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>


    <div class="form-group ${hasErrors(bean: itemInstance, field: 'observaciones', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Observaciones
            </label>

            <div class="col-md-8">
                <g:textArea style="resize: none;" name="observaciones" maxlength="127" class="form-control"
                            value="${itemInstance?.observaciones}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

</g:form>

<div class="modal grande hide fade" id="modal-ccp" style="overflow: hidden;">
    <div class="modal-header btn-info">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3 id="modalTitle2"></h3>
    </div>

    <div class="modal-body" id="modalBody2">
        <bsc:buscador name="pac.buscador.id" value="" accion="buscaCpac" controlador="mantenimientoItems" campos="${campos}" label="cpac" tipo="lista"/>
    </div>

    <div class="modal-footer" id="modalFooter2">
    </div>
</div>


<script type="text/javascript">

    function validarNum(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
        (ev.keyCode >= 96 && ev.keyCode <= 105) ||
        ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
        ev.keyCode == 37 || ev.keyCode == 39 ||
        ev.keyCode == 110 || ev.keyCode == 190);
    }

    $(".validacionNumero").keydown(function (ev) {
        return validarNum(ev);
    }).keyup(function () {

    });

    $(".number").blur(function () {
        if(isNaN($(this).val()))
            $(this).val("0.00")
        if($(this).val()=="")
            $(this).val("0.00")
    });



    function label() {
        var c = $("#tipoLista").children("option:selected").attr("class");
        if (c == "null") {
            $("#grupoPeso").hide();
        } else {
            $("#grupoPeso").show();
            $("#spanPeso").text(c);
        }
    }


    label();

    $(".allCaps").blur(function () {
        this.value = this.value.toUpperCase();
    });


    var validator = $("#frmItem").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        },
        rules          : {
            codigo : {
                remote : {
                    url  : "${createLink(action:'checkCdIt_ajax')}",
                    type : "post",
                    data : {
                        id  : "${itemInstance?.id}",
                        dep : "${departamento.id}"
                    }
                }
            },
            nombre : {
                remote : {
                    url  : "${createLink(action:'checkNmIt_ajax')}",
                    type : "post",
                    data : {
                        id : "${itemInstance?.id}"
                    }
                }
            },
            campo  : {
                remote : {
                    url  : "${createLink(action:'checkCmIt_ajax')}",
                    type : "post",
                    data : {
                        id : "${itemInstance?.id}"
                    }
                },
                regex  : /^[A-Za-z\d_]+$/
            }
        },
        messages       : {
            codigo : {
                remote : "Código ya Existe"
            },
            nombre : {
                remote : "El nombre ya se ha ingresado para otro item"
            },
            campo  : {
                regex  : "El nombre corto no permite caracteres especiales",
                remote : "El nombre ya se ha ingresado para otro item"
            }
        }
    });

    $(function () {
        $("#item_codigo").dblclick(function () {
            var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cerrar</a>');
            $("#modalTitle2").html("Código compras públicas");
            $("#modalFooter2").html("").append(btnOk);
            $(".contenidoBuscador").html("")
            $("#modal-ccp").modal("show");
            $("#buscarDialog").unbind("click")
            $("#buscarDialog").bind("click", enviar)
        });
    });

    $("#btnMarca").click(function () {
        createEditRowMarca();
    });

    function submitFormMarca() {
        var $form = $("#frmMarca");
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
//                        location.reload(true);
                        bootbox.hideAll();
                        closeLoader();
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

    function createEditRowMarca(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id : id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'marca', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
//                    class   : "long",
                    title   : "Nueva Marca",
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
                                return submitFormMarca();
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



</script>
