<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 20/08/18
  Time: 15:04
--%>

    <table class="table table-bordered table-hover table-condensed" style="margin-top: 1px">
        <tbody>
        <g:each in="${detalles}" status="i" var="detalle">
            <tr data-id="${detalle.id}">
                <td class="centrado" style="width: 50%">${detalle?.empleado?.persona?.nombre + " " + detalle?.empleado?.persona?.apellido}</td>
                <td class="centrado" style="width: 25%">${detalle?.rubroTipoContrato?.rubro?.descripcion}</td>
                <td class="centrado" style="width: 25%">${detalle?.valor}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
