<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 18/12/17
  Time: 10:23
--%>

<table class="table table-bordered table-hover table-condensed" style="width: 100%">
    <thead>
    <tr>
        <th style="width: 65%">Tipo de Pago</th>
        <th style="width: 25%">Plazo</th>
        <th style="width: 10%">Acciones</th>
    </tr>
    </thead>
    <tbody>

    <g:each in="${formasPago}" var="forma">
        <tr style="width: 100%">
            <td style="text-align: left; width: 65%">${forma?.tipoPago?.descripcion}</td>
            <td style="text-align: center; width: 25%">${forma?.plazo}</td>
            <g:if test="${proceso?.estado != 'R'}">
                <td style="text-align: center; width: 10%"><a href="#" class="btn btn-danger btnBorrarFormaPago" data-id="${forma?.id}"><i class="fa fa-trash-o"></i></a></td>
            </g:if>
        </tr>
    </g:each>

    </tbody>
</table>

<script type="text/javascript">

    $(".btnBorrarFormaPago").click(function () {
        var id = $(this).data("id");
        $.ajax({
           type: 'POST',
           url: '${createLink(controller: 'proceso', action: 'borrarFormaPago_ajax')}',
            data:{
               id: id
            },
            success: function (msg){
               if(msg == 'ok'){
                   log("Forma de pago borrada correctamente","success");
                   cargarTablaFormaPago();
               }else{
                   log("Error al borrar la Forma de Pago", "error");
               }
            }
        });
    });

</script>