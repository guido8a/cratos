<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 13/07/17
  Time: 15:00
--%>

<style type="text/css">
.colorAsiento {
    color: #0b0b0b;
    background-color: #5aa6ff;
}
</style>

<table class="table table-bordered table-hover table-condensed">
    <tbody>
    <g:each in="${detalles}" var="detalle">
        <tr style="color:${detalle.item.tipoIVA.id == 2? '#000000' : '#005060'}">
            <td style="width: 90px;">${detalle?.item?.codigo}</td>
            <td style="width: 200px">${detalle?.item?.nombre}</td>
            <td style="width: 50px">${detalle?.bodega?.descripcion}</td>
            <td style="width: 50px">${detalle?.centroCosto?.nombre?.take(5)}</td>
            <td style="width: 30px">${detalle?.item?.unidad}</td>
            <td style="width: 45px; text-align: right">${detalle?.cantidad?.toInteger()}</td>
            <td style="width: 80px; text-align: right"><g:formatNumber number="${detalle?.precioUnitario}" maxFractionDigits="4" minFractionDigits="4"/></td>
            <g:if test="${detalle?.proceso?.tipoProceso?.codigo?.trim() != 'T'}">
                <td style="width: 50px;text-align: right">${detalle?.descuento}</td>
            </g:if>
            <td style="width: 90px;text-align: right"><g:formatNumber number="${detalle?.cantidad * detalle?.precioUnitario}" maxFractionDigits="2" minFractionDigits="2"/></td>
            <g:if test="${truncar}">
                <td style="width: 60px; text-align: center"></td>
            </g:if>
            <g:else>
                <td style="width: 60px; text-align: center">
                    <a href="#" class="btn btn-danger btn-sm btnBorrarItemDetalle"
                       title="Borrar Item" idI="${detalle?.id}"><i class="fa fa-trash-o"></i></a>

                    <a href="#" class="btn btn-success btn-sm btnEditarItem"
                       title="Editar Item"  idI="${detalle?.id}"><i class="fa fa-pencil"></i></a>
                </td>
            </g:else>

        </tr>
    </g:each>
    </tbody>
</table>

<table class="table table-bordered table-hover table-condensed">
    <tbody>
    <tr class="colorAsiento">
        <td style="width: 90px; text-align: right">Tarifa 0%:</td>
        <td style="width: 80px; font-weight: bold">${totl?.basecero + totl?.basenoiv}</td>
        <td style="width: 110px">Tarifa 12%:</td>
        <td style="width: 80px; font-weight: bold">${totl?.base__nz}</td>
        <td style="width: 80px; text-align: right">Descuento:</td>
        <td style="width: 80px; font-weight: bold">${totl?.dsct}</td>
        <td style="width: 40px; text-align: right">IVA:</td>
        <td style="width: 80px; font-weight: bold">${totl?.iva}</td>
        <td style="width: 70px; text-align: right">Flete:</td>
        <td style="width: 80px; font-weight: bold">${totl?.flte}</td>
        <td style="width: 40px; text-align: right">Ice:</td>
        <td style="width: 50px; font-weight: bold">${totl?.ice}</td>
        <td style="width: 60px; text-align: right">Total:</td>
        <td style="width: 80px; font-weight: bold">${totl?.totl}</td>
    </tr>
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
//                $("#cantidadItem").val(parts[4]).attr('readonly', true);
                $("#cantidadItem").val(parts[4]);
                $("#descuentoItem").val(parts[5]);
                $("#bodegas").val(parts[6]);
                $("#centros").val(parts[7]);
                $("#idItem").val(parts[8]);
                $("#totalItem").val((parts[3] * parts[4]).toFixed(2)).attr('readonly',true);
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