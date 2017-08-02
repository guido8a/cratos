<div class="col-md-2 negrilla">
    Sustento Tributario:
</div>

<div class="col-md-8 negrilla">
    <g:select class=" form-control required cmbRequired sustentoSri" name="tipoCmprSustento" id="tipoCmprSustento"
              from="${data}"
              title="Sustento tributario" optionKey="id" optionValue="${{it.codigo  + ' - ' + it.descripcion}}"
              noSelection="${['-1': 'Seleccione...']}" value="${sstr}" disabled="${estado == 'R'? true : false}"/>
</div>
<g:if test="${estado != 'R'}">
    <a href="#" id="btn_cargarCp" class="btn btn-info">
        <i class="fa fa-check"></i>
    </a>
</g:if>

%{--

<div class="col-md-2 " style="font-size: 10px;">
    Necesario para el ATS
</div>
--}%

<script type="text/javascript">

    $("#tipoCmprSustento").click(function () {
//        console.log("clic en tipoCmprSustento")
        var prve = $("#prve__id").val();
        if(!prve) {
            $("#btn_buscar").click()
        }
    });

    $("#btn_cargarCp").click(function () {
//        console.log("change...", $("#tipoCmprSustento").val());
        if($("#tipoCmprSustento").val() != '-1') {
            $("#tipoCmprSustento").change()
        }
    });



    $("#tipoCmprSustento").change(function () {
        var tptr = $(".tipoProcesoSel option:selected").val();
        var sstr = $(".sustentoSri option:selected").val();
        var prve = $("#prve__id").val();

//        console.log("cambia tipoCmprSustento")
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'cargaTcsr')}",
            data: {
                tptr: tptr,
                prve: prve,
                sstr: sstr,
                tpcp: "${tpcpSri}",
                etdo: "${estado}"
            },
            success: function (msg) {
                $("#divComprobanteSustento").html(msg)
                $("#divComprobanteSustento").show()
            }
        });
    });

</script>