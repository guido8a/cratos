<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 04/09/17
  Time: 11:07
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 16/08/17
  Time: 10:32
--%>

<div class="row" style="margin-bottom: 10px">
    <div class="col-xs-4 negrilla">
        Número:
        <input type="text" class=" form-control label-shared" style="width: 200px" name="numero_name" id="numeroCuenta"/>
    </div>
    <div class="col-xs-5 negrilla">
        Descripción:
        <input type="text" class=" form-control label-shared" style="width: 250px" name="desc_name" id="descCuenta"/>
    </div>
    <div class="col-xs-3 negrilla">
        <a href="#" class="btn btn-azul btnBuscarCuenta">
            <i class="fa fa-search"></i>
            Buscar
        </a>
        <a href="#" class="btn btn-warning btnLimpiar" title="Limpiar Búsqueda">
            <i class="fa fa-eraser"></i>
            Limpiar
        </a>
    </div>
</div>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr>
        <th style="width: 50px">Número</th>
        <th style="width: 250px">Descripción</th>
        <th style="width: 30px"><i class="fa fa-check"></i></th>
    </tr>
    </thead>
</table>

<div class="row-fluid"  style="width: 99.7%;height: 250px;overflow-y: auto;float: right;">
    <div class="span12">
        <div id="divTablaCuentas" style="width: 1030px; height: 250px;"></div>
    </div>
</div>

<script type="text/javascript">

    $(".btnLimpiar").click(function () {
        $("#numeroCuenta").val('');
        $("#descCuenta").val('');
        tablaCuentas(null, null);
    });

    tablaCuentas(null, null);

    $(".btnBuscarCuenta").click(function () {
        var numero = $("#numeroCuenta").val();
        var desc = $("#descCuenta").val();
        tablaCuentas(numero, desc);
    });

    function tablaCuentas (numero, desc){
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'cuenta', action: 'tablaCuentas_ajax')}',
            data:{
                numero: numero,
                desc: desc
            },
            success: function (msg) {
                $("#divTablaCuentas").html(msg)
            }
        });
    }



</script>

