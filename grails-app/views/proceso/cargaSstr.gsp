<div class="col-md-2 negrilla">
    Sustento Tributario:
</div>

<div class="col-md-8 negrilla">
    <g:select class=" form-control required cmbRequired sustentoSri" name="tipoCmprSustento" id="sustento"
              from="${data}"
              title="Sustento tributario" optionKey="id" optionValue="${{it.codigo  + ' - ' + it.descripcion}}"
               noSelection="${['-1': 'Seleccione...']}" value="${sstr}"/>
</div>

<div class="col-md-2 " style="font-size: 10px;">
    Necesario para el ATS
</div>

<script type="text/javascript">

    $("#sustento").click(function () {
        console.log("clic en sustento")
        var prve = $("#prve__id").val();
        if(!prve) {
            $("#btn_buscar").click()
        }
    });

    $("#sustento").change(function () {
        var tptr = $(".tipoProcesoSel option:selected").val();
        var sstr = $(".sustentoSri option:selected").val();
        var prve = $("#prve__id").val();

        console.log("cambia sustento")
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'cargaTcsr')}",
            data: {
                tptr: tptr,
                prve: prve,
                sstr: sstr
            },
            success: function (msg) {
                $("#divComprobanteSustento").html(msg)
            }
        });
    });

</script>