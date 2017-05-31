<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 19/05/17
  Time: 14:44
--%>

<div class="col-md-2 negrilla">
    Comprobante
</div>

<div class="col-md-3">
    <g:textField name="comprobanteName" id="comprobanteDesc" class="form-control" disabled="true"
                 title="Comprobante" style="width: 270px" placeholder="Descripción"
                 value="${proceso?.comprobante?.descripcion}"/>
</div>
<div class="col-md-2">
    <g:textField name="comprobanteSaldoName" id="comprobanteSaldo" class="form-control"
                 disabled="true" title="Saldo del Comprobante" style="width:165px;" placeholder="Saldo"
                 value="${saldo}" />
</div>
<div class="col-xs-2" style="margin-left: 20px">
    <g:if test="${proceso?.estado == 'N' || !proceso?.id}">
        <a href="#" id="btnBuscarCom" class="btn btn-info ${proceso?.id ? '' : 'hidden'}">
            <i class="fa fa-search"></i>
            Buscar
        </a>
    </g:if>
</div>
<g:hiddenField name="comprobanteSel_name" id="comprobanteSel" value="${proceso?.comprobante?.id}"/>
<g:hiddenField name="comprobanteSaldo_name" id="comprobanteSaldo1" value="${saldo}"/>

<script type="text/javascript">

    $("#btnBuscarCom").click(function(){
        var tipo = $("#tipoProceso").val();
        var idProveedor = $("#prov_id").val();
        var titulo = "Pagos pendientes al Proveedor";
        if(tipo == 'N') {
            titulo = "Ventas realizadas al Cliente";
        }
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'proceso',action: 'tablaBuscarComprobante_ajax')}",
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