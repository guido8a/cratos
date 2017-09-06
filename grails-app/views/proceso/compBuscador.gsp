<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 24/07/17
  Time: 15:38
--%>

<div class="row" style="margin-bottom: 10px">
    <div class="col-xs-3 negrilla">
        Documento:
        <input type="text" class=" form-control label-shared number" style="width: 150px" name="numeroC_name" id="numeroC"/>
    </div>
    <div class="col-xs-6 negrilla">
        Concepto:
        <input type="text" class=" form-control label-shared" style="width: 350px" name="descripcionC_name" id="descripcionC"/>
    </div>
    <div class="col-xs-2 negrilla">
        <input type="hidden" name="movimientos" value="1"/>
        <a href="#" class="btn btn-azul btnBuscarC"  id="buscarC">
            <i class="fa fa-search"></i>
            Buscar
        </a>
    </div>
</div>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr>
        <th style="width: 150px">Nombre</th>
        <th style="width: 300px">Concepto</th>
        <th style="width: 150px">Documento</th>
        <th style="width: 70px">Por Pagar</th>
        <th style="width: 70px">Pagado</th>
        <th style="width: 70px">Saldo</th>
        <th style="width: 50px"><i class="fa fa-pencil"></i> </th>
    </tr>
    </thead>
</table>

<div class="row-fluid"  style="width: 99.7%;height: 350px;overflow-y: auto;float: right;margin-bottom: 20px">
    <div class="span12" id="divCargarComprobante">

    </div>
</div>

<script type="text/javascript">

    cargarTablaBusqueda(null, null);

    $(".btnBuscarC").click(function () {
        var desc = $("#descripcionC").val();
        var numero = $("#numeroC").val();
        cargarTablaBusqueda(desc,numero)
    });

    function cargarTablaBusqueda (desc,num) {
        openLoader("Buscando");
        $.ajax({
            type:'POST',
            url: '${createLink(controller: 'proceso', action: 'tablaBuscarComp_ajax')}',
            data:{
                proveedor: '${proveedor?.id}',
                tipo: '${tipo?.id}',
                numero: num,
                descripcion : desc
            },
            success: function (msg) {
                closeLoader();
                $("#divCargarComprobante").html(msg)
            }
        });
    }

    $("#numeroC, #descripcionC").keyup(function (ev) {
        if (ev.keyCode == 13) {
            var desc = $("#descripcionC").val();
            var numero = $("#numeroC").val();
            cargarTablaBusqueda(desc,numero)
        }
    });



</script>


