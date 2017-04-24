<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main"/>
    <title>Rubros</title>
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
    <p class="css-vertical-text">Rubros</p>
    <div class="linea"></div>

    <input type="hidden" name="id" id="id"/>

    <div class="row">
        <div class="col-xs-1 negrilla">
            Tipo:
        </div>
        <div class="col-xs-3 ">
            <g:select class="form-control izquierda required" name="tipoRubro.id" from="${tipos}" id="tipoRubro" optionKey="id"  required=""/>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-1 negrilla">
            Descripción:
        </div>
        <div class="col-xs-5 ">
            <g:textField name="descripcion" id="descripcion"  class="form-control required" maxlength="63"/>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-1 negrilla">
            Porcentaje:
        </div>
        <div class="col-xs-2 ">
            <g:textField class="form-control  required" name="porcentaje"  id="porcentaje" />
        </div>

        <div class="col-xs-1 negrilla">
            Valor:
        </div>
        <div class="col-xs-2 ">
            <g:textField name="valor" id="valor" class="form-control  required"/>
        </div>

    </div>
    <div class="row">
        <div class="col-xs-1 negrilla">
            IESS:
        </div>
        <div class="col-xs-1 negrilla">
            <g:checkBox name="iess" id="iess" class="  required"/>
        </div>
        <div class="col-xs-1 negrilla">
            Gravable:
        </div>
        <div class="col-xs-1 negrilla">
            <g:checkBox name="gravable" id="gravable" class="  izquierda required"/>
        </div>
        <div class="col-xs-1 negrilla">
            Décimo:
        </div>
        <div class="col-xs-1 negrilla">
            <g:checkBox name="decimo" id="decimo" class=" izquierda required"/>
        </div>
        %{--<div class="col-xs-1 negrilla">--}%
            %{--Editable:--}%
        %{--</div>--}%
        %{--<div class="col-xs-1 negrilla">--}%
            %{--<g:checkBox name="editable" id="editable" class=" izquierda required"/>--}%
        %{--</div>--}%


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


    $(".lista").click(function () {
        location.href="${g.createLink(controller: 'rubro', action: 'list')}"
    });


    $("#tipoRubro").change(function(){

        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'rubro',action: 'cargaRubros')}",
            data    : "id=" +$("#tipoRubro").val(),
            success : function (msg) {

                $("#detalle").html(msg).show("slide")
            }
        });
    });

    $("#tipoRubro").change()

    $(".agregar").click(function () {


        $.ajax({
            type : "POST",
            url  : "${g.createLink(controller: 'rubro', action: 'saveRubro')}",
            data : {
                id:$("#id").val(),
                tipoRubro : $("#tipoRubro").val(),
                porcentaje : $("#porcentaje").val(),
                valor: $("#valor").val(),
                descripcion : $("#descripcion").val(),
                iess:         $("#iess").is(':checked'),
                gravable     :$("#gravable").is(':checked'),
                decimo       :$("#decimo").is(':checked'),
                editable     :$("#editable").is(':checked')

            },
            success : function (msg) {
                var part = msg
                if(part == 'OK'){
                    $.ajax({
                        type    : "POST",
                        url     : "${g.createLink(controller: 'rubro',action: 'cargaRubros')}",
                        data    : "id=" +$("#tipoRubro").val(),
                        success : function (msg) {

                            $("#detalle").html(msg)
                        }
                    });



                }else {

                    bootbox.alert("Error al grabar el rubro")

                }





            }



        });

        return false;
    });


</script>
</body>
</html>