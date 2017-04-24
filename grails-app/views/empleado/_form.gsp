<%@ page import="cratos.Empleado" %>



<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'porcentajeComision', 'error')} required">
    <label for="porcentajeComision">
        <g:message code="empleado.porcentajeComision.label" default="Porcentaje Comision"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field name="porcentajeComision" type="number" value="${fieldValue(bean: empleadoInstance, field: 'porcentajeComision')}" class="number form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'foto', 'error')} ">
    <label for="foto">
        <g:message code="empleado.foto.label" default="Foto"/>

    </label>
    <input type="file" id="foto" name="foto"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'estado', 'error')} ">
    <label for="estado">
        <g:message code="empleado.estado.label" default="Estado"/>

    </label>
    <g:textField name="estado" maxlength="1" class="allCaps form-control" value="${empleadoInstance?.estado}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'fechaFin', 'error')} ">
    <label for="fechaFin">
        <g:message code="empleado.fechaFin.label" default="Fecha Fin"/>

    </label>
    <elm:datepicker name="fechaFin" title="fechaFin" class="datepicker form-control" value="${empleadoInstance?.fechaFin}" default="none" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'fechaInicio', 'error')} ">
    <label for="fechaInicio">
        <g:message code="empleado.fechaInicio.label" default="Fecha Inicio"/>

    </label>
    <elm:datepicker name="fechaInicio" title="fechaInicio" class="datepicker form-control" value="${empleadoInstance?.fechaInicio}" default="none" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'sueldo', 'error')} required">
    <label for="sueldo">
        <g:message code="empleado.sueldo.label" default="Sueldo"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field name="sueldo" type="number" value="${fieldValue(bean: empleadoInstance, field: 'sueldo')}" class="number form-control  required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'cuenta', 'error')} ">
    <label for="cuenta">
        <g:message code="empleado.cuenta.label" default="Cuenta"/>

    </label>
    <g:textField name="cuenta" maxlength="12" class="allCaps form-control" value="${empleadoInstance?.cuenta}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'hijo', 'error')} required">
    <label for="hijo">
        <g:message code="empleado.hijo.label" default="Hijo"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field name="hijo" type="number" value="${empleadoInstance.hijo}" class="digits form-control required" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'iess', 'error')} ">
    <label for="iess">
        <g:message code="empleado.iess.label" default="Iess"/>

    </label>
    <g:textField name="iess" maxlength="13" class="allCaps form-control" value="${empleadoInstance?.iess}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'numero', 'error')} ">
    <label for="numero">
        <g:message code="empleado.numero.label" default="Numero"/>

    </label>
    <g:textField name="numero" maxlength="10" class="allCaps form-control" value="${empleadoInstance?.numero}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'tipoContrato', 'error')} ">
    <label for="tipoContrato">
        <g:message code="empleado.tipoContrato.label" default="Tipo Contrato"/>

    </label>
    <g:select id="tipoContrato" name="tipoContrato.id" from="${cratos.TipoContrato.list()}" optionKey="id" value="${empleadoInstance?.tipoContrato?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'cargo', 'error')} ">
    <label for="cargo">
        <g:message code="empleado.cargo.label" default="Cargo"/>

    </label>
    <g:select id="cargo" name="cargo.id" from="${cratos.Cargo.list()}" optionKey="id" value="${empleadoInstance?.cargo?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'persona', 'error')} ">
    <label for="persona">
        <g:message code="empleado.persona.label" default="Persona"/>

    </label>
    <g:select id="persona" name="persona.id" from="${cratos.seguridad.Persona.list()}" optionKey="id" value="${empleadoInstance?.persona?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'canton', 'error')} ">
    <label for="canton">
        <g:message code="empleado.canton.label" default="Canton"/>

    </label>
    <g:select id="canton" name="canton.id" from="${cratos.Canton.list()}" optionKey="id" value="${empleadoInstance?.canton?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empleadoInstance, field: 'observaciones', 'error')} ">
    <label for="observaciones">
        <g:message code="empleado.observaciones.label" default="Observaciones"/>

    </label>
    <g:textField name="observaciones" maxlength="127" class="allCaps form-control" value="${empleadoInstance?.observaciones}"/>
</div>

