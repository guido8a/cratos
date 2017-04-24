<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 2/4/14
  Time: 1:18 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Cambiar contabilidad</title>
    </head>

    <body>
        <g:form action="cambiarContabilidad" name="frmContabilidad">
            <div class="row">
                <div class="col-md-2">
                    <b>Usuario:</b>
                </div>

                <div class="col-md-6">
                    ${yo.nombre} ${yo.apellido} (${yo.login})
                </div>
            </div>

            <div class="row">
                <div class="col-md-2">
                    <b>Contabilidad actual:</b>
                </div>

                <div class="col-md-6">
                    ${cont}
                </div>
            </div>

            <div class="row">
                <div class="col-md-2">
                    <b>Cambiar a contabilidad:</b>
                </div>

                <div class="col-md-5">
                    <g:select name="contabilidad" from="${contabilidades}" class="form-control" optionKey="id"/>
                </div>
            </div>
        </g:form>
        <div class="row">
            <div class="col-md-6 text-center">
                <a href="#" class="btn btn-success" id="btnSave">
                    <i class="fa fa-save"></i> Guardar
                </a>
            </div>
        </div>

        <script type="text/javascript">
            $("#btnSave").click(function () {
                $("#frmContabilidad").submit();
            });
        </script>

    </body>
</html>