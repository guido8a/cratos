<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/08/17
  Time: 14:51
--%>

<div class="row">

    <div class="col-md-2 negrilla">
        Cliente:
    </div>

    <div class="col-md-10 negrilla">

        <div class="col-md-3" style="margin-left: -40px">
            <input type="text" name="proveedor?.ruc" class="form-control proveedor" id="prvePro" readonly
                   value="" title="RUC del proveedor o cliente" placeholder="RUC" style="width: 130px"/>
        </div>

        <div class="col-md-5" style="margin-left: 20px">
            <input type="text" name="proveedor?.nombre" class="form-control label-shared proveedor" id="prve_nombrePro"
                   readonly value="" title="Nombre del proveedor o cliente"
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
            <input type="text" name="dcmtEstablecimiento" id="dcmtEstablecimiento" size="3" maxlength="3"
                   style="width: 100px;"
                   value="${proceso?.procesoSerie01}" class="form-control validacionNumero"
                   validate=" number" placeholder="Establ." />
        </div>

        <div class="col-md-3">
            <input type="text" name="dcmtEmision" id="dcmtEmision" size="3" maxlength="3" style="width: 100px;"
                   value="${proceso?.procesoSerie02}"
                   class="form-control validacionNumero " validate=" number" placeholder="Emisión"
                   title="El número de punto de emisión del documento" />
        </div>

        <div class="col-md-4">
            <input type="text" name="dcmtSecuencial" id="dcmtSecuencial" size="10" maxlength="9"
                   style="width: 100px;"
                   value="${proceso?.secuencial}"
                   class="form-control label-shared validacionNumero " validate=" number"
                   title="El número de secuencia del documento" }
                   placeholder="Secuencial"/>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-xs-2 negrilla" style="font-size: 12px">
        Autorización:
    </div>

    <div class="col-xs-3 negrilla">
        <input type="text" name="dcmtAutorizacion" id="dcmtAutorizacion" size="10" maxlength="15"
               value="${proceso?.autorizacion?: atrz}" class=" digits form-control label-shared validacionNumero"
               validate=" number" placeholder="Autorización"
               title="El número autorización de la factura a registrar" style="margin-left: -15px"/>
    </div>
</div>
<div class="row">
    <div class="col-xs-1 negrilla" style="width: 100px">
        Base Impo. IVA ${iva}%:
    </div>

    <div class="col-xs-2 negrilla" style="margin-left: -20px">
        <input type="text" name="baseImponibleIva" id="iva12" size="7" value="${proceso?.baseImponibleIva ?: 0.00}"
               class="required  number form-control validacionNumero"
               validate="required number" ${proceso?.estado == 'R' ? 'readonly' : ( band ? 'readonly' : '')} />
    </div>

    <div class="col-xs-1 negrilla" style="width: 100px">
        Base impo. IVA 0%:
    </div>

    <div class="col-xs-2 negrilla" style="margin-left: -20px">
        <input type="text" name="baseImponibleIva0" size="7" id="iva0" value="${proceso?.baseImponibleIva0 ?: 0.00}"
               class="required number form-control validacionNumero"
               validate="required number"  ${proceso?.estado == 'R' ? 'readonly' : ( band ? 'readonly' : '')}  />
    </div>

    <div class="col-xs-1 negrilla" style="width: 100px">
        No aplica el IVA:
    </div>

    <div class="col-xs-2 negrilla" style="margin-left: -20px">
        <input type="text" name="baseImponibleNoIva" id="noIva" size="7"
               value="${proceso?.baseImponibleNoIva ?: 0.00}" class="required number form-control validacionNumero"
               validate="required number" ${proceso?.estado == 'R' ? 'readonly' : ( band ? 'readonly' : '')}  />
    </div>
</div>


<div class="row" style="font-size: 12px">
    <div class="col-xs-1 negrilla" style="width: 100px">
        Excento del IVA:
    </div>

    <div class="col-xs-2 negrilla" style="margin-left: -20px">
        <input type="text" name="excentoIva" id="excentoIva" size="7"
               value="${proceso?.excentoIva ?: 0.00}" class="required number form-control validacionNumero"
               validate="required number" ${proceso?.estado == 'R' ? 'readonly' : ( band ? 'readonly' : '')}  />
    </div>

    <div class="col-xs-1 negrilla" style="width: 100px">
        IVA generado:
    </div>

    <div class="col-xs-2 negrilla" style="margin-left: -20px">
        <input type="text" name="ivaGenerado" id="ivaGenerado" value="${proceso?.ivaGenerado}"
               class="required number form-control validacionNumero"
               validate="required number"  ${proceso?.estado == 'R' ? 'readonly' : ( band ? 'readonly' : '')}  />
    </div>

    <div class="col-xs-1 negrilla" style="width: 100px">
        ICE generado:
    </div>

    <div class="col-xs-2 negrilla" style="margin-left: -20px">
        <input type="text" name="iceGenerado" id="iceGenerado" value="${proceso?.iceGenerado ?: 0.00}"
               class="required number form-control validacionNumero"
               validate="required number"  ${proceso?.estado == 'R' ? 'readonly' : ( band ? 'readonly' : '')} />
    </div>
</div>


<script type="text/javascript">


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

</script>
