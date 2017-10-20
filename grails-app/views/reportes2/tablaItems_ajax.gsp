<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 19/10/17
  Time: 14:56
--%>
<div class="" style="width: 100%;height: 300px; overflow-y: auto;float: right; margin-top: -20px">
<table class="table table-bordered table-condensed">
    <tbody>
        <g:each in="${items}" var="item">

            <tr style="width: 600px">
                <td style="width: 100px">${item?.codigo}</td>
                <td style="width: 450px">${item?.nombre}</td>
                <td style="width: 50px; text-align: center">
                    <a href="#" class="btn btn-success btnSeleccionar" data-cod="${item?.codigo}" data-nom="${item?.nombre}" data-id="${item?.id}">
                        <i class="fa fa-check"></i>
                    </a>
                </td>
            </tr>
        </g:each>
    </tbody>
</table>
</div>

<script type="text/javascript">

    $(".btnSeleccionar").click(function () {
        var cd = $(this).data("cod");
        var nm = $(this).data("nom");
        var id = $(this).data("id");

        $("#codigo2").val(cd);
        $("#item2").val(nm);
        $("#item2ID").val(id)

        $("#filaItems").addClass('hidden')
    });


</script>