<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 18/12/17
  Time: 10:22
--%>

<g:if test="${proceso?.estado != 'R'}">
    <div class="row">
        <div class="col-xs-2 negrilla text-info">
            Forma de Pago
        </div>

        <div class="col-xs-5">
            <g:select name="formaPago_name" from="${cratos.TipoPago.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" id="formaPago" class="form-control"/>
        </div>

        <div class="col-xs-1 negrilla text-info">
            Plazo
        </div>

        <div class="col-xs-2">
            <g:textField name="plazo_name" id="plazoFormaPago" class="form-control validaNumero" maxlength="3"/>
        </div>

        <a href="#" class="btn btn-success btnAgregarFormaPago" title="Agregar Forma de Pago"><i class="fa fa-plus"></i> Agregar</a>

    </div>
</g:if>

<div style="margin-top: 10px" id="divTablaFormaPago">


</div>

<script type="text/javascript">

    $(".btnAgregarFormaPago").click(function () {
        var tipo = $("#formaPago option:selected").val();
        var plazo = $("#plazoFormaPago").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'guardarFormaPago_ajax')}',
            data:{
                tipo: tipo,
                plazo: plazo,
                id: '${proceso?.id}'
            },
            success: function (msg){
                if(msg == 'ok'){
                    log("Forma de Pago agregada correctamente","success");
                    cargarTablaFormaPago();
                }else{
                    log("Error al agregar la Forma de Pago","error");
                }
            }
        });
    });

    cargarTablaFormaPago();


    function cargarTablaFormaPago () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'tablaFormaPago_ajax')}',
            data:{
                proceso: '${proceso?.id}'
            },
            success: function (msg) {
                $("#divTablaFormaPago").html(msg)
            }
        });
    }

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
        ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 188);
    }


    $(".validaNumero").keydown(function (ev) {
        return validarNum(ev);
    }).keyup(function () {
    });


</script>