<div class="row" style="">
    <div class="col-xs-4 negrilla" style="text-align: center">
        Perfil
    </div>
    <div class="col-xs-8 negrilla" style="">
        <g:select name="prfl"  from="${perfiles}" optionKey="id" optionValue="perfil" id="perfil" class="form-control"/>
    </div>
</div>
<div class="row">

</div>
<div style="width: 100%;height: 40px;margin-top: 20px;text-align: right;">
    <a href="#" id="ing_perfil" class="btn btn-azul" >
        <i class="icon-off"></i>Ingresar</a>
</div>
<script type="text/javascript">
    $("#ing_perfil").click(function(){
        if(${contabilidades?.size() > 0}){
            $(".frm-login").submit();
        }else{
            var seleccionado = $("#perfil option:selected").val();
            $.ajax({
               type:'POST',
                url: '${createLink(controller: 'login', action: 'verificarPerfil_ajax')}',
                data:{
                    sesion: seleccionado
                },
                success: function(msg){
                    if(msg == 'ok'){
                        $(".frm-login").submit();
                    }else{
                        $("#msg").html("Su empresa no tiene asociada ninguna contabilidad, contacte al administrador.");
                        $("#msg-container").fadeIn("slow")
                    }
                }
            });
        }
    });

    $("#perfil").bind('keyup',function(e) {
        if(e.which === 13) {
            $(".frm-login").submit();
        }
    });

</script>