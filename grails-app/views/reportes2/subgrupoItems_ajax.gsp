<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 19/10/17
  Time: 12:53
--%>

<g:select name="subGrupo2_name" id="subGrupo2" from="${subgrupo}"
          optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione el subgrupo']"
          class="form-control"/>




<script type="text/javascript">

    cargarDepartamento($("#subGrupo2").val());

    function cargarDepartamento(subgrupo){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes2', action: 'departamentoItems_ajax')}',
            data:{
                subgrupo: subgrupo
            },
            success: function (msg) {
                $("#divDepartamento").html(msg)
            }
        })
    }

    $("#subGrupo2").change(function () {
        var subgrupo = $(this).val();
        cargarDepartamento(subgrupo)
    });


</script>