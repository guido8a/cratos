<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 20/10/17
  Time: 13:21
--%>

<%@ page import="cratos.inventario.Grupo" %>

<script src="${resource(dir: 'js/plugins/Toggle-Button-Checkbox/js', file: 'bootstrap-checkbox.js')}"></script>

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


<div class="fila" style="margin-bottom: 15px">
    <div class="col-md-2">
        <label class="uno">Contabilidad:</label>
    </div>
    <div class="col-md-4">
        <g:select name="contK2" id="contK3"
                  from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                  optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                  class="form-control dos"/>
    </div>
    <div class="col-md-2">
        <label class="uno">Bodega:</label>
    </div>
    <div class="col-md-2">
        <g:select name="bode_name" id="bode3"
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
        <elm:datepicker name="fechaDesde" title="Fecha desde" id="fechaDK3" class="datepicker form-control fechaDeK3"
                        maxDate="new Date()"/>
    </div>

    <div class="col-md-1">
        <label>Hasta: </label>
    </div>
    <div class="col-md-2">
        <elm:datepicker name="fechaHasta" title="Fecha hasta" id="fechaHK3" class="datepicker form-control fechaHaK3"
                        maxDate="new Date()"/>
    </div>

    <div class="col-md-2">
        <a href="#" class="btn btn-success" id="btnImprimir">
            <i class="fa fa-print"></i> Imprimir
        </a>
    </div>


    <div class="col-md-2">
        Imprimir con valores:
    </div>
    <div class="col-md-2">
        <g:checkBox name="valores_name" id="valores" class="form-control valo" data-on-Label="Si"/>
    </div>

</div>


<script type="text/javascript">

    $(function() {
        $("#valores").checkboxpicker({
        });
    });


    $("#btnImprimir").click(function () {
        var cont = $("#contK3").val();
        var fechaDesde = $(".fechaDeK3").val();
        var fechaHasta = $(".fechaHaK3").val();
        var bodega = $("#bode3").val();
        var departamento = $("#departamento2").val();
        var valores = $(".valo").prop('checked');

        if (cont == '-1') {
            bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una contabilidad!")
        } else {
            if(bodega == '-1'){
                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una bodega!")
            }else{
                if(fechaDesde == '' || fechaHasta == ''){
                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione las fechas!")
                }else{
                    if(departamento == '-1'){
                        bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione el departamento!")
                    }else{
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                            data:{
                                desde: fechaDesde,
                                hasta: fechaHasta
                            },
                            success: function (msg){
                                if(msg == 'ok'){
                                    url = "${g.createLink(controller:'reportes2' , action: 'kardex3')}?cont=" + cont + "Wemp=${session.empresa.id}" + "Wdesde=" + fechaDesde + "Whasta=" + fechaHasta + "Wbodega=" + bodega + "Wdepartamento=" + departamento + "Wvalor=" + valores;
                                    location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=kardex.pdf"
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

