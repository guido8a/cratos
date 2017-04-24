<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    %{--<link href="${resource(dir: 'bootstrap-3.0.1/css', file: 'bootstrap.spacelab.css')}" rel="stylesheet">--}%
    <link href="${resource(dir: 'bootstrap-3.0.1/css', file: 'bootstrap.happy1.css')}" rel="stylesheet">

    <meta name="layout" content="loginL">
    <title>Cratos - Login</title>

    <style type="text/css">
    .archivo {
        width      : 100%;
        float      : left;
        margin-top : 30px;
        text-align : center;
    }
    .negrilla{

        height:35px;
        line-height: 35px;
    }

    .rotate{
        -webkit-transform : rotate(-20deg);
        -moz-transform    : rotate(-20deg);
    }
    .mensaje-svt{
        width: 300px;
        height: 25px;
        padding: 3px;
        border: 1px solid #A94442;
        display: none;
        background: #F2DEDE;
        color:#A94442 ;
    }
    .mensaje-svt:before, .mensaje-svt:after{
        position: absolute;
        content: "";
        width: 0px;
        height: 0px;
        border: 1px solid #A94442;
    }
    .mensaje-svt:before{
        left:303;
        top:6 ;
        width: 16px;
        height: 16px;
        background: #F2DEDE;
        -webkit-border-radius: 8px;
        -moz-border-radius: 8px;
        border-radius: 8px;
    }
    .mensaje-svt:after{
        left:322;
        top:12 ;
        width: 12px;
        height: 12px;
        background: #F2DEDE;
        -webkit-border-radius: 6px;
        -moz-border-radius: 6px;
        border-radius: 6px;
    }
    </style>
</head>

<body>
%{--<div style="text-align: center; margin-top: -60px; height: 580px;" class="well">--}%
<div style="text-align: center; width: 499px;margin: auto;height: 80px;background: #FFE0AB;padding: 6px;position: relative;margin-top: 80px" class="ui-corner-all">
    <div style="position: absolute;left: 0px;top:0px;width: 70px;height: 70px;" class="rotate">
        <img src="${g.resource(dir: 'images',file: 'cratos.jpeg')}" width="70px" height="70px">
    </div>
    <div class="titulo-azul" style="font-size: 17px;margin-left: 30px">Cratos -  <p class="text-info" style="display: inline">Sistema Integrado de Contabilidad</p></div>
    <p class="text-info" style=";margin-left: 50px" >Inventarios, Nómina, Activos Fijos y Comercialización</p>
</div>

<div class="ui-corner-all etiqueta-container " style="height: 245px;width: 500px;margin: auto;background: #FFC766;padding: 0px" >
    <div class="etiqueta-svt">
        Ingreso al sistema
    </div>
    <div style="width: 80%;margin: auto;">
        <g:form name="frmLogin" action="savePer" class="form-horizontal frm-login">
            <div id="data">
                <div class="row" style="">
                    <div class="col-xs-4 negrilla" style="text-align: center">
                        Usuario
                    </div>
                    <div class="col-xs-8 negrilla" style="">
                        <input name="login" id="login" type="text" class="form-control required"   autofocus >
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4 negrilla" style="">
                        Contraseña
                    </div>
                    <div class="col-xs-8 negrilla" style="">
                        <input name="pass" id="pass" type="password" class="form-control required"  >
                    </div>
                </div>
                <div style="width: 100%;height: 40px;margin-top: 20px;text-align: right;">
                    <a href="#" id="ingresar" class="btn btn-azul" >
                        <i class="icon-off"></i>Ingresar</a>
                </div>
            </div>
        </g:form>
    </div>

    %{--<div class="archivo">--}%
    %{--Le recomendamos descargar y leer el--}%
    %{--<a href="${createLink(uri: '/')}"><img--}%
    %{--src="${resource(dir: 'images', file: 'pdf_pq.png')}"/>manual de usuario</a>--}%
    %{--</div>--}%

    %{--<div style="text-align: center ; color:#004060; margin-top:120px; font-size: 10px;">Desarrollado por: TEDEIN S.A. Versión ${message(code: 'version', default: '1.1.0x')}</div>--}%
    <p  style="font-size: 10px;width: 220px;height: 20px;position: absolute;bottom: 0px;right: 0px;margin: 0px">
       <a href="http://www.tedein.com.ec" style="text-decoration: none;color:#000000;" target="_blank">
           Desarrollado por: TEDEIN S.A. Versión ${message(code: 'version', default: '1.1.0x')}
       </a>
    </p>
    <div style=" position: absolute;left: 32;bottom: 53px;" class=" mensaje-svt ui-corner-all" id="msg-container" >
        <button type="button" class="close" id="close-mensaje">&times;</button>
        <p>
            <i class="fa fa-warning fa-1x pull-left  " style="margin-right: 5px;margin-top: 2px" ></i>
            <span id="msg"></span>
        </p>
    </div>
</div>




<script type="text/javascript">
    var $frm = $("#frmLogin");
    function doLogin() {
        var band=true
        $("#msg-container").fadeOut()
        if($("#login").val()=="" || $("#pass").val()=="")
            band=false
//        console.log("aa",$("#login").val(),$("#pass").val(),band)
        if (band) {
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(action: 'validar')}",
                data    : $(".frm-login").serialize(),
                success : function (msg) {
                    if(!msg.match("error")){
                        $("#data").html(msg)
                    }else{
                        var parts=msg.split("_")
                        $("#msg").html(parts[1])
                        $("#msg-container").fadeIn("slow")
                    }
                }
            });
        }else{
            $("#msg").html("Ingrese su usuario y contraseña")
            $("#msg-container").fadeIn("slow")
        }
    }
    ;

    $(function () {
        $("#modalBody").draggable({
            handle : ".modal-header"
        });
        $("#close-mensaje").click(function(){
            $(this).parent().fadeOut("slow")
        })

        $("#ingresar").click(function () {
            doLogin()
        });


        $("#btn-login").click(function () {
            doLogin();
        });
        $("input").keyup(function (ev) {
            if (ev.keyCode == 13) {
                doLogin();
            }
        });
    });
</script>

</body>
</html>