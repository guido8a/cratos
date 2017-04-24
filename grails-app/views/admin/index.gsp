<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 1/31/14
  Time: 4:01 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Administración</title>
    </head>

    <body>
        <p>
            Administración de valores generales del sistema. Permite crear empresas nuevas y personas dentro de cualquier empresa.
        </p>
        <ul class="fa-ul">
            <li>
                <i class="fa-li fa fa-building-o"></i>
                <g:link controller="empresa" action="listAdmin">
                    Empresas
                </g:link>
            </li>
            <li>
                <i class="fa-li fa fa-users"></i>
                <g:link controller="persona" action="listAdmin">
                    Usuarios
                </g:link>
            </li>
        </ul>
    </body>
</html>