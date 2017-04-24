<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 10/17/12
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Conciliación bancaria</title>


        <style type="text/css">
        th {
            text-align : center;
        }
        </style>
    </head>

    <body>
        <elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

        <g:form action="validarPagoAux" name="frmValidarPagoAux">
            <div class="vertical-container vertical-container-list">
                <p class="css-vertical-text">Conciliación bancaria</p>

                <div class="linea"></div>
                <table class="table table-condensed table-bordered table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Factura</th>
                            <th>Tipo Documento</th>
                            <th>Referencia</th>
                            <th>Valor</th>
                            <th>Validar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:if test="${pagos.size() > 0}">
                            <g:each in="${pagos}" var="pago" status="i">
                                <tr>
                                    <td>
                                        <g:formatDate date="${pago.fecha}" format="dd-MM-yyyy"/>
                                    </td>
                                    <td>
                                        ${pago.factura}
                                    </td>
                                    <td>
                                        ${pago.tipoDocumento.descripcion}
                                    </td>
                                    <td>
                                        ${pago.referencia}
                                    </td>
                                    <td style="text-align:right;">
                                        <g:formatNumber number="${pago.monto}" minFractionDigits="2" maxFractionDigits="2"/>
                                    </td>
                                    <td style="text-align:center;">
                                        <g:checkBox name="${pago.id}"/>
                                    </td>
                                </tr>
                            </g:each>
                        </g:if>
                        <g:else>
                            <tr class="danger text-center">
                                <td colspan="6">No se encontraron pagos.</td>
                            </tr>
                        </g:else>
                    </tbody>
                </table>

                <div class="row">

                    <div class="col-md-6">
                        <g:if test="${pagos.size() > 0}">
                            <a href="#" class="btn btn-success btnGuardar"><i class="fa fa-save"></i> Guardar</a>
                        </g:if>
                    </div>
                </div>
            </div>
        </g:form>


        <script type="text/javascript">
            $(function () {
                $(".btnGuardar").click(function () {
                    $("#frmValidarPagoAux").submit();
                });
            });
        </script>

    </body>
</html>