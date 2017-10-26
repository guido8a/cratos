<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Comprobante</title>

    <rep:estilos orientacion="p" pagTitle="${"Comprobante"}"/>


    <style type="text/css">

    .even {
        background: #B7C4F7;
    }

    .odd {
        background: #FCFDFF
    }

    table {
        border-collapse: collapse;
    }

    .item {
        border-bottom: solid 2px #555;
    }

    .table th {
        background     : #5d6263;
        text-align     : center;
        text-transform : uppercase;
    }
    .table {
        margin-top      : 0.5cm;
        width           : 100%;
        border-collapse : collapse;
    }

    .table, .table td, .table th {
        border : solid 1px #444;
    }

    .table td, .table th {
        padding : 3px;
    }

    .odd{
        background: #ffecd2;
    }
    .even{
        background: #e7e6ea;
    }
    </style>
</head>

<body>


<rep:headerFooter title="${'Comprobante ' + (proceso?.tipoProceso?.codigo?.trim() == 'P' ? 'Egreso' : proceso?.tipoProceso?.codigo?.trim() == 'I' ? 'Ingreso' : '') }" subtitulo="${'Datos'}" empresa="${empresa?.id}"/>




    <div class="hoja">

        <g:each in="${comp}" var="item">
            <g:set var="val" value="${item.value}"/>
            <table style="width: 600px;">
                <tr>
                    <td width="400px" height="50px" >
                        <b>Número:</b> ${item.key} ${(comprobante.registrado=="B")?" Anulado":""}
                    </td>

                    <td>
                        <b>Fecha:</b>
                        ${val.fecha?.format("dd/MM/yyyy")}
                    </td>
                </tr>
                <tr>
                    <td height="50px">
                        <b>Descripción:</b> ${val.descripcion}
                    </td>
                    <td>
                        <b>Tipo: </b>${val.tipo}
                    </td>
                </tr>
            </table>

            <table border="1" style="width: 600px;">
                <tr>
                    <th style="width: 140px" align="center" class="ui-state-focus">
                        Número
                    </th>
                    <th style="width: 360px" align="center" class="ui-state-focus">
                        Cuenta
                    </th>
                    <th style="width: 60px" align="center" class="ui-state-focus">
                        Debe
                    </th>
                    <th style="width: 60px" align="center" class="ui-state-focus">
                        Haber
                    </th>
                </tr>

                <g:set var="totalDebe"  value="${0}"/>
                <g:set var="totalHaber" value="${0}"/>

                <g:each in="${val.items}" var="i" status="j" >
                    <g:if test="${i.debe+i.haber>0}">
                        <tr>
                            <td>
                                ${i.cuenta}
                            </td>
                            <td>
                                ${i.descripcion}
                            </td>
                            <td align="right">
                                ${i.debe}
                            </td>
                            <td align="right">
                                ${i.haber}
                            </td>
                            <g:set var="totalDebe" value="${totalDebe + i.debe}"/>
                            <g:set var="totalHaber" value="${totalHaber +i.haber}"/>
                        </tr>
                    </g:if>
                </g:each>

                <tr>
                    <td>
                    </td>
                    <td align="center">
                        TOTAL:

                    </td>
                    <td align="right">
                        ${totalHaber.toDouble().round(2)}
                    </td>
                    <td align="right">
                        ${totalDebe.toDouble().round(2)}
                    </td>
                </tr>
            </table>
        </g:each>

        <g:each in="${tipoComprobante}" var="i">
            <g:if test="${i == 'D'}">
                <table style="width: 600px; margin-top: 50px">
                    <tr>
                        <td width="400px" style="text-align: center" >
                            <b>___________________</b>
                        </td>
                    </tr>
                    <tr>
                        <td width="400px" height="50px" style="text-align: center" >
                            Autoriza
                        </td>
                    </tr>
                </table>
            </g:if>
            <g:else>
                <table style="width: 600px; margin-top: 50px">
                    <tr>
                        <td width="400px" style="text-align: center" >
                            <b>___________________</b>
                        </td>

                        <td width="400px" style="text-align: center" >
                            <b>____________________</b>
                        </td>
                    </tr>
                    <tr>
                        <td width="400px" height="50px" style="text-align: center" >
                            Autoriza
                        </td>

                        <td width="400px" height="50px" style="text-align: center" >
                            Recibí Conforme
                        </td>
                    </tr>
                </table>
            </g:else>
        </g:each>
    </div>






</body>
</html>