<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 16/05/17
  Time: 11:21
--%>

<div class="row">
    <div class="col-md-2">
        <label>Cuenta:</label>
    </div>
    <div class="col-md-3">
        <input type="text" name="codigoAsiento_name" id="codigoAsiento" value="${asiento?.cuenta?.numero}" readonly style="width: 120px"/>
    </div>
    <div class="col-md-5" style="margin-left: -27px">
        <input type="text" name="nombreAsiento_name" id="nombreAsiento" class="" value="${asiento?.cuenta?.descripcion}" readonly style="width: 350px" title="${asiento?.cuenta?.descripcion}"/>
    </div>

</div>
<div class="row">
    <div class="col-md-2">
        <label>Descripción:</label>
    </div>
    <div class="col-md-3">
        <g:textField name="descripcion_name" id="descripcionAux" class="form-control" style="width: 400px" value="${auxiliar?.descripcion ?: ''}"/>
    </div>
</div>
<div class="row">
    <div class="col-md-2">
        <label>Fecha Pago:</label>
    </div>
    <div class="col-md-4">
        <elm:datepicker name="fechapago_name" title="Fecha de pago" class="datepicker form-control required fechaPago" value="${auxiliar?.fechaPago ?: new java.util.Date().format("dd-MM-yyyy")}"/>
    </div>
</div>
<div class="row">
    <div class="col-md-2">
        <label>Forma de Pago:</label>
    </div>
    <div class="col-md-3">
        <g:select name="tipo_name" from="${cratos.TipoPago.list()}" optionKey="id" optionValue="descripcion" id="tipoPago" class="form-control" style="width: 400px"/>
    </div>
</div>
<div class="row">
    <div class="col-md-2">
        <label>Proveedor:</label>
    </div>
    <div class="col-md-3">
        <g:select name="proveedor_name" id="proveedor" from="${cratos.Proveedor.list().sort{it.nombre}}" class="form-control" optionValue="nombre" optionKey="id" style="width: 400px"/>
    </div>
</div>
<div class="row">
    <div class="col-md-2">
        <label>Valor:</label>
    </div>
    <div class="col-md-10">
        <div class="col-md-2">Pagar</div>
        <div class="col-md-3">
            <g:textField type="number" name="valorAuxiliarP_name" id="valorPagar" class="validacionNumero form-control valorP" style="width: 90px;" value="${auxiliar ? auxiliar?.debe : asiento?.debe}" />
        </div>
        <div class="col-md-2">Cobrar</div>
        <div class="col-md-3">
            <g:textField type="number" name="valorAuxiliarC_name" id="valorCobrar" class="validacionNumero form-control valorC" style="width: 90px;" value="${auxiliar ? auxiliar?.haber : asiento?.haber}" />
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
        $(".valorC").val(0).prop('readonly', true)
    }).keyup(function () {
    });

    $(".valorC").keydown(function (ev) {
        $(".valorP").val(0).prop('readonly', true)
    }).keyup(function () {
    });
</script>