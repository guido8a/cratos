<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 17/10/17
  Time: 11:55
--%>

<div style="height: 70px">

    <div class="col-md-9" style="margin-bottom: 20px">
        <div class="col-md-5">
            <strong>Valor Actual:</strong>
        </div>
        <div class="col-md-4">
            <g:formatNumber number="${proceso?.valor}" maxFractionDigits="2" minFractionDigits="2" locale="en_US" format="##,##0" />
        </div>
    </div>

    <div class="col-md-9">
        <div class="col-md-5">
            <strong>Nuevo Valor: </strong>
        </div>
        <div class="col-md-4">
            <g:textField name="con_name" id="conciliacion" class="form-control validacionNumero" style="width: 150px"/>
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
    }).keyup(function (ev) {
    });

</script>