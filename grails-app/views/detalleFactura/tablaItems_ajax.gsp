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
            <td style="width: 60px">${item.itemcdgo}</td>
            <td style="width: 210px">${item.itemnmbr}</td>
            <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'V' || proceso?.tipoProceso?.codigo?.trim() == 'NC'}">
                <td style="width: 90px; text-align: right">${item.itempcun}</td>
            </g:if>
            <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'C' || proceso?.tipoProceso?.codigo?.trim() == 'T'}">
                <td style="width: 90px; text-align: right">${item.itempccs}</td>
            </g:if>
            <td style="width: 90px; text-align: center">${item.exst.toInteger()}</td>
           <td style="width: 90px"><g:formatDate date="${item.fcha}" format="dd-MM-yyyy HH:mm"/> </td>
            <td style="width: 50px; text-align: center">
                <a href="#" class="btn btn-success btnAgregarItem"
                   title="Agregar Item" codigo="${item.itemcdgo}" nombre="${item.itemnmbr}" precio="${item.itempcun}" idI="${item.item__id}" costo="${item.itempccs}"><i class="fa fa-check"></i></a> </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $(".btnAgregarItem").click(function () {
        var codigo = $(this).attr('codigo');
        var nombre = $(this).attr('nombre');
        var precio = $(this).attr('precio');
        var precioCosto = $(this).attr('costo');
        var idI = $(this).attr('idI');
        $("#codigoItem").val(codigo);
        $("#nombreItem").val(nombre);
        <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'T'}">
        $("#precioItem").val(precioCosto);
        </g:if>
        <g:else>
        $("#precioItem").val(precio);
        </g:else>
        $("#idItem").val(idI);
        $("#cantidadItem").val(1);
        $("#descuentoItem").val(0);
        $("#totalItem").val(precio);
        bootbox.hideAll();
     });

</script>