<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 17/08/17
  Time: 12:43
--%>

<table class="table table-bordered table-hover table-condensed" width="1000px">
    <tbody>
    <g:each in="${reembolsos}" var="reembolso">
        <tr>
            <td width="150px">${reembolso?.proveedor?.nombre}</td>
            <td width="150px">${reembolso?.tipoCmprSustento?.tipoComprobanteSri?.descripcion}</td>
            <td width="80px">${reembolso?.reembolsoEstb + " - " + reembolso?.reembolsoEmsn + " - " + reembolso?.reembolsoSecuencial}</td>
            <td width="100px">${reembolso?.valor ?: 0.00}</td>
            <td width="45px"></td>
        </tr>
    </g:each>
    </tbody>
</table>