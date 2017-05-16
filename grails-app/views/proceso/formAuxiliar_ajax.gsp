<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 16/05/17
  Time: 11:21
--%>

<div class="row">
    <div class="col-md-2">
        <label>Código:</label>
    </div>
    <div class="col-md-4">
        <input type="text" name="codigoAsiento_name" id="codigoAsiento" value="${asiento?.cuenta?.numero}" readonly style="width: 150px"/>
    </div>
    %{--<div class="col-md-2">--}%
        %{--<a href="#" class="btn btn-info" id="btnBuscarCuenta"><i class="fa fa-search"></i> Buscar cuenta</a>--}%
    %{--</div>--}%
</div>
<div class="row">
    <div class="col-md-2">
        <label>Nombre:</label>
    </div>
    <div class="col-md-7">
        <input type="text" name="nombreAsiento_name" id="nombreAsiento" class="" value="${asiento?.cuenta?.descripcion}" readonly style="width: 400px"/>
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
<div class="row">
    <div class="col-md-2">
        <label>Fecha Pago:</label>
    </div>
    <div class="col-md-3">

    </div>
</div>
<div class="row">
    <div class="col-md-2">
        <label>Forma de Pago:</label>
        <div class="col-md-3">

        </div>
    </div>
</div>


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