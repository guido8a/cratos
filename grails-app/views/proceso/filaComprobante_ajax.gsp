<div class="col-md-2 negrilla">
    Comprobante
</div>

<div class="col-md-3">
    <g:textField name="comprobanteName" id="comprobanteDesc" class="form-control" disabled="true"
                 title="Comprobante" style="width: 270px" placeholder="Descripción"
                 value="${proceso?.comprobante?.descripcion}"/>
</div>
<div class="col-md-2">
    <g:textField name="documento" id="comprobanteDoc" class="form-control" disabled="true"
                 title="Documento" style="width: 170px" placeholder="Documento"
                 value="${proceso?.comprobante?.proceso?.documento}"/>
</div>
<div class="col-md-2">
    <g:textField name="comprobanteSaldoName" id="comprobanteSaldo" class="form-control"
                 disabled="true" title="Saldo del Comprobante" style="width:165px;" placeholder="Saldo"
                 value="${saldo ? saldo : 0}" />
</div>
<div class="col-xs-1" style="margin-left: -10px">
    <g:if test="${proceso?.estado == 'N' || !proceso?.id}">
        <a href="#" id="btnBuscarComp" class="btn btn-info ${proceso?.id ? '' : 'hidden'}">
            <i class="fa fa-search"></i>
            Buscar
        </a>
    </g:if>
</div>
%{--<div class="col-xs-2" style="margin-left: 0px">--}%
        %{--<a href="#" id="btnBuscarSaldos" class="btn btn-info ${proceso?.id ? '' : 'hidden'}">--}%
            %{--<i class="fa fa-search"></i>--}%
            %{--Saldos CxC y CxP--}%
        %{--</a>--}%
%{--</div>--}%
<g:hiddenField name="comprobanteSel_name" id="comprobanteSel" value="${proceso?.comprobante?.id}"/>
<g:hiddenField name="comprobanteSaldo_name" id="comprobanteSaldo1" value="${saldo}"/>

<script type="text/javascript">

    $("#btnBuscarComp").click(function(){
        console.log('buscarComp')
        var tipo = $("#tipoProceso").val();
        var idProveedor = $("#prve__id").val();
        var titulo = "Pagos pendientes al Proveedor";
        if(tipo == '6') {
            titulo = "Ventas realizadas al Cliente";
        }
        if(tipo == '5'){
            titulo = "Cobros pendientes";
        }

        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'proceso', action: 'compBuscador')}",
            data    : {
                proveedor: idProveedor,
                tipo:      tipo
            },
            success : function (msg) {
                bootbox.dialog({
                    title   : titulo,
                    message : msg,
                    class :'long',
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    }
                });
            }
        });
    });

</script>