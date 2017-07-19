<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main"/>
    %{--<g:includeJQuery archivo="transacciones"/>--}%
    <title>Transacciones anuladas</title>
    <style type="text/css">
    .etiqueta {
        width       : 100px;
        height      : 20px;
        line-height : 20px;
        font-weight : bold;
        display     : inline-block;
    }
    </style>
</head>
<body>
<div class="container entero ui-corner-all">
    <fieldset style="margin-left: 25px;width: 1080px;float: left" class="ui-corner-all">

        <div class="row">
            <div class="col-md-4">
                <g:link class="btn btn-info" action="buscarPrcs">
                    <i class="fa fa-chevron-left"></i>
                    Lista de Procesos
                </g:link>
            </div>
            <div class="col-md-8">
                <b>Contabilidad:</b>
                <g:select name="contabilidad"  class="form-control label-shared" id="contabilidad" style="width:450px"
                          from="${cratos.Contabilidad.findAllByInstitucion(session.empresa,[sort:'id',order:'desc'])}"
                          value="${contabilidad.id}" optionKey="id"/>
            </div>
        </div>
        <table  style="margin-top: 10px;border: 1px solid black;padding:5px;"
                class="table table-bordered table-hover table-condensed">
            <thead>
            <tr>
                <th>Descripción</th>
                <th>Fecha</th>
                <th>Comprobate</th>
                <th>Valor</th>
            </tr>
            </thead>
            <tbody>
            <g:if test="${procesos}">
                <g:each in="${procesos}" var="p">
                    <tr>
                        <td>${p.descripcion}</td>
                        <td>${p.fecha.format("dd/MM/yyyy")}</td>
                        <g:set var="comp" value="${cratos.Comprobante.findByProceso(p)}"/>
                        <g:if test="${comp}">
                            <td><g:link controller="proceso" action="verComprobante" id="${comp.id}">${comp?.prefijo+""+comp?.numero}</g:link></td>
                        </g:if>
                        <g:else>
                            <td></td>
                        </g:else>
                        <td style="text-align: right">${(p.valor+p.impuesto).round(2)}</td>
                    </tr>
                </g:each>
            </g:if>
            <g:else>

                <tr class="danger text-center">
                    <td colspan="6">No se encontraron procesos anulados</td>
                </tr>

            </g:else>
            </tbody>
        </table>
    </fieldset>
</div>
<script type="text/javascript">
    $("#contabilidad").change(function(){
        location.href="${g.createLink(controller: 'proceso',action: 'procesosAnulados')}?contabilidad="+$(this).val()
    })
</script>
</body>
</html>