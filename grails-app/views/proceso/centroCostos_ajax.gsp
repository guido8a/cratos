<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 01/08/17
  Time: 10:54
--%>

<div class="col-md-12" style="margin-bottom: 10px">
    <div class="col-md-7">
        <label>Centro de Costos</label>
        <g:select from="${cs}" name="selCentro_name" id="selCentro" class="form-control" optionKey="id" optionValue="nombre"/>
    </div>
    <div class="col-md-4">
        <label>Valor</label>
        <g:textField name="vlorCentro_name" id="vlorCentro" class="form-control number vlor" value="${(valor ? valor : 0)}"/>
    </div>
    <div class="col-md-1" style="margin-top: 25px">
        <a href="#" id="agregarCost" class="btn btn-success ${valor == 0 ? 'hidden' : ''}">
            <i class="fa fa-plus"></i>
        </a>
    </div>
    <g:hiddenField name="valor" id="valorNuevo" value="${valor}"/>
</div>

<table class="table-bordered table-condensed table-hover col-md-12">
    <thead>
    <tr>
        <th style="width: 170px">Centro</th>
        <th style="width: 80px">Valor</th>
        <th style="width: 30px"><i class="fa fa-pencil"></i></th>
    </tr>
    </thead>
</table>

<div id="divTablaCentro"></div>

<script type="text/javascript">

    function validarNum(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
        (ev.keyCode >= 96 && ev.keyCode <= 105) ||
        ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
        ev.keyCode == 37 || ev.keyCode == 39 ||
        ev.keyCode == 110 || ev.keyCode == 190);
    }

    $(".vlor").keydown(function (ev) {
        return validarNum(ev);
    }).keyup(function () {

        if($(".vlor").val() == 0){
            $("#agregarCost").addClass('Disabled');
        }else{
            $("#agregarCost").removeClass('Disabled');

        }

        if(parseFloat($(".vlor").val()) > parseFloat($("#valorNuevo").val()) || $(".vlor").val() == ''){
            actualizarValor();
            $("#agregarCost").removeClass('Disabled');
        }

    });

    $("#agregarCost").click(function () {
        var valor = $("#vlorCentro").val();
        var centro = $("#selCentro").val();
        if(valor.split('.').length - 1 > 1){
            bootbox.alert("El número ingresado no es válido!")
        }else{
            $.ajax({
                type: 'POST',
                url:'${createLink(controller: 'proceso', action: 'guardarCentro_ajax')}',
                data:{
                    asiento: '${asiento?.id}',
                    valor: valor,
                    centro: centro,
                    tipo: '${tipo}'
                },
                success: function (msg){
                    if(msg == 'ok'){
                        log("Agregado correctamente","success");
                        cargarTablaCentros();
                        actualizarValor();
                        cargarComprobanteP('${asiento?.comprobante?.proceso?.id}');
                    }else{
                        log("Error al agregar el centro de costos","error")
                    }
                }
            });
        }
    });

    cargarTablaCentros();

    function cargarTablaCentros () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'tablaCentroCostos_ajax')}',
            data:{
                asiento: '${asiento?.id}',
                tipo: '${tipo}'
            },
            success: function (msg){
                $("#divTablaCentro").html(msg)
            }
        });
    }

    function actualizarValor () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'calcularValor_ajax')}',
            data:{
                asiento: '${asiento?.id}',
                tipo: '${tipo}'
            },
            success: function (msg){
                $("#vlorCentro").val(msg);
                $("#valorNuevo").val(msg);
                if(msg == 0){
                    $("#agregarCost").addClass('hidden')
                }else{
                    $("#agregarCost").removeClass('hidden')
                }
            }
        })
    }


</script>