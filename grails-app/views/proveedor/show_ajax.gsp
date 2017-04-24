<%@ page import="cratos.Proveedor" %>

<g:if test="${!proveedorInstance}">
    <elm:notFound elem="Proveedor" genero="o"/>
</g:if>
<g:else>

<g:if test="${proveedorInstance?.ruc}">
    <div class="row">
        <div class="col-md-4 text-info">
            Ruc
        </div>

        <div class="col-md-3">
            <g:fieldValue bean="${proveedorInstance}" field="ruc"/>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.nombre}">
    <div class="row">
        <div class="col-md-4 text-info">
            Nombre
        </div>

        <div class="col-md-3">
            <g:fieldValue bean="${proveedorInstance}" field="nombre"/>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.direccion}">
    <div class="row">
        <div class="col-md-4 text-info">
            Dirección
        </div>

        <div class="col-md-3">
            <g:fieldValue bean="${proveedorInstance}" field="direccion"/>
        </div>

    </div>
</g:if>


<g:if test="${proveedorInstance?.tipoProveedor}">
    <div class="row">
        <div class="col-md-4 text-info">
            Tipo Proveedor
        </div>

        <div class="col-md-3">
            ${proveedorInstance?.tipoProveedor?.descripcion?.encodeAsHTML()}
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.tipoPersona}">
    <div class="row">
        <div class="col-md-4 text-info">
            Tipo Persona
        </div>

        <div class="col-md-3">
            ${proveedorInstance?.tipoPersona?.descripcion?.encodeAsHTML()}
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.empresa}">
    <div class="row">
        <div class="col-md-4 text-info">
            Empresa
        </div>

        <div class="col-md-3">
            ${proveedorInstance?.empresa?.encodeAsHTML()}
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.tipoIdentificacion}">
    <div class="row">
        <div class="col-md-4 text-info">
            Tipo Identificación
        </div>

        <div class="col-md-5">
            ${proveedorInstance?.tipoIdentificacion?.descripcion?.encodeAsHTML()}
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.canton}">
    <div class="row">
        <div class="col-md-4 text-info">
            Cantón
        </div>

        <div class="col-md-3">
            ${proveedorInstance?.canton?.encodeAsHTML()}
        </div>

    </div>
</g:if>



<g:if test="${proveedorInstance?.fecha}">
    <div class="row">
        <div class="col-md-4 text-info">
            Fecha
        </div>

        <div class="col-md-3">
            <g:formatDate date="${proveedorInstance?.fecha}" format="dd-MM-yyyy"/>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.nombreContacto}">
    <div class="row">
        <div class="col-md-4 text-info">
            Nombre Contacto
        </div>

        <div class="col-md-3">
            <g:fieldValue bean="${proveedorInstance}" field="nombreContacto"/>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.apellidoContacto}">
    <div class="row">
        <div class="col-md-4 text-info">
            Apellido Contacto
        </div>

        <div class="col-md-3">
            <g:fieldValue bean="${proveedorInstance}" field="apellidoContacto"/>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.descuento}">
    <div class="row">
        <div class="col-md-4 text-info">
            Descuento
        </div>

        <div class="col-md-3">
            <g:fieldValue bean="${proveedorInstance}" field="descuento"/>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.estado}">
    <div class="row">
        <div class="col-md-4 text-info">
            Estado
        </div>

        <div class="col-md-3">
            %{--<g:fieldValue bean="${proveedorInstance}" field="estado"/>--}%
            <g:if test="${proveedorInstance?.estado == '1'}">
                ${"Activo"}
            </g:if>
            <g:else>
                ${"No Activo"}
            </g:else>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.observaciones}">
    <div class="row">
        <div class="col-md-4 text-info">
            Observaciones
        </div>

        <div class="col-md-3">
            <g:fieldValue bean="${proveedorInstance}" field="observaciones"/>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.telefono}">
    <div class="row">
        <div class="col-md-4 text-info">
            Teléfono
        </div>

        <div class="col-md-3">
            <g:fieldValue bean="${proveedorInstance}" field="telefono"/>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.tipoRelacion}">
    <div class="row">
        <div class="col-md-4 text-info">
            Tipo Relación
        </div>

        <div class="col-md-3">
            ${proveedorInstance?.tipoRelacion?.descripcion?.encodeAsHTML()}
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.actividad}">
    <div class="row">
        <div class="col-md-4 text-info">
            Actividad
        </div>

        <div class="col-md-3">
            <g:fieldValue bean="${proveedorInstance}" field="actividad"/>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.email}">
    <div class="row">
        <div class="col-md-4 text-info">
            Email
        </div>

        <div class="col-md-3">
            <g:fieldValue bean="${proveedorInstance}" field="email"/>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.pais}">
    <div class="row">
        <div class="col-md-4 text-info">
            País
        </div>

        <div class="col-md-3">
            <g:fieldValue bean="${proveedorInstance}" field="pais"/>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.nombreCheque}">
    <div class="row">
        <div class="col-md-4 text-info">
            Nombre Cheque
        </div>

        <div class="col-md-3">
            <g:fieldValue bean="${proveedorInstance}" field="nombreCheque"/>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.autorizacionSri}">
    <div class="row">
        <div class="col-md-4 text-info">
            Autorización Sri
        </div>

        <div class="col-md-3">
            <g:fieldValue bean="${proveedorInstance}" field="autorizacionSri"/>
        </div>

    </div>
</g:if>

<g:if test="${proveedorInstance?.fechaCaducidad}">
    <div class="row">
        <div class="col-md-4 text-info">
            Fecha Caducidad
        </div>

        <div class="col-md-3">
            <g:formatDate date="${proveedorInstance?.fechaCaducidad}" format="dd-MM-yyyy"/>
        </div>

    </div>
</g:if>

</g:else>