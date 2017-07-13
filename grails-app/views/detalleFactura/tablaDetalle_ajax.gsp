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
            <td style="width: 80px">${detalle?.item?.codigo}</td>
            <td style="width: 270px">${detalle?.item?.nombre}</td>
            <td style="width: 40px">${detalle?.item?.unidad}</td>
            <td style="width: 90px">${detalle?.cantidad}</td>
            <td style="width: 90px">${detalle?.precioUnitario}</td>
            <g:if test="${detalle?.proceso?.tipoProceso?.id == 1}">
                <td style="width: 90px">${detalle?.descuento}</td>
            </g:if>
            <td style="width: 50px; text-align: center">
                <a href="#" class="btn btn-danger btn-sm btnBorrarItem"
                   title="Borrar Item"  idI="${detalle?.id}"><i class="fa fa-trash-o"></i></a> </td>
        </tr>
    </g:each>
    </tbody>
</table>