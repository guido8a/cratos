<style type="text/css">

.tab-pane {

    border-left: 1px solid #ddd;
    border-right: 1px solid #ddd;
    border-bottom: 1px solid #ddd;
    border-radius: 0px 0px 5px 5px;
    background-color: #eeeeee;
}

.nav-tabs {
    margin-bottom: 0;
}

</style>

<ul class="nav nav-tabs">
    <g:each in="${comprobantes}" var="comprobante" status="j">
    <li class="${j == 0 ? 'active' : ''}"><a data-toggle="tab" href="#" class="btnComprobante" idComp="${comprobante?.id}">${comprobante?.tipo?.descripcion}</a></li>
    </g:each>
</ul>

<div class="tab-content">
    <div class="tab-pane fade in active">
        <div class="col-md-12" id="divBotones" style="margin-top: 20px"></div>
        <div class="col-md-12" id="divAsientos"style="margin-bottom: 10px;"></div>
    </div>
</div>

<script type="text/javascript">

    $(".btnComprobante").click(function (){
        var id = $(this).attr('idComp');
        cargarAsiento(id);
        cargarBotones(id);
    });

    <g:if test="${comprobantes}">
    cargarAsiento('${comprobantes?.first()?.id}');
    cargarBotones('${comprobantes?.first()?.id}');
    </g:if>

    function cargarAsiento (idComprobante) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'asientos_ajax')}',
            data:{
                comprobante: idComprobante,
                proceso: '${proceso?.id}'
            },
            success: function (msg) {
                $("#divAsientos").html(msg).show("slide");
            }
        });
    }

    function cargarBotones (idComprobante) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'botonesMayo_ajax')}',
            data:{
                comprobante: idComprobante,
                proceso: '${proceso?.id}'
            },
            success: function (msg) {
                $("#divBotones").html(msg).show("slide");
            }
        });
    }

</script>