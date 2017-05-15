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
        <input type="text" class=" form-control label-shared" style="width: 150px" name="codigo" id="codigoBus"/>
    </div>
    <div class="col-xs-3 negrilla">
        Nombre:
        <input type="text" class=" form-control label-shared" style="width: 150px" name="nombreBus" id="nombreBus"/>
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

    $("#buscarM").click(function (){
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
    });

</script>