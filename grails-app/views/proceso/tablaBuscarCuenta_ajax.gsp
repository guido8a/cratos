<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 12/05/17
  Time: 11:31
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 03/05/17
  Time: 13:11
--%>
<table class="table table-bordered table-hover table-condensed">
    <tbody>
    <g:each in="${cuentas}" var="cuenta">
        <tr>
            <td style="width: 30px">${cuenta.numero}</td>
            <td style="width: 310px">${cuenta.descripcion}</td>
            <td style="width: 20px">${cuenta.nivel.descripcion}</td>
            <td style="width: 90px; text-align: center">
                %{--<a href="#" class="btn btn-success agregarDebe" cuenta="${cuenta.id}" title="Agregar cuenta como Debe">--}%
                    %{--<i class="fa fa-chevron-up"></i>--}%
                    %{--Debe--}%
                %{--</a>--}%
                %{--<a href="#" class="btn btn-info agregarHaber" cuenta="${cuenta.id}" title="Agregar cuenta como Haber">--}%
                    %{--<i class="fa fa-chevron-down"></i>--}%
                    %{--Haber--}%
                %{--</a>--}%
                <a href="#" class="btn btn-info btnAgregarCuenta" cuenta="${cuenta.id}" codigo="${cuenta.numero}" nombre="${cuenta.descripcion}" title="Agregar cuenta ">
                    <i class="fa fa-chevron-down"></i>
                    Agregar
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">
    $(".btnAgregarCuenta").click(function () {
        var cuenta = $(this).attr('cuenta');
        var codigo = $(this).attr('codigo');
        var nombre = $(this).attr('nombre');

        $("#codigoAsiento").val(codigo);
        $("#nombreAsiento").val(nombre);
        $("#idCuentaNueva").val(cuenta);

        $("#dlgBuscarCuenta").modal('hide')
    });
</script>