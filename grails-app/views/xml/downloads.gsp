<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 12/23/13
  Time: 12:54 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Archivos XML para descargar</title>

        <style type="text/css">
        .container {
            padding : 5px;
        }
        </style>
    </head>

    <body>

        <elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

        <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link action="xml" class="btn btn-default">
                    <i class="fa fa-arrow-left"></i> Regresar
                </g:link>
            </div>
        </div>


        <div class="vertical-container vertical-container-list">
            <p class="css-vertical-text">Archivos XML del ATS</p>

            <div class="linea"></div>

            <p>
                A continuación se presentan los archivos XML previamente generados. Haga click en el nombre del archivo para descargarlo.
            </p>

            <table class="table table-condensed table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th>Mes</th>
                        <th>Año</th>
                        <th>Fecha de creación</th>
                        <th>Descargar</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${list}" var="arch">
                        <tr>
                            <td>${arch.mes}</td>
                            <td>${arch.anio}</td>
                            <td>${arch.modified}</td>
                            <td>
                                <g:link action="downloadFile" params="[mes: arch.mes, anio: arch.anio]">
                                    ${arch.file}
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
    </body>
</html>