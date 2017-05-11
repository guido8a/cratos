<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 11/05/17
  Time: 11:30
--%>

<div class="btn-group">
    <g:each in="${comprobantes}" var="comprobante">
        <a href="#" class="btn btn-info btn-sm btnComprobante" idComp="${comprobante.id}" style="margin-bottom: 10px">
            <i class="fa fa-file-text-o"></i> ${comprobante?.tipo?.descripcion}
        </a>
    </g:each>
</div>
<div class="col-md-12" id="divAsientos"style="margin-bottom: 20px">

</div>

<script type="text/javascript">

    $(".btnComprobante").click(function (){
            var id = $(this).attr('idComp');
            cargarAsiento(id)
    });

    if('${comprobantes}'){
        cargarAsiento('${comprobantes.first().id}')
    }

    function cargarAsiento (idComprobante) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'asientos_ajax')}',
            data:{
                comprobante: idComprobante
            },
            success: function (msg) {
                $("#divAsientos").html(msg).show("slide");
            }
        });
    }



</script>



