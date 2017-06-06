<html>

<head>
    <title>Gestores</title>
    <meta name="layout" content="main"/>

</head>

<body>
<g:if test="${flash.message}">
    <div class="alert ${flash.tipo == 'error' ? 'alert-danger' : flash.tipo == 'success' ? 'alert-success' : 'alert-info'} ${flash.clase}">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <g:if test="${flash.tipo == 'error'}">
            <i class="fa fa-warning fa-2x pull-left"></i>
        </g:if>
        <g:elseif test="${flash.tipo == 'success'}">
            <i class="fa fa-check-square fa-2x pull-left"></i>
        </g:elseif>
        <g:elseif test="${flash.tipo == 'notFound'}">
            <i class="icon-ghost fa-2x pull-left"></i>
        </g:elseif>
        <p>
            ${flash.message}
        </p>
    </div>
</g:if>
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link class="btn btn-info" action="formGestor">
            <i class="fa fa-file-o"></i> Crear nuevo Gestor
        </g:link>
    </div>
</div>
<div style="margin-top: -50px;" class="vertical-container-no-padding">
    <div id="divContenido">
        <g:form action="buscarGestor" class="buscarGestor">
            <div class="ui-state-error ui-corner-all ui-helper-hidden" style="padding: 5px; margin-bottom: 10px;">
                <span class="icon ui-icon ui-icon-alert" style="margin-top: 0; margin-right: 10px;"></span>
                <span id="error">error!</span>
            </div>
            <div class="row">
                <div class="col-xs-2 negrilla">
                </div>
                <div class="col-xs-4 negrilla">
                    Nombre del gestor:
                    <input type="text" name="nombre" id="txtBusca" class="form-control required label-shared"/>
                </div>

                <div class="col-xs-3 negrilla">
                    <a href="#" id="buscarGestor" class="btn btn-azul">
                        <i class="fa fa-search"></i>
                        Buscar
                    </a>
                </div>
            </div>

        </g:form>
    </div>

    <table class="table table-bordered table-hover table-condensed" width="800px">
        <thead>
        <tr>
            <th style="width: 440px">
                Nombre
            </th>
            <th style="width: 300px">
                Observaciones
            </th>
            <th style="width: 60px">Acciones</th>
        </tr>
        </thead>
    </table>

    <div class="row-fluid"  style="width: 99.7%;height: 500px;overflow-y: auto;float: right;">
        <div class="span12">
            <div id="divLista" style="width: 1120px; height: 450px;"></div>
        </div>
    </div>

    %{--<div id="divLista" style="clear: both; padding: 5px; margin-top: 5px;max-height: 490px;overflow-y: auto">--}%
    %{--</div>--}%
</div> <!-- container -->
<script type="text/javascript">


    $(function () {
        enviar();
        $("#buscarGestor").click(function () {
            enviar();
        });

        $("#txtBusca").keydown(function (ev) {
            if (ev.keyCode == 13) {
                enviar();
                return false;
            }
            return true;
        });

        function enviar() {
            openLoader("Buscando")
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(action: 'buscarGestor')}",
                data    : $(".buscarGestor").serialize(),
                success : function (msg) {
                    closeLoader()
                    $("#divLista").html(msg).show("slide");

                }
            });
        }
    });

</script>
</body>

</html>