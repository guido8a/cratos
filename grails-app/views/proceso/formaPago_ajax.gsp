<g:if test="${proceso?.estado != 'R'}">
    <div class="row">
        <div class="col-xs-1 negrilla text-info">
            Forma de Pago
        </div>

        <div class="col-xs-4">
            <g:select name="formaPago_name" from="${cratos.TipoPago.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" id="formaPago" class="form-control"/>
        </div>

        <div class="col-xs-1 negrilla text-info">
            Plazo
        </div>

        <div class="col-xs-1">
            <g:textField name="plazo_name" id="plazoFormaPago" class="form-control validaNumero" maxlength="3"/>
        </div>

        <div class="col-xs-1 negrilla text-info">
            Valor
        </div>

        <div class="col-xs-2">
            <g:textField name="valor_name" id="valorFormaPago" class="form-control validaNumeroDecimal"/>
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
        var valor = $("#valorFormaPago").val();

        if(valor){
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'proceso', action: 'guardarFormaPago_ajax')}',
                data:{
                    tipo: tipo,
                    plazo: plazo,
                    valor: valor,
                    id: '${proceso?.id}'
                },
                success: function (msg){
                    var parts = msg.split("_");
                    if(parts[0] == 'ok'){
                        log("Forma de Pago agregada correctamente","success");
                        cargarTablaFormaPago();
                    }else{
                        if(parts[0] == 'error1'){
                            var b = bootbox.dialog({
                                id   : "dlgError1",
                                title: "Alerta",
                                message: "<i class='fa fa-exclamation-triangle fa-2x pull-left text-danger text-shadow'></i> El valor ingresado es mayor al valor de la factura",
                                buttons: {
                                    cancelar: {
                                        label    : "<i class='fa fa-times'></i> Cancelar",
                                        className: "btn-primary",
                                        callback : function () {
                                        }
                                    }
                                } //buttons
                            }); //dialog
                        }else{
                            if(parts[0] == 'error2'){
                                var c = bootbox.dialog({
                                    id   : "dlgError2",
                                    title: "Alerta",
                                    message: "<i class='fa fa-exclamation-triangle fa-2x pull-left text-danger text-shadow'></i> El valor ingresado es mayor al valor disponible:" + parts[1],
                                    buttons: {
                                        cancelar: {
                                            label    : "<i class='fa fa-times'></i> Cancelar",
                                            className: "btn-primary",
                                            callback : function () {
                                            }
                                        }
                                    } //buttons
                                }); //dial
                            }else{
                                log("Error al agregar la Forma de Pago","error");
                            }
                        }
                    }
                }
            });
        }else{
            var d = bootbox.dialog({
                id   : "dlgError3",
                title: "Alerta",
                message: "<i class='fa fa-exclamation-triangle fa-2x pull-left text-danger text-shadow'></i> Ingrese un valor",
                buttons: {
                    cancelar: {
                        label    : "<i class='fa fa-times'></i> Cancelar",
                        className: "btn-primary",
                        callback : function () {
                        }
                    }
                } //buttons
            }); //dial
        }


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

    function validarNumDec(ev) {
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
        ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 188 ||
        ev.keyCode == 190 || ev.keyCode == 110);
    }


    $(".validaNumeroDecimal").keydown(function (ev) {
        return validarNumDec(ev);
    }).keyup(function () {
    });



</script>