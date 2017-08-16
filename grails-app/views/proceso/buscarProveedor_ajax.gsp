<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 16/08/17
  Time: 10:32
--%>

<div class="row" style="margin-bottom: 10px">
    <div class="col-xs-4 negrilla">
        RUC:
        <input type="text" class=" form-control label-shared" style="width: 200px" name="codigo" id="rucPro"/>
    </div>
    <div class="col-xs-4 negrilla">
        Nombre:
        <input type="text" class=" form-control label-shared" style="width: 250px" name="nombreBus" id="nombrePro"/>
    </div>
    <div class="col-xs-2 negrilla">
        <input type="hidden" name="movimientos" value="1"/>
        <a href="#" class="btn btn-azul btnBuscarPro">
            <i class="fa fa-search"></i>
            Buscar
        </a>
    </div>
</div>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr>
        <th style="width: 73px">RUC</th>
        <th style="width: 147px">Nombre</th>
        <th style="width: 60px">Tipo</th>
        <th style="width: 30px"><i class="fa fa-check"></i></th>
    </tr>
    </thead>
</table>

<div class="row-fluid"  style="width: 99.7%;height: 250px;overflow-y: auto;float: right;">
    <div class="span12">
        <div id="divTablaProveedor" style="width: 1030px; height: 250px;"></div>
    </div>
</div>

<script type="text/javascript">

    buscarProveedor(null, null);

    $(".btnBuscarPro").click(function () {
        var nombre = $("#nombrePro").val();
        var ruc = $("#rucPro").val();
       buscarProveedor(ruc, nombre);
    });

    function buscarProveedor (ruc, nom){
        $.ajax({
           type: 'POST',
            url:'${createLink(controller: 'proceso', action: 'tablaProveedor_ajax')}',
            data:{
                proceso: '${proceso?.id}',
                ruc: ruc,
                nom: nom
            },
            success: function (msg) {
                $("#divTablaProveedor").html(msg)
            }
        });
    }



</script>

