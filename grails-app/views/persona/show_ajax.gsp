<%@ page import="cratos.seguridad.Persona" %>
<div class="col2">
    <g:if test="${!personaInstance}">
        <elm:notFound elem="Persona" genero="o"/>
    </g:if>
    <g:else>

        <g:if test="${personaInstance?.cedula}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Cédula
                </div>

                <div class="col-md-4">
                    <g:fieldValue bean="${personaInstance}" field="cedula"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.nombre}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Nombre
                </div>

                <div class="col-md-4">
                    <g:fieldValue bean="${personaInstance}" field="nombre"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.apellido}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Apellido
                </div>

                <div class="col-md-4">
                    <g:fieldValue bean="${personaInstance}" field="apellido"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.sigla}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Sigla
                </div>

                <div class="col-md-4">
                    <g:fieldValue bean="${personaInstance}" field="sigla"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.fechaNacimiento}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Fecha Nacimiento
                </div>

                <div class="col-md-4">
                    <g:formatDate date="${personaInstance?.fechaNacimiento}" format="dd-MM-yyyy"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.email}">
            <div class="row">
                <div class="col-md-3 text-info">
                    E-mail
                </div>

                <div class="col-md-4">
                    <g:fieldValue bean="${personaInstance}" field="email"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.telefono}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Teléfono
                </div>

                <div class="col-md-4">
                    <g:fieldValue bean="${personaInstance}" field="telefono"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.direccion}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Dirección
                </div>

                <div class="col-md-4">
                    <g:fieldValue bean="${personaInstance}" field="direccion"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.direccionReferencia}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Referencias dirección
                </div>

                <div class="col-md-4">
                    <g:fieldValue bean="${personaInstance}" field="direccionReferencia"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.barrio}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Barrio
                </div>

                <div class="col-md-4">
                    <g:fieldValue bean="${personaInstance}" field="barrio"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.discapacitado}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Discapacitado
                </div>

                <div class="col-md-4">
                    <g:message code="persona.discapacitado.${personaInstance.discapacitado}"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.sexo}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Sexo
                </div>

                <div class="col-md-4">
                    <g:message code="persona.sexo.${personaInstance.sexo}"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.nacionalidad}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Nacionalidad
                </div>

                <div class="col-md-4">
                    ${personaInstance?.nacionalidad?.encodeAsHTML()}
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.profesion}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Profesión
                </div>

                <div class="col-md-4">
                    ${personaInstance?.profesion?.descripcion}
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.estadoCivil}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Estado Civil
                </div>

                <div class="col-md-4">
                    ${personaInstance?.estadoCivil?.descripcion}
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.observaciones}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Observaciones
                </div>

                <div class="col-md-4">
                    <g:fieldValue bean="${personaInstance}" field="observaciones"/>
                </div>

            </div>
        </g:if>

        <g:if test="${personaInstance?.login}">
            <div class="row">
                <div class="col-md-3 text-info">
                    Login
                </div>

                <div class="col-md-4">
                    <g:fieldValue bean="${personaInstance}" field="login"/>
                </div>

            </div>
        </g:if>

    %{--<g:if test="${personaInstance?.activo}">--}%
        <div class="row">
            <div class="col-md-3 text-info">
                Activo
            </div>

            <div class="col-md-4">
                <g:formatBoolean boolean="${personaInstance.activo == 1}" true="SI" false="NO"/>
            </div>

        </div>
    %{--</g:if>--}%

        <div class="row">
            <div class="col-md-3 text-info">
                Perfiles
            </div>

            <div class="col-md-4">
                <ul class="fa-ul">
                    <g:each in="${cratos.seguridad.Sesn.findAllByUsuario(personaInstance)}" var="perf">
                        <li class="keeptogether"><i class="fa-li fa fa-user"></i>
                            ${perf.perfil.nombre}
                        </li>
                    </g:each>
                </ul>
            </div>

        </div>

    </g:else>
</div>