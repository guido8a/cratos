<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/12/17
  Time: 12:16
--%>

<div class="row">
%{--
    <div class="col-xs-3 negrilla text-info">
        Empresa
    </div>
--}%

    <div class="col-xs-12">
        <g:textField name="empresa_name" value="Empresa: ${empresa?.nombre}" readonly="" class="form-control" style="text-align: center"/>
    </div>
</div>

<div class="row">
    <g:hiddenField name="id_name" id="idSuc" value=""/>
    <div class="col-xs-1 negrilla text-info">
        Número:
    </div>

    <div class="col-xs-2">
        <g:textField name="numero" id="numeroSuc" maxlength="3" class="form-control" value=""/>
    </div>

    <div class="col-xs-1 negrilla text-info">
        Nombre:
    </div>

    <div class="col-xs-6">
        <g:textField name="nombre" id="nombreSuc" maxlength="63" class="form-control" value=""/>
    </div>
</div>

<div class="row">
    <div class="col-xs-1 negrilla text-info" >
        Dirección:
    </div>

    <div class="col-xs-9">
        <g:textArea name="direccion" id="direccionSuc" class="form-control" value="" maxlength="255" style="width: 100%; height: 55px; resize: none"/>
    </div>

    <a href="#" class="btn btn-success btnAgregarSucursal" title="Agregar Sucursal"><i class="fa fa-plus"></i> Agregar</a>
    <a href="#" class="btn btn-primary btnLimpiarCampos" title="Limpiar campos de texto"><i class="fa fa-eraser"></i></a>
</div>

<div class="row" id="divTablaSucursales">

</div>

<script type="text/javascript">

    cargarTablaSucursales();

    function cargarTablaSucursales () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'empresa', action: 'tablaSucursales_ajax')}',
            data:{
                id: '${empresa?.id}'
            },
            success: function (msg){
                $("#divTablaSucursales").html(msg)
            }
        })
    };

    $(".btnAgregarSucursal").click(function () {
        var numero = $("#numeroSuc").val();
        var nombre = $("#nombreSuc").val();
        var direccion = $("#direccionSuc").val();
        var sucursal = $("#idSuc").val();

        if(numero == '' || nombre == '' || direccion == ''){
            bootbox.alert("<i class='fa fa-warning fa-3x pull-left text-warning text-shadow'></i> Ingrese todos los campos!")
        }else{
            openLoader("Guardando...");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'empresa', action: 'guardarSucursal_ajax')}',
                data:{
                    id: '${empresa?.id}',
                    numero: numero,
                    nombre: nombre,
                    direccion: direccion,
                    sucursal: sucursal
                },
                success: function (msg){
                    closeLoader();
                    if(msg == 'ok'){
                        log("Sucursal creada correctamente","success");
                        cargarTablaSucursales();
                    }else{
                        log("Error al crear la sucursal","error")
                    }
                }
            })
        }

    });


    $(".btnLimpiarCampos").click(function () {
        $("#idSuc").val("");
        $("#numeroSuc").val("");
        $("#nombreSuc").val("");
        $("#direccionSuc").val("");
    });

</script>