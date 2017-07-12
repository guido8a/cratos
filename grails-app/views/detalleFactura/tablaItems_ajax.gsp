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
            <td style="width: 150px">${item?.codigo}</td>
            <td style="width: 250px">${item?.nombre}</td>
            <td style="width: 70px">${item?.precioVenta}</td>
            <td style="width: 50px">  <a href="#" class="btn btn-success" id="btnAgregarItem"><i class="fa fa-check"></i></a> </td>
        </tr>
    </g:each>
    </tbody>
</table>