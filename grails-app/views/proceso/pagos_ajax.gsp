<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 10/05/17
  Time: 11:54
--%>


<div class="row" style="margin-bottom: 10px">
    <div class="col-xs-2 negrilla" style="width: 140px">
        Tipo de pago:
    </div>
    <div class="col-xs-6 negrilla" style="margin-left: -20px" id="divSelF">
        %{--<g:select name="tipoPago.id" id="comboFP" class=" form-control" from="${lista}" label="Tipo de pago: " optionKey="id"  optionValue="descripcion" />--}%
    </div>
    <div class="col-xs-1 negrilla" style="width: 140px">
        <a href="#" id="agregarForma" class="btn btn-azul">
            <i class="fa fa-plus"></i>
            Agregar
        </a>
    </div>
</div>

<div class="row" id="divTablaPagos" >
</div>

<script type="text/javascript">

    if('${proceso?.id}'){
        cargarFormasPago('${proceso?.id}');
        cargarSelFormas ('${proceso?.id}')
    }

    function cargarFormasPago(proceso) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'tablaPagos_ajax')}',
            data:{
                proceso: proceso
            },
            success: function (msg) {
                $("#divTablaPagos").html(msg)
            }
        });
    }

    function cargarSelFormas (proceso) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'listaFormas_ajax')}',
            data:{
                proceso: proceso
            },
            success: function (msg) {
                $("#divSelF").html(msg)
            }
        });
    }

    $("#agregarForma").click(function () {
        var idForma = $(".comboF option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'agregarFormaPago_ajax')}',
            data:{
                proceso: '${proceso?.id}',
                forma: idForma
            },
            success: function (msg) {
                if(msg == 'ok'){
                    cargarFormasPago('${proceso?.id}');
                    cargarSelFormas ('${proceso?.id}')
                }
            }
        });
    });


</script>