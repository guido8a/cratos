<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/12/17
  Time: 12:54
--%>



<table class="table table-bordered table-hover table-condensed" style="width: 100%">
    <thead>
    <tr>
        <th style="width: 15%">Número</th>
        <th style="width: 35%">Nombre</th>
        <th style="width: 38%">Dirección</th>
        <th style="width: 12%">Acciones</th>
    </tr>
    </thead>
    <tbody>

    <g:each in="${sucursales}" var="sucursal">
        <tr>
            <td style="text-align: center">${sucursal?.numero}</td>
            <td>${sucursal?.nombre}</td>
            <td>${sucursal?.direccion}</td>
            <td style="text-align: center">
                <a href="#" class="btn btn-sm btn-success btnEditar" data-id="${sucursal?.id}" data-num="${sucursal?.numero}" data-nom="${sucursal?.nombre}" data-dir="${sucursal?.direccion}"><i class="fa fa-pencil"></i></a>
                <a href="#" class="btn btn-sm btn-danger btnBorrar" data-id="${sucursal?.id}"><i class="fa fa-trash-o"></i></a>
            </td>
        </tr>
    </g:each>

    </tbody>
</table>

<script type="text/javascript">

        $(".btnEditar").click(function (){
            var id = $(this).data('id');
            var numero = $(this).data('num');
            var nombre = $(this).data('nom');
            var direccion = $(this).data('dir');
            $("#idSuc").val(id);
            $("#numeroSuc").val(numero);
            $("#nombreSuc").val(nombre);
            $("#direccionSuc").val(direccion);
        });

        $(".btnBorrar").click(function () {
            var id = $(this).data('id');
           $.ajax({
               type: 'POST',
               url: '${createLink(controller: 'empresa', action: 'borrarSucursal_ajax')}',
               data:{
                   id: id
               },
               success: function (msg){
                if(msg == 'ok'){
                    log("Sucursal borrada correctamente!","success");
                    cargarTablaSucursales();
                }else{
                    log("Error al borrar la sucursal","error");
                }
               }
           });
        });

</script>
