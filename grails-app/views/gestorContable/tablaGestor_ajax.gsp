<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 03/05/17
  Time: 10:51
--%>

<style type="text/css">
.largo{
    width: 80px;
}
</style>

<table class="table table-bordered table-hover table-condensed">
    <tbody>
    <g:set var="por" value="${0}" />
    <g:set var="imp" value="${0}" />
    <g:set var="val" value="${0}" />
    <g:set var="porH" value="${0}" />
    <g:set var="impH" value="${0}" />
    <g:set var="valH" value="${0}" />
    <g:if test="${movimientos}">
        <g:each in="${movimientos}" var="genera" status="i">
            <tr style="background-color: ${(genera.tipoComprobante.id.toInteger() == 1)?'#D4E6FC':((genera.tipoComprobante.id.toInteger() == 2)?'#99CC99':'#FFCC99')} !important; " class="movimiento">
            <td style="width: 285px;">${genera.cuenta.numero}<span style="font-size: 12px"> (${genera.cuenta.descripcion})</span></td>
            <g:if test="${genera.debeHaber=='D'}">
                <td class="largo"><g:textField type="number" name="porcentaje" id="por_${genera?.id}" class="validacionNumero form-control" style="width: 80px;" value="${genera.porcentaje ?: 0}" /></td>
                <td class="largo"><g:textField type="number" name="porcentaje" id="sin_${genera?.id}" class="validacionNumero form-control" style="width: 80px;" value="${genera.baseSinIva ?: 0}" /></td>
                <td class="largo"><g:textField type="number" name="impuestos" id="imp_${genera?.id}" class="validacionNumero form-control" style="width: 70px;" value="${genera.porcentajeImpuestos?:0}" /></td>
                <td class="largo"><g:textField type="number" name="valor" id="val_${genera?.id}" class="validacionNumero form-control" style="width: 80px;" value="${genera.valor?:0}" /></td>
                <td class="largo"></td>
                <td class="largo"></td>
                <td class="largo"></td>
                <td class="largo"></td>
                <td style="width: 70px">
                    <g:if test="${gestor?.estado != 'R'}">

                        <div class="btn-group">
                            <a href="#" class="btn btn-success btn-sm btnGuardarMovi" cuenta="${genera?.id}" iden="${i}" title="Guardar cambios">
                                <i class="fa fa-save"></i>
                            </a>
                            <a href="#" class="btn btn-danger btn-sm btnEliminarMovi" cuenta="${genera?.id}" title="Eliminar movimiento">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>

                    </g:if>
                </td>
                </tr>
                <g:set var="por" value="${por+genera.porcentaje?:0}" />
                <g:set var="imp" value="${imp+genera.porcentajeImpuestos?:0}" />
                <g:set var="val" value="${val+genera.valor?:0}" />
            </g:if>
            <g:else>
                <td class="largo"></td>
                <td class="largo"></td>
                <td class="largo"></td>
                <td class="largo"></td>
                <td class="largo"><g:textField type="number" name="porcentajeDown" id="por_${genera?.id}" class="validacionNumero form-control" style="width: 80px;" value="${genera.porcentaje ?: 0}" /></td>
                <td class="largo"><g:textField type="number" name="porcentajeDown" id="sin_${genera?.id}" class="validacionNumero form-control" style="width: 80px;" value="${genera.baseSinIva ?: 0}" /></td>
                <td class="largo"><g:textField type="number" name="impuestos" id="imp_${genera?.id}" class="validacionNumero form-control" style="width: 70px;" value="${genera.porcentajeImpuestos?:0}" /></td>
                <td class="largo"><g:textField type="number" name="valor" id="val_${genera?.id}" class="validacionNumero form-control" style="width: 80px;" value="${genera.valor?:0}" /></td>
                <td style="width: 70px">
                    <g:if test="${gestor?.estado != 'R'}">
                        <div class="btn-group">
                            <a href="#" class="btn btn-success btn-sm btnGuardarMovi" cuenta="${genera?.id}" iden="${i}" title="Guardar cambios">
                                <i class="fa fa-save"></i>
                            </a>
                            <a href="#" class="btn btn-danger btn-sm btnEliminarMovi" title="Eliminar movimiento" cuenta="${genera?.id}" nombreCuenta="${genera?.cuenta?.descripcion}">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </g:if>
                </td>
                <g:set var="porH" value="${porH+genera.porcentaje?:0}" />
                <g:set var="impH" value="${impH+genera.porcentajeImpuestos?:0}" />
                <g:set var="valH" value="${valH+genera.valor?:0}" />
            </g:else>
        </g:each>
    </g:if>
    <g:else>
        <tr class="danger text-center">
            <td colspan="6">Sin movimientos contables.</td>
        </tr>
    </g:else>

    </tbody>
</table>

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

    $(".btnEliminarMovi").click(function () {
        var genera = $(this).attr('cuenta');
        var gestor = '${gestor?.id}';
        var tipo = '${tipo?.id}';
        var generaNombre = $(this).attr('nombreCuenta');
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar esta cuenta?. </p>" ,
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash-o'></i> Borrar",
                    className : "btn-danger",
                    callback  : function () {
                        openLoader("Eliminando");
                        $.ajax({
                            type: 'POST',
                            url:'${createLink(controller: 'gestorContable', action: 'borrarCuenta_ajax')}',
                            data:{
                                genera: genera
                            },
                            success: function (msg) {
                                if(msg == 'ok'){
                                    closeLoader();
                                    cargarMovimientos(gestor, tipo);
                                    cargarTotales(gestor, tipo);
                                    log("Cuenta borrada correctamente","success");
                                }else{
                                    closeLoader();
                                    cargarMovimientos(gestor, tipo);
                                    cargarTotales(gestor, tipo);
                                    log("Error al borrarla cuenta!.","error");
                                }
                            }
                        });
                    }
                }
            }
        });
    });

    $(".btnGuardarMovi").click(function () {
        var genera = $(this).attr('cuenta');
        var porcentaje = $("#por_"+ genera).val();
        var impuesto = $("#imp_"+ genera).val();
        var valor = $("#val_"+ genera).val();
        var gestor = '${gestor?.id}';
        var tipo = '${tipo?.id}';
        var sinIva = $("#sin_" + genera).val();

        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'gestorContable', action: 'guardarValores_ajax')}',
            data:{
                genera: genera,
                porcentaje: porcentaje,
                impuesto: impuesto,
                valor: valor,
                sinIva: sinIva
            },
            success: function (msg){
                if(msg == 'ok'){
                    log("Valores guardados correctamente","success");
                    cargarMovimientos(gestor, tipo);
                    cargarTotales(gestor, tipo);
                }else{
                    log("Error al guardar los valores!","error");
                }
            }
        });

    });


</script>