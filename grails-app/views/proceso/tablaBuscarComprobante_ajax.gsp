<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 18/05/17
  Time: 14:50
--%>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr>
        <th style="width: 150px">Nombre</th>
        <th style="width: 250px">Concepto</th>
        <th style="width: 70px">Por Pagar</th>
        <th style="width: 70px">Pagado</th>
        <th style="width: 70px">Saldo</th>
        <th style="width: 50px"><i class="fa fa-pencil"></i> </th>
    </tr>
    </thead>
</table>

<div class="row-fluid"  style="width: 99.7%;height: 350px;overflow-y: auto;float: right;margin-bottom: 20px">
    <div class="span12">
        <table class="table table-bordered table-condensed">
            <tbody>
            <g:each in="${res}" var="comprobante">
                <tr>
                    <td style="width: 150px">${comprobante.prvenmbr}</td>
                    <td style="width: 250px">${comprobante.dscr}</td>
                    <td style="width: 70px; text-align: right">${comprobante.hber}</td>
                    <td style="width: 70px; text-align: right">${comprobante.pgdo}</td>
                    <td style="width: 70px; text-align: right">${comprobante.sldo}</td>
                    <td style="width: 50px; text-align: center">
                        <div class="btn-group">
                            <a href="#" class="btn btn-success btn-sm btnSeleccionarComp" idAs="${comprobante.cmpr__id}" des="${comprobante.dscr}" sld="${comprobante.sldo}" title="Seleccionar">
                                <i class="fa fa-check"></i>
                            </a>
                        </div>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>

<script type="application/javascript">

    $(".btnSeleccionarComp").click(function () {
        var descripcion = $(this).attr('des');
        var saldo = $(this).attr('sld');
        var idCom = $(this).attr('idAs');
        $("#comprobanteDesc").val(descripcion);
        $("#comprobanteSaldo").val(saldo);
        $("#comprobanteSel").val(idCom);
        bootbox.hideAll();
    });


</script>