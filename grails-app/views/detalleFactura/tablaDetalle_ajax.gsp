<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 13/07/17
  Time: 15:00
--%>

<table class="table table-bordered table-hover table-condensed">
    <tbody>
    <g:each in="${detalles}" var="detalle">
        <tr>
            <td style="width: 70px">${detalle?.item?.codigo}</td>
            <td style="width: 190px">${detalle?.item?.nombre}</td>
            <td style="width: 50px" title="${detalle?.bodega?.descripcion}">${detalle?.bodega?.descripcion}</td>
            <td style="width: 50px" title="${detalle?.centroCosto?.nombre}">${detalle?.centroCosto?.nombre?.substring(10)}</td>
            <td style="width: 20px">${detalle?.item?.unidad}</td>
            <td style="width: 40px">${detalle?.cantidad?.toInteger()}</td>
            <td style="width: 90px"><g:formatNumber number="${detalle?.precioUnitario}" maxFractionDigits="4" minFractionDigits="4"/></td>
            <g:if test="${detalle?.proceso?.tipoProceso?.id == 1}">
                <td style="width: 50px">${detalle?.descuento}</td>
            </g:if>
            <td style="width: 80px"><g:formatNumber number="${detalle?.cantidad * detalle?.precioUnitario}" maxFractionDigits="2" minFractionDigits="2"/></td>
            <td style="width: 60px; text-align: center">
                <a href="#" class="btn btn-danger btn-sm btnBorrarItemDetalle"
                   title="Borrar Item" idI="${detalle?.id}"><i class="fa fa-trash-o"></i></a>

                <a href="#" class="btn btn-success btn-sm btnEditarItem"
                   title="Editar Item"  idI="${detalle?.id}"><i class="fa fa-pencil"></i></a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $(".btnEditarItem").click(function () {
        var det = $(this).attr('idI');
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'detalleFactura', action: 'cargarEdicion_ajax')}',
            data:{
                detalle: det
            },
            success: function (msg) {
                var parts = msg.split("_");
                $("#idDetalle").val(parts[0]);
                $("#codigoItem").val(parts[1]);
                $("#nombreItem").val(parts[2]);
                $("#precioItem").val(parts[3]);
                $("#cantidadItem").val(parts[4]);
                $("#descuentoItem").val(parts[5]);
                $("#bodegas").val(parts[6]);
                $("#centros").val(parts[7]);
                $("#idItem").val(parts[8]);
                $("#btnBuscar").addClass('hidden');
                $("#btnAgregar").addClass('hidden');
                $("#btnGuardar").removeClass('hidden');
                $("#btnCancelar").removeClass('hidden');
            }
        });

    });


        $(".btnBorrarItemDetalle").click(function () {
            var det = $(this).attr('idI');
            bootbox.confirm("Está seguro que desea borrar el item del detalle de la factura?", function (result) {
                if (result) {
                    $.ajax({
                        type:'POST',
                        url:'${createLink(controller: 'detalleFactura', action: 'borrarItemDetalle_ajax')}',
                        data:{
                            detalle: det
                        },
                        success: function (msg){
                            if(msg == 'ok'){
                                log("Item borrado correctamente", "success");
                                cargarTablaDetalle();
                            }else{
                                log("Error al borrar el item al detalle","error");
                            }
                        }
                    });
                }
            });
        });




</script>