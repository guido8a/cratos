<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 12/09/17
  Time: 15:08
--%>

<table class="table table-bordered table-hover table-condensed" style="width: 1070px">
        <tbody>
        <g:each in="${proveedores}" var="proveedor">
            <tr>
                <td style="width: 40px">${proveedor?.ruc}</td>
                <td style="width: 250px">${proveedor?.nombre}</td>
                <td style="width: 40px">${proveedor?.tipoProveedor?.descripcion}</td>
                <td style="width: 80px">${proveedor?.tipoIdentificacion?.descripcion}</td>
                <td style="width: 150px">${proveedor?.direccion}</td>
                <td style="width: 90px; text-align: center">
                    <a href="#" class="btn btn-info btn-sm btn-show" data-id="${proveedor?.id}"><i class="fa fa-search"></i></a>
                    <a href="#" class="btn btn-success btn-sm btn-edit" data-id="${proveedor?.id}"><i class="fa fa-pencil"></i></a>
                    <a href="#" class="btn btn-danger btn-sm btn-delete" data-id="${proveedor?.id}"><i class="fa fa-trash-o"></i></a>
                </td>
            </tr>
        </g:each>
        </tbody>
</table>

<script type="text/javascript">
    $(".btn-show").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'show_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                bootbox.dialog({
                    title   : "Ver Proveedor",
                    message : msg,
                    buttons : {
                        ok : {
                            label     : "Aceptar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    }
                });
            }
        });
    });

    $(".btn-edit").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });
    $(".btn-delete").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

</script>