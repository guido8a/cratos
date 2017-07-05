<div class="col-md-2 negrilla">
    Tipo de comprobante:
</div>

<div class="col-md-8 negrilla">
    <g:select class="form-control cmbRequired" name="tipoComprobanteSri.id" id="tipoComprobante"
              from="${data}"
              optionKey="id" title="Tipo de comprobante" optionValue="${{it.codigo  + ' - ' + it.descripcion}}"
              noSelection="${['-1': 'Seleccione...']}" value="${tpcpSri?:12}" readonly="${estado == 'R' ? true : false}"/>
</div>


<script type="text/javascript">

    $("#tipoComprobante").change(function () {
        var tpps = $(".tipoProcesoSel option:selected").val();
        console.log("cambia tpcp+++", $("#tipoComprobante").val())
        cargarTipo( $(".tipoProcesoSel option:selected").val(), $("#tipoComprobante").val(), $("#prve__id").val(), tpps);
    });

</script>