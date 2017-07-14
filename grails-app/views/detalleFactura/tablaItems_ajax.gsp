<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 07/07/17
  Time: 10:02
--%>

<table class="table table-bordered table-hover table-condensed">
    <tbody>
    <g:each in="${items}" var="item">
        <tr>
            <td style="width: 80px">${item?.codigo}</td>
            <td style="width: 270px">${item?.nombre}</td>
            <td style="width: 90px">${item?.precioVenta}</td>
            <td style="width: 50px; text-align: center">
                <a href="#" class="btn btn-success btnAgregarItem"
                   title="Agregar Item" codigo="${item?.codigo}" nombre="${item?.nombre}" precio="${item?.precioVenta}" idI="${item?.id}"><i class="fa fa-check"></i></a> </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $(".btnAgregarItem").click(function () {
        var codigo = $(this).attr('codigo');
        var nombre = $(this).attr('nombre');
        var precio = $(this).attr('precio');
        var idI = $(this).attr('idI');
        $("#codigoItem").val(codigo);
        $("#nombreItem").val(nombre);
        $("#precioItem").val(precio);
        $("#idItem").val(idI);
        $("#cantidadItem").val(1);
        $("#descuentoItem").val(0);
        bootbox.hideAll();
     });

</script>