<%@ page import="cratos.inventario.Grupo" %>
<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 19/10/17
  Time: 11:22
--%>


<style type="text/css">

.letra{
    font-size: 11px;
    font-weight: bold;
}

</style>



<div class="fila">

    <div class="col-md-1">
        <label class="letra">Grupo: </label>
    </div>
    <div class="col-md-3">
        <g:select name="grupo_name" id="grupo2"
                  from="${cratos.inventario.Grupo.list([sort: 'codigo'])}"
                  optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione el grupo']"
                  class="form-control"/>
    </div>

    <div class="col-md-1">
        <label class="letra">Subgrupo: </label>
    </div>
    <div class="col-md-3" id="divSubgrupo">
    </div>

    <div class="col-md-1">
        <label class="letra">Departamento: </label>
    </div>
    <div class="col-md-3" id="divDepartamento">
    </div>

</div>

<div class="fila">
    <g:hiddenField name="item_name" id="item2ID"/>

    <div class="col-md-1">
        <label><strong>Item</strong></label>
    </div>

    <div class="col-md-1">
        <label>Código: </label>
    </div>

    <div class="col-md-2">
        <g:textField name="desc_name" id="codigo2" class="form-control"/>
    </div>

    <div class="col-md-1">
        <label>Nombre: </label>
    </div>

    <div class="col-md-5">
        <g:textField name="item_name" id="item2" class="form-control"/>
    </div>

    <div class="col-md-2">
        <a href="#" class="btn btn-info" id="btnBuscarItem">
            <i class="fa fa-search"></i> Buscar
        </a>
        <a href="#" class="btn btn-warning" id="btnLimpiar" title="Limpiar Búsqueda">
            <i class="fa fa-eraser"></i>
        </a>
    </div>
</div>

<div class="fila hidden" style="height: 350px;" id="filaItems">
    <table class="table table-bordered table-hover table-condensed">
        <thead>
        <tr style="width: 600px">
            <th style="width: 100px">Código</th>
            <th style="width: 450px">Descripción</th>
            <th style="width: 50px"><i class="fa-fa-check"></i></th>
        </tr>
        </thead>
    </table>
    <div id="divTablaItems">
    </div>
</div>

<div class="fila" style="margin-bottom: 15px">
    <div class="col-md-2">
        <label class="uno">Contabilidad:</label>
    </div>
    <div class="col-md-4">
        <g:select name="contK2" id="contK2"
                  from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                  optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                  class="form-control dos"/>
    </div>
    <div class="col-md-2">
        <label class="uno">Bodega:</label>
    </div>
    <div class="col-md-2">
        <g:select name="bode_name" id="bode2"
                  from="${cratos.inventario.Bodega.findAllByEmpresa(session.empresa, [sort: 'codigo'])}"
                  optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la bodega']"
                  class="form-control dos"/>
    </div>
</div>

<div class="fila">
    <div class="col-md-1">
        <label>Desde: </label>
    </div>
    <div class="col-md-2">
        <elm:datepicker name="fechaDesde" title="Fecha desde" id="fechaDK2" class="datepicker form-control fechaDeK2"
                        maxDate="new Date()"/>
    </div>

    <div class="col-md-1">
        <label>Hasta: </label>
    </div>
    <div class="col-md-2">
        <elm:datepicker name="fechaHasta" title="Fecha hasta" id="fechaHK2" class="datepicker form-control fechaHaK2"
                        maxDate="new Date()"/>
    </div>

    <div class="col-md-2">
        <a href="#" class="btn btn-success" id="btnImprimir">
            <i class="fa fa-print"></i> Imprimir
        </a>
    </div>
</div>


<script type="text/javascript">

    $("#btnLimpiar").click(function () {
        $("#item2").val('');
        $("#codigo2").val('');
        $("#item2ID").val();

        $("#filaItems").addClass('hidden');
    });

    $("#btnImprimir").click(function () {
        var cont = $("#contK2").val();
        var fechaDesde = $(".fechaDeK2").val();
        var fechaHasta = $(".fechaHaK2").val();
        var bodega = $("#bode2").val();
        var item = $("#item2ID").val();
        var nombre = $("#item2").val();

        if (cont == '-1') {
            bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una contabilidad!")
        } else {
            if(bodega == '-1'){
                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una bodega!")
            }else{
                if(fechaDesde == '' || fechaHasta == ''){
                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione las fechas!")
                }else{
                    if(nombre == ''){
                        bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione un item!")
                    }else {
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                            data:{
                                desde: fechaDesde,
                                hasta: fechaHasta
                            },
                            success: function (msg){
                                if(msg == 'ok'){
                                    url = "${g.createLink(controller:'reportes3' , action: 'kardex4')}?cont=" + cont + "Wemp=${session.empresa.id}" + "Wdesde=" + fechaDesde + "Whasta=" + fechaHasta + "Wbodega=" + bodega + "Witem=" + item;
                                    location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=existenciasXItem.pdf"
                                }else{
                                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                                    return false;
                                }
                            }
                        });
                    }
                }
            }
        }
    });

    $("#btnBuscarItem").click(function () {
        var departamento = $("#departamento2 option:selected").val();
        var item = $("#item2").val();
        var codigo = $("#codigo2").val();
        cargarTablaItems(departamento, item, codigo);
    });

    function cargarTablaItems (departamento, item, codigo) {
        $.ajax({
            type:'POST',
            url:'${createLink(controller: 'reportes2', action: 'tablaItems_ajax')}',
            data:{
                departamento: departamento,
                item: item,
                codigo: codigo
            },
            success: function (msg) {
                $("#filaItems").removeClass('hidden')
                $("#divTablaItems").html(msg)
            }
        });
    }

    cargarComboSubgrupo($("#grupo2").val());

    function cargarComboSubgrupo(grupo) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes2', action: 'subgrupoItems_ajax')}',
            data:{
                grupo : grupo
            },
            success: function (msg) {
                $("#divSubgrupo").html(msg)
            }
        }) ;
    }

    $("#grupo2").change(function () {
        var grupo = $(this).val()
        cargarComboSubgrupo(grupo)
    });

</script>

