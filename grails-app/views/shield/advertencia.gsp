<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main"/>
        <title>Advertencia</title>
    </head>

    <body>
        <div class="alert alert-danger">

            <h1 class="text-shadow text-danger">
                <i class="fa-2x icon-ghost"></i>
                ALERTA!
            </h1>

            <p class="text-danger">
                ${msn}
            </p>

            <g:if test="${error}">
                <span style="font-size: 16px"><b>Reporte este error al administrador del sistema de forma detallada.</b>
                </span><br>
                <g:if test="${session.usuario}">
                    <span style="font-size: 16px"><b>Usuario:${session.usuario}</b></span><br>
                </g:if>
                <span style="font-size: 16px"><b>Para continuar usando el sistema pulse <a href="${createLink(controller: 'login', action: 'logout')}" id="regresar">Aquí</a>
                </b></span><br>
            %{--<span style="font-size: 16px"><b>Si desea borrar toda la información del sistema pulse  <a href="${createLink(controller: 'shield',action: 'prueba')}" id="prueba">Aquí</a></b></span><br>--}%
                <script type="text/javascript">
                    $("#regresar").button()
                    $("#prueba").button()
                </script>
            %{--<h2>Que eres pal burro????</h2>        --}%
            %{--<select name="queEresPalBurro">--}%
            %{--<option>seleccione....</option>--}%
            %{--<option>Pápa</option>--}%
            %{--<option>Novio</option>--}%
            %{--<option>Hijo</option>--}%
            %{--<option>Sobrino</option>--}%
            %{--<option>Yo mismo soy</option>--}%
            %{--</select>--}%
            %{--<g:link action="index" controller="inicio" class=" tbbtn fg-button ui-state-default fg-button-icon-left ui-corner-all"> <span class="ui-icon ui-icon-disk"></span><span>Aceptar</span></g:link>--}%
            %{--Hint: 'yo mismo soy'--}%
                <div class="message" style="width: 840px;">
                    <strong>Error ${request.'javax.servlet.error.status_code'}:</strong> ${request.'javax.servlet.error.message'.encodeAsHTML()}<br/>
                    <strong>Servlet:</strong> ${request.'javax.servlet.error.servlet_name'}<br/>
                    <strong>URI:</strong> ${request.'javax.servlet.error.request_uri'}<br/>
                    <g:if test="${exception}">
                        <strong>Exception Message:</strong> ${exception.message?.encodeAsHTML()} <br/>
                        <strong>Caused by:</strong> ${exception.cause?.message?.encodeAsHTML()} <br/>
                        <strong>Class:</strong> ${exception.className} <br/>
                        <strong>At Line:</strong> [${exception.lineNumber}] <br/>
                        <strong>Code Snippet:</strong><br/>

                        <div class="snippet">
                            <g:each var="cs" in="${exception.codeSnippet}">
                                ${cs?.encodeAsHTML()}<br/>
                            </g:each>
                        </div>
                    </g:if>
                </div>
                <g:if test="${exception}">
                    <h2>Stack Trace</h2>

                    <div class="stack" style="width: 860px;background: rgba(254,0,0,0.2);padding-left: 15px;padding-top: 20px;padding-bottom: 20px; border: black dotted 1px">
                        <g:each in="${exception.stackTraceLines}">${it.encodeAsHTML()}<br/></g:each>
                    </div>
                </g:if>
            </g:if>
        </div>

    </body>
</html>
