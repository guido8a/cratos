<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 01/08/17
  Time: 11:19
--%>
<table class="table table-bordered table-hover table-condensed">
    <tbody>
    <g:each in="${centros}" var="centro">
        <tr>
            <td style="width: 170px">${centro?.centroCosto?.nombre}</td>
            <td style="width: 80px; text-align: right">${tipo == '1' ? centro?.debe : centro?.haber}</td>
            <td style="width: 30px;text-align: center">
                <a href="#" class="btn btn-danger btn-sm borrarCost" idcs="${centro?.id}">
                    <i class="fa fa-trash-o"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">
    $(".borrarCost").click(function () {
        var id = $(this).attr('idcs');
        $.ajax({
           type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'borrarCentro_ajax')}',
            data:{
                id: id
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Registro borrado correctamente","success");
                    cargarTablaCentros();
                    actualizarValor();
                    cargarComprobanteP('${asiento?.comprobante?.proceso?.id}');
                }else{
                    log("Error al borrar el registro", "error")
                }
            }
        });
    });
</script>
