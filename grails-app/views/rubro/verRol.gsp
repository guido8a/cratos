<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main"/>

    <title>Rol de pagos</title>
    <style type="text/css">

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
<div class="row" style="margin-bottom: 20px">
    <div class="col-xs-1 negrilla">
        Mes:
    </div>
    <div class="col-xs-2 negrilla">
        <g:select name="mes" from="${meses}" class="form-control" id="meses" optionKey="id" optionValue="descripcion" value="${mes.id}"></g:select>
    </div>
    <div class="col-xs-1 negrilla">
        Año:
    </div>
    <div class="col-xs-2 negrilla">
        <g:select name="mes" from="${anios}" class="form-control" optionKey="key" optionValue="value" id="anios" value="${anio}"></g:select>
    </div>
    <div class="col-xs-1 negrilla">
        <a href="#" class="btn btn-azul" id="ver" style="margin-left: 10px">Ver</a>
    </div>
</div>
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <a href="#" class="btn btn-default" id="imprimir" >
            <i class="fa fa-print "></i>
            Imprimir
        </a>
        <a href="#" id="imprimirDet" class="btn btn-default">
            <i class="fa fa-print "></i>
            Imprimir Detalles
        </a>
    </div>
</div>



<input type="hidden" id="control" value="0">
<div class="titulo-azul">

</div>
<div class="vertical-container" style="margin-top: 25px;color: black;padding-bottom: 10px;min-height: 390px">

    <p class="css-vertical-text">
        <g:if test="${rol}">
            Rol del pagos del mes de ${rol?.mess.descripcion}
        </g:if>
        <g:else>
            Seleccione un mes y año
        </g:else>
    </p>
    <div class="linea"></div>
    <div id="tabla"  style="width: 930px;margin-left: 0px;margin-top: 15px;">
    <input type="hidden" id="etiqueta">
        <table style="width: 910px;"  class="table table-striped">
            <thead>
            <tr>
                <th>Empleado</th>
                <th>Cargo</th>
                <th>Contrato</th>
                <th>A recibir</th>
                <th style="width: 130px">Detalle</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${datos}" var="d" status="i">
                <tr class="datos" id="${d[0]}">
                    <td>${d[1]}</td>
                    <td>${d[2]}</td>
                    <td>${d[3]}</td>
                    <td style="text-align: right" id="r_${i}" class="subtotal">${d[4]}</td>
                    <td>
                        <a href="#" class="detalle btn btn-small btn-azul"  title="Ver detalle" id="${d[0]}" eti="r_${i}">
                           <i class="fa fa-bars"></i>

                        </a>
                        <a href="#" class="imprimir btn btn-small btn-azul" title="Imprimir detalle" id="${d[0]}">
                            <i class="fa fa-print"></i>

                        </a>
                    </td>
                </tr>
            </g:each>
            <tr>
                <td colspan="3"><b>TOTAL</b></td>
                <td style="text-align: right" id="total">${rol?.pagado}</td>
                <td></td>
            </tr>
            </tbody>

        </table>
    </div>
</div>


<g:if test="${rol?.estado != 'R'}">
    <div style="margin: 23px;">
        <a href="#" class="btn btn-success" id="registrar">Registrar Rol</a>
    </div>
</g:if>

<div class="modal fade longModal" id="dlg-rol" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Rol de pago</h4>
            </div>
            <div class="modal-body" id="body-dlg-rol">


            </div>
            <div class="modal-footer">

            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<script type="text/javascript">
    function actualizaTotal(){
        var tot=0
        $(".subtotal").each(function(){
            tot+=$(this).html()*1
        })
        $("#total").html(number_format(tot,2,".",""))
    }

    $("#ver").click(function () {
        location.href = "${g.createLink(action: 'verRol')}/?mes=" + $("#meses").val() + "&anio=" + $("#anios").val();
    });
    $("#imprimir").click(function () {
        location.href = "${g.createLink(controller: 'reporteRol', action: 'imprimirLista')}/?mes=" + $("#meses").val() + "&anio=" + $("#anios").val();
    });
    $("#imprimirDet").click(function () {
        location.href = "${g.createLink(controller: 'reporteRol', action: 'imprimirDetalles')}/?mes=" + $("#meses").val() + "&anio=" + $("#anios").val();
    });
    $("#registrar").click(function () {
        if (confirm("Esta seguro? una vez registrado el rol no podrá hacer cambios")) {
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'rubro',action: 'registrarRol')}",
                data    : "rol=${rol?.id}",
                success : function (msg) {
                    $(this).remove()
                    window.location.reload(true)
                }
            });
        }
    });

    $(".detalle").click(function () {
        $("#etiqueta").val($(this).attr("eti"))
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'rubro',action: 'getDetalle')}",
            data    : "rol=${rol?.id}&emp=" + $(this).attr("id"),
            success : function (msg) {
                //console.log(msg)
                $("#body-dlg-rol").html(msg)
                $("#dlg-rol").modal("show")

            }
        });
    });

    $(".imprimir").click(function () {
        location.href = "${g.createLink(controller: 'reporteRol', action: 'imprimirDetalle')}/?rol=${rol?.id}&emp=" + $(this).attr("id");
    });

</script>
</body>
</html>