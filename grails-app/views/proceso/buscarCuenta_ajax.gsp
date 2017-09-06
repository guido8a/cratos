<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 12/05/17
  Time: 11:29
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 03/05/17
  Time: 12:40
--%>

<div class="row" style="margin-bottom: 10px">
    <div class="col-xs-3 negrilla">
        C&oacute;digo:
        <input type="text" class="form-control label-shared validacionNumeroSinPuntos" style="width: 150px" name="codigo_name" id="codigoBus"/>
    </div>
    <div class="col-xs-5 negrilla">
        Nombre:
        <input type="text" class=" form-control label-shared" style="width: 350px" name="nombre_name" id="nombreBus"/>
    </div>
    <div class="col-xs-2 negrilla">
        <input type="hidden" name="movimientos" value="1"/>
        <a href="#" class="btn btn-azul"  id="buscarM">
            <i class="fa fa-search"></i>
            Buscar
        </a>
    </div>
</div>


<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr>
        <th style="width: 30px">C&oacute;digo</th>
        <th style="width: 230px">Nombre</th>
        <th style="width: 10px">Nivel</th>
        <th style="width: 30px">Acciones</th>
    </tr>
    </thead>
</table>

<div class="row-fluid"  style="width: 99.7%;height: 250px;overflow-y: auto;float: right;">
    <div class="span12">
        <div id="divTablaCuentas" style="width: 1030px; height: 250px;"></div>
    </div>
</div>

<script type="text/javascript">

    function validarNumSinPuntos(ev) {
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
        ev.keyCode == 37 || ev.keyCode == 39 );
    }


    $(".validacionNumeroSinPuntos").keydown(function (ev) {
        return validarNumSinPuntos(ev);
    }).keyup(function () {
//        return validarNumSinPuntos(ev);
    });

    cargarBuscarCuenta();

    $("#buscarM").click(function (){
        cargarBuscarCuenta();
    });

    function cargarBuscarCuenta () {
        var cod = $("#codigoBus").val();
        var nom = $("#nombreBus").val();
        var empresa = ${empresa?.id}
            openLoader("Buscando");
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'tablaBuscarCuenta_ajax')}",
            data:{
                codigo: cod,
                nombre: nom,
                empresa: empresa
            },
            success: function (msg){
                closeLoader();
                $("#divTablaCuentas").html(msg)
            }
        });
    }


    $("#codigoBus, #nombreBus").keyup(function (ev) {
        if (ev.keyCode == 13) {
            cargarBuscarCuenta();
        }
    });



</script>