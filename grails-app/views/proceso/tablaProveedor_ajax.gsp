<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 16/08/17
  Time: 10:45
--%>

<table class="table table-bordered table-hover table-condensed" width="1000px">
    <tbody>
    <g:each in="${prve}" var="p">
        <tr>
            <td style="width: 30px">${p.ruc}</td>
            <td style="width: 230px">${p.nombre}</td>
            <td style="width: 50px">${p.tipoProveedor}</td>
            <td style="width: 20px; text-align: center">
                <a href="#" class="btn_bsc btn btn-success btn-selPro" id="${p.id}" ruc="${p.ruc}" nombre="${p?.nombre}"
                   title="Seleccionar">
                    <i class="fa fa-check"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $(".btn-selPro").click(function () {
        var ruc = $(this).attr('ruc');
        var nombre = $(this).attr('nombre');
        var id = $(this).attr('id')
        $("#prvePro").val(ruc)
        $("#prve_nombrePro").val(nombre)
        $("#prve_idPro").val(id)

        $("#dlgBuscarPro").hide()
        cargarTcsr(id)
    });

    function cargarTcsr(prve) {
        var tptr = '${proceso?.tipoProceso?.id}';
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'cargaTcsr')}",
            data: {
                tptr: tptr,
                prve: prve,
                sstr: "${proceso?.sustentoTributario?.id}",
                tpcp: "${proceso?.tipoCmprSustento?.id}",
                etdo: 'N',
                esta: '1'
            },
            success: function (msg) {
                $("#divComprobanteSustento").html(msg)
                $("#divComprobanteSustento").show()
            }
        });
    };

</script>