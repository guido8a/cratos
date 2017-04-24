<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main"/>
    <title>Asignación de rubros</title>
    <style type="text/css">
    .etiqueta {
        width       : 80px;
        height      : 20px;
        line-height : 20px;
        font-weight : bold;
        display     : inline-block;
        margin-left: 5px;
    }
    .margen{
        margin-left: 20px;
    }
    th{
        text-align: center;
    }

    table{
        border-collapse:collapse;
    }
    td,th{
        border: 1px solid #000000;
    }

    .izquierda {
        float: left;

    }
    .fila {
        clear: both;

    }
    .uno{

        width: 150px;

    }

    .dos {
        width: 80px;
        margin-left: 15px;

    }
    </style>
</head>
<body>

<div class="vertical-container vertical-container-list">
    <p class="css-vertical-text">Asignación de Rubros</p>
    <div class="linea"></div>

    <g:hiddenField name="id" id="rubro_id"/>

    <div class="row">
        <div class="col-xs-1 negrilla">

        </div>
        <div class="col-xs-3 ">

        </div>
    </div>
    <div class="row">
        <div class="col-xs-2 negrilla">
            Tipo de Contrato:
        </div>
        <div class="col-xs-3 ">
            <g:select name="tipoContrato" from="${tipos}" id="tipoContrato" optionKey="id" optionValue="descripcion" class="form-control izquierda" style="width: 250px; margin-bottom: 10px"/>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-2 negrilla">
            Tipo de Rubro:
        </div>
        <div class="col-xs-3 ">
            <g:select name="tipoRubro" from="${tiposRubro}" id="tipoRubro" optionKey="id" class="form-control izquierda"  style="width: 250px; margin-bottom: 10px"/>
        </div>
        <div class="col-xs-1 negrilla">
            Rubros:
        </div>
        <div class="col-xs-3 ">
            <div id="div_rubros"></div>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-2 negrilla">
            Porcentaje:
        </div>
        <div class="col-xs-3 ">
            <g:textField class="form-control izquierda required" name="rubro_porcentaje"  id="rubro_porcentaje" style="width: 100px; margin-bottom: 10px"/>
        </div>
        <div class="col-xs-1 negrilla">
            Valor:
        </div>
        <div class="col-xs-3 ">
            <g:textField name="rubro_valor" id="rubro_valor" style="width: 90px; margin-bottom: 10px" class="form-control izquierda required"/>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-1 negrilla">
            IESS:
        </div>
        <div class="col-xs-1 ">
            <g:checkBox name="rubro_iess" id="rubro_iess" class="  required" checked=""/>
        </div>
        <div class="col-xs-1 negrilla">
            Gravable:
        </div>
        <div class="col-xs-1 ">
            <g:checkBox name="rubro_gravable" id="rubro_gravable" class="   required" checked=""/>
        </div>
        <div class="col-xs-1 negrilla">
            Décimo:
        </div>
        <div class="col-xs-1 ">
            <g:checkBox name="rubro_decimo" id="rubro_decimo" class="  required" checked=""/>
        </div>
    </div>

    <div class="fila" style="margin-top: 40px; margin-bottom: 15px">
        <g:link class="btn agregar btn-success btn-ajax" id="agregar"><i class="fa fa-plus"></i> Agregar</g:link>

    </div>

    <fieldset style="width: 90%;margin-left: 20px;">
        <legend>Rubros</legend>
        <div id="detalle" style="width: 95%"></div>
        <legend style="margin-top: 20px"></legend>
    </fieldset>
    <div id="errors" style="display: none"></div>
</div>
<script type="text/javascript">
    $("#tipoRubro").change(function(){


        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'rubro',action: 'cargaRubrosCombo')}",
            data    : "id=" +$("#tipoRubro").val(),
            success : function (msg) {

                $("#div_rubros").html(msg).show()

                $("#rubro_iess").attr("checked", false);
                $("#rubro_gravable").attr("checked", false);
                $("#rubro_decimo").attr("checked", false);

                $("#rubro_valor").val('');
                $("#rubro_porcentaje").val('');






            }
        });
    });
    $("#tipoRubro").change()

    $("#tipoContrato").change(function(){
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'rubro',action: 'cargaRubrosContrato')}",
            data    : "id=" +$("#tipoContrato").val(),
            success : function (msg) {

                $("#detalle").html(msg).show("slide")
            }
        });
    })
    $("#tipoContrato").change()



    $(".agregar").click(function(){


        //old

        var id = $("#rubro_id").val()

        var porcentaje = $("#rubro_porcentaje").val()
        var valor = $("#rubro_valor").val()
        var iess=0
        var grav=0
        var decimo=0
        var msn=""
        if(isNaN(porcentaje) || porcentaje=="")
            porcentaje=-1
        if(porcentaje*1<0)
            msn+="Error: El porcentaje debe ser un número positivo <br>"
        if(isNaN(valor) || valor=="")
            valor=-1
        if(valor*1<0)
            msn+="Error: El valor debe ser un número positivo"
//        if($("#rubro_iess").attr("checked")=="checked")
        if($("#rubro_iess").is("checked"))
            iess=1
//        if($("#rubro_decimo").attr("checked")=="checked")
        if($("#rubro_decimo").is("checked"))
            decimo=1
//        if($("#rubro_gravable").attr("checked")=="checked")
        if($("#rubro_gravable").is("checked"))
            grav=1

        if(msn==""){
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'rubro',action: 'addRubroContrato')}",
                data    : "id=" +id+"&porcentaje="+porcentaje+"&valor="+valor+"&iess="+iess+"&decimo="+decimo+"&grav="+grav+"&tipo="+$("#tipoRubro").val()+"&rubro="+$("#rubros").val()+"&tipoContrato="+$("#tipoContrato").val(),
                success : function (msg) {
                    $("#rubro_gravable").attr("checked",false)
                    $("#rubro_iess").attr("checked",false)
                    $("#rubro_decimo").attr("checked",false)
                    $("#detalle").html(msg).show("slide")
                    $("#rubro_porcentaje").val("")
                    $("#rubro_valor").val("")
                    $("#rubro_id").val("")
                    $("#rubro_descripcion").val("")
                }
            });
        }else{

            bootbox.alert(msn)

        }


        return false;


    });



</script>
</body>
</html>