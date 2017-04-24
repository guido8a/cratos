%{--<g:select name="rubros" id="rubros" from="${rubros}" optionKey="id" optionValue="descripcion" noSelection="['-1':'Seleccione...']"></g:select>--}%
<g:select name="rubros" from="${rubros}" id="rubros" optionKey="id" optionValue="descripcion" class="form-control izquierda"  style="width: 250px; margin-bottom: 10px" noSelection="['-1': 'Seleccione']"/>



<script type="text/javascript">


    $("#rubros").change(function(){
        if($(this).val() != "-1"){
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'rubro',action: 'getDatosRubro')}",
                data    : "id=" +$("#rubros").val(),

                success : function (msg) {
                    var datos = msg.split(";")
                    $("#rubro_porcentaje").val(datos[1])
                    $("#rubro_valor").val(datos[0])

                    if(datos[2]=="1") {
                      //  console.log("check?",$("#rubro_iess"))

                        $("#rubro_iess").prop('checked', true);
//                        $("#rubro_iess").attr("checked","checked")
                    }
                    else{
                        //$("#rubro_iess").removeAttr("checked")
                        $("#rubro_iess").prop('checked', false);
                    }

                    if(datos[3]=="1") {
                        $("#rubro_gravable").prop('checked', true);
                    }
                    else{
                        $("#rubro_gravable").prop('checked', false);
                    }

                    if(datos[4]=="1"){

                        $("#rubro_decimo").prop('checked', true);
                    }
                    else{
                        $("#rubro_decimo").prop('checked', false);
                    }


                }
            });
        }else{

            $("#rubro_porcentaje").val("")
            $("#rubro_valor").val("")

//            $("#rubro_iess").removeAttr("checked")
            $("#rubro_iess").attr("checked", false)

//            $("#rubro_gravable").removeAttr("checked")
            $("#rubro_gravable").attr("checked", false)

//            $("#rubro_decimo").removeAttr("checked")
            $("#rubro_decimo").attr("checked", false)
        }

    });
</script>