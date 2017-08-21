<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/08/17
  Time: 14:51
--%>

<style type="text/css">

.doce{
    font-size: 10px;
}


</style>


<g:form name="reembolsoForm">
    <div class="row">

        <div class="col-md-2 negrilla">
            Cliente:
        </div>

        <div class="col-md-10 negrilla">

            <div class="col-md-3" style="margin-left: -40px">
                <input type="text" name="proveedor?.ruc" class="form-control proveedor required" id="prvePro" readonly
                       value="${reembolso?.proveedor?.ruc ?: ''}" title="RUC del proveedor o cliente" placeholder="RUC" style="width: 130px"/>
            </div>

            <div class="col-md-5" style="margin-left: 20px">
                <input type="text" name="proveedor?.nombre" class="form-control label-shared proveedor required" id="prve_nombrePro"
                       readonly value="${reembolso?.proveedor?.nombre ?: ''}" title="Nombre del proveedor o cliente"
                       placeholder="Nombre" style="width: 200px"/>
            </div>

            <div class="col-md-2" style="margin-left: 20px">
                <a href="#" id="btn_buscar" class="btn btn-info" title="Buscar cliente">
                    <i class="fa fa-search"></i>
                    Buscar
                </a>
            </div>
            <input type="hidden" name="proveedor.id" id="prve_idPro" value="${proceso?.proveedor?.id}">
        </div>
    </div>


    <div class="row" id="divComprobanteSustento"></div>

    <div class="row" style="font-size: 12px">
        <div class="col-xs-3 negrilla">
            Documento registrado:
        </div>

        <div class="col-md-10 negrilla" style="margin-left: -80px">
            <div class="col-md-3">
                <input type="text" name="dcmtEstablecimiento" id="dcmtEstablecimientoR" maxlength="10"
                       style="width: 100px;" value="${reembolso?.reembolsoEstb ?: ''}" class="form-control required validacionNumeroSinPuntos" placeholder="Establ." />
            </div>

            <div class="col-md-3">
                <input type="text" name="dcmtEmision" id="dcmtEmisionR" maxlength="10" style="width: 100px;"
                       value="${reembolso?.reembolsoEmsn ?: ''}" class="form-control required validacionNumeroSinPuntos" placeholder="Emisión" title="El número de punto de emisión del documento" />
            </div>

            <div class="col-md-4">
                <input type="text" name="dcmtSecuencial" id="dcmtSecuencialR" maxlength="10"
                       style="width: 115px;" value="${reembolso?.reembolsoSecuencial ?: ''}" class="form-control label-shared required validacionNumeroSinPuntos"
                       title="El número de secuencia del documento" placeholder="Secuencial"/>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-2 negrilla" style="font-size: 12px">
            Autorización:
        </div>

        <div class="col-xs-3 negrilla">
            <input type="text" name="dcmtAutorizacion" id="dcmtAutorizacionR" maxlength="10"
                   value="${reembolso?.autorizacion ?: ''}" class=" digits form-control label-shared required validacionNumeroSinPuntos"
                   placeholder="Autorización" title="El número autorización de la factura a registrar" style="margin-left: -15px; width: 150px"/>
        </div>

        <div class="col-xs-2 negrilla" style="font-size: 12px">
            Fecha :
        </div>

        <div class="col-xs-4 negrilla" style="margin-left: -35px">
            <elm:datepicker name="fechaR_name" title="Fecha" id="fechaR"
                            class="datepicker form-control required" value="${reembolso?.fecha}" maxDate="new Date()"
                            style="width: 100px;"/>
        </div>
    </div>
    <div class="col-md-12" style="margin-top: 20px">
        <div class="col-md-1 negrilla doce" style="width: 70px">
            Base Impo. IVA %:
        </div>

        <div class="col-md-3 negrilla" style="margin-left: -20px">
            <input type="text" name="baseImponibleIva" id="ivaR" size="7" value="${reembolso?.baseImponibleIva}"
                   class="required  number form-control validacionNumero"
                   validate="required number" />
        </div>

        <div class="col-md-1 negrilla doce" style="width: 70px; margin-left: -10px">
            Base impo. IVA 0%:
        </div>

        <div class="col-md-3 negrilla" style="margin-left: -20px">
            <input type="text" name="baseImponibleIva0" size="7" id="iva0R" value="${reembolso?.baseImponibleIva0}"
                   class="required number form-control validacionNumero"
                   validate="required number"/>
        </div>

        <div class="col-md-1 negrilla doce" style="width: 70px; margin-left: -10px">
            No aplica el IVA:
        </div>

        <div class="col-md-3 negrilla" style="margin-left: -20px">
            <input type="text" name="baseImponibleNoIva" id="noIvaR" size="7" value="${reembolso?.baseImponibleNoIva}"
                   class="required number form-control validacionNumero"
                   validate="required number"  />
        </div>

    </div>


    <div class="col-md-12" style="font-size: 12px; margin-top: 10px; margin-bottom: 10px">

        <div class="col-md-1 negrilla doce" style="width: 70px;">
            Excento del IVA:
        </div>

        <div class="col-md-3 negrilla" style="margin-left: -20px">
            <input type="text" name="excentoIva" id="excentoIvaR" size="7" value="${reembolso?.excentoIva}"
                   class="required number form-control validacionNumero"
                   validate="required number"  />
        </div>
        <div class="col-md-1 negrilla doce" style="width: 70px; margin-left: -10px">
            IVA generado:
        </div>

        <div class="col-md-3 negrilla" style="margin-left: -20px">
            <input type="text" name="ivaGenerado" id="ivaGeneradoR" value="${reembolso?.ivaGenerado}"
                   class="required number form-control validacionNumero"
                   validate="required number"  />
        </div>

        <div class="col-md-1 negrilla doce" style="width: 70px; margin-left: -10px">
            ICE generado:
        </div>

        <div class="col-md-3 negrilla" style="margin-left: -20px">
            <input type="text" name="iceGenerado" id="iceGeneradoR" value="${reembolso?.iceGenerado}"
                   class="required number form-control validacionNumero"
                   validate="required number"  />
        </div>

    </div>

</g:form>


<script type="text/javascript">

    $("#reembolsoForm").validate({
        errorClass: "help-block",
        errorPlacement: function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success: function (label) {
            label.parents(".grupo").removeClass('has-error');
        }
    });

    function validarNumSinPuntos(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
        (ev.keyCode >= 96 && ev.keyCode <= 105) ||
        ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
        ev.keyCode == 37 || ev.keyCode == 39 );
    }

    $(".validacionNumeroSinPuntos").keydown(function (ev) {
//        return validarNumSinPuntos(ev);
    }).keyup(function (ev) {
        return validarNumSinPuntos(ev);
    });

    function validarNum(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
        (ev.keyCode >= 96 && ev.keyCode <= 105) ||
        ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
        ev.keyCode == 37 || ev.keyCode == 39 ||
        ev.keyCode == 110 || ev.keyCode == 190);
    }

    $(".validacionNumero").keydown(function (ev) {
//        return validarNum(ev);
    }).keyup(function (ev) {
        return validarNum(ev);
    });


    $("#btn_buscar").click(function () {
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'proceso', action:'buscarProveedor_ajax')}",
            data: {
                proceso: '${proceso?.id}'
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgBuscarPro",
                    title: "Buscar proveedor",
                    class: "long",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    });


    <g:if test="${reembolso}">
    cargarTcsr('${reembolso?.proveedor?.id}');
    </g:if>


    function cargarTcsr(prve) {
        var tptr = '${proceso?.tipoProceso?.id}';
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'cargaTcsr')}",
            data: {
                tptr: tptr,
                prve: prve,
                sstr: "${proceso?.sustentoTributario?.id}",
                tpcp: "${proceso?.tipoCmprSustento?.id}",
                etdo: 'N',
                esta: '1',
                reembolso: '${reembolso?.id}'
            },
            success: function (msg) {
                $("#divComprobanteSustento").html(msg)
                $("#divComprobanteSustento").show()
            }
        });
    };

</script>
