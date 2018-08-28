<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 28/08/18
  Time: 9:29
--%>

<g:if test="${tipo == '1'}">
    <table class="table table-bordered table-hover table-condensed">
        <tbody>
        <g:each in="${rolPagosInstanceList}" status="i" var="rolPagosInstance">
            <tr style="width: 100%" data-id="${rolPagosInstance.id}" data-estado="${rolPagosInstance?.estado}" data-mes="${rolPagosInstance?.mess__id}" data-anio="${rolPagosInstance?.anio__id}" data-mes1="${rolPagosInstance?.mess}" data-anio2="${rolPagosInstance?.anio}">
                <td class="centrado" style="width: 15%">${rolPagosInstance?.anio}</td>
                <td class="centrado" style="width: 15%">${rolPagosInstance?.mess}</td>
                <td class="centrado" style="width: 15%"><g:formatDate date="${rolPagosInstance.fecha}" format="dd-MM-yyyy" /></td>
                <td class="centrado" style="width: 20%"><g:formatDate date="${rolPagosInstance.fechaModificacion}" format="dd-MM-yyyy" /></td>
                <td style="text-align: right; width: 20%"><g:formatNumber number="${rolPagosInstance?.pagado}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/></td>
                <td class="centrado" style="text-align: center; width: 15%; color: ${rolPagosInstance?.estado == 'N' ? 'rgba(112,27,25,0.9)': 'rgba(83,207,109,0.9)'}">${rolPagosInstance?.estado == 'N' ? 'No Aprobado' : 'Aprobado'}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</g:if>
<g:else>
    <table class="table table-bordered table-hover table-condensed">
        <tbody>
        <g:each in="${roles}" status="i" var="rolPagosInstance">
            <tr style="width: 100%" data-id="${rolPagosInstance.id}" data-estado="${rolPagosInstance?.estado}" data-mes="${rolPagosInstance?.mess?.id}" data-anio="${rolPagosInstance?.anio?.id}" data-mes1="${rolPagosInstance?.mess}" data-anio2="${rolPagosInstance?.anio}">
                <td class="centrado" style="width: 15%">${rolPagosInstance?.anio?.anio}</td>
                <td class="centrado" style="width: 15%">${rolPagosInstance?.mess?.descripcion}</td>
                <td class="centrado" style="width: 15%"><g:formatDate date="${rolPagosInstance.fecha}" format="dd-MM-yyyy" /></td>
                <td class="centrado" style="width: 20%"><g:formatDate date="${rolPagosInstance.fechaModificacion}" format="dd-MM-yyyy" /></td>
                <td style="text-align: right; width: 20%"><g:formatNumber number="${rolPagosInstance?.pagado}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="en_US"/></td>
                <td class="centrado" style="text-align: center; width: 15%; color: ${rolPagosInstance?.estado == 'N' ? 'rgba(112,27,25,0.9)': 'rgba(83,207,109,0.9)'}">${rolPagosInstance?.estado == 'N' ? 'No Aprobado' : 'Aprobado'}</td>
            </tr>
        </g:each>
        </tbody>
    </table>

</g:else>

<script type="text/javascript">

    $(function () {
        $("tr").contextMenu({
            items  : createContextMenu,
            onShow : function ($element) {
                $element.addClass("trHighlight");
            },
            onHide : function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });
    });



    function createContextMenu(node) {
        var $tr = $(node);
        $tr.addClass("success");
        var id = $tr.data("id");
        var est = $tr.data("estado");
        var mes = $tr.data("mes");
        var anio = $tr.data("anio");
        var mesN = $tr.data("mes1");
        var anioN = $tr.data("anio2");

        var items = {
            header: {
                label: "Acciones",
                header: true
            }
        };

        var ver = {
            label  : 'Ver',
            icon   : "fa fa-search",
            action : function (e) {
                $("tr.success").removeClass("success");
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'show_ajax')}",
                    data    : {
                        id : id
                    },
                    success : function (msg) {
                        bootbox.dialog({
                            title   : "Ver Rol de Pagos",
                            message : msg,
                            buttons : {
                                ok : {
                                    label     : "Aceptar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                }
                            }
                        });
                    }
                });
            }
        };

        var ce = {
            label  : 'Cambiar Estado',
            icon   : "fa fa-undo",
            action : function (e) {
                cambiarEstado(id)
            }
        };


        var dpr = {
            label  : 'Detalle de Pago por Rubro',
            icon   : "fa fa-list-ol",
            action : function (e) {
                rubros(id)
            }
        };


        var dpe = {
            label  : 'Detalle de Pago por Empleado',
            icon   : "fa fa-users",
            action : function (e) {
                cargarEmpleados(id)
            }
        };

        var generar = {
            label  : 'Generar Rol Nuevamente',
            icon   : "fa fa-check-square",
            action : function (e) {
                generarRol(mes, anio, mesN, anioN)
            }
        };

        var imprimir = {
            label  : 'Imprimir Rol de Pagos',
            icon   : "fa fa-print",
            action : function (e) {
                location.href="${createLink(controller: 'reportes3', action: 'reporteRolPagosGeneral')}/?id=" + id
            }
        };

        items.ver = ver;
        items.ce = ce;
        items.dpr = dpr;
        items.dpe = dpe;
        items.imprimir = imprimir;
        if(est == 'N'){
            items.generar = generar;
        }

        return items
    }

    function generarRol (mes, anio, mesN, anioN) {
        console.log(" - " + mesN + " - " + anioN)
        bootbox.confirm("Está a punto de generar el rol del pago nuevamente para el mes de <span style='color:blue'>"+
            mesN +" </span> del año <span style='color:blue'>"+
            anioN +".</span><br><br>Si es correcto, presione Aceptar para generar el rol",
            function(result){
                if(result){
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${g.createLink(controller:'rubro', action:'generarRol')}",
                        data    : "mes="+ mes + "&anio="+ anio, //+
                        success : function (msg) {
                            location.reload()
                        }
                    });
                }
            })
    }



</script>


