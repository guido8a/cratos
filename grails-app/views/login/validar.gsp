<div class="row" style="">
    <div class="col-xs-4 negrilla" style="text-align: center">
        Perfil
    </div>
    <div class="col-xs-8 negrilla" style="">
        <g:select name="prfl" from="${perfiles}" optionKey="id" optionValue="perfil" id="perfil" class="form-control" ></g:select>
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
      $(".frm-login").submit();
    })
</script>