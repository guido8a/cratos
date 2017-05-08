<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 02/05/17
  Time: 14:46
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>${(gestorInstance) ? 'Editar Gestor' : 'Nuevo gestor contable'}</title>

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
        <g:link class="btn btn-primary" action="index">
            <i class="fa fa-chevron-left"></i>
            Lista de Gestores
        </g:link>

        <a href="#" id="btnGuardar" class="btn btn-success">
        <i class="fa fa-save"></i>
        Guardar
         </a>
    </div>
</div>
<div class="vertical-container" style="margin-top: 25px;color: black">
    <p class="css-vertical-text">Gestor Contable</p>
    <div class="linea"></div>
    %{--<g:form action="save" class="frmGestor" controller="gestorContable">--}%
        <div id="contenido" >
            %{--<input type="hidden" name="id" value="${gestorInstance?.id}"/>--}%

%{--
            <div class="fila">
                <div class="label">
                    Empresa:
                </div>

                <div class="campo">
                    <strong>${session.empresa}</strong>
                </div>
            </div>
--}%

            <div class="fila">
                <div class="label">
                    Nombre:
                </div>

                <div class="campo">
                    %{--<span class="grupo">--}%
                        <input name="nombre_name" id="nombre" type="text" value="${gestorInstance?.nombre}" maxlength="127"
                               class="form-control required"/>
                    %{--</span>--}%
                </div>
            </div>

            <div class="fila">
                <div class="label">
                    Descripción:
                </div>

                <div class="campo">
                    <span class="grupo">
                        <input name="descripcion_name" id="descripcion" type="textArea" value="${gestorInstance?.descripcion}" maxlength="255"  style="width:700px;" class="form-control required"/>
                    </span>
                </div>
            </div>

            <div class="fila">
                <div class="label">
                    Observaciones:
                </div>

                <div class="campo">
                    <input name="observaciones_name" id="observaciones" type="textArea" value="${gestorInstance?.observaciones}"  maxlength="125" style="width:700px;" class="form-control"/>
                </div>
            </div>

            <div class="fila">
                <div class="label">
                    Fuente:
                </div>

                <div class="campo">
                    <g:select name="fuente.id" type="select" campo="fuente" from="${cratos.Fuente.list([sort: 'descripcion'])}"
                              label="Fuente: " value="${gestorInstance?.fuente?.id}" optionKey="id" optionValue="descripcion"
                              class="form-control required col-md-3" id="fuenteGestor"/>
                </div>

            </div>
        </div>
    %{--</g:form>--}%
</div>

<g:if test="${gestorInstance?.id}">
    <div class="vertical-container" style="margin-top: 25px;color: black; height: 500px">
        <p class="css-vertical-text">Cuentas del asiento</p>
        <div class="linea"></div>

        <div class="contenido">

            <div class="col-md-12" style="margin-bottom: 10px">
                <div class="label col-md-3">
                    Tipo de comprobante:
                </div>

                <div class="col-md-3">
                    <span class="grupo">
                        <g:select name="tipoCom" type="select" campo="tipo" from="${cratos.TipoComprobante.list([sort: 'descripcion'])}"
                                  label="Tipo comprobante: " value="${''}" optionKey="id" id="tipo" class="form-control required col-md-3"
                                  optionValue="descripcion" style="margin-left: 80px; font-weight: bold"/>
                    </span>
                </div>
                <span class="col-md-3">

                </span>
                <div class="btn-group col-md-3">
                    <a href="#" id="btnAgregarMovimiento" class="btn btn-info" title="Agregar una cuenta al gestor">
                        <i class="fa fa-plus"></i> Agregar Cuenta
                    </a>
                </div>
            </div>


            <table class="table table-bordered table-hover table-condensed">
                <thead>
                <tr>
                    <th></th>
                    <th colspan="3">DEBE</th>
                    <th colspan="3">HABER</th>
                    <th></th>
                </tr>
                <tr>
                    <th style="width: 280px;">Código (Cuenta)</th>
                    <th style="width: 100px">% B. Imponible</th>
                    <th style="width: 80px">Impuestos</th>
                    <th style="width: 80px">Valor</th>
                    <th style="width: 100px">% B. Imponible</th>
                    <th style="width: 80px">Impuestos</th>
                    <th style="width: 80px">Valor</th>
                    <th style="width: 70px"><i class="fa fa-pencil"></i> </th>
                </tr>
                </thead>
            </table>


            <div class="row-fluid"  style="width: 99.7%;height: 320px;overflow-y: auto;float: right;">
                <div class="span12">
                    <div id="cuentaAgregada" style="width: 1070px; height: 280px;"></div>
                </div>
            </div>

            %{--<div class="row-fluid"  style="width: 99.7%;height: 250px;overflow-y: auto;float: right;">--}%
                <div class="span12">
                    <div id="totales" style="width: 1070px; height: 20px;"></div>
                </div>
            %{--</div>--}%



        </div>
    </div>
</g:if>



<script type="text/javascript">


    $("#btnAgregarMovimiento").click(function () {
        var tipo = $("#tipo").val();
        $.ajax({
            type   : "POST",
            url    : "${createLink(controller: 'gestorContable', action:'buscarMovimiento_ajax')}",
            data   : {
                    empresa: '${session.empresa.id}',
                    id: '${gestorInstance?.id}',
                    tipo: tipo

            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id   : "dlgBuscar",
                    title: "Buscar cuenta",
                    class   : "long",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label    : "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback : function () {
                            }
                        }
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    });


    if('${gestorInstance?.id}'){
        var tipoC = $("#tipo").val();
        cargarMovimientos('${gestorInstance?.id}', tipoC);
        cargarTotales('${gestorInstance?.id}', tipoC);
    }

        $("#tipo").change(function () {
            var tipoVal = $(this).val();
            cargarMovimientos('${gestorInstance?.id}', tipoVal);
            cargarTotales('${gestorInstance?.id}', tipoVal);
        });

        function cargarMovimientos (idGestor, idTipo) {
            $.ajax({
                type:'POST',
                url: '${createLink(controller: 'gestorContable', action: 'tablaGestor_ajax')}',
                data:{
                    id: idGestor,
                    tipo: idTipo
                },
                success: function (msg){
                    $("#cuentaAgregada").html(msg)
                }
            });
        }

        function cargarTotales(idGestor, idTipo) {
            $.ajax({
                type:'POST',
                url: '${createLink(controller: 'gestorContable', action: 'totales_ajax')}',
                data:{
                    id: idGestor,
                    tipo: idTipo
                },
                success: function (msg){
                    $("#totales").html(msg)
                }
            });
        }


        $("#btnGuardar").click(function () {
            var gestor = '${gestorInstance?.id}'
            var nombreGestor = $("#nombre").val();
            var descripcion = $("#descripcion").val();
            var observacion = $("#observaciones").val();
            var fuente = $("#fuenteGestor").val();
            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'gestorContable', action: 'guardarGestor')}",
                data:{
                    gestor: gestor,
                    nombre: nombreGestor,
                    descripcion: descripcion,
                    observacion: observacion,
                    fuente: fuente
                },
                success: function (msg){
                    var parts = msg.split("_");
                    if(parts[0] == 'ok'){
                        log("Información del gestor guardada correctamente","success")
                        setTimeout(function () {
                          location.href="${createLink(controller: 'gestorContable', action: 'formGestor')}/" + parts[1]
                        }, 800);
                    }else{
                        log("Error al guardar la información del gestor","error")
                    }
                }

            });
        });


</script>

</body>
</html>