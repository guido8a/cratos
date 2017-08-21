<div class="col-md-2 negrilla" style="font-size: ${esta == '1' ? '12px' : '14px'}">
    Tipo de comprobante:
</div>

<div class="col-md-9 negrilla">


    <g:if test="${reembolso}">
        <g:select class="form-control cmbRequired" name="tipoComprobanteSri.id" id="tipoComprobante"
                  from="${data}"
                  optionKey="id" title="Tipo de comprobante" optionValue="${{it.codigo  + ' - ' + it.descripcion}}"
                  noSelection="${['-1': 'Seleccione...']}" value="${reembolso?.tipoCmprSustento?.id}" disabled="${estado == 'R' ? true : false}"/>

    </g:if>
    <g:else>
        <g:select class="form-control cmbRequired" name="tipoComprobanteSri.id" id="tipoComprobante"
                  from="${data}"
                  optionKey="id" title="Tipo de comprobante" optionValue="${{it.codigo  + ' - ' + it.descripcion}}"
                  noSelection="${['-1': 'Seleccione...']}" value="${tpcpSri?:12}" disabled="${estado == 'R' ? true : false}"/>
    </g:else>


</div>


<script type="text/javascript">

    $("#tipoComprobante").change(function () {
        var tpps = $(".tipoProcesoSel option:selected").val();
//        console.log("cambia tpcp+++", $("#tipoComprobante").val())
        if(${esta != '1'}){
            cargarTipo( $(".tipoProcesoSel option:selected").val(), $("#tipoComprobante").val(), $("#prve__id").val(), tpps);
        }
    });

</script>