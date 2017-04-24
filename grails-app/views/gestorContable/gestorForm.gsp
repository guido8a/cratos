<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>${(gestorInstance) ? 'Editar gestor contable' : 'Nuevo gestor contable'}</title>
    <style type="text/css">
    .fila {
        width  : 800px;
        min-height : 40px;
    }

    .label {
        width       : 80px;
        float       : left;
        height      : 30px;
        line-height : 30px;
        color: #000000;
        font-size: inherit;
        text-align: left;
        margin-left: 0px;
    }

    .campo {
        width  : 670px;
        float  : right;
        min-height: 40px;
    }
    </style>
</head>
<body>
<g:if test="${flash.message}">
    <div class="alert ${flash.tipo == 'error' ? 'alert-danger' : flash.tipo == 'success' ? 'alert-success' : 'alert-info'} ${flash.clase}">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <g:if test="${flash.tipo == 'error'}">
            <i class="fa fa-warning fa-2x pull-left"></i>
        </g:if>
        <g:elseif test="${flash.tipo == 'success'}">
            <i class="fa fa-check-square fa-2x pull-left"></i>
        </g:elseif>
        <g:elseif test="${flash.tipo == 'notFound'}">
            <i class="icon-ghost fa-2x pull-left"></i>
        </g:elseif>
        <p>
            ${flash.message}
        </p>
    </div>
</g:if>
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <a href="#" id="btnGuardar" class="btn btn-azul">
            <i class="fa fa-save"></i>
            Guardar
        </a>
        <g:link class="btn btn-default" action="index">
            <i class="fa fa-times"></i>
            Cancelar
        </g:link>
    </div>
</div>
<div class="vertical-container" style="margin-top: 25px;color: black">
    <p class="css-vertical-text">Descripción</p>
    <div class="linea"></div>
    <g:form action="save" class="frmGestor" controller="gestorContable">
        <div id="contenido" >
            <input type="hidden" name="id" value="${gestorInstance?.id}"/>
            <div class="fila">
                <div class="label">
                    Nombre:
                </div>

                <div class="campo">
                    <span class="grupo">
                        <input name="nombre" type="text" value="${gestorInstance?.nombre}" maxlength="127" style="width:700px;" class="form-control required"/>
                    </span>
                </div>
            </div>

            <div class="fila">
                <div class="label">
                    Descripción:
                </div>

                <div class="campo">
                    <span class="grupo">
                        <input name="descripcion" type="textArea" value="${gestorInstance?.descripcion}" maxlength="255"  style="width:700px;" class="form-control required"/>
                    </span>
                </div>
            </div>

            <div class="fila">
                <div class="label">
                    Observaciones:
                </div>

                <div class="campo">
                    <input name="observaciones" type="textArea" value="${gestorInstance?.observaciones}"  maxlength="125" style="width:700px;" class="form-control"/>
                </div>
            </div>

            <div class="fila">
                <div class="label">
                    Fuente:
                </div>

                <div class="campo">
                    <g:select name="fuente.id" type="select" campo="fuente" from="${cratos.Fuente.list([sort: 'descripcion'])}" label="Fuente: "
                              value="${gestorInstance?.fuente?.id}" optionKey="id" optionValue="descripcion" class="form-control required" style="width: 200px" ></g:select>
                </div>
            </div>

            <div class="fila">
                <div class="label">
                    Tipo:
                </div>

                <div class="campo">
                    <span class="grupo">
                        <g:select name="tipoCom" type="select" campo="tipo" from="${cratos.TipoComprobante.list([sort: 'descripcion'])}" label="Tipo comprobante: " value="${tipoCom?.id}"
                                  optionKey="id" id="tipo" class="form-control required" optionValue="descripcion" style="width: 200px"></g:select>
                    </span>
                </div>
            </div>


            <div style="margin-left: 50px">
            </div>
        </div>
    </g:form>
</div>

<div class="vertical-container" style="margin-top: 25px;min-height: 200px">
    <p class="css-vertical-text">Movimientos</p>
    <div class="linea"></div>
    <g:render template="busquedaCuentas"/>
</div>

<div class="vertical-container" style="margin-top: 25px;min-height: 370px;margin-bottom: 30px">
    <p class="css-vertical-text">Agregar movimientos</p>
    <div class="linea"></div>
    <div class="row" style="margin-bottom: 10px">
        <div class="col-xs-3 negrilla">
            C&oacute;digo:
            <input type="text" class=" form-control label-shared" style="width: 150px" name="codigo" id="codigoBus"/>
        </div>
        <div class="col-xs-3 negrilla">
            Nombre:
            <input type="text" class=" form-control label-shared" style="width: 150px" name="nombreBus" id="nombreBus"/>
        </div>
        <div class="col-xs-2 negrilla">
            <input type="hidden" name="movimientos" value="1"/>
            <a href="#" class="btn btn-azul"  id="buscar">
                <i class="fa fa-search"></i>
                Buscar
            </a>
        </div>
    </div>


    %{--<table class="table table-striped" width="400px">--}%
        <table class="table table-bordered table-hover table-condensed">
        <thead>
        <tr>
            <th style="width: 10px">C&oacute;digo</th>
            <th style="width: 300px">Nombre</th>
            <th style="width: 10px">Nivel</th>
            <th style="width: 20px">Debe/Haber</th>
            <th style="width: 30px">Agregar</th>
        </tr>
        </thead>
    </table>

    <div class="row-fluid"  style="width: 99.7%;height: 250px;overflow-y: auto;float: right;">
        <div class="span12">
            <div id="divPlanCuentas" style="width: 1050px; height: 250px;"></div>
        </div>
    </div>


    %{--<div id="divPlanCuentas" style=" padding: 5px; margin-top: 2px; width: 700px;">--}%

    %{--</div>--}%

</div>
<script type="text/javascript">
    $(function () {
        var band = 1
        $("#buscar").click(function () {
            openLoader("Buscando")
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'gestorContable',action: 'buscarCuentas')}",
                data    : "nombre=" + $('#nombreBus').val() + "&codigo=" + $("#codigoBus").val(),
                success : function (msg) {
                    closeLoader()
                    $('#divPlanCuentas').html(" ")
                    $('#divPlanCuentas').html(msg);
                    var b = true

                }
            })
        });
        $("#tipo").change(function () {
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'gestorContable',action: 'cambiarComprobante')}",
                data    : "tc=" + $(this).val(),
                success : function (msg) {
                    $("#agregarCuentas").html(msg)

                }
            })
        });

        $("#txtBusca").bind('keyup', function (event) {
            var keyCode = event.which;
            if (keyCode == 13) {
                enviar();
            }
            if ($(this).val().length >= 0 && $("#error").parent().is(":visible")) {
                $("#error").html("").parent().hide("slide");
            }
        });

        $("#buscarGestor").click(function () {
            enviar();
        });

        function enviar() {
            $.ajax({
                type    : "POST",
                url     : "buscarGestor",
                data    : $(".buscarGestor").serialize(),
                success : function (msg) {
                    $("#divLista").html(msg).show("slide");
                    tablas();
                }
            });
        }

        $("#btnGuardar").click(function () {
//            console.log($(".frmGestor2"))
            if($(".frmGestor").valid()){
                if($(".movimiento").size()>0){
                $(".frmGestor").submit()
                }else{
                    bootbox.alert("Por favor ingrese los movimientos contables antes de guardar el gestor")
                }
            }
            return false

        });
        var validator = $(".frmGestor").validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
                element.parents(".grupo").parent().parent().height( element.parents(".grupo").parent().parent().height()+30)
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
                label.parents(".grupo").parent().parent().height( label.parents(".grupo").parent().parent().height()-30)
            }
        });

    });
</script>
</body>
</html>


