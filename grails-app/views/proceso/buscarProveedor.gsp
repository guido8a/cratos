<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
 <table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr>
        <th style="width: 20px"><i class="fa fa-check"></i></th>
        <th style="width: 37px">RUC</th>
        <th style="width: 190px">Nombre</th>
        <th style="width: 40px">Tipo</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${prve}" var="p">
        <tr>
            <td style="width: 20px">
                <a href="#" class="btn_bsc btn btn-success" id="${p.id}" ruc="${p.ruc}" nombre="${p?.nombre}"
                    title="Seleccionar">
                    <i class="fa fa-check"></i>
                </a>
            </td>
            <td style="width: 37px">${p.ruc}</td>
            <td style="width: 190px">${p.nombre}</td>
            <td style="width: 40px">${p.tipoProveedor}</td>
        </tr>
    </g:each>
    </tbody>

</table>

<script type="text/javascript">
    $(".btn_bsc").click(function(){
        $("#prve").val($(this).attr("ruc"))
        $("#prve_nombre").val($(this).attr("nombre"))
        $("#prve_id").val($(this).attr("id"))
        $("#prve__id").val($(this).attr("id"))

        $('#modal-proveedor').modal('hide')
        $("#btnBuscarComp").removeClass('hidden')

//        console.log("carga sustento desde buscarProveedor");
        if($("#tipoProceso").val() == '1') {
            cargarSstr($(this).attr("id"))
        } else {
            if($("#tipoProceso").val() == '2')
                cargarTcsr($(this).attr("id"))
        }
    });
</script>