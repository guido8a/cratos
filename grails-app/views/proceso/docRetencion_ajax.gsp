<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 24/10/17
  Time: 11:02
--%>

<div class="row" style="font-size: 12px; margin-top: 20px">
    <div class="col-xs-1 negrilla text-info" style="width: 120px;">
        Documento de retención:
    </div>

    <div class="col-xs-3 negrilla" style="margin-left: -10px; width: 260px;">
        <input type="text" name="retencionVenta_name" id="retencionVenta2" value="${proceso?.retencionVenta}"
               class="form-control"  />
    </div>

    <div class="col-xs-2 negrilla text-info">
        Valor retenido del IVA:
    </div>

    <div class="col-xs-2 negrilla" style="margin-left: -20px">
        <input type="text" name="retenidoIva_name" id="retenidoIva2" value="${proceso?.retenidoIva ?: 0.00}"
               class="required number form-control validacionNumero"
               validate="required number"  />
    </div>

    <div class="col-xs-2 negrilla text-info">
        Valor retenido del Impuesto a la Renta:
    </div>

    <div class="col-xs-2 negrilla" style="margin-left: 0px">
        <input type="text" name="retenidoRenta_name" id="retenidoRenta2" value="${proceso?.retenidoRenta ?: 0.00}"
               class="required number form-control validacionNumero"
               validate="required number" />
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

    $(".number").blur(function () {
        if (isNaN($(this).val()))
            $(this).val("0.00")
        if ($(this).val() == "")
            $(this).val("0.00")
    });



</script>