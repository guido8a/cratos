<div class="row">
    <div class="col-md-2">
        <label>Cuenta:</label>
    </div>
    <div class="col-md-3">
        <input type="text" name="codigoAsiento_name" id="codigoAsiento" value="${asiento?.cuenta?.numero}" readonly
               style="width: 100px"/>
    </div>
    <div class="col-md-5" style="margin-left: -45px">
        <input type="text" name="nombreAsiento_name" id="nombreAsiento" class="" value="${asiento?.cuenta?.descripcion}"
               readonly style="width: 350px" title="${asiento?.cuenta?.descripcion}"/>
    </div>

</div>
<div class="row">
    <div class="col-md-2">
        <label>Descripción:</label>
    </div>
    <div class="col-md-3">
        <g:textField name="descripcion_name" id="descripcionAux" class="form-control" style="width: 400px"
                     value="${auxiliar?.descripcion ?: ''}" readonly="${auxiliar ? true : false}"/>
    </div>
</div>
<div class="row">
    <div class="col-md-2">
        <label>Proveedor:</label>
    </div>
    <div class="col-md-3">
        <g:select name="proveedor_name" id="proveedor" from="${proveedores}" class="form-control" optionValue="nombre" optionKey="id" style="width: 400px" value="${auxiliar?.proveedor?.id}" disabled="${band ? false : true}"/>
    </div>
</div>

%{--muestra la factura--}%
<g:if test="${band3}">
    <div class="row">
        <div class="col-md-2">
            <label>Factura: </label>
        </div>
        <div class="col-md-10">
            <g:select name="factura_name" id="facturaAuxiliar" from="${res}" optionKey="${{it.axlr__id}}"
                      optionValue="${{it?.dcmt + ' - ' +  it?.dscr + ' - $ ' + it?.sldo}}" class="form-control porPagar"
                      value="${auxiliar?.afecta?.id}"/>
        </div>
    </div>
</g:if>


<div class="row">
    <div class="col-md-2">
        <label>Forma de Pago:</label>
    </div>
    <div class="col-md-4">
        <g:select name="tipo_name" from="${cratos.TipoDocumentoPago.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion"
                  id="tipoPago" class="form-control" value="${auxiliar?.tipoDocumentoPago?.id}"
                  noSelection="${['-1': 'Seleccione...']}"/>
    </div>

    <div class="col-md-2">
        <label>Fecha de Pago:</label>
    </div>
    <div class="col-md-4">
        <elm:datepicker name="fechapago_name" title="Fecha de pago" class="datepicker form-control required fechaPago"
                        value="${auxiliar?.fechaPago}"/>
    </div>
</div>

<g:if test="${comprobante?.proceso?.tipoProceso?.codigo?.trim() in ['C'] || band}">
    <div class="row">
        <div class="col-md-5">
            <label>Documento por pagar:</label>
        </div>
        <div class="col-md-6">
            <g:textField name="factura" id="factura" class="form-control" value="${auxiliar?.factura ?: ''}"/>
        </div>
    </div>
</g:if>

<g:if test="${comprobante?.proceso?.tipoProceso?.codigo?.trim() in ['P', 'I']}">
    <div class="row">
        <div class="col-md-5">
            <label>Documento con que se paga:</label>
        </div>
        <div class="col-md-6">
            <g:textField name="referencia_name" id="referencia" class="form-control" value="${auxiliar?.documento ?: ''}"/>
        </div>
    </div>
</g:if>


<div class="row">
    <div class="col-md-2">
        <label>Valor:</label>
    </div>
    <div class="col-md-10">
        <div class="col-md-2">Debe (CxC)</div>
        <div class="col-md-4">
            %{--<g:textField type="number" name="valorAuxiliarP_name" id="valorPagar" readonly="${auxiliar ? true : false}" --}%
            <g:textField type="number" name="valorAuxiliarP_name" id="valorPagar"
                         class="validacionNumero form-control valorP required" placeholder="${auxiliar ? auxiliar?.debe : maximoDebe}"
                         style="width: 120px;" value="${auxiliar ? auxiliar?.debe : maximoDebe}" />
        </div>
        <div class="col-md-2">Haber (CxP)</div>
        <div class="col-md-4">
            <g:textField type="number" name="valorAuxiliarC_name" id="valorCobrar"
                         placeholder="${auxiliar ? auxiliar?.haber : maximoHaber}"
                         class="validacionNumero form-control valorC required" style="width: 120px;"
                         value="${auxiliar ? auxiliar?.haber : maximoHaber}" />
        </div>
    </div>
</div>

<g:hiddenField name="asiento_name" id="asientoId" value="${asiento?.id}"/>

<script type="text/javascript">
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
        return validarNum(ev);
    }).keyup(function () {

    });

    $(".valorP").keydown(function (ev) {
        $(".valorC").val(0).prop('disabled', true)
    }).keyup(function () {
    });

    $(".valorC").keydown(function (ev) {
        $(".valorP").val(0).prop('disabled', true)
    }).keyup(function () {
    });

    $(".valorC").keydown(function (ev) {

    }).keyup(function () {
        if('${auxiliar?.id}'){
            if($(".valorC").val() > ${maximoHaber} && $(".valorC").val() > ${totHaber ?: 0}){
                $(".valorC").val(${auxiliar?.haber ?: 0})
            }
        }else{
            if($(".valorC").val() > ${maximoHaber}){
                $(".valorC").val(${maximoHaber})
            }
        }
    });

    $(".valorP").keydown(function (ev) {


    }).keyup(function () {
        if('${auxiliar?.id}'){
            if($(".valorP").val() > ${maximoDebe} && $(".valorP").val() > ${totDebe ?: 0}){
                $(".valorP").val(${auxiliar?.debe ?: 0})
            }
        }else{
            if($(".valorP").val() > ${maximoDebe}){
                $(".valorP").val(${maximoDebe})
            }
        }

    });


</script>