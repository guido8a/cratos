<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/08/17
  Time: 11:04
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Reembolso</title>
</head>

<body>

<div class="btn-group" style="margin-right: 20px">
    <a href="#" class="btn btn-success previous" id="irProceso">
        <i class="fa fa-chevron-left"></i>
        Proceso
    </a>
    <a href="#" class="btn btn-success" id="comprobanteN">
        <i class="fa fa-calendar-o"></i>
        Comprobante
    </a>
    <a href="#" class="btn btn-success disabled" id="reembolsoN">
        <i class="fa fa-thumbs-up"></i>
        Reembolso
    </a>
    <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'C'}">
        <g:link class="btn btn-success" action="detalleSri" id="${proceso?.id}" style="margin-bottom: 10px;">
            <i class="fa fa-money"></i> Retenciones
        </g:link>
    </g:if>
</div>



<g:if test="${proceso}">
    <div class="vertical-container" skip="1" style="margin-top: 5px; color:black; margin-bottom:20px; height:700px; max-height: 620px; overflow: auto;">
        <p class="css-vertical-text">Reembolso</p>

        <div class="linea"></div>

        %{--<div class="col-md-10" style="margin-top: 15px">--}%
            %{--<div class="col-md-2 negrilla">--}%
                %{--Gestor:--}%
            %{--</div>--}%
            %{--<div class="col-md-8 negrilla">--}%
                %{--<g:textField name="gestorR" value="${proceso?.gestor?.nombre}" class="form-control" readonly=""/>--}%
            %{--</div>--}%
        %{--</div>--}%

        %{--<div class="col-md-10"  style="margin-top: 10px">--}%
            %{--<div class="col-md-2 negrilla">--}%
                %{--Cliente:--}%
            %{--</div>--}%
            %{--<div class="col-md-3 negrilla">--}%
                %{--<g:textField name="proveedorCodigoR" value="${proceso?.proveedor?.ruc}" class="form-control" readonly=""/>--}%
            %{--</div>--}%
            %{--<div class="col-md-5 negrilla">--}%
                %{--<g:textField name="proveedorR" value="${proceso?.proveedor?.nombre}" class="form-control" readonly=""/>--}%
            %{--</div>--}%
        %{--</div>--}%

        %{--<div class="col-md-10"  style="margin-top: 10px">--}%
            %{--<div class="col-md-2 negrilla">--}%
                %{--Tipo de comprobante:--}%
            %{--</div>--}%
            %{--<div class="col-md-8 negrilla">--}%
                %{--<g:textField name="tipoCompR" value="${proceso?.tipoCmprSustento?.tipoComprobanteSri?.descripcion}" class="form-control" readonly=""/>--}%
            %{--</div>--}%
        %{--</div>--}%

        <div class="col-md-10" style="margin-top: 10px; margin-bottom: 10px">
            <div class="btn-group" style="float: left;">
                <a href="#" class="btn btn-success" id="agregarN">
                    <i class="fa fa-plus"></i>
                    Agregar
                </a>
            </div>
        </div>

        <table class="table table-bordered table-hover table-condensed" width="1000px">
            <thead>
            <tr>
                <th width="150px">Proveedor</th>
                <th width="150px">Tipo de Comprobante</th>
                <th width="80px">N°</th>
                <th width="100px">Valor</th>
                <th width="45px"><i class="fa fa-pencil"></i></th>
            </tr>
            </thead>
        </table>

        <div id="divReembolso" class="col-xs-12"style="margin-bottom: 0px ;padding: 0px;margin-top: 5px; height: 450px">
        </div>
    </div>
</g:if>


<script type="text/javascript">



    $("#agregarN").click(function () {
        $.ajax({
           type: 'POST',
            url:'${createLink(controller: 'proceso', action: 'formReembolso_ajax')}',
            data:{
                proceso: '${proceso?.id}'
            },
            success: function (msg) {
                bootbox.dialog({
                    title: 'Agregar reembolso',
                    message: msg,
//                    class: 'long',
                    buttons:{
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                                bootbox.hideAll();
                            }
                        },
                        guardar:{
                            label: "<i class='fa fa-save'></i> Guardar",
                            className: "btn-success",
                            callback: function () {
                                bootbox.hideAll();
                            }
                        }
                    }
                })
            }
        });
    });


    $("#comprobanteN").click(function () {
        location.href="${createLink(controller: 'proceso', action: 'comprobante')}/?proceso=" + '${proceso?.id}'
    })

    $("#irProceso").click(function () {
        location.href='${createLink(controller: 'proceso', action: 'nuevoProceso')}/?id=' + '${proceso?.id}'
    })

</script>

</body>
</html>