<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 10/05/17
  Time: 12:53
--%>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr>
        <th>Forma de Pago</th>
        <th><i class="fa fa-trash-o"></i></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${formas}" var="f">
        <tr>
            <td>${f?.tipoPago?.descripcion}</td>
            <td style="text-align: center">
                <a href="#" class="btn btn-danger borrarFormaPago" idForma="${f?.id}" title="Eliminar forma de pago">
                    <i class="fa fa-trash-o"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $(".borrarFormaPago").click(function () {
        var idF = $(this).attr('idforma');
            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'proceso', action: 'borrarFormaPago_ajax')}",
                data:{
                    id: idF
                },
                success: function (msg){
                    if(msg == 'ok'){
                        cargarFormasPago('${proceso?.id}');
                        cargarSelFormas ('${proceso?.id}');
                        cargarPagosMain('${proceso?.id}');
                    }else{
                        log("Error al borrar la forma de pago","error")
                    }

                }
            })
    });

</script>
