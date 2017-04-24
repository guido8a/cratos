<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 2/14/14
  Time: 4:20 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Errores</title>
    </head>

    <body>
        <elm:flashMessage tipo="${flash.tipo}" icon="${flash.icon}" clase="${flash.clase}" title="${flash.title}">
            ${flash.message}
        </elm:flashMessage>
    </body>
</html>